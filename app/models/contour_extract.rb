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
    @contours ||= begin
      contour_cv = edge_detect.find_contours(mode: OpenCV::CV_RETR_LIST, method: OpenCV::CV_CHAIN_APPROX_SIMPLE)
      tmp_collection = []
      while contour_cv
        # print '.'
        # $stdout.flush
        next if contour_cv.hole?
        current_box = contour_cv.bounding_rect
        puts "that contour encloses an area of #{contour_cv.contour_area} square pixels"
        tmp_collection << contour_cv
        contour_cv = contour_cv.h_next
      end
      tmp_collection
    end
  end

  def boxx
    puts 'boxx'
    contours
    binding.pry
    # while @contour
    #   # next unless @contour.hole?
    #   current_box = @contour.bounding_rect
    #   puts "found external contour with bounding rectangle from #{current_box.top_left.x},#{current_box.top_left.y} to #{current_box.bottom_right.x},#{current_box.bottom_right.y}"
    #   puts "that contour encloses an area of #{@contour.contour_area} square pixels"
    #   @contour&.h_next
    # end
  end

  def boxes
    @boxes ||= begin
      tmp_boxes = []
      while contour
        next if contour.hole?
        puts '-' * 80
        puts "BOUNDING RECT FOUND"
        puts '-' * 80

        # You can detect the "bounding rectangle" which is always oriented horizontally and vertically
        current_box = contour.bounding_rect
        puts "found external contour with bounding rectangle from #{current_box.top_left.x},#{current_box.top_left.y} to #{current_box.bottom_right.x},#{current_box.bottom_right.y}"

        # The contour area can be computed:
        puts "that contour encloses an area of #{contour.contour_area} square pixels"

        # .. as can be the length of the contour
        puts "that contour is #{contour.arc_length} pixels long "

        # Draw that bounding rectangle
        vision.rectangle! current_box.top_left, current_box.bottom_right, :color => OpenCV::CvColor::Black

        # You can also detect the "minimal rectangle" which has an angle, width, height and center coordinates
        # and is not neccessarily horizonally or vertically aligned.
        # The corner of the rectangle with the lowest y and x position is the anchor (see image here: http://bit.ly/lT1XvB)
        # The zero angle position is always straight up.
        # Positive angle values are clockwise and negative values counter clockwise (so -60 means 60 degree counter clockwise)
        current_box = contour.min_area_rect2
        puts "found minimal rectangle with its center at (#{current_box.center.x.round},#{current_box.center.y.round}), width of #{current_box.size.width.round}px, height of #{current_box.size.height.round} and an angle of #{current_box.angle.round} degree"
        tmp_boxes << current_box
        contour = contour&.h_next
      end
    end
  end

  def save!
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
