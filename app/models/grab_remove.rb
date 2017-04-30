class GrabRemove
  attr_reader :photo, :top_left, :bottom_right

  def initialize(photo:)
    @photo = photo
    @box = ContourExtract.new(photo).max_box
    @original = OpenCV::CvMat.load(tmp_file_path(photo.url))
  end

  def call

  end

  def tmp_file_path(url)
    @tmp_file_path ||= begin
      tmp_file = Tempfile.new(["#{photo.file.filename}_cutted"])
      tmp_file.binmode
      open(url) do |url_file|
        tmp_file.write(url_file.read)
      end
      tmp_file.rewind
      tmp_file.path
    end
  end
end
