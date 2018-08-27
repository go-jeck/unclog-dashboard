class PredictionController < ApplicationController
  helper_method :options_prediction, :node_id, :log_level

  def log_metric_prediction
    x_axis = LogMetricPrediction.distinct.pluck(:timestamp)
    labels = LogMetricPrediction.distinct.pluck(:log_level)

    datasets = []

    labels.each do |label|
      color = random_color
      quantities = LogMetricPrediction.select('quantity').where(log_level: label).pluck('quantity')
      items = []

      if quantities.length < x_axis.length then
        diff = x_axis.length - quantities.length

        for i in 0...diff
          items.push(0)
        end
      end

      items.concat(quantities)

      datasets.push(
        label: label,
        borderColor: color,
        backgroundColor: color,
        data: items,
        fill: false
      )

      Rails.logger.debug(items)
    end

    @data = {
      labels: x_axis,
      datasets: datasets
    }

    @options = {
      responsive: true,
      maintainAspectRatio: false,
      tooltips: {
        mode: 'index',
        intersect: false
      },
      hover: {
        mode: 'nearest',
        intersect: true
      },
      scales: {
        xAxes: [{
          display: false,
          scaleLabel: {
            display: true,
            labelString: 'Time'
          }
        }],
        yAxes: [{
          display: true,
          scaleLabel: {
            display: true,
            labelString: 'Quantity'
          }
        }]
      }
    }
  end

  def app_options
    all_app_combinations = LogMetricPrediction.select(:app_name, :node_id, :log_level).distinct.order(:app_name, :node_id, :log_level).as_json(:except => :id)
    render json: all_app_combinations
  end

  def chart_data
    data = LogMetricPrediction.select('*').where(:app_name => params['app_name'], :node_id => params['node_id'], :log_level => params['log_level'])
    render json: data
  end

  def random_color
    'rgba(' + String(generate_number) + ',' + String(generate_number) + ',' + String(generate_number) + ', 1)'
  end

  def generate_number
    rand(0...255)
  end

  def moving_avg(data, duration, round)
    data.each_cons(duration).map { |sma| sma.reduce(&:+).fdiv(duration).round(round) }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_log_metric
    @log_metric = LogMetricPrediction.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def log_metric_params
    params.fetch(:log_metric, {})
  end
end
