# frozen_string_literal: true

class Employment < ApplicationRecord
  belongs_to :organization
  belongs_to :user
  belongs_to :vessel, optional: true

  after_destroy :remove_user_roles

  private

  def remove_user_roles
    user.roles.where(resource: organization).pluck(:name).each do |role|
      user.remove_role(role, organization)
    end
  end
end
