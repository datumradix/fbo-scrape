require 'test_helper'

class SelectionCriteriaControllerTest < ActionController::TestCase
  setup do
    @selection_criterium = selection_criteria(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:selection_criteria)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create selection_criterium" do
    assert_difference('SelectionCriterium.count') do
      post :create, selection_criterium: { classification_code_id: @selection_criterium.classification_code_id, procurement_type_id: @selection_criterium.procurement_type_id, set_aside_id: @selection_criterium.set_aside_id }
    end

    assert_redirected_to selection_criterium_path(assigns(:selection_criterium))
  end

  test "should show selection_criterium" do
    get :show, id: @selection_criterium
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @selection_criterium
    assert_response :success
  end

  test "should update selection_criterium" do
    patch :update, id: @selection_criterium, selection_criterium: { classification_code_id: @selection_criterium.classification_code_id, procurement_type_id: @selection_criterium.procurement_type_id, set_aside_id: @selection_criterium.set_aside_id }
    assert_redirected_to selection_criterium_path(assigns(:selection_criterium))
  end

  test "should destroy selection_criterium" do
    assert_difference('SelectionCriterium.count', -1) do
      delete :destroy, id: @selection_criterium
    end

    assert_redirected_to selection_criteria_path
  end
end
