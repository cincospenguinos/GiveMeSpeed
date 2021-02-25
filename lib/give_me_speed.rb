require 'speedtest'
require 'give_me_speed/version'

module GiveMeSpeed
  class SpeedtestInterface
    def initialize; end

    def run_test
      Speedtest::Test.new.run
    end
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
