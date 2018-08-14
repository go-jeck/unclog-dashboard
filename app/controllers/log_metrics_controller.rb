# frozen_string_literal: true

class LogMetricsController < ApplicationController
  before_action :set_log_metric, only: %i[show edit update destroy]

  # GET /log_metrics
  # GET /log_metrics.json
  def index
    x_axis = LogMetric.select("date_trunc('minute', timestamp) as time").group('time').order('time').pluck("date_trunc('minute', timestamp) as time")
    labels = LogMetric.distinct.pluck(:log_level)

    datasets = []

    labels.each do |label|
      color = random_color
      quantities = LogMetric.select('quantity').where(log_level: label).pluck('quantity')
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

  def random_color
    'rgba(' + String(generate_number) + ',' + String(generate_number) + ',' + String(generate_number) + ', 1)'
  end

  def generate_number
    rand(0...255)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_log_metric
    @log_metric = LogMetric.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def log_metric_params
    params.fetch(:log_metric, {})
  end
end
