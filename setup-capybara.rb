# Require the gems
require 'capybara/poltergeist'

# Configure Poltergeist to not blow up on websites with js errors aka every website with js
# See more options at https://github.com/teampoltergeist/poltergeist#customization

# Configure Capybara to use Poltergeist as the driver
Capybara.default_driver = :webkit
