require "emailnet/engine"

module Emailnet
  # Your code goes here...
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :bee_client_id,
                  :bee_client_secret,
                  :definition_file
  end
end
