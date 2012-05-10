# software dependencies
package "git-core"
package "screen"

# users and groups
group node[:user][:name]
user node[:user][:name] do
  password node[:user][:password]
  gid node[:user][:name]
  home "/home/#{node[:user][:name]}"
  supports manage_home: true
  shell "/bin/bash"
end

group "admin" do
  gid 999
  members [node[:user][:name]]
  append true
end

include_recipe "main::config_files"

include_recipe "nginx::source"

# TODO: postgresql
# does currently not work because of broken postgresql::server
#include_recipe "postgresql::server"

