class Screenshot < ActiveRecord::Base
  uploadable path: :screenshots, acl: :public_read

  def enqueue
    Delayed::Job.enqueue(ScreenshotJob.new(id))
  end

  def process!
    capture = ScreenshotService.new(website, options).capture
    update!(file_url: upload(capture).public_url.to_s)
  end

  def to_params
    options.merge(file_url: file_url).to_query
  end
end
