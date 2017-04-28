require 'rails_helper'

RSpec.describe "Frames", type: :request do
  describe "GET /frames" do
    it "it have status Ok" do
      get frame_path
      expect(response).to be_ok
    end
  end

  describe "PUT /frames" do
    before :all do
      Frame.create!(build(:frame_params))
    end

    let(:frame_params) { build(:frame_params) }
    it "it have status Ok" do
      put frame_path, params: { frame: frame_params }

      expect(response).to be_ok
    end
  end
end
