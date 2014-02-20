require 'test_helper'

class FoodFeedsControllerTest < ActionController::TestCase
  setup do
    @food_feed = food_feeds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:food_feeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food_feed" do
    assert_difference('FoodFeed.count') do
      post :create, food_feed: { description: @food_feed.description, image: @food_feed.image, title: @food_feed.title, url: @food_feed.url }
    end

    assert_redirected_to food_feed_path(assigns(:food_feed))
  end

  test "should show food_feed" do
    get :show, id: @food_feed
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @food_feed
    assert_response :success
  end

  test "should update food_feed" do
    patch :update, id: @food_feed, food_feed: { description: @food_feed.description, image: @food_feed.image, title: @food_feed.title, url: @food_feed.url }
    assert_redirected_to food_feed_path(assigns(:food_feed))
  end

  test "should destroy food_feed" do
    assert_difference('FoodFeed.count', -1) do
      delete :destroy, id: @food_feed
    end

    assert_redirected_to food_feeds_path
  end
end
