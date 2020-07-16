require 'rails_helper'

RSpec.describe "Seasons", type: :request do

  describe "GET /season" do
    it "returns http success" do
      get "/seasons/season"
      expect(response).to have_http_status(:success)
    end
  end

end
