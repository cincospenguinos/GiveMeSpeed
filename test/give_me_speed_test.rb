require 'test_helper'

class GiveMeSpeedTest < Minitest::Test
  def setup
    GiveMeSpeed::SpeedCheck.interface = mock_interface
  end

  def test_speed_check_respects_threshold
    check = GiveMeSpeed::SpeedCheck.new({ download: 100, upload: 1 })
    assert check.enough_upload?
    refute check.enough_download?
  end

  private

  def mock_interface
    result = OpenStruct.new(download_rate: 1, upload_rate: 1, pretty_download_rate: "1 Mbps",
      pretty_upload_rate: "1 Mbps")
    OpenStruct.new(run_test: result)
  end
end
