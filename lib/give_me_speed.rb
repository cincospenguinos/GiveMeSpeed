require 'give_me_speed/version'
require 'give_me_speed/speedtest_interface'
require 'give_me_speed/tweet_message'
require 'give_me_speed/speed_check'
require 'give_me_speed/twitter_interface'
require 'give_me_speed/config'

module GiveMeSpeed
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
