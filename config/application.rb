require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.generators do |g|
      g.test_framework :rspec
      g.assets false          #CSS,JavaScriptファイルは生成しない
      # g.test_framework false  #testファイルは生成しない
    end

    # ブラウザ側でJavaSciptが無効になっていた場合でも動くようにする
    config.action_view.embed_authenticity_token_in_remote_forms = true
    # 時間を東京に設定
    config.time_zone = 'Tokyo'
  end
end
