# software dependencies
package "git-core"
package "screen"
package "libcurl4-openssl-dev"

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
  group "root" do
    action :modify
    members node[:user][:name]
    append true
  end
end

directory "/var/www" do
  owner "#{node[:nginx][:user]}"
  group "#{node[:nginx][:user]}"
  mode 0755
  action :create
end

gem_package("bundler") do
  version "1.3.0.pre8"
  action :install
end

include_recipe "main::config_files"

if node[:features][:rmagick]
  package "imagemagick"
  package "libmagick-dev"
  package "libmagickwand-dev"
end

if node[:features][:nodejs]
  include_recipe "apt"
  apt_repository "node.js" do
    uri "http://ppa.launchpad.net/chris-lea/node.js/ubuntu"
    distribution node['lsb']['codename']
    components ["main"]
    keyserver "keyserver.ubuntu.com"
    key "C7917B12"
  end
  execute "apt-get update"
  package "nodejs"
end
