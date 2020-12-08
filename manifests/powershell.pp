#gpo policy for powershell 
class windowsjea::powershell(
  $enablescriptblocklogging = 0,
  $enablescriptblockinvocationlogging = 0,
  $enabletranscripting = 0,
  $enablemodulelogging = 0,
  $modulenames = ['*'],
){
  registry_value {'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging\EnableScriptBlockLogging':
    ensure => present,
    data   => $enablescriptblocklogging,
    type   => 'dword',
  }
  registry_value {'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging\EnableScriptBlockInvocationLogging':
    ensure => present,
    data   => $enablescriptblockinvocationlogging,
    type   => 'dword',
  }
  registry_key {'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription':
    ensure => present,
  }
  registry_value {'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription\EnableTranscripting':
    ensure  => present,
    data    => $enabletranscripting,
    type    => 'dword',
    require => Registry_key['HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription'],
  }
  registry_value {'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription\OutputDirectory':
    ensure  => present,
    data    => 'c:\transcription',
    type    => string,
    require => Registry_key['HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription'],
  }
  registry_key {'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging':
    ensure  => present,
  }
  registry_value {'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\EnableModuleLogging':
    ensure  => present,
    data    => $enablemodulelogging,
    type    => 'dword',
    require => Registry_key['HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging'],
  }
  registry_key { 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames':
    ensure  => 'present',
    require => Registry_key['HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging'],
  }
  $modulenames.each |String $name| {
    registry_value {"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\PowerShell\\ModuleLogging\\ModuleNames\\${name}":
      ensure  => present,
      data    => $name,
      type    => string,
      require => Registry_key['HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames'],
    }
  }
}
