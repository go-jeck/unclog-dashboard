require 'test_helper'

class LogMetricsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @log_metric = log_metrics(:one)
  end

  test "should get index" do
    get log_metrics_url
    assert_response :success
  end
end
