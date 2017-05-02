class FramesController < ApplicationController
  def update
    frame = Frame.new
    frame.update!(image_data: change_img_params(frame_params[:photo]))
    # binding.pry
    render status: :ok
  end

  def show
    render json: Frame.latest
  end

  def frame_params
    params.permit(:photo)
  end

  def change_img_params(img)
    begin
      Base64.decode64(img) #To check if thats a base64 string
      if img
        img = file_decode(img.split(',')[1],"some file name") #getting only the string leaving out the data/<format>
      end
    rescue Exception => e
      img #Returning if its not a base64 string
    end
  end

  def file_decode(base, filename)
    file = Tempfile.new([file_base_name(filename), file_extn_name(filename)])
    file.binmode
    file.write(Base64.decode64(base))
    file.close
    file
  end

  def file_base_name(file_name)
    File.basename(file_name, file_extn_name(file_name))
  end

  def file_extn_name(file_name)
    File.extname(file_name)
  end
end
