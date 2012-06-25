# Lockitron
Lockitron lets you unlock your front door from anywhere in the world, including your smartphone. We have an iPhone app, an Android app, a webapp, a mobile web app, a REST API, and now, a RubyGem.

This is a very early version of the gem. With it, you can lock, or unlock Lockitrons by their name.

## Prerequisites

You need two things for this gem. Firstly, you need a Lockitron-powered door lock, which you can buy at https://lockitron.com. Secondly, you'll need an access token. If you'll only use this for yourself, then go [grab your access token](https://api.lockitron.com/v1/oauth/applications). Right now, the gem doesn't handle authorization, so you'll need to manually switch out access tokens. We use OAuth2, if you'd like to [read up on how to authenticate with OAuth2](https://api.lockitron.com/v1/getting_started/authenticating_with_oauth).

### Setting an Access Token
To use the Lockitron gem or as a shell script, you'll need to set an access token. You can set it in Ruby or in bash, and it'll work either way. Although, I recommend that you set the access token as an environment variable. I've shown how to do that below

#### From Bash

Storing the access token as an environment variable: (Remember to replace MY_ACCESS_TOKEN with your access token!)
```bash
echo "export LOCKITRON_ACCESS_TOKEN=MY_ACCESS_TOKEN" >> ~/.bashrc && exec $SHELL
```

#### From Ruby:

```ruby
Lockitron::Locks.access_token = MY_ACCESS_TOKEN
```

## Usage (Bash)
You can lock or unlock your Lockitron-powered locks, and list the available locks.

### Locking or Unlocking

To lock, run:

```bash
lockitron lock LOCK_NAME
```

To unlock, run:

```bash
lockitron unlock LOCK_NAME
```

### Listing Locks

To list all available locks, run:

```bash
lockitron list
```

###

## Usage (Ruby)

You can lock or unlock your locks by their name. 

### Locking & Unlocking

To unlock by name, run:

```ruby
Lockitron::Locks.unlock_by_name("Lock Name")
```

To lock by name, run:

```ruby
Lockitron::Locks.lock_by_name("Lock Name")
```

### Listing Locks

To list all available locks, run:

```ruby
Lockitron::Locks.list
```


