class Advertisment < ApplicationRecord
	belongs_to :users

	validates_presence_of(:ad_id, :ad_name, :type)  
end
