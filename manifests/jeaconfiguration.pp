#custom define for setting jea configuration
#this will accept parameters
#lay down the two files based on templates
#then register the file
define jea::jeaconfiguration(
  String $configname,
  Hash $roledefinitions,
  Hash $roledefinitiondetails,
  Boolean $runasvirtualaccount = true,
  String $transcriptdirectory = 'C:\Transcripts',
  String $sessiontype = 'RestrictedRemoteServer',
  Array $scriptstoprocess = [],
) {
  if $runasvirtualaccount {
    $runasvirtualaccountstring = '$true'
  }
  else {
    $runasvirtualaccountstring = '$false'
  }
  file {"C:/Program Files/WindowsPowerShell/PSRemoteConfigurations/${configname}.pssc":
    ensure  => 'file',
    content => epp('jea/session_configuration_template.epp',
                    { 'sessiontype'               => $sessiontype,
                      'runasvirtualaccountstring' => $runasvirtualaccountstring,
                      'transcriptdirectory'       => $transcriptdirectory,
                      'scriptstoprocess'          => $scriptstoprocess,
                      'roledefinitions'           => $roledefinitions,
                    }
                  ),
    require => Class['jea::basedirectory'],
  }
  $roledefinitiondetails.each |String $key, Hash $value| {
    file {"C:/Program Files/WindowsPowerShell/Modules/JEA/Rolecapabilities/${key}.psrc":
      ensure  => 'file',
      content => epp('jea/role_capabilities_template.epp',
                      { 'visiblealiases'       => $value['visiblealiases'],
                        'visiblefunctions'     => $value['visiblefunctions'],
                        'visiblecmdlets'       => $value['visiblecmdlets'],
                        'visiblecommands'      => $value['visiblecommands'],
                        'visibleproviders'     => $value['visibleproviders'],
                        'scriptstoprocessrole' => $value['scriptstoprocessrole'],
                        'aliasdefinitions'     => $value['aliasdefinitions'],
#                       'functiondefinitions'  => $value['functiondefinitions'],
                        'environmentvariables' => $value['environmentvariables'],
                        'typestoprocess'       => $value['typestoprocess'],
                        'formatstoprocess'     => $value['formatstoprocess'],
                      }
                    ),
      require => Class['jea::basedirectory'],
    }
  }
  exec{"register configuration ${configname}":
    command     => "c:\\windows\\system32\\WindowsPowerShell\\v1.0\\powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -Command \"Register-PSSessionConfiguration -name ${configname} -force -path \'C:\\Program Files\\WindowsPowerShell\\PSRemoteConfigurations\\${configname}.pssc\'\" ",
    subscribe   => File["C:/Program Files/WindowsPowerShell/PSRemoteConfigurations/${configname}.pssc"],
    refreshonly => true,
  }
}
