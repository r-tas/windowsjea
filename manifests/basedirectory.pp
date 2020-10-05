#class to create the base directory structure to use with JEA
#just enough administration.  only supported in PS 5.1 and above
#so only use with windows 2016 and above
#This will be part of the windows 2016 base profile?
#its better to have this in its own file that can be part of base
#or sourced from other profiles, because we canot have each profile/user
#trying to create the same resources.  So we provide the directories
#and they/we can drop in config files
class jea::basedirectory{
  file{'C:/Program Files/WindowsPowerShell/PSRemoteConfigurations':
    ensure => directory,
  }

  file{ 'C:/Program Files/WindowsPowerShell/Modules/JEA':
    ensure => directory,
  }
  file{ 'C:/Program Files/WindowsPowerShell/Modules/JEA/RoleCapabilities':
    ensure  => directory,
    require => File['C:/Program Files/WindowsPowerShell/Modules/JEA'],
  }

}


