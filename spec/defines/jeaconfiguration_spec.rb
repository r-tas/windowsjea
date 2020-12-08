# frozen_string_literal: true

require 'spec_helper'

describe 'windowsjea::jeaconfiguration' do
  let(:pre_condition) do
    [
      'class windowsjea::basedirectory {}',
      'include windowsjea::basedirectory',
    ]
  end
  let(:title) { 'mytitle' }
  let(:facts) { { 'operatingsystem' => 'windows' } }
  let(:params) do
    {
      'configname' => 'myconfig',
      'sessiontype' => 'RestrictedRemoteServer',
      'roledefinitions' =>
        {
          'DOMAIN\User1' => ['johntest1'],
	  'DOMAIN\Group1' => ['johntest1','johntest2'],
	},
      'roledefinitiondetails' => 
        {
          'johntest1' =>
	    {
              'visiblecmdlets' =>
	        {
		  'restart-service' => '',
		  'get-runspace' =>
		    {
                      'parameters' => ['name','computername','Throttlelimit'],
		      'validatesets' => { 'name' => ['john','bob'] },
                    }
		},
              'visiblecommands' =>
	        [
                  'C:\Windows\System32\whoami.exe',
		  'C:\Windows\System32\expand.exe'
		],
              'visibleproviders' =>
	        [
                  'winrm',
		  'powershell'
		],
	    },
          'johntest2' =>
	    {
              'visiblecmdlets' =>
	        {
		  'restart-service' => '',
		  'get-runspace' =>
		    {
                      'parameters' => ['name','computername','Throttlelimit'],
		      'validatesets' => { 'name' => ['john','bob'] },
                    }
		},
              'visiblecommands' =>
	        [
                  'C:\Windows\System32\whoami.exe',
		  'C:\Windows\System32\expand.exe'
		],
              'visibleproviders' =>
	        [
                  'winrm',
		  'powershell'
		],
	    },
        }
    }
  end

  context 'with default configuration' do
    it { is_expected.to compile }
    it {
      contenttext = "\\n"
      contenttext += "\\n"
      contenttext += "@{"
      contenttext += "SessionType = 'RestrictedRemoteServer'"
      contenttext += "RunAsVirtualAccount = '\$true'"
      contenttext += "RoleDefinitions = @{"
      contenttext += "      'DOMAIN\\User1' = @{ RoleCapabilities = 'johntest' }"
      contenttext += "      'DOMAIN\\Group1' = @{ RoleCapabilities = 'johntest','johntest2' }"
      contenttext += "  }"
      contenttext += "}"
      is_expected.to contain_file('C:/Program Files/WindowsPowerShell/PSRemoteConfigurations/myconfig.pssc')
        .with(
          'ensure' => 'file',
	  'content' => contenttext,
        ).that_requires('Class[windowsjea::basedirectory]')
    }
    it { is_expected.to have_resource_count(4) }
  end
end
