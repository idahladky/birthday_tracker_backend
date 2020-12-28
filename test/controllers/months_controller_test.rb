require 'test_helper'

class MonthsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @month = months(:one)
  end

  test "should get index" do
    get months_url, as: :json
    assert_response :success
  end

  test "should create month" do
    assert_difference('Month.count') do
      post months_url, params: { month: { month: @month.month } }, as: :json
    end

    assert_response 201
  end

  test "should show month" do
    get month_url(@month), as: :json
    assert_response :success
  end

  test "should update month" do
    patch month_url(@month), params: { month: { month: @month.month } }, as: :json
    assert_response 200
  end

  test "should destroy month" do
    assert_difference('Month.count', -1) do
      delete month_url(@month), as: :json
    end

    assert_response 204
  end
end
