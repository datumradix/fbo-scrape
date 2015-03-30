require 'test_helper'

class NaicsCodesControllerTest < ActionController::TestCase
  setup do
    @naics_code = naics_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:naics_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create naics_code" do
    assert_difference('NaicsCode.count') do
      post :create, naics_code: { name: @naics_code.name }
    end

    assert_redirected_to naics_code_path(assigns(:naics_code))
  end

  test "should show naics_code" do
    get :show, id: @naics_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @naics_code
    assert_response :success
  end

  test "should update naics_code" do
    patch :update, id: @naics_code, naics_code: { name: @naics_code.name }
    assert_redirected_to naics_code_path(assigns(:naics_code))
  end

  test "should destroy naics_code" do
    assert_difference('NaicsCode.count', -1) do
      delete :destroy, id: @naics_code
    end

    assert_redirected_to naics_codes_path
  end
end
