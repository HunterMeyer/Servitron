class Class
  def uploadable(options = {})
    define_method :upload do |file|
      obj = S3_BUCKET.objects["#{Rails.env}/#{options.delete(:path)}/#{File.basename(file)}"]
      obj.write({ file: file }.merge(options))
    end
  end

  def statusable(*statuses)
    settings = StatusTransition.settings_for(*statuses)
    class_eval do
      settings.each do |status, options|
        scope "except_#{status}".to_sym, -> { where('status != ?', options[:value]) }
        scope status, -> { where(status: options[:value]) }
      end
    end
    settings.each do |status, options|
      define_method("#{status}?") { status == options[:value] }
      define_method(options[:toggle]) { update(status: options[:value]) }
    end
  end
end
