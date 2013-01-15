# Contributing to SimpleResource

## Forking the project

1. Click the "Fork" button in https://github.com/jarijokinen/simple_resource
2. Clone your fork (`git clone https://github.com/[username]/simple_resource.git`)
3. Track the original repository (`git remote add upstream https://github.com/jarijokinen/simple_resource.git`)
4. Fetch new changes from the original repository (`git fetch upstream`)
5. Merge any changes fetched from the original repository (`git merge upstream/master`)

## Using your own fork in your applications

Add this line to your application's Gemfile:

    gem "simple_resource", git: "https://github.com/[username]/simple_resource.git"

Replace the [username] with your GitHub username.

And then execute:

    $ bundle

## Running tests

    $ cd spec/dummy
    $ rake db:setup
    $ rake db:test:clone
    $ cd ../..
    $ rake spec

## Adding a new feature

1. Fork the project
2. Run tests and make sure they pass
3. Create a new branch (`git checkout -b my-new-feature`)
4. Write tests for your new feature and make sure they fail
5. Write a code for your new feature and make sure all tests pass
6. Commit your changes (`git commit -am 'Add some feature'`)
7. Push your branch into the repository (`git push origin my-new-feature`)

## Adding your changes to the original repository

1. Create a new Pull Request in GitHub
