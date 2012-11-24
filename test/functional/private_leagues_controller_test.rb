require 'test_helper'

class PrivateLeaguesControllerTest < ActionController::TestCase
  setup do
    @private_league = private_leagues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:private_leagues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create private_league" do
    assert_difference('PrivateLeague.count') do
      post :create, private_league: @private_league.attributes
    end

    assert_redirected_to private_league_path(assigns(:private_league))
  end

  test "should show private_league" do
    get :show, id: @private_league.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @private_league.to_param
    assert_response :success
  end

  test "should update private_league" do
    put :update, id: @private_league.to_param, private_league: @private_league.attributes
    assert_redirected_to private_league_path(assigns(:private_league))
  end

  test "should destroy private_league" do
    assert_difference('PrivateLeague.count', -1) do
      delete :destroy, id: @private_league.to_param
    end

    assert_redirected_to private_leagues_path
  end
end
