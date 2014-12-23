require 'test_helper'

class SearchKeywordsControllerTest < ActionController::TestCase
  setup do
    @search_keyword = search_keywords(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:search_keywords)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search_keyword" do
    assert_difference('SearchKeyword.count') do
      post :create, search_keyword: { name: @search_keyword.name, team_id: @search_keyword.team_id }
    end

    assert_redirected_to search_keyword_path(assigns(:search_keyword))
  end

  test "should show search_keyword" do
    get :show, id: @search_keyword
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @search_keyword
    assert_response :success
  end

  test "should update search_keyword" do
    patch :update, id: @search_keyword, search_keyword: { name: @search_keyword.name, team_id: @search_keyword.team_id }
    assert_redirected_to search_keyword_path(assigns(:search_keyword))
  end

  test "should destroy search_keyword" do
    assert_difference('SearchKeyword.count', -1) do
      delete :destroy, id: @search_keyword
    end

    assert_redirected_to search_keywords_path
  end
end
