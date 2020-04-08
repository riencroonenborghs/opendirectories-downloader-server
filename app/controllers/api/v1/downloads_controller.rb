class Api::V1::DownloadsController < ApiController
  before_action :get_download, only: [:destroy, :cancel, :queue]
  
  def index    
    scope = @current_user.downloads.order(created_at: :desc)
    render json: scope.map(&:to_json)
  end

  def create
    data = JSON.parse params.require(:download)
    download = @current_user.downloads.build(data)

    if download.save!
      download = download.reload_proper!
      download.enqueue!
      render json: {added: true}, status: 200
    else
      render json: {error: download.errors.full_messages.join(", ")}, status: 422
    end
  end

  def destroy
    if @download &&  @download.destroy
      render nothing: true, status: 200
    else
      render nothing: true, status: 422
    end
  end

  def cancel
    if @download && @download.cancel!
      render nothing: true, status: 200
    else
      render nothing: true, status: 422
    end
  end

  def queue
    if @download 
      @download = @download.reload_proper!
      @download.enqueue!
      render nothing: true, status: 200
    else
      render nothing: true, status: 422
    end
  end

  def clear
    @current_user.downloads.for_clearing.map(&:destroy)
    render nothing: true, status: 200
  end

  private

  def get_download
    @download = @current_user.downloads.where(id: params[:id]).first
  end
end