require 'test_helper'

class ThresholdCheckTest < Minitest::Test
  def default_threshold_amounts
    {
      download: 1000,
      upload: 1000,
    }
  end

  def test_download_is_respected
    run = OpenStruct.new(download_rate: 1, upload_rate: 1000)
    check = GiveMeSpeed::ThresholdCheck.new(run, default_threshold_amounts)
    refute check.enough_download?
    assert check.enough_upload?
  end

  def test_upload_is_respected
    run = OpenStruct.new(download_rate: 1000, upload_rate: 100)
    check = GiveMeSpeed::ThresholdCheck.new(run, default_threshold_amounts)
    assert check.enough_download?
    refute check.enough_upload?
  end
end