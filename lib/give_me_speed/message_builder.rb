module GiveMeSpeed
  class MessageBuilder
    ISP_TWITTER_HANDLES = {
      comcast: '@comcast'
    }

    def message_for(isp_key, threshold_check)
      download_amt = threshold_check.run.pretty_download_rate
      "I am currently paying for 100 Mbps of download speed to my ISP, but #{isp(isp_key)} is giving me #{download_amt}. What gives?"
    end

    private

    def isp(key)
      ISP_TWITTER_HANDLES[key] || 'my isp'
    end
  end
end