Rails.application.routes.draw do
  resource :frame, only: [:show, :update]
end
