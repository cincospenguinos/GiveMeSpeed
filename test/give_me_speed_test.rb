require 'test_helper'

class GiveMeSpeedTest < Minitest::Test
  def setup
    GiveMeSpeed::SpeedCheck.interface = mock_interface
    GiveMeSpeed::Config.config = {
      isp: nil,
      thresholds: { download: 1000000, upload: 1000000 },
      twitter_keys: {
        api_key: 'yup',
        api_secret: 'yup',
        access_token: 'yup',
        access_secret: 'yup'
      }
    }
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

  def test_tweet_for_handles_indicates_download_speed
    check = GiveMeSpeed::SpeedCheck.new({ download: 100, upload: 1 })
    assert GiveMeSpeed.tweet_for(check) =~ /\d+ [a-zA-Z]{3,4} download/
  end

  def test_tweet_for_handles_indicates_upload_speed
    check = GiveMeSpeed::SpeedCheck.new({ download: 1, upload: 100 })
    assert GiveMeSpeed.tweet_for(check) =~ /\d+ [a-zA-Z]{3,4} upload/
  end

  def test_tweet_for_handles_both
    check = GiveMeSpeed::SpeedCheck.new({ download: 100, upload: 100 })
    assert GiveMeSpeed.tweet_for(check) =~ /\d+ [a-zA-Z]{3,4} download/
    assert GiveMeSpeed.tweet_for(check) =~ /\d+ [a-zA-Z]{3,4} upload/
  end

  def test_tweet_for_returns_nil_if_no_need_for_tweet
    check = GiveMeSpeed::SpeedCheck.new({ download: 0, upload: 0 })
    assert_nil GiveMeSpeed.tweet_for(check)
  end

  def test_tweet_for_handles_unit_conversion
    check = GiveMeSpeed::SpeedCheck.new({ download: 10, upload: 10000000000 })
    assert GiveMeSpeed.tweet_for(check) =~ /10 bps/
    assert GiveMeSpeed.tweet_for(check) =~ /9 Gbps/
  end

  def test_tweet_for_respects_isp
    check = GiveMeSpeed::SpeedCheck.new({ download: 100, upload: 1 })
    GiveMeSpeed.config = { isp: :xfinity }
    assert GiveMeSpeed.tweet_for(check) =~ /@xfinity/
  end

  def test_config_needs_thresholds
    GiveMeSpeed::Config.config = { thresholds: nil }
    refute GiveMeSpeed::Config.config.valid?
  end

  def test_config_needs_twitter_info
    GiveMeSpeed::Config.config = { twitter_keys: nil }
    refute GiveMeSpeed::Config.config.valid?
  end

  def test_config_needs_all_the_twitter_info
    GiveMeSpeed::Config.config = {
      twitter_keys: {
        api_key: 'yes',
        api_secret: nil,
        access_token: 'yup'
      }
    }
    refute GiveMeSpeed::Config.config.valid?
  end

  def test_pester_submits_tweet
    GiveMeSpeed::Config.config.twitter_interface = mock_twitter_interface
    GiveMeSpeed.pester!
    refute mock_twitter_interface.last_message.nil?
  end

  private

  class MockTwitterInterface
    attr_reader :last_message

    def initialize(_keys); end

    def tweet!(message)
      @last_message = message
    end
  end

  def mock_interface
    result = OpenStruct.new(download_rate: 1, upload_rate: 1, pretty_download_rate: '1 Mbps',
      pretty_upload_rate: '1 Mbps')
    OpenStruct.new(run_test: result)
  end

  def mock_twitter_interface
    @mock_twitter_interface ||= MockTwitterInterface.new(nil)
  end
end
