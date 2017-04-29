require 'rails_helper'

RSpec.describe ContourExtract, type: :model do
  let(:photo) { Frame.create!(build(:frame_params)).photo }
  subject { ContourExtract.new(photo) }

  it { is_expected.not_to raise_error}
  describe 'extraction' do
    it do
      contour = ContourExtract.new(photo)
      contour.boxx
      # binding.pry
    end
  end
end
