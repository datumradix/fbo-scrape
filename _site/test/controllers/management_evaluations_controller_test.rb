require 'test_helper'

class ManagementEvaluationsControllerTest < ActionController::TestCase
  setup do
    @management_evaluation = management_evaluations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:management_evaluations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create management_evaluation" do
    assert_difference('ManagementEvaluation.count') do
      post :create, management_evaluation: { evaluation: @management_evaluation.evaluation, opportunity_id: @management_evaluation.opportunity_id }
    end

    assert_redirected_to management_evaluation_path(assigns(:management_evaluation))
  end

  test "should show management_evaluation" do
    get :show, id: @management_evaluation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @management_evaluation
    assert_response :success
  end

  test "should update management_evaluation" do
    patch :update, id: @management_evaluation, management_evaluation: { evaluation: @management_evaluation.evaluation, opportunity_id: @management_evaluation.opportunity_id }
    assert_redirected_to management_evaluation_path(assigns(:management_evaluation))
  end

  test "should destroy management_evaluation" do
    assert_difference('ManagementEvaluation.count', -1) do
      delete :destroy, id: @management_evaluation
    end

    assert_redirected_to management_evaluations_path
  end
end
