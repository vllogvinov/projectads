# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Announcement, type: :model do
  describe 'validate_presence_adv' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:announcement_type) }
  end

  describe 'status_changing' do
    let(:announcement) { build(:announcement) }
    it 'status_changing' do
      expect(announcement).to transition_from(:draft).to(:ready_to_publish).on_event(:send_to_moderate)
      expect(announcement).to transition_from(:ready_to_publish).to(:approved).on_event(:approve)
      expect(announcement).to transition_from(:ready_to_publish).to(:rejected).on_event(:reject)
      expect(announcement).to transition_from(:approved).to(:published).on_event(:publish)
      expect(announcement).to transition_from(:rejected).to(:draft).on_event(:refact)
      expect(announcement).to transition_from(:published).to(:archived).on_event(:archive)
    end
  end
end
