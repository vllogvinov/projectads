require 'rails_helper'

RSpec.describe Advertisment, type: :model do

  describe "validate_presence_adv" do
  	it { should validate_presence_of(:ad_name) }
  	it { should validate_presence_of(:type) }
  end


end
