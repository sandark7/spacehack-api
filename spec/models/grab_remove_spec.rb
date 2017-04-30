require 'rails_helper'

RSpec.describe GrabRemove, type: :model do
  let(:photo) { Frame.create!(build(:frame_params)).photo }
  subject { GrabRemove.new(photo: photo) }

  it 'remove background' do
    subject.call
  end
end
