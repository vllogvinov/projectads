# frozen_string_literal: true

class PublishWorker
  include Sidekiq::Worker

  def perform
    Announcement.approved.find_each { |announcement| announcement.update(status: 'published') }
  end
end
