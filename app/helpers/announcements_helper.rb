# frozen_string_literal: true

module AnnouncementsHelper
  def draft_or_rejected(announcement)
    announcement.draft? || announcement.rejected?
  end
end
