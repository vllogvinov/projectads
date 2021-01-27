# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, 
  :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, 
  :created_at, :updated_at, :last_name, :first_name, :admin
end
