package "git-core"

group "admin"
user node[:user][:name] do
  password node[:user][:password]
  gid "admin"
  home "/home/#{node[:user][:name]}"
  supports manage_home: true
  shell "/bin/bash"
end

template "/home/#{node[:user][:name]}/.bashrc" do
  source "bashrc.erb"
  owner node[:user][:name]
end

if node[:user][:authorized_keys]
  file "/home/#{node[:user][:name]}/.ssh/authorized_keys" do
    owner node[:user][:name]
    mode "600"
    content node[:user][:authorized_keys]  
  end
end
