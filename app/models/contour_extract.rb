class ContourExtract
  attr_reader :photo, :tmp_file, :vision

  def initialize(photo)
    @photo = photo
    @vision = OpenCV::CvMat.load(tmp_file_path(photo.url)).BGR2GRAY
  end

  def call
    puts "found external contour with bounding rectangle from #{box.top_left.x},#{box.top_left.y} to #{box.bottom_right.x},#{box.bottom_right.y}"
    vision.rectangle!(box.top_left, box.bottom_right, color: OpenCV::CvColor::Black)
    save!
  end

  def edge_detect
    @edge_detect ||= vision.canny(50, 150)
  end

  def contours
    @contours ||=begin
      tmp_external_contours = []
      contour = edge_detect.find_contours(mode: OpenCV::CV_RETR_LIST, method: OpenCV::CV_CHAIN_APPROX_SIMPLE)
      while contour
        unless contour.hole?
          puts '-' * 80
          puts "BOUNDING RECT FOUND"
          puts '-' * 80
          box = contour.bounding_rect
          puts "found external contour with bounding rectangle from #{box.top_left.x},#{box.top_left.y} to #{box.bottom_right.x},#{box.bottom_right.y}"
          puts "that contour encloses an area of #{contour.contour_area} square pixels"
          puts "that contour is #{contour.arc_length} pixels long "
          # vision.rectangle! box.top_left, box.bottom_right, :color => OpenCV::CvColor::Red
          box = contour.min_area_rect2
          tmp_external_contours << contour
          puts "found minimal rectangle with its center at (#{box.center.x.round},#{box.center.y.round}), width of #{box.size.width.round}px, height of #{box.size.height.round} and an angle of #{box.angle.round} degree"
        end
        contour = contour.h_next
      end
      tmp_external_contours
    end
  end

  def max_contour
    contours.max { |a,b| a.contour_area <=> b.contour_area }
  end

  def max_box
    @max_box ||= contour.bounding_rect
  end

  def save!
    box = max_contour.bounding_rect

    vision.rectangle! box.top_left, box.bottom_right, :color => OpenCV::CvColor::Red
    vision.save_image("rotated-boxes-with-detected-bounding-rectangles.jpg")
  end

  def tmp_file_path(url)
    @tmp_file_path ||= begin
      tmp_file = Tempfile.new(["#{photo.file.filename}"])
      tmp_file.binmode
      open(url) do |url_file|
        tmp_file.write(url_file.read)
      end
      tmp_file.rewind
      tmp_file.path
    end
  end
end
