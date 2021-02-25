require 'speedtest'
require 'give_me_speed/version'

module GiveMeSpeed
  class Error < StandardError; end

  class SpeedTest
    attr_reader :last_run

    def initialize; end
  end
end
