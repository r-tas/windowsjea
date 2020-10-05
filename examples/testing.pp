#class to create the base directory structure to use with JEA
#just enough administration.  only supported in PS 5.1 and above
#so only use with windows 2016 and above
#This will be part of the windows 2016 base profile?
#its better to have this in its own file that can be part of base
#or sourced from other profiles, because we canot have each profile/user
#trying to create the same resources.  So we provide the directories
#and they/we can drop in config files
class jea::testing(
  $sessiontype,
  $roledefinitions,
  $visiblecmdlets
){

  $mycmdlets = ['restart-service','get-service']
  $visiblecommands = ['C:\Windows\System32\whoami.exe','C:\Windows\System32\expand.exe']
  $visibleproviders = ['winrm','powershell']
  $scriptstoprocess= ['C:\Program Files\WindowsPowerShell\Modules\Pester\3.4.0\Pester.Tests.ps1','C:\Program Files\WindowsPowerShell\Modules\Pester\3.4.0\build.psake.ps1']
  jea::jeaconfiguration{'johntesting1':
    configname       => 'johntesting1',
    sessiontype      => 'RestrictedRemoteServer',
    roledefinitions  => $roledefinitions,
    visiblecmdlets   =>  $visiblecmdlets,
    visiblecommands  =>  $visiblecommands,
    visibleproviders =>  $visibleproviders,
  }
}


