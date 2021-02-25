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
      return nil if speedcheck.enough_download? && speedcheck.enough_upload?

      if !speedcheck.enough_download? && !speedcheck.enough_upload?
        "I'm paying @comcast for #{present_speed(speedcheck.thresholds[:download])} download and #{present_speed(speedcheck.thresholds[:upload])} upload but I'm only getting #{download_rate} and #{upload_rate}. What gives?"
      elsif !speedcheck.enough_upload?
        "I'm paying @comcast for #{present_speed(speedcheck.thresholds[:upload])} upload but I'm only getting #{upload_rate}. What gives?"
      else
        "I'm paying @comcast for #{present_speed(speedcheck.thresholds[:download])} download but I'm only getting #{download_rate}. What gives?"
      end
    end

    private

    def download_rate
      speedcheck.last_run.pretty_download_rate
    end

    def upload_rate
      speedcheck.last_run.pretty_upload_rate
    end

    def present_speed(rate)
      units = %w(bps Kbps Mbps Gbps Tbps)
      unit_index = 0

      while rate > 1024
        rate /= 1024
        unit_index += 1
      end

      "#{rate} #{units[unit_index]}"
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
