class ScreenshotJob < Struct.new(:instance_id)
  def enqueue(job)
    job.delayed_reference_id   = instance_id
    job.delayed_reference_type = 'Screenshot'
    job.save!
  end

  def perform
    Screenshot.find(instance_id).process!
  end

  def success(_job)
    instance = Screenshot.find(instance_id)
    if instance.callback_url
      HTTParty.post(instance.callback_url, body: instance.to_params)
    end
  end

  def queue_name
    'Screenshots'
  end

  # def error(_job)
  # end

  # def failure(_job)
  # end
end
