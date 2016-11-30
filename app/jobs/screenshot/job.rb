module Screenshot
  class Job < Struct.new(:instance_id)
    def enqueue(job)
      job.delayed_reference_id   = instance_id
      job.delayed_reference_type = 'Screenshot::Instance'
      job.save!
    end

    def perform
      Screenshot::Instance.find(instance_id).process!
    end

    def success(job)
      instance = Screenshot::Instance.find(instance_id)
      if instance.callback_url
        HTTParty.post(instance.callback_url, body: instance.to_params)
      end
    end

    def error(job)
    end

    def failure(job)
    end
  end
end
