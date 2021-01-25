# frozen_string_literal: true

class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: %i[show edit update destroy]

  def index
    @announcements = Announcement.published.includes(image_attachment: :blob).page(params[:page]).per(6).desc_order
  end

  def show
    if @announcement.rejected?
      flash[:notice] = t('flashes.reject_notice')
    end
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
        format.html { redirect_to @announcement, notice: t('announcements.notices.created') }
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render :new }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        status_definition
        format.html { redirect_to @announcement, notice: t('announcements.notices.updated') }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url, notice: t('announcements.notices.deleted') }
      format.json { head :no_content }
    end
  end

  private

  def set_announcement
    @announcement ||= Announcement.find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(:title, :content, :announcement_type, :status, :phone, :image, :post_button)
  end

  def status_definition
    @announcement.refact! if @announcement.rejected?
    @announcement.send_to_moderate! if params[:post_button].present?
  end
end
