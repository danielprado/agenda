require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @contact = contacts(:pedro)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get :index, user_id: @user.id
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  test "should get new" do
    get :new, user_id: @user.id
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post :create, user_id: @user.id, contact: { email: "test@gmail.com", name: "Nuevo", surnames: "Juarez", category: "Familiares", user_id: @user.id }
    end

    assert_redirected_to user_contact_path(@user,assigns(:contact))
  end

  test "should show contact" do
    get :show, id: @contact.id, user_id: @user.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact, user_id: @user.id
    assert_response :success
  end

  test "should update contact" do
    patch :update, id: @contact.id, user_id: @user.id, contact: { email: "test@gmail.com", name: "Nuevo", surnames: "Juarez", category: "Familiares", user_id: @user.id }
    assert_redirected_to user_contact_path(@user,assigns(:contact))
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete :destroy, id: @contact, user_id: @user.id
    end

    assert_redirected_to user_contacts_path(@user)
  end
end
