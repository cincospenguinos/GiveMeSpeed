require_relative './messages/what_gives'
require_relative './messages/why_charge_for_amount'
require_relative './messages/still_not_getting'

module GiveMeSpeed
  class TweetMessage
    ISP_TWITTER_ACCOUNTS = {
      xfinity: '@xfinity'
    }

    attr_reader :speedcheck, :template

    def initialize(speedcheck, isp = nil, message_class = random_message_class)
      @speedcheck = speedcheck
      @isp = ISP_TWITTER_ACCOUNTS[isp] || 'my ISP'
      @template = message_class&.new(@isp, @speedcheck) || WhatGives.new(@isp, @speedcheck)
    end

    def message
      return nil if speedcheck.enough_download? && speedcheck.enough_upload?

      if !speedcheck.enough_download? && !speedcheck.enough_upload?
        template.both
      elsif !speedcheck.enough_upload?
        template.upload
      else
        template.download
      end
    end

    private

    def random_message_class
      [WhatGives, WhyChargeForAmount, StillNotGetting].shuffle.sample
    end
  end
end