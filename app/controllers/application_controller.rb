# frozen_string_literal: true

class ApplicationController < ActionController::Base
  around_action :switch_locale

  def default_url_options
    { locale: I18n.locale }
  end

  def switch_locale(&action)
    locale = extract_locale_from_uri || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def extract_locale_from_uri
    extracted_locale = request.fullpath.split("\/")[1]
    I18n.available_locales.map(&:to_s).include?(extracted_locale) ? extracted_locale : nil
  end
end
