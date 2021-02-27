require_relative './what_gives'

module GiveMeSpeed
  class StillNotGetting < WhatGives
    def download
      "I'm still not getting what I paid for #{@isp}. I was promised #{present_speed(speedcheck.thresholds[:download])} download but I'm getting #{download_rate} #GiveMeSpeed"
    end

    def upload
      "I'm still not getting what I paid for #{@isp}. I was promised #{present_speed(speedcheck.thresholds[:upload])} upload but I'm getting #{upload_rate} #GiveMeSpeed"
    end

    def both
      "I'm still not getting what I paid for #{@isp}. I was promised #{present_speed(speedcheck.thresholds[:upload])} upload and #{present_speed(speedcheck.thresholds[:download])} download but I'm getting #{upload_rate} and #{download_rate}#GiveMeSpeed"
    end
  end
end