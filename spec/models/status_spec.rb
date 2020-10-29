require 'rails_helper'

RSpec.describe Status, type: :model do

	describe "validate_status" do
		it { should validate_presence_of(:status_name) }
	end
end
