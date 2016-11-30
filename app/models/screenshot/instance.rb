module Screenshot
  class Instance < ActiveRecord::Base
    uploadable path: :screenshots, acl: :public_read

    def enqueue
      Delayed::Job.enqueue(Screenshot::Job.new(id))
    end

    def process!
      capture = Screenshot::Service.new(website, options).capture
      update!(file_url: upload(capture).public_url.to_s)
    end

    def to_params
      options.merge(file_url: file_url).to_query
    end
  end
end
