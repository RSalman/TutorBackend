# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

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

* Database initialization:

* How to run the test suite:

* Services (job queues, cache servers, search engines, etc.):

* Deployment instructions:
