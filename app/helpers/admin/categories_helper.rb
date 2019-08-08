module Admin::CategoriesHelper
  def load_sub_category category
    @sub_cats = Category.sub_cats(category.id)
  end

  def check_parent_category category
    (category.parent_id.nil? || category.parent_id != 0) ? true : false
  end
end
