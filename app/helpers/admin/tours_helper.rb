module Admin::ToursHelper
  def check_currency value
    return value if params[:locale] == Settings.locale_en
    value / 22_000 unless value.nil?
  end
end
