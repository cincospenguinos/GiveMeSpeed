module GiveMeSpeed
  class ThresholdCheck
    attr_reader :run, :threshold

    def initialize(speed_test_run, threshold)
      @run = speed_test_run
      @threshold = threshold
    end

    def enough_download?
      run.download_rate >= threshold[:download]
    end

    def enough_upload?
      run.upload_rate >= threshold[:upload]
    end
  end
end