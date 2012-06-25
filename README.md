# Lockitron
Lockitron lets you unlock your front door from anywhere in the world, including your smartphone. We have an iPhone app, an Android app, a webapp, a mobile web app, a REST API, and now, a RubyGem.

This is a very early version of the gem. With it, you can lock, or unlock Lockitrons by their name.

## Prerequisites

You need two things for this gem. Firstly, you need a Lockitron-powered door lock, which you can buy at https://lockitron.com. Secondly, you'll need an access token. If you'll only use this for yourself, then go [grab your access token](https://api.lockitron.com/v1/oauth/applications). Right now, gem doesn't handle authorization, so you'll need to manually switch out access tokens. We use OAuth2, if you'd like to [read up on how to authenticate with OAuth2](https://api.lockitron.com/v1/getting_started/authenticating_with_oauth).

### Setting an Access Token

Run the following:

  Lockitron::Lockitron.access_token = ACCESS_TOKEN

Replace ACCESS_TOKEN with the access token of your choosing.

## Usage

You can lock or unlock your locks by their name. 

### Unlocking by Name

To unlock by name, run:

  Lockitron::Lockitron.unlock_by_name("Name")

### Locking by Name
To lock by name, run:
  
  Lockitron::Lockitron.lock_by_name("Home")


