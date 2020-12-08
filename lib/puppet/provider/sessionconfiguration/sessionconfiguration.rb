# require 'puppet/util/windows'
# begin
#  require File.expand_path('../../../util/ini_file', __FILE__)
# rescue LoadError
#  # in case we're not in libdir
#  require File.expand_path('../../../../../spec/fixtures/modules/inifile/lib/puppet/util/ini_file', __FILE__) if File.file?('../../../../../spec/fixtures/modules/inifile/lib/puppet/util/ini_file')
# end

Puppet::Type.type(:sessionconfiguration).provide(:sessionconfiguraiton) do
    defaultfor :osfamily => :windows
    confine :osfamily => :windows
end

