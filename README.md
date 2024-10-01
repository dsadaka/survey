# Survey

Display Surveys and allow logged in users to respond to and create new questions.

Developed using Ruby on Rails Rails 7.2.1, this app uses Hotwire components: TurboStreams, TurboFrames and a little stimulus. 

![Screenshot](https://website1-screenshots.s3.amazonaws.com/Surveys+Logged+In.png)

         
## Improvements since Version 1.
- Full page refresh no longer occurs when a question is answered.  The Yes and No percentages are refreshed via a broadcasted turbo stream
- Pagination added to Survey index page
- No Sidekiq necessary
- Deployed to http://apple.web-site1.com

## Features

-   Create new questions
-   Answer questions (Yes or No)

                       
## Setup (for local testing)

- Install Ruby 3.2.3
- Install redis-server (if not already installed)
- Unzip to new directory (e.g. survey)
- cd to new directory
- bundle
- rails db:setup
  - this step creates the database, loads the schema and seeds the database with the following users
    - admin, palo and george
    - their passwords are all 123456789
- rail s

## Go!
Test locally or at http://survey.web-site1.com

- login as any user in one browser window 
- open a different browser or run an incognito chrome window and login as a different user
- create a question or two in both browsers
- respond Yes or No in the grid in both browsers
- notice changes instantly appear in both browser windows!
- Note: A user can change his/her response to a question but his/her response will never be counted twice. (i.e. no duplicate responses)
- Enjoy!

## Dependencies

-   Ruby 3.2.3
-   Rails 7.2.1
-   Bundler 2.5.18
-   redis server
                                 

## Tests

Run full test suite and the test coverage will appear on the last line:

```shell
$ rspec
```
