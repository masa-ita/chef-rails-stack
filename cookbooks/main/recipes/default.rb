package "git-core"

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

template "/home/#{node[:user][:name]}/.bashrc" do
  source "bashrc.erb"
  owner node[:user][:name]
end

if node[:user][:authorized_keys]
  directory "/home/#{node[:user][:name]}/.ssh" do
    mode "700"
    owner node[:user][:name]
  end
  file "/home/#{node[:user][:name]}/.ssh/authorized_keys" do
    owner node[:user][:name]
    mode "600"
    content node[:user][:authorized_keys]  
  end
end
