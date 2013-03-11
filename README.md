# SimpleResource

[![Build Status](https://secure.travis-ci.org/jarijokinen/simple_resource.png)](http://travis-ci.org/jarijokinen/simple_resource) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/jarijokinen/simple_resource)

SimpleResource speeds up development of standard Rails applications by integrating [Inherited Resources](https://github.com/josevalim/inherited_resources), inherited views and form builders together.

## Features

* Everything is customizable application-wide and per resource
* Internationalization support
* Support for your own form builders
* Support for external form builders
    * [Formtastic](https://github.com/justinfrench/formtastic)
    * [SimpleForm](https://github.com/plataformatec/simple_form)
* Support for CanCan

## Requirements

* Ruby 2.0 or greater
* Rails 4.0 or greater

## Installation

Add this line to your application's Gemfile:

    gem "simple_resource"

And then execute:

    $ bundle

## Usage

Inherit your resource controllers from SimpleResource::BaseController. For example:

    class ProjectsController < SimpleResource::BaseController
    end

That's it. Your resource now uses Formtastic as a form builder, views from SimpleResource and restful actions from Inherited Resources.

### Configuring form builder

You can configure which form builders you want to use. Configuration can be done application-wide or per resource.

For example, if you like to use simple_form by default for all your resources, configure the builder in the app/views/simple_resource/_form.html.erb:

    <%= render_form "simple_form" %>

If you like to use simple_form only for products resource, put the above line into the app/views/products/_form.html.erb.

### Creating own form builder

Put your form builder into the app/views/simple_resource/builders/_my_builder.html.erb:

    <form>
      <% fields.each do |field| %>
        <%= input_field_tag(field) %>
      <% end %>
      <%= submit_tag "Submit" %>
    </form>

Then use it (see section "Configuring form builder"):

    <%= render_form "my_builder" %>

### Overriding views

You may override SimpleResource views application-wide or per resource.

## Support

If you have any questions or issues with SimpleResource, or if you like to report a bug, please create an [issue on GitHub](https://github.com/jarijokinen/simple_resource/issues).

## License

MIT License. Copyright (c) 2013 [Jari Jokinen](http://jarijokinen.com). See [LICENSE](https://github.com/jarijokinen/simple_resource/blob/master/LICENSE.txt) for further details.
