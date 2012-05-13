# rbenv!
if node[:user]

# install prequisites
  case node[:platform]
  when "ubuntu", "debian"
    package "build-essential"
    package "openssl"
    package "libssl-dev"
    package "libreadline-dev"
  end

# define installation path
  node.default[:rbenv][:path] = "/home/#{node[:user][:name]}/.rbenv"

# install rbenv
  git "rbenv" do
    repository 'https://github.com/sstephenson/rbenv.git'
    destination node[:rbenv][:path]
    user node[:user][:name]
    group node[:user][:name]
  end

# install plugins
  directory File.join(node[:rbenv][:path], "plugins") do
    owner node[:user][:name]
    group node[:user][:name]
  end

  node[:rbenv][:plugins].each do |repo|
    plugin = repo.match(/([^\/]+)\.git$/)[1]
    git plugin do
      repository repo
      destination File.join(node[:rbenv][:path], "plugins", plugin)
      user node[:user][:name]
      group node[:user][:name]
    end
  end

# install rubies
  node[:rbenv][:rubies].each do |ruby|
    execute "rbenv install #{ruby}" do
      command %Q{export PATH=#{node[:rbenv][:path]}/bin:$PATH && eval "$(rbenv init -)" && rbenv install #{ruby} && rbenv global #{ruby} && gem install bundler -y}
      creates File.join(node[:rbenv][:path], "versions", ruby, "bin", "ruby")
      user node[:user][:name]
      group node[:user][:name]
      environment ({'HOME' => "/home/#{node[:user][:name]}"})
    end
  end
end
