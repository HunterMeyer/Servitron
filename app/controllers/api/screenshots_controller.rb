module Api
  class ScreenshotsController < ApiController
    def show
      @screenshot = Screenshot.find_by_id(params[:id])
      if @screenshot
        render json: @screenshot.attributes.slice('id', 'website', 'file_url')
      else
        render json: { message: 'Not Found' }, status: 404
      end
    end

    def create
      @screenshot = Screenshot.find_or_create_by(screenshot_params)
      if @screenshot.save
        if !@screenshot.new_record?
          render json: { file_url: @screenshot.file_url }
        elsif params[:instant] == 'true'
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
