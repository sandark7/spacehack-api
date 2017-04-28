class FramesController < ApplicationController
  def update
    respond json: {

    }
  end

  # Show data for last frame
  def show
    render json: Frame.latest
  end
end
