require 'test_helper'

class GiveMeSpeedTest < Minitest::Test
  def setup
    GiveMeSpeed::SpeedTest.interface = mock_interface
  end

  def test_that_it_has_a_version_number
    refute_nil ::GiveMeSpeed::VERSION
  end

  def test_speedtest_respects_provided_thresholds
    GiveMeSpeed::SpeedTest.config = { download: 1000, upload: 1000 }
    speedtest = GiveMeSpeed::SpeedTest.new
    refute speedtest.test.enough_download?
    refute speedtest.test.enough_upload?
  end

  private

  def mock_interface
    result = OpenStruct.new(download_rate: 100, upload_rate: 100)
    OpenStruct.new(test: result, result: result)
  end
end
