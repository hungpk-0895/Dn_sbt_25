require "rails_helper"

describe "admin/tours/edit.html.erb" do
  subject{rendered}
  let!(:categories){Category.sub_categories}
  let!(:category){FactoryBot.create :category1}
  let(:tour) {FactoryBot.create :tour}

  before do
    assign :tour, tour
    assign :category, category
    assign :categories, categories
    render
  end

  it {is_expected.to have_content I18n.t("admin.tours.edit.title")}

  describe "form" do
    it{assert_select "form[action*=?]", admin_tour_path(id: tour.id)}

    it{is_expected.to have_field "tour_name"}

    it{is_expected.to have_field "tour_description"}

    it{is_expected.to have_field "tour_place"}

    it{is_expected.to have_field "tour_picture"}

    it{is_expected.to have_field "tour_start_time"}

    it{is_expected.to have_field "tour_price"}

    it{is_expected.to have_field "tour_status"}

    it{is_expected.to have_field "tour_category_id"}

    it{is_expected.to have_link I18n.t("admin.tours.new.btn_cancel"), href: admin_tours_path}

  end

end
