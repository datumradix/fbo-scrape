require 'test_helper'

class SolicitationNumbersControllerTest < ActionController::TestCase
  setup do
    @solicitation_number = solicitation_numbers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:solicitation_numbers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create solicitation_number" do
    assert_difference('SolicitationNumber.count') do
      post :create, solicitation_number: { name: @solicitation_number.name }
    end

    assert_redirected_to solicitation_number_path(assigns(:solicitation_number))
  end

  test "should show solicitation_number" do
    get :show, id: @solicitation_number
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @solicitation_number
    assert_response :success
  end

  test "should update solicitation_number" do
    patch :update, id: @solicitation_number, solicitation_number: { name: @solicitation_number.name }
    assert_redirected_to solicitation_number_path(assigns(:solicitation_number))
  end

  test "should destroy solicitation_number" do
    assert_difference('SolicitationNumber.count', -1) do
      delete :destroy, id: @solicitation_number
    end

    assert_redirected_to solicitation_numbers_path
  end
end
