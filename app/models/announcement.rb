# frozen_string_literal: true

class Announcement < ApplicationRecord
  include AASM

  VALID_TYPES = %w[Buy Sell Exchange].freeze

  belongs_to :user
  has_one_attached :image
  paginates_per 6
  scope :desc_order, -> { order(created_at: :desc) }
  scope :published, -> { where(status: 4) }

  validates_presence_of(:title, :content, :announcement_type)

  enum status: {
    draft: 0,
    ready_to_publish: 1,
    approved: 2,
    rejected: 3,
    published: 4,
    archived: 5
  }

  aasm column: :status, enum: true do
    state :draft, initial: true
    state :ready_to_publish, :approved, :rejected, :published, :archived

    event :send_to_moderate do
      transitions from: :draft, to: :ready_to_publish
    end

    event :approve do
      transitions from: :ready_to_publish, to: :approved
    end

    event :reject do
      transitions from: :ready_to_publish, to: :rejected
    end

    event :publish do
      transitions from: :approved, to: :published
    end

    event :refact do
      transitions from: :rejected, to: :draft
    end

    event :archive do
      transitions from: :published, to: :archived
    end
  end
end
