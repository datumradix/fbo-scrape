require 'test_helper'

class EvaluationCodesControllerTest < ActionController::TestCase
  setup do
    @evaluation_code = evaluation_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evaluation_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create evaluation_code" do
    assert_difference('EvaluationCode.count') do
      post :create, evaluation_code: { name: @evaluation_code.name }
    end

    assert_redirected_to evaluation_code_path(assigns(:evaluation_code))
  end

  test "should show evaluation_code" do
    get :show, id: @evaluation_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @evaluation_code
    assert_response :success
  end

  test "should update evaluation_code" do
    patch :update, id: @evaluation_code, evaluation_code: { name: @evaluation_code.name }
    assert_redirected_to evaluation_code_path(assigns(:evaluation_code))
  end

  test "should destroy evaluation_code" do
    assert_difference('EvaluationCode.count', -1) do
      delete :destroy, id: @evaluation_code
    end

    assert_redirected_to evaluation_codes_path
  end
end
