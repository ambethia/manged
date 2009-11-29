RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'

  config.gem 'haml'
  config.gem 'compass'
  config.gem 'sprockets'
  config.gem 'formtastic'
  config.gem 'will_paginate'
  config.gem 'thinking-sphinx',
             :lib => 'thinking_sphinx/0.9.8'
end