Description
---
Chef config etc for my Ruby on Rails stack (postgres, nginx, unicorn).

* sets up users
  * create user and group
  * create authorized_keys file
* sets up some configs
  * bashrc's
  * vim
  * gem
  * bundler
* installs prequisite packages
* installs some software from source

Prequisites
---
See [Ruby/Chef Solo Bootstrap](https://gist.github.com/2349875).
Example:

    curl -L https://raw.github.com/gist/2349875/chef_solo_bootstrap.sh | bash

Contents
---
* [git](http://git-scm.com)
* [nginx](http://nginx.org)
* [postgresql](http://www.postgresql.org)
