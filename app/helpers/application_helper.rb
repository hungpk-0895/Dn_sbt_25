module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "helpers.base_title"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def change_en_to_vn num_en
    num_en * 22_000
  end

  def currency value
    return value if params[:locale] == Settings.locale_en
    value * 22_000
  end

  def have_picture?
    Tour.picture.present?
  end
end
