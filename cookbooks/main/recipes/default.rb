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

# some global templates
%w{/etc/bash.bashrc /etc/vim/vimrc}.each do |t|
  template t do
    source "#{t.match(/[a-z]+$/i)}-global.erb"
    owner "root"
    group "root"
    mode "644"
  end
end

# user specific templates
%w{bashrc profile screenrc}.each do |f|
  template "/home/#{node[:user][:name]}/.#{f}" do
    source "#{f}-user.erb"
    owner node[:user][:name]
  end
end

file "/home/#{node[:user][:name]}/.gemrc" do
  owner node[:user][:name]
  content "gem: --no-rdoc --no-ri\n"
end

# templates for root
template "/root/.bashrc" do
  source "bashrc-root.erb"
  owner "root"
  group "root"
  mode "644"
end


# for security..
directory "/home/#{node[:user][:name]}/.ssh" do
  mode "700"
  owner node[:user][:name]
  group node[:user][:name]
end

# optional stuff below here

if node[:user][:authorized_keys]
  file "/home/#{node[:user][:name]}/.ssh/authorized_keys" do
    owner node[:user][:name]
    mode "600"
    content node[:user][:authorized_keys]  
  end
end
