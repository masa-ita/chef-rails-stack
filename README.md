Description
---
Chef config etc for my Ruby on Rails stack (postgres, thin, nginx).

* sets up users
* installs prequisite packages
* installs some software from source

Prequisites
---
See [Ruby/Chef Solo Bootstrap](https://gist.github.com/2349875).
Example (**Note** always use the latest link from the gist page!):

    curl -L https://gist.github.com/raw/2349875/2b57f107c539e4349bd6452f662d4c49dd4bf1ad/chef_solo_bootstrap.sh | bash

Contents
---
* [git](http://git-scm.com)
* [nginx](http://nginx.org) (s)
* [postgresql](http://www.postgresql.org) (s)

(s) from source