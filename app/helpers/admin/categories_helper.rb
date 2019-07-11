module Admin::CategoriesHelper
  def load_sub_category category
    @sub_cats = Category.sub_cats(category.id)
  end
end
