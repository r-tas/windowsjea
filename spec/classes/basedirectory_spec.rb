# frozen_string_literal: true

require 'spec_helper'

describe 'windowsjea::basedirectory' do
  let(:facts) { { 'operatingsystem' => 'windows' } }

  context 'with default configuration' do
    it { is_expected.to compile }
    it { is_expected.to contain_file('C:/Program Files/WindowsPowerShell/PSRemoteConfigurations').with('ensure' => 'directory') }
    it { is_expected.to contain_file('C:/Program Files/WindowsPowerShell/Modules/JEA').with('ensure' => 'directory') }
    it {
      is_expected.to contain_file('C:/Program Files/WindowsPowerShell/Modules/JEA/RoleCapabilities')
        .with(
          'ensure' => 'directory',
        ).that_requires('File[C:/Program Files/WindowsPowerShell/Modules/JEA]')
    }
    it { is_expected.to have_resource_count(3) }
  end
end
