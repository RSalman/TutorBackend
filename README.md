# README

* Ruby version: 2.3.1p112

* System dependencies: Windows 10, MySQL 5.7.16, DevKit 4.7.2

* Configuration: 

        Steps taken to resolve SSL error downloading gems:
        Download rubygems_update version 2.6.8 (latest version at this time)
        Install rubygems_update: gem install rubygems-update-2.6.8.gem
        Run it: update_rubygems --no-ri --no-rdoc
        Make sure gem -v returns version 2.6.8
        [Optional] Uninstall rubygems_update: gem uninstall rubygems-update -x

* Database creation: rake db:create

* Database initialization: rake db:migrate

* How to run the test suite:

* Deployment configuration instructions:

        wget http://dev.mysql.com/get/mysql-apt-config_0.6.0-1_all.deb
        sudo dpkg -i mysql-apt-config_0.6.0-1_all.deb
        sudo apt-get update
        sudo apt-get install rbenv mysql-server libssl-dev libreadline-dev build-essential ruby-dev libmysqlclient-dev nodejs
        sudo mysql_secure_installation
        git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
        rbenv install 2.3.1
        rbenv global 2.3.1
        sudo gem install bundler

* Deployment instructions:

        git clone https://github.com/pliu/TutorBackend.git (not required after first deployment)
        cd TutorBackend
        git pull (required after first deployment)
        git reset --hard origin/master (required after first deployment)
        bundle install
        rake db:create
        rake db:migrate
        Remove the .exe from ruby in bin/rails
        bin/rails server -b 0.0.0.0 -p 3000
