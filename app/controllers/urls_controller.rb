# frozen_string_literal: true

class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.all
  end

  def create
    @url = Url.new(url_params)
    @url.shorten
    if @url.save
      redirect_to action: :show, url: @url.short_url
    else
      flash.notice = @url.errors.full_messages.join(', ')
      redirect_to root_path
    end
  end

  def show
    @url = Url.find_by(short_url: params[:url])
    return render file: 'public/404.html', layout: false, status: :not_found unless @url
    # implement queries
    @daily_clicks =  @url.clicks.where('created_at > ?', Time.now.beginning_of_month).group('CAST( EXTRACT(day FROM created_at) AS VARCHAR)').count.to_a
    @daily_clicks = @daily_clicks.empty? ? [[]] : @daily_clicks
    @browsers_clicks = @url.clicks.group(:browser).count.to_a
    @platform_clicks = @url.clicks.group(:platform).count.to_a
  end

  def visit
    @url = Url.find_by(short_url: params[:url])
    return render file: 'public/404.html', layout: false, status: :not_found unless @url
    ActiveRecord::Base.transaction do
      @url.update_attribute(:clicks_count, @url.clicks_count + 1)
      Click.create(url: @url, browser: browser.name, platform: browser.platform.name)
    end
    redirect_to @url.original_url
  end

  def url_params
    params.require(:url).permit(:original_url)
  end
end
