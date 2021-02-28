require 'twitter'

module GiveMeSpeed
  class TwitterInterface
    def initialize(twitter_keys)
      @twitter_keys = twitter_keys
    end

    def tweet!(message)
      client.update(message)
    end

    def client
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key = @twitter_keys[:api_key]
        config.consumer_secret = @twitter_keys[:api_secret]
        config.access_token = @twitter_keys[:access_token]
        config.access_token_secret = @twitter_keys[:access_secret]
      end
    end

    private
  end
end