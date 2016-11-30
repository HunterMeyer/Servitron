module Api
  class ScreenshotsController < ApiController
    def create
      @screenshot = Screenshot.create(screenshot_params)
      if @screenshot.save && @screenshot.enqueue
        render json: { id: @screenshot.id, message: 'Talk to you soon' }
      end
    end

    private

    def screenshot_params
      params.slice(:website, :callback_url, :options)
    end
  end
end
