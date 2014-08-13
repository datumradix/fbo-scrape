require 'test_helper'

class SetAsidesControllerTest < ActionController::TestCase
  setup do
    @set_aside = set_asides(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:set_asides)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create set_aside" do
    assert_difference('SetAside.count') do
      post :create, set_aside: { name: @set_aside.name }
    end

    assert_redirected_to set_aside_path(assigns(:set_aside))
  end

  test "should show set_aside" do
    get :show, id: @set_aside
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @set_aside
    assert_response :success
  end

  test "should update set_aside" do
    patch :update, id: @set_aside, set_aside: { name: @set_aside.name }
    assert_redirected_to set_aside_path(assigns(:set_aside))
  end

  test "should destroy set_aside" do
    assert_difference('SetAside.count', -1) do
      delete :destroy, id: @set_aside
    end

    assert_redirected_to set_asides_path
  end
end
