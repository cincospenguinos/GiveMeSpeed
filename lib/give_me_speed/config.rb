module GiveMeSpeed
  class Config
    attr_reader :opts

    DEFAULT_CONFIG = {
      isp: nil,
      thresholds: nil,
      twitter_keys: {
        api_key: ENV['TWITTER_API_KEY'],
        api_secret: ENV['TWITTER_API_SECRET'],
        access_token: ENV['TWITTER_ACCESS_TOKEN'],
        access_secret: ENV['TWITTER_ACCESS_SECRET']
      }
    }

    def initialize(opts = {})
      @opts = DEFAULT_CONFIG.merge(opts)
    end

    def isp
      @opts[:isp]
    end

    def thresholds
      @opts[:thresholds]
    end

    def valid?
      return false unless thresholds && @opts[:twitter_keys]

      all_keys = @opts[:twitter_keys].keys == DEFAULT_CONFIG[:twitter_keys].keys
      all_values = @opts[:twitter_keys].values.all? { |v| !!v }
      all_keys && all_values
    end

    def twitter_interface
      @interface ||= GiveMeSpeed::TwitterInterface.new(opts[:twitter_keys])
    end

    def twitter_interface=(interface)
      @interface = interface
    end

    def self.config
      @@config ||= Config.new
    end

    def self.config=(opts = {})
      old_config = self.config
      @@config = Config.new(old_config.opts.merge(opts))
    end
  end
end