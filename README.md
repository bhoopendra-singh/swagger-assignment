# README

This README would normally document whatever steps are necessary to get the
application up and running.

1. used cmd rails new to generate the rails application.
2. added the gem dependencies to the gemfile and  used cmd bundle install to install the gem in the local system with its locked version in gem.lock file.
3. create schema for the problem statement i.e create the model with with cmd rails g model model_name.
4. after adding the model class attribute to migration run the cmd rails db:migrate to reflect the changes in schema.rb file.
5. create the controller with cmd rails g controller.
6. added the routes to route.rb file and then it actions to its controller.
7. added the required validations to models.


API's desciption
1. hit the swagger API get token to get authentication token.
2. save this token in authorize dialog box which appears on right top corner of the swagger API doc and save.
3. now hit the second API to create short url with entering the long url in the params and you will get the short url token in the response.
4. copy the above short url token to get the long url in the response on the third last most API.

Please mention this(about git repo)
-> master is the main branch that contains all the code.
-> assessments was the branch cutted from the master branch and was compared with github tool and merged to master branch after raising the pull request against the master branch from assessement branch.
