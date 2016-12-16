## Development Instructions

### Setup
Install Rails and MySQL. Follow [these instructions](http://stackoverflow.com/questions/5996834/how-to-install-ruby-on-rails-with-mysql-and-get-it-working-a-step-by-step-guide) if on Windows.

Execute the following commands after installing Rails and MySQL and cloning the repository:
```
$ cd ~/TutorBackend
$ bundle install
$ rake db:schema:load
$ rake db:migrate
$ overcommit --install && overcommit --sign
$ rails server -d -b 0.0.0.0
```

### Development Steps
* Create feature branches off of staging: `git checkout -b feature-branch-name origin/staging`
* Git pull and rebase your feature branch onto staging regularly to ensure freshness: `git rebase staging`
* Always git pull and rebase onto staging prior to submitting a pull request.
* IMPORTANT!!: When submitting a pull request to *staging*, always **squash and merge**. When submitting to *master*, always **rebase**!

*NOTE: We periodically submit pull requests from staging to master to deploy new features/fixes master is automatically deployed to production (an Azure VM).*

### Running Tests
Simple: `rake test`
        
## Deployment Instructions and Miscellaneous
* Configuration:

        Steps taken to resolve SSL error downloading gems:
            Download rubygems_update version 2.6.8 (latest version at this time)
            gem install rubygems-update-2.6.8.gem
            update_rubygems --no-ri --no-rdoc
            Make sure gem -v returns version 2.6.8
            [Optional] gem uninstall rubygems-update -x
            
        Steps taken to resolve bcrypt LoadError:
            gem uninstall devise
            gem uninstall bcrypt
            gem install bcrypt --platform=ruby
            gem install devise

* Database creation: rake db:create

* Database initialization: rake db:migrate

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
            GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,INDEX ON TutorBackend_production.* TO 'TutorBackend'@'localhost';
 
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
        bundle install --deployment
        rake db:schema:load
        rake db:migrate
        mv bin/rails_linux bin/rails
        rails server -d -b 0.0.0.0

* Deployment instructions (subsequent deploys):

        ~/TutorBackend/deploy.sh
