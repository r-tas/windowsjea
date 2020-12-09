Puppet::Type.newtype(:sessionconfiguration) do
  @doc = <<-'EOT'
  Manage Powershell Session Configurations using .pssc files
  EOT

  ensurable do
    defaultvalues
    defaultto :absent
  end

  newparam(:name, :namevar => true) do
    desc 'Configuration name'
  end
  newproperty(:configpath) do
    desc 'Configuration file path'
    validate do |value|
      fail('Invalid path specified') unless value =~ %r{^(\w:\\.+$)}
    end
  end
end
