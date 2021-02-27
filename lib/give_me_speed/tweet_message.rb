require_relative './messages/what_gives'

module GiveMeSpeed
  class TweetMessage
    ISP_TWITTER_ACCOUNTS = {
      xfinity: '@xfinity'
    }

    attr_reader :speedcheck, :template

    def initialize(speedcheck, isp = nil, message_class = nil)
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
  end
end