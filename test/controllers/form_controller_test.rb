require 'test_helper'

class FormControllerTest < ActionController::TestCase
  test "should get input" do
    get :input
    assert_response :success
  end

end
