
class Profile < ApplicationRecord
  belongs_to :user

  #scope :myscope, -> { where(:first_name => "umair") }
  scope :myscope, ->(lastname) { where(:last_name => lastname) }
end
