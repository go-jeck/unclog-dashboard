class CreateLogMetricPredictions < ActiveRecord::Migration[5.2]
  def change
    create_table :log_metric_predictions do |t|

      t.timestamps
    end
  end
end
