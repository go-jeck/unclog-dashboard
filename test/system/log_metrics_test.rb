require "application_system_test_case"

class LogMetricsTest < ApplicationSystemTestCase
  setup do
    @log_metric = log_metrics(:one)
  end

  test "visiting the index" do
    visit log_metrics_url
    assert_selector "h1", text: "Log Metrics"
  end
end
