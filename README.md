# Survey

Display Surveys and allow logged in users to respond to and create new questions.

Developed using Ruby on Rails Rails 7.2.1, this app uses Hotwire components: TurboStreams, TurboFrames and a little stimulus. 

![Screenshot](https://website1-screenshots.s3.amazonaws.com/Surveys+Logged+In.png)


## Features

-   Create new questions
-   Answer questions (Yes or No)

## Give it a try at...

http://apple.web-site1.com
                       
## Setup

- Install Ruby 3.2.3
- Install redis-server (if not already installed)
- Unzip to new directory (e.g. survey)
- cd to new directory
- bundle
- rails db:setup
  - this step creates the database, loads the schema and seeds the database with the following users
    - admin, palo and george
    - their passwords are all 123456789
- sidekiq (in another terminal window)
- rail s

## Go!
- login as any user 
- create a question or two
- respond Yes or No in the grid.
- Note: A user can change his/her response to a question but his/her response will never be counted twice. (i.e. no duplicate responses)
- Enjoy!

## Dependencies

-   Ruby 3.2.3
-   Rails 7.2.1
-   Bundler 2.5.18
-   redis server
                                 

## Troubleshooting
                
- If Question grid does not update after submitting a new question, be sure Sidekiq is running (and redis)

## Tests

Run full test suite and the test coverage will appear on the last line:

```shell
$ bundle exec rspec
```

To see any linting errors:

```shell
$ rubocop
```

## Credits
https://github.com/danwa5

https://github.com/joelparkerhenderson