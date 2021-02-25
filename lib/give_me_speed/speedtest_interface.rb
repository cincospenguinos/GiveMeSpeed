module GiveMeSpeed
  class SpeedtestInterface
    def initialize; end

    def run_test
      Speedtest::Test.new.run
    end
  end
end