require 'speedtest'
require 'give_me_speed/version'
require 'give_me_speed/speedtest_interface'
require 'give_me_speed/tweet_message'
require 'give_me_speed/speed_check'

module GiveMeSpeed
  def self.tweet_for(speedcheck)
    TweetMessage.new(speedcheck).message
  end
end
