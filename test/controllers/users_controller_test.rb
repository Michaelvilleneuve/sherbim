# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  name             :string
#  firstname        :string
#  description      :text
#  email            :string
#  phone            :string
#  age              :integer
#  points           :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  provider         :string
#  uid              :string
#  oauth_token      :string
#  oauth_expires_at :datetime
#  image            :string
#  role             :string
#

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { age: @user.age, description: @user.description, email: @user.email, firstname: @user.firstname, name: @user.name, phone: @user.phone, points: @user.points }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { age: @user.age, description: @user.description, email: @user.email, firstname: @user.firstname, name: @user.name, phone: @user.phone, points: @user.points }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
