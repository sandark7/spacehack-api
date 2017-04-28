class FramesController < ApplicationController
  def update
    frame = Frame.latest
    frame.update!(frame_params)

    render json: frame
  end

  def show
    render json: Frame.latest
  end

  def frame_params
    params.require(:frame).permit(:photo, :name)
  end
end
