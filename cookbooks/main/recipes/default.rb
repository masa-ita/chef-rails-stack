# software dependencies
package "git-core"
package "screen"

# users and groups
if node[:user]
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
end

include_recipe "main::config_files"
include_recipe "main::rbenv"
include_recipe "nginx"
nginx_site 'default', :enable => false
package "postgresql-9.1"
package "postgresql-server-dev-9.1"

if node[:features][:rmagick]
  package "imagemagick"
  package "libmagick-dev"
  package "libmagickwand-dev"
end

if node[:features][:nodejs]
  # TODO
end
