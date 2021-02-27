require_relative './what_gives'

module GiveMeSpeed
  class WhyChargeForAmount < WhatGives
    def download
      "#{@isp} why am I getting charged for #{present_speed(speedcheck.thresholds[:download])} download but I'm only getting #{download_rate}? #GiveMeSpeed"
    end

    def upload
      "#{@isp} why am I getting charged for #{present_speed(speedcheck.thresholds[:upload])} upload but I'm only getting #{upload_rate}? #GiveMeSpeed"
    end

    def both
      "#{@isp} why am I getting charged for #{present_speed(speedcheck.thresholds[:upload])} upload and #{present_speed(speedcheck.thresholds[:download])} download but I'm only getting #{upload_rate} and #{download_rate}? #GiveMeSpeed"
    end
  end
end