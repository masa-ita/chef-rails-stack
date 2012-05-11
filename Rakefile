# Author: Manuel Hutter <manuel.hutter@gmail.com>
# Rake Tasks for automatic deployment of chef recipes etc...

require 'net/ssh'

desc 'upload files and run chef-solo'
task :deploy, [:hostname] => [:upload, :run]

desc 'upload all the cookbooks etc to the hostname'
task :upload, [:hostname] do |t, args|
  say "Uploading current directory..."
  cmd = %Q{rsync -rv --delete #{File.expand_path(__FILE__+"/..")}/ root@#{args.hostname}:/var/chef --exclude='.git*' --exclude=cache --exclude=backup}
  say cmd
  system cmd
end

desc 'run the chef-solo command on the hostname'
task :run, [:hostname] do |t, args|
  Net::SSH.start(args.hostname, 'root') do |ssh|
    channel = ssh.open_channel do |ch|
      # callbacks
      ch.on_data do |c, data|
        STDOUT.print data
      end
      ch.on_extended_data do |c, type, data|
        STDERR.print data
      end
      ch.on_close { say "SSH Session closed!" }

      say "run chef-solo"
      cmd = %Q{chef-solo -c /var/chef/solo.rb}
      say cmd
      ch.exec cmd
    end
  end
end

# administrative tasks
desc 'installs the prequisites'
task :prepare, [:hostname] do |t, args|

  Net::SSH.start(args.hostname, 'root') do |ssh|
    channel = ssh.open_channel do |ch|
      # callbacks
      ch.on_data do |c, data|
        STDOUT.print data
      end
      ch.on_extended_data do |c, type, data|
        STDERR.print data
      end
      ch.on_close { say "SSH Session closed!" }
      
      say "Installing curl and rsync"
      say "apt-get install -y curl rsync"
      ch.exec "apt-get install -y curl rsync"
      ch.wait
      say "Running chef-solo-bootstrap script..."
      say "curl -L https://raw.github.com/gist/2349875/chef_solo_bootstrap.sh | bash"
      ch.exec "curl -L https://raw.github.com/gist/2349875/chef_solo_bootstrap.sh | bash"
      ch.wait
      say "mkdir /var/chef"
      ch.exec "mkdir /var/chef"
    end
    channel.wait
  end
end

# Helper Stuff
def say(text)
  puts "[#{Time.new}] :: #{text}"
end