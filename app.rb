require 'bundler/setup'
Bundler.require

module EaterAtlas
  class Web < Sinatra::Base
    configure do
      enable :sessions
      set :assets_precompile, %w(application.js styles.css *.png *.jpg *.svg *.eot *.ttf *.woff)
      set :assets_css_compressor, :sass
      helpers  Sinatra::Cookies
      register Sinatra::AssetPipeline

      # Actual Rails Assets integration, everything else is Sprockets
      if defined?(RailsAssets)
        RailsAssets.load_paths.each do |path|
          settings.sprockets.append_path(path)
        end
      end
    end

    def self.title
      "EaterAtlas"
    end


    get '/' do
      @weekday = Time.now.strftime("%A")
      @meal    = "Lunch"
      erb :index
    end
  end
end