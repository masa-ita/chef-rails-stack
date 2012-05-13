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
    run_cmd ssh, "chef-solo -c /var/chef/solo.rb"
  end
end

# administrative tasks
desc 'installs the prequisites'
task :prepare, [:hostname] do |t, args|

  Net::SSH.start(args.hostname, "root") do |ssh|
    run_cmd ssh, "apt-get install -y curl"
    run_cmd ssh, "curl -L https://raw.github.com/gist/2349875/chef_solo_bootstrap.sh | bash"
  end

end

# Helper Stuff
def say(text)
  puts "[#{Time.new}] :: #{text}"
end

def run_cmd(ssh, cmd)
  say "[SSH>] #{cmd}"
  ssh.open_channel do |channel|
    channel.exec(cmd) do |ch, success|
      abort "[ERROR] error executing '#{cmd}'!" unless success
      # callbacks
      channel.on_data do |c, data|
        STDOUT.print data
      end
      channel.on_extended_data do |c, type, data|
        STDERR.print data
      end
      channel.on_close { say "[SSH] Channel closed!" }

      channel.wait
    end
  end
  ssh.loop
end
