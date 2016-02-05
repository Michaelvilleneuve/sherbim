# == Schema Information
#
# Table name: services
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string
#  description :text
#  place       :string
#  transport   :string
#  done        :boolean
#  price       :float
#  date        :datetime
#  code        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  nbpart      :integer
#  longitude   :string
#  latitude    :string
#  category_id :integer
#

require 'test_helper'

class ServicesControllerTest < ActionController::TestCase
  setup do
    @service = services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service" do
    assert_difference('Service.count') do
      post :create, service: { code: @service.code, date: @service.date, description: @service.description, place: @service.place, price: @service.price, statut: @service.statut, title: @service.title, transport: @service.transport, user_id: @service.user_id }
    end

    assert_redirected_to service_path(assigns(:service))
  end

  test "should show service" do
    get :show, id: @service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service
    assert_response :success
  end

  test "should update service" do
    patch :update, id: @service, service: { code: @service.code, date: @service.date, description: @service.description, place: @service.place, price: @service.price, statut: @service.statut, title: @service.title, transport: @service.transport, user_id: @service.user_id }
    assert_redirected_to service_path(assigns(:service))
  end

  test "should destroy service" do
    assert_difference('Service.count', -1) do
      delete :destroy, id: @service
    end

    assert_redirected_to services_path
  end
end
