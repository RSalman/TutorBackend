# README (Fix/add anything you felt was unclear)

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

* Development instructions:

        staging is the development trunk (test against staging)
        We periodically submit pull requests from staging to master to deploy new features/fixes
        master is automatically deployed to production (an Azure VM)
        
        Create feature branches off of staging
        Git pull and rebase onto staging regularly to ensure freshness
        Always git pull and rebase onto staging prior to submitting a pull request

* How to run the test suite: rake test

* Deployment configuration instructions:

        wget http://dev.mysql.com/get/mysql-apt-config_0.6.0-1_all.deb
        sudo dpkg -i mysql-apt-config_0.6.0-1_all.deb
        sudo apt-get update
        sudo apt-get install rbenv mysql-server libssl-dev libreadline-dev build-essential ruby-dev libmysqlclient-dev nodejs python-pip
        git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
        rbenv install 2.3.1
        rbenv global 2.3.1
        sudo gem install bundler
        sudo mysql_secure_installation
        
        Set up the MySQL database:
            mysql -u root --password={ROOT DATABASE PASSWORD}
            CREATE USER 'TutorBackend'@'localhost' IDENTIFIED BY '{TUTORBACKEND DATABASE PASSWORD}';
            GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP ON TutorBackend_production.* TO 'TutorBackend'@'localhost';
 
        echo 'export RAILS_SERVE_STATIC_FILES=true' >> ~/.bashrc
        echo 'export RAILS_ENV=production' >> ~/.bashrc
        echo 'export TUTORBACKEND_DATABASE_PASSWORD={TUTORBACKEND DATABASE PASSWORD}' >> ~/.bashrc
        cd ~/TutorBackend && echo "export SECRET_KEY_BASE=$(rails secret)" >> ~/.bashrc && cd ~
        source ~/.bashrc
        
        git config --global credential.helper store
        git clone https://github.com/olipo186/Git-Auto-Deploy.git ~
        git clone https://github.com/pliu/TutorBackend.git ~
        mv ~/TutorBackend/git-auto-deploy.conf.json ~/Git-Auto-Deploy/
 
        pip install -r ~/Git-Auto-Deploy/requirements.txt
        python ~/Git-Auto-Deploy/GitAutoDeploy.py -d --config ~/Git-Auto-Deploy/git-auto-deploy.conf.json

* Deployment instructions (first deploy):

        cd ~/TutorBackend
        bundle install
        rake db:create
        rake db:migrate
        mv bin/rails_linux bin/rails
        rails server -d -b 0.0.0.0

* Deployment instructions (subsequent deploys):

        ~/TutorBackend/deploy.sh
