[![Build Status](https://travis-ci.com/mediafinger/ruby_coding_challenge.svg?branch=master)](https://travis-ci.com/mediafinger/ruby_coding_challenge)

# Ruby Coding Challenge

This app allows _Admins_ to create _Ruby Coding Challenges_ which consist of one or multiple _Tasks_.

_Participants_ can login over _Github OAuth_, upload their _Solutions_ and get direct feedback if their Ruby code fulfills all requirements or if it breaks a spec.

Every working solution gets a rating which equals the number of characters without the whitespaces:  
`rating = solution.gsub(/\s+/, "").length`  
A _Leaderboard_ will show how the _Participants_ compare to each other.

Once the time for a _Task_ is over, or the _Admin_ decides to end it, all solutions will be made visible with _Code Syntax Highlighting_.

There can be winners per _Task_ and winners of the whole _Ruby Coding Challenge_.

**Try it:** https://ruby-coding-challenge.herokuapp.com/

## TODOs

- [ ] Create Rails 5.2 app
- [ ] Setup Travis CI
- [ ] Create User Model
- [ ] Setup GitHub Oauth
- [ ] Create Challenge Model
- [ ] Create Task Model
- [ ] Setup Code Syntax Highlighting
- [ ] Setup Solution Model
- [ ] Setup Solution Validation
- [ ] Setup Rating Calculation
- [ ] Setup Leaderboard

## Development

Get the source code:

`git clone git@github.com:mediafinger/ruby_coding_challenge.git`

Change into the new directory and run:

`bundle install` _this requires Ruby >= 2.5 and the bundler gem_

After this finished run:

`bin/rails setup` _this requires Postgresql_

### Tests

After the app was setup, run the tests:

`bundle exec rake rspec`

Automatic testing is setup with Travis CI, which executes:

`bundle exec rake ci`

### Run the app

To start a server locally run:

`bin/rails server` and open http://localhost:3000

## Contributing

Feedback, questions and PRs are welcome :-)
