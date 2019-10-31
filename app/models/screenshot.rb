class Screenshot < ActiveRecord::Base
  statusable :active, :erased
  uploadable path: :screenshots, acl: 'public-read', content_type: 'image/png'

  def enqueue
    Delayed::Job.enqueue(ScreenshotJob.new(id))
  end

  def process!
    url = image_meta_tag || screenshot
    update!(file_url: url)
  end

  def image_meta_tag
    MetaTagService.new(website).find('og:image')
  end

  def screenshot
    capture = ScreenshotService.new(website, options).capture
    upload(capture).public_url.to_s
  end

  def to_params
    { website: website, file_url: file_url }.to_param
  end
end
