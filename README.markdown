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

- [x] Create Rails 5.2 app
- [x] Setup Travis CI
- [x] Setup Heroku
- [x] Create User Model
- [x] Setup GitHub Oauth
- [ ] Create Challenge Model
- [ ] Create Task Model
- [ ] Setup Code Syntax Highlighting
- [ ] Setup Solution Model
- [ ] Setup Solution Validation
- [ ] Setup Rating Calculation
- [ ] Setup Leaderboard
- [ ] Setup GDPR Privacy Policy
- [ ] Setup Delete User (ask to keep provider and provider_uid & anonymize)
- [ ] Setup User Info retrieval (logged in only)
- [ ] Setup Cookie Message(?)

## Development

Get the source code:

    git clone git@github.com:mediafinger/ruby_coding_challenge.git

Change into the new directory and run:

`bundle install` _this requires Ruby >= 2.5 and the bundler gem_

After this finished run:

`bin/rails setup` _this requires Postgresql_

### Tests

After the app was setup, run the tests:

`bundle exec rake rspec`

### Pushing to master

Automatic testing is setup with **Travis CI**, which executes:

`bundle exec rake ci` _== rake rubocop bundle:audit rspec_

When the build was successful, it will automatically be deployed to **heroku**

### Run the app

To start a server locally run:

`bin/rails server` and open http://localhost:3000

### GitHub OAuth

You will have to register a new **OAuth App on GitHub** under:

https://github.com/settings/applications/new

Then either create a file `config/settings.local.rb` and add the **Client ID** and **Client secret** there:

    Settings.set :github_client_id, "123456"
    Settings.set :github_client_secret, "secret"

Or create a `.env` file and add the ENV variables there:

    GITHUB_CLIENT_ID=123456
    GITHUB_CLIENT_SECRET=secret

The `config/settings.local.rb` file is already being loaded. The `.env` file will work, when you start the app with the heroku CLI command: `heroku local` - or when you add the dotenv gem to the project.  
Both files are in _.gitignore_ so you won't accidentally push your secrets to origin.

### heroku

The repo already contains a `Procfile` and is ready to be pushed to heroku. Migrations are run automatically on push. The production version of the app has to be registered as different **OAuth App on GitHub** as the development version.

Don't forget to add `GITHUB_CLIENT_ID`, `GITHUB_CLIENT_SECRET` and `BASE_HOST` as ENV variables on heroku. The latter will look something like `https://ruby-coding-challenge.herokuapp.com/`.

## Contributing

Feedback, questions and PRs are welcome :-)

## License

MIT
