#!/bin/bash

cd ~/TutorBackend &&
bundle install --deployment &&
mv bin/rails_linux bin/rails &&
rake db:migrate &&
rails restart
