require 'test_helper'

class SetAsideRadiosControllerTest < ActionController::TestCase
  setup do
    @set_aside_radio = set_aside_radios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:set_aside_radios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create set_aside_radio" do
    assert_difference('SetAsideRadio.count') do
      post :create, set_aside_radio: { name: @set_aside_radio.name }
    end

    assert_redirected_to set_aside_radio_path(assigns(:set_aside_radio))
  end

  test "should show set_aside_radio" do
    get :show, id: @set_aside_radio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @set_aside_radio
    assert_response :success
  end

  test "should update set_aside_radio" do
    patch :update, id: @set_aside_radio, set_aside_radio: { name: @set_aside_radio.name }
    assert_redirected_to set_aside_radio_path(assigns(:set_aside_radio))
  end

  test "should destroy set_aside_radio" do
    assert_difference('SetAsideRadio.count', -1) do
      delete :destroy, id: @set_aside_radio
    end

    assert_redirected_to set_aside_radios_path
  end
end
