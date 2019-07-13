require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  def setup
    @category = Category.create(name: "Sports")
  end

  # test "should get categories index" do
  #   get categories_path
  #   assert_response :success
  # end
  #
  # test "should get new" do
  #   get new_article_path
  #   assert_response :success
  #
  # end

  # test "should get show" do
  #   get(category_path(@category))
  #   assert_response :success
  # end
end