#
# Cookbook Name:: puppet
# Recipe:: default
#
# Copyright 2018, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


package "puppet" do
  action :install
end

cookbook_file '/etc/puppet/puppet.conf' do
  source 'puppet.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

add_line = "10.8.218.62 puppet.master"
bash "add_to_config" do
  code <<-EOH
    grep '#{add_line}' /etc/hosts || echo '#{add_line}' >> /etc/hosts
  EOH
end

service "puppet" do
  start_command 'service puppet start'
  restart_command 'service puppet restart'
  stop_command 'service puppet stop'
  status_command 'service puppet status'
  action [:enable, :start]
end


