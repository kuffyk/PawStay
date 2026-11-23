# frozen_string_literal: true

module PawStay
  class Application < Rails::Application
    config.i18n.available_locales = %i[en ua]
  end
end
