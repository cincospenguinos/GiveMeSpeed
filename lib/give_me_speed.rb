require 'speedtest'
require 'give_me_speed/version'
require 'give_me_speed/speedtest_interface'

module GiveMeSpeed
  class TweetMessage
    attr_reader :speedcheck

    def initialize(speedcheck)
      @speedcheck = speedcheck
    end

    def message
      "I'm paying @comcast for 100 Mbps download but I'm only getting #{download_rate}. What gives?"
    end

    private

    def download_rate
      speedcheck.last_run.pretty_download_rate
    end

    def upload_rate
      speedcheck.last_run.pretty_upload_rate
    end
  end

  def self.tweet_for(speedcheck)
    TweetMessage.new(speedcheck).message
  end

  class SpeedCheck
    attr_reader :thresholds

    def initialize(thresholds)
      @thresholds = thresholds
      @last_run = nil
    end

    def enough_upload?
      last_run.upload_rate >= thresholds[:upload]
    end

    def enough_download?
      last_run.download_rate >= thresholds[:download]
    end

    def last_run
      @last_run ||= SpeedCheck.interface.run_test
    end

    def self.interface
      @@interface ||= SpeedtestInterface.new
    end

    def self.interface=(interface)
      @@interface = interface
    end
  end
end
