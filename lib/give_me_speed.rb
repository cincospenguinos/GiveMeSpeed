require 'give_me_speed/version'
require 'give_me_speed/threshold_check'
require 'give_me_speed/speedtest_interface'

module GiveMeSpeed
  class Error < StandardError; end

  class SpeedTest
    attr_reader :last_run

    DEFAULT_CONFIG = {
      download: 1,
      upload: 1
    }

    def initialize; end

    def test
      @last_run = SpeedTest.interface.test
      ThresholdCheck.new(last_run, thresholds)
    end

    def self.config=(config = {})
      @@config = DEFAULT_CONFIG.merge(config)
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
        download: @@config[:download],
        upload: @@config[:upload],
      }
    end
  end
end
