module Helpers
  def set_locale(locale = "fi")
    I18n.locale = locale
  end

  def reset_locale
    I18n.locale = I18n.default_locale
  end
end
