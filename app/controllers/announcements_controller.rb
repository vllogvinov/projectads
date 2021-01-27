# frozen_string_literal: true

class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: %i[show edit update destroy]
  ITEMS_PER_PAGE = 10

  def index
    @announcements = Announcement.published.includes(image_attachment: :blob)
                                 .page(params[:page]).per(ITEMS_PER_PAGE).desc_order
  end

  def show
    return unless @announcement.rejected?

    flash[:notice] = t('flashes.reject_notice')
  end

  def new
    @announcement = Announcement.new(user_id: current_user.id)
  end

  def edit; end

  def create
    @announcement = current_user.announcements.new(announcement_params)
    @announcement.send_to_moderate if params[:post_button].present?
    respond_to do |format|
      if @announcement.save
        response -> { redirect_to @announcement, notice: t('announcements.notices.created') }
      else
        response -> { render :new }
      end
      format.html response
    end
  end

  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        status_definition
        response -> { redirect_to @announcement, notice: t('announcements.notices.updated') }
      else
        response -> { render :edit }
      end
      format.html response
    end
  end

  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url, notice: t('announcements.notices.deleted') }
    end
  end

  private

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(:title, :content, :announcement_type, :status, :phone, :image, :post_button)
  end

  def status_definition
    @announcement.refact! if @announcement.rejected?
    @announcement.send_to_moderate! if params[:post_button].present?
  end
end
