require 'give_me_speed/version'
require 'give_me_speed/speedtest_interface'
require 'give_me_speed/tweet_message'
require 'give_me_speed/speed_check'
require 'give_me_speed/twitter_interface'

module GiveMeSpeed
  class Config
    attr_reader :opts

    DEFAULT_CONFIG = {
      isp: nil,
      thresholds: nil,
      twitter_keys: {
        api_key: ENV['TWITTER_API_KEY'],
        api_secret: ENV['TWITTER_API_SECRET'],
        access_token: ENV['TWITTER_ACCESS_TOKEN'],
        access_secret: ENV['TWITTER_ACCESS_SECRET']
      }
    }

    def initialize(opts = {})
      @opts = DEFAULT_CONFIG.merge(opts)
    end

    def isp
      @opts[:isp]
    end

    def thresholds
      @opts[:thresholds]
    end

    def valid?
      return false unless thresholds && @opts[:twitter_keys]

      all_keys = @opts[:twitter_keys].keys == DEFAULT_CONFIG[:twitter_keys].keys
      all_values = @opts[:twitter_keys].values.all? { |v| !!v }
      all_keys && all_values
    end

    def twitter_interface
      @interface ||= TwitterInterface.new(opts[:twitter_keys])
    end

    def twitter_interface=(interface)
      @interface = interface
    end

    def self.config
      @@config ||= Config.new
    end

    def self.config=(opts = {})
      old_config = self.config
      @@config = Config.new(old_config.opts.merge(opts))
    end
  end

  def self.pester!
    check = SpeedCheck.new(Config.config.thresholds)
    if (message = self.tweet_for(check))
      Config.config.twitter_interface.tweet!(message)
    end
  end

  def self.tweet_for(speedcheck)
    isp = Config.config.isp
    TweetMessage.new(speedcheck, isp).message
  end

  def self.config=(opts = {})
    Config.config = opts
  end
end
