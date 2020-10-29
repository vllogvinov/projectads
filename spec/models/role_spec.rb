require 'rails_helper'

RSpec.describe Role, type: :model do

	describe "validate_roles" do
		it { should validate_presence_of(:role_name) }
	end
end
