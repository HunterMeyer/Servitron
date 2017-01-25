class Screenshot < ActiveRecord::Base
  statusable :active, :erased
  uploadable path: :screenshots, acl: :public_read, content_type: 'image/png'

  def enqueue
    Delayed::Job.enqueue(ScreenshotJob.new(id))
  end

  def process!
    capture = ScreenshotService.new(website, options).capture
    update!(file_url: upload(capture).public_url.to_s)
  end

  def to_params
    { website: website, file_url: file_url }.to_param
  end
end
