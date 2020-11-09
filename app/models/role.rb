class Role < ApplicationRecord
	ADMIN_ROLE = "admin_role".freeze
	USER_ROLE = "user_role".freeze

	validates_presence_of :role_name
	validates_inclusion_of :role_name, {in: [ADMIN_ROLE, USER_ROLE]}
end
