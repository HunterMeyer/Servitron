module Api
  class ScreenshotsController < ApiController
    def create
      @screenshot = Screenshot.create(screenshot_params)
      if @screenshot.save
        if params[:instant] == 'true'
          @screenshot.process!
          render json: { file_url: @screenshot.file_url }
        else
          @screenshot.enqueue
          render json: { id: @screenshot.id, message: 'Talk to you soon' }
        end
      end
    end

    private

    def screenshot_params
      params.slice(:website, :callback_url, :options)
    end
  end
end
