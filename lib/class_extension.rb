class Class
  def uploadable(options = {})
    define_method :upload do |file|
      obj = S3_BUCKET.objects["#{Rails.env}/#{options.delete(:path)}/#{File.basename(file)}"]
      obj.write({ file: file }.merge(options))
    end
  end
end
