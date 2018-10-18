module Service
  class Upload(T)
    def initialize(@entity : T, @direction : String)
    end

    def call(filename : String, body : IO)
      picture = @entity.picture
      file_path = ::File.join ["uploads", @direction, Time.now.epoch.to_s + filename]

      if !picture.new_record?
        File.delete(picture.path.not_nil!) rescue nil
      end

      picture.name = filename
      picture.path = file_path
      picture.save

      @entity.picture_id = picture.id
      @entity.save

      File.open(file_path, "w") do |f|
        IO.copy(body, f)
      end
    end
  end
end
