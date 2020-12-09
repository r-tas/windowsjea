#class to create the base directory structure to use with JEA
#just enough administration.  only supported in PS 5.1 and above
#so only use with windows 2016 and above
#This will be part of the windows 2016 base profile?
#its better to have this in its own file that can be part of base
#or sourced from other profiles, because we canot have each profile/user
#trying to create the same resources.  So we provide the directories
#and they/we can drop in config files
class windowsjea::testing(
  $sessiontype = {},
  $roledefinitions = {},
  $roledefinitiondetails = {},
  $transcriptdirectory = 'C:\Transcripts',
  $runasvirtualaccount = true,
  $scriptstoprocess = [],
){
  windowsjea::jeaconfiguration{'johntesting1':
    configname             => 'johntesting1',
    sessiontype            => 'RestrictedRemoteServer',
    roledefinitions        => $roledefinitions,
    roledefinitiondetails  => $roledefinitiondetails,
  }
}
