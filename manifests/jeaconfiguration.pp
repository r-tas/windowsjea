#custom define for setting jea configuration
#this will accept parameters
#lay down the two files based on templates
#then register the file
define jea::jeaconfiguration(
  String $configname,
  Hash $roledefinitions,
  Hash $visiblecmdlets = [],
  Array $visiblecommands = [],
  Array $visibleproviders= [],
  String $sessiontype = 'RestrictedRemoteServer'

) {

  file {"C:/Program Files/WindowsPowerShell/PSRemoteConfigurations/${configname}.pssc":
    ensure  => 'file',
    content => epp('jea/session_configuration_template.epp',
                    { 'sessiontype'     => $sessiontype,
                      'roledefinitions' => $roledefinitions,
                    }
                  ),
    require => Class['jea::basedirectory'],
  }

  file {"C:/Program Files/WindowsPowerShell/Modules/JEA/RoleCapabilities/${configname}.psrc":
    ensure  => 'file',
    content => epp('jea/role_capabilities_template.epp',
                    { 'visiblecmdlets'   => $visiblecmdlets,
                      'visiblecommands'  => $visiblecommands,
                      'visibleproviders' => $visibleproviders,
                    }
                  ),
    require => Class['jea::basedirectory'],
  }
  exec{"register configuration ${configname}":
    command     => "c:\\windows\\system32\\WindowsPowerShell\\v1.0\\powershell.exe -NonInteractive -NoProfile -ExecutionPolicy Bypass -Command \"Register-PSSessionConfiguration -name ${configname} -force -path \'C:\\Program Files\\WindowsPowerShell\\PSRemoteConfigurations\\${configname}.pssc\'\" ",
    subscribe   => File["C:/Program Files/WindowsPowerShell/PSRemoteConfigurations/${configname}.pssc"],
    refreshonly => true,
  }

}
