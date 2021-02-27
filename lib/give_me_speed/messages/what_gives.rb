module GiveMeSpeed
  class WhatGives
    attr_reader :isp, :speedcheck

    def initialize(isp, speedcheck)
      @isp = isp
      @speedcheck = speedcheck
    end

    def download
      "I'm paying #{@isp} for #{present_speed(speedcheck.thresholds[:download])} download but I'm only getting #{download_rate}. What gives?"
    end

    def upload
      "I'm paying #{@isp} for #{present_speed(speedcheck.thresholds[:upload])} upload but I'm only getting #{upload_rate}. What gives?"
    end

    def both
      "I'm paying #{@isp} for #{present_speed(speedcheck.thresholds[:download])} download and #{present_speed(speedcheck.thresholds[:upload])} upload but I'm only getting #{download_rate} and #{upload_rate}. What gives?"
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