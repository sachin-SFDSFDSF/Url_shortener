class UrlsController < ApplicationController

 before_action :find_url, only: [:show, :shortened]
 skip_before_filter :verify_authenticity_token  


  def index
    @url = Url.new
  end

  def show
    redirect_to @url.sanitize_url
  end

  def create
    @url = Url.new
    @url.original_url = params[:original_url]
    @url.sanitize
    if @url.new_url?
      if @url.save
        redirect_to shortened_path(@url.short_url)
      else
        flash[:error] = "Check the error below:"
        render 'index'
      end
    else
      flash[:notice] = "A short link for this URL is already in our database"
      redirect_to shortened_path(@url.find_duplicate.short_url)
    end
  end

  def shortened
  	@url = Url.where("short_url = '#{params[:short_url]}'").first
  end

  def fetch_original_url
  	fetch_url = Url.where("short_url = '#{params[:short_url]}'").first
  	redirect_to "#{fetch_url.sanitize_url}"
  end

  private

  def find_url
    @url = Url.find_by_short_url(params[:short_url])
  end

  def url_params
    params.require(:url).permit(:original_url)
  end
end
