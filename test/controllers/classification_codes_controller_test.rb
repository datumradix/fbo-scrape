require 'test_helper'

class ClassificationCodesControllerTest < ActionController::TestCase
  setup do
    @classification_code = classification_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:classification_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create classification_code" do
    assert_difference('ClassificationCode.count') do
      post :create, classification_code: { name: @classification_code.name }
    end

    assert_redirected_to classification_code_path(assigns(:classification_code))
  end

  test "should show classification_code" do
    get :show, id: @classification_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @classification_code
    assert_response :success
  end

  test "should update classification_code" do
    patch :update, id: @classification_code, classification_code: { name: @classification_code.name }
    assert_redirected_to classification_code_path(assigns(:classification_code))
  end

  test "should destroy classification_code" do
    assert_difference('ClassificationCode.count', -1) do
      delete :destroy, id: @classification_code
    end

    assert_redirected_to classification_codes_path
  end
end
