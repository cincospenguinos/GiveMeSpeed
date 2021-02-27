require 'speedtest'
require 'give_me_speed/version'
require 'give_me_speed/speedtest_interface'
require 'give_me_speed/tweet_message'
require 'give_me_speed/speed_check'

module GiveMeSpeed
  class Config
    attr_reader :opts

    DEFAULT_CONFIG = {
      isp: nil
    }

    def initialize(opts = {})
      @opts = DEFAULT_CONFIG.merge(opts)
    end

    def isp
      @opts[:isp]
    end

    def self.config
      @@config ||= Config.new
    end

    def self.config=(opts = {})
      old_config = self.config
      @@config = Config.new(old_config.opts.merge(opts))
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
