module GiveMeSpeed
  class TweetMessage
    ISP_TWITTER_ACCOUNTS = {
      xfinity: '@xfinity'
    }

    attr_reader :speedcheck

    def initialize(speedcheck, isp = nil)
      @speedcheck = speedcheck
      @isp = ISP_TWITTER_ACCOUNTS[isp] || 'my ISP'
    end

    def message
      return nil if speedcheck.enough_download? && speedcheck.enough_upload?

      if !speedcheck.enough_download? && !speedcheck.enough_upload?
        "I'm paying #{@isp} for #{present_speed(speedcheck.thresholds[:download])} download and #{present_speed(speedcheck.thresholds[:upload])} upload but I'm only getting #{download_rate} and #{upload_rate}. What gives?"
      elsif !speedcheck.enough_upload?
        "I'm paying #{@isp} for #{present_speed(speedcheck.thresholds[:upload])} upload but I'm only getting #{upload_rate}. What gives?"
      else
        "I'm paying #{@isp} for #{present_speed(speedcheck.thresholds[:download])} download but I'm only getting #{download_rate}. What gives?"
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
end