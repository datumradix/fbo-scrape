require 'test_helper'

class ProcurementTypesControllerTest < ActionController::TestCase
  setup do
    @procurement_type = procurement_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:procurement_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create procurement_type" do
    assert_difference('ProcurementType.count') do
      post :create, procurement_type: { name: @procurement_type.name }
    end

    assert_redirected_to procurement_type_path(assigns(:procurement_type))
  end

  test "should show procurement_type" do
    get :show, id: @procurement_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @procurement_type
    assert_response :success
  end

  test "should update procurement_type" do
    patch :update, id: @procurement_type, procurement_type: { name: @procurement_type.name }
    assert_redirected_to procurement_type_path(assigns(:procurement_type))
  end

  test "should destroy procurement_type" do
    assert_difference('ProcurementType.count', -1) do
      delete :destroy, id: @procurement_type
    end

    assert_redirected_to procurement_types_path
  end
end
