require 'test_helper'

class MessageBuilderTest < Minitest::Test
  def test_builder_has_default_message_for_download
    builder = GiveMeSpeed::MessageBuilder.new
    message = builder.message_for(:comcast, mock_check(false))
    assert message =~ /I am currently paying for 100 Mbps of download speed to my ISP, but @comcast is giving me 10 Mbps. What gives?/
  end

  def test_builder_has_default_message_for_upload
    builder = GiveMeSpeed::MessageBuilder.new
    message = builder.message_for(:comcast, mock_check(true, false))
    assert message =~ /I am currently paying for 100 Mbps of upload speed to my ISP, but @comcast is giving me 10 Mbps. What gives?/
  end

  def test_builder_has_no_handle_for_no_isp
    builder = GiveMeSpeed::MessageBuilder.new
    message = builder.message_for(:non_existent_isp, mock_check(false))
    assert message =~ /I am currently paying for 100 Mbps of download speed to my ISP, but my isp is giving me 10 Mbps. What gives?/
  end

  private

  def mock_check(enough_download = true, enough_upload = true)
    result = OpenStruct.new(pretty_download_rate: '10 Mbps', pretty_upload_rate: '10 Mbps')
    OpenStruct.new(run: result, enough_download?: enough_download,
      enough_upload?: enough_upload)
  end

end