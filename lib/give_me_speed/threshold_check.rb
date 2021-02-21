module GiveMeSpeed
  class ThresholdCheck
    attr_reader :download, :upload, :threshold

    def initialize(download, upload, threshold)
      @download = download
      @upload = upload
      @threshold = threshold
    end

    def enough_download?
      download[:amount] >= threshold[:download][:amount]
    end

    def enough_upload?
      upload[:amount] >= threshold[:upload][:amount]
    end
  end
end