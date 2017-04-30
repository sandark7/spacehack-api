FactoryGirl.define do
  factory :frame_params, class: Hash do
    name { Faker::Pokemon.name }
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'test_image_7.jpg'), 'image/jpg')  }
  end

  initialize_with { attributes }
end
