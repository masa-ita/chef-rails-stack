default[:environment]         = "production"
default[:user][:name]         = "deployer"
default[:rbenv][:plugins]     = ['https://github.com/sstephenson/ruby-build.git', 'https://github.com/jamis/rbenv-gemset.git']
default[:rbenv][:rubies]      = ['1.9.3-p194']
default[:features][:rmagick]  = false
default[:features][:nodejs]   = false
