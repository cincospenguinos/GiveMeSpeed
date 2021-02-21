require 'speedtest'

module GiveMeSpeed
  class SpeedtestInterface
    attr_reader :results

    DEFAULT_CONFIG = {
      download_runs: 4,
      upload_runs: 4,
      ping_runs: 4,
      download_sizes: [750, 1500],
      upload_sizes: [10000, 400000],
      debug: false
    }

    def initialize(options = {})
      config = DEFAULT_CONFIG.merge(options)
      @runner = Speedtest::Test.new(config)
    end

    def test
      @results = @runner.run
    end
  end
end