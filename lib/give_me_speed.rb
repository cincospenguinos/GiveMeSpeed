require 'give_me_speed/version'
require 'give_me_speed/threshold_check'
require 'give_me_speed/speedtest_interface'

module GiveMeSpeed
  class Error < StandardError; end

  class SpeedTest
    attr_reader :last_run

    def initialize; end

    def test
      @last_run = SpeedTest.interface.test
      ThresholdCheck.new(last_run, thresholds)
    end

    def self.download_threshold=(amt)
      @@download_amount = amt
    end

    def self.upload_threshold=(amt)
      @@upload_amount = amt
    end

    def self.interface
      @@speedtest_interface ||= SpeedtestInterface.new
    end

    def self.interface=(interface)
      @@speedtest_interface = interface
    end

    private

    def thresholds
      {
        download: @@download_amount || 1,
        upload: @@upload_amount || 1,
      }
    end
  end
end
