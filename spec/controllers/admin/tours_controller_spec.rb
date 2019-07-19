require "rails_helper"
require "helpers/spec_test_helper"

RSpec.describe Admin::ToursController, type: :controller do
  include SpecTestHelper

  let(:admin) {FactoryBot.create :admin}
  let(:non_admin) {FactoryBot.create :user}
  let!(:category1) {FactoryBot.create :category1}
  let(:tour) {FactoryBot.create :tour}
  let(:invalid_params){{name: ""}}

  describe "GET index" do
    context "when user did not log in" do
      before{get :index}

      it{expect(response).to redirect_to login_path}
    end

    context "when non_admin log in" do
      before do
        log_in non_admin
        get :index
      end

      it{expect(response).to redirect_to root_path}
    end

    context "when admin log in" do
      before do
        log_in admin
        get :index
      end

      it{expect(response).to render_template :index}
    end
  end

  describe "GET new" do
    context "when user not log in" do
      before{get :new}

      it{expect(response).to redirect_to login_path}
    end

    context "when non_admin log in" do
      before do
        log_in non_admin
        get :new
      end

      it{expect(response).to redirect_to root_path}
    end

    context "when admin log in" do
      before do
        log_in admin
        get :new
      end

       it{expect(response).to render_template :new}
    end
  end

  describe "POST create" do
    before {log_in admin}

    context "when valid attributes" do
      it do
        post :create, params: {tour: FactoryBot.attributes_for(:tour)}
        expect(assigns(:tour)).to be_a Tour
      end
    end

    context "when invalid atrributes" do
      it do
        post :create, params: {tour: invalid_params}
        expect(response).to render_template :new
      end
    end
  end

  describe "GET edit" do
    context "when user not log in" do
      before{get :new}

      it{expect(response).to redirect_to login_path}
    end

    context "when non_admin log in" do
      before do
        log_in non_admin
        get :new
      end

      it{expect(response).to redirect_to root_path}
    end

    context "when admin log in" do
      before do
        log_in admin
        get :edit, params: {id: tour.id}
      end

      it{expect(response).to render_template :edit}
    end
  end

  describe "PUT update" do
    before{log_in admin}

    context "when valid attributes" do
      it do
        put :update, params: {tour: FactoryBot.attributes_for(:tour), id: tour.id}
        expect(assigns(:tour)).to be_a Tour
      end
    end

    context "when invalid atrributes" do
      it do
        put :update, params: {tour: invalid_params, id: tour.id}
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before{log_in admin}

    context "when admin delete success" do
      it do
        delete :destroy, params: {id: tour.id}
        expect(response).to redirect_to admin_tours_path
      end
    end
  end
end
