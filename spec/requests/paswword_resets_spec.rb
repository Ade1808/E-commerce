require 'rails_helper'

RSpec.describe "PaswwordResets", type: :request do
  describe "GET /paswword_resets" do
    it "works! (now write some real specs)" do
      get paswword_resets_path
      expect(response).to have_http_status(200)
    end
  end
end
