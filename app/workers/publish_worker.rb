# frozen_string_literal: true

class PublishWorker
  include Sidekiq::Worker

  def perform
    Announcement.approved.update_all(status: 'published')
  end
end
