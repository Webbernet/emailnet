# Emailnet
Manage email templates using the BeePlugin editor

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'emailnet'
```

And then execute:
```bash
$ bundle
```

Install the migrations and run

```bash
$ rake emailnet:install:migrations
```

```bash
$ rake db:migrate
```

Create the definition file in the host app, 

```yaml
- id: reset_password
  description: Sent when the user chooses to reset their password
  merge_fields:
    - name: 'First Name'
      value: '{{first_name}}'
  special_links:
    - type: 'User'
      label: 'Reset Password Page'
      link: '{{reset_link}}'
```

Add an initializer file to the host app. 

```ruby
Emailnet.configure do |config|
  config.bee_client_id = '12345'
  config.bee_client_secret = '12345'
  config.definition_file = "#{Rails.root}/app/src/email_template_definitions.yml"
end
```

Add to routes to the host app

```ruby
Rails.application.routes.draw do
  mount Emailnet::Engine => '/emailnet'
end
```

Now you can access and edit templates via `http://localhost:3000/emailnet/templates`

## Usage

```ruby
html_template = BuildEmail.new('reset_password', {
  first_name: 'Johnny', reset_link: @url }
).run
```

