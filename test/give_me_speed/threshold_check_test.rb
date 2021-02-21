require 'test_helper'

class ThresholdCheckTest < Minitest::Test
  def default_threshold_amounts
    {
      download: {amount: 10, unit: :megabits },
      upload: {amount: 1, unit: :megabits },
    }
  end

  def test_threshold_check_respects_download
    download = { amount: 1, unit: :megabits }
    upload = { amount: 1, unit: :megabits }

    check = GiveMeSpeed::ThresholdCheck.new(download, upload, default_threshold_amounts)
    refute check.enough_download?
    assert check.enough_upload?
  end

  def test_threshold_check_respects_upload
    download = { amount: 10, unit: :megabits }
    upload = { amount: 0.1, unit: :megabits }

    check = GiveMeSpeed::ThresholdCheck.new(download, upload, default_threshold_amounts)
    assert check.enough_download?
    refute check.enough_upload?
  end
end