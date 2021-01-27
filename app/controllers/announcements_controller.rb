# frozen_string_literal: true

class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: %i[show edit update destroy]

  # GET /announcements
  # GET /announcements.json
  def index
    @announcements = Announcement.published.desc_order.includes(image_attachment: :blob).page(params[:page]).per(6)
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
    flash[:notice] = t('flashes.reject_notice') if @announcement.rejected?
  end

  # GET /announcements/new
  def new
    @announcement = Announcement.new(user_id: current_user.id)
  end

  # GET /announcements/1/edit
  def edit; end

  # POST /announcements
  # POST /announcements.json
  def create
    @announcement = current_user.announcements.new(announcement_params)
    @announcement.send_to_moderate if params[:post_button].present?
    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement, notice: 'Announcement was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        status_definition
        format.html { redirect_to @announcement, notice: 'Announcement was successfully updated.' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url, notice: 'Announcement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def announcement_params
    params.require(:announcement).permit(:title, :content, :announcement_type, :status, :phone, :image, :post_button)
  end

  def status_definition
    @announcement.refact! if @announcement.rejected?
    @announcement.send_to_moderate! if params[:post_button].present?
  end
end
