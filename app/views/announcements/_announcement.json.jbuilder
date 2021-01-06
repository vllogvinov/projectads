# frozen_string_literal: true

json.extract! announcement, :id, :title, :content, :type, :user_id, :status_id, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)
