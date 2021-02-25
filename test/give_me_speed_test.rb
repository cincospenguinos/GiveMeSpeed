require 'test_helper'

class GiveMeSpeedTest < Minitest::Test
  def setup
    GiveMeSpeed::SpeedCheck.interface = mock_interface
  end

  def test_speed_check_respects_threshold_for_download
    check = GiveMeSpeed::SpeedCheck.new({ download: 100, upload: 1 })
    assert check.enough_upload?
    refute check.enough_download?
  end

  def test_speed_check_respects_threshold_for_upload
    check = GiveMeSpeed::SpeedCheck.new({ download: 1, upload: 100 })
    refute check.enough_upload?
    assert check.enough_download?
  end

  def test_message_for_handles_indicates_download_speed
    check = GiveMeSpeed::SpeedCheck.new({ download: 100, upload: 1 })
    assert GiveMeSpeed.tweet_for(check) =~ /I'm paying @comcast for \d+ [a-zA-Z]{4} download but I'm only getting \d+ [a-zA-Z]{4}. What gives?/
  end

  def test_message_for_handles_indicates_upload_speed
    check = GiveMeSpeed::SpeedCheck.new({ download: 1, upload: 100 })
    assert GiveMeSpeed.tweet_for(check) =~ /I'm paying @comcast for \d+ [a-zA-Z]{4} upload but I'm only getting \d+ [a-zA-Z]{4}. What gives?/
  end

  def test_message_for_handles_both
    check = GiveMeSpeed::SpeedCheck.new({ download: 1, upload: 1 })
    assert GiveMeSpeed.tweet_for(check) =~ /I'm paying @comcast for \d+ [a-zA-Z]{4} download and \d+ [a-zA-Z]{4} upload but I'm only getting \d+ [a-zA-Z]{4} and \d+ [a-zA-Z]{4}. What gives?/
  end

  def test_message_for_returns_nil_if_no_need_for_tweet
    check = GiveMeSpeed::SpeedCheck.new({ download: 1, upload: 1 })
    assert_nil GiveMeSpeed.tweet_for(check)
  end

  private

  def mock_interface
    result = OpenStruct.new(download_rate: 1, upload_rate: 1, pretty_download_rate: '1 Mbps',
      pretty_upload_rate: '1 Mbps')
    OpenStruct.new(run_test: result)
  end
end
