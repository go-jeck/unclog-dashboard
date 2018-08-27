require 'rails_helper'

RSpec.describe PredictionController, type: :controller do

  describe "GET #log_metric_prediction" do
    it "returns http success" do
      get :log_metric_prediction
      expect(response).to have_http_status(:success)
    end
  end

end
