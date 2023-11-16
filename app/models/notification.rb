class Notification < ApplicationRecord
	
	belongs_to :subject, polymorphic: true
  belongs_to :user
  
  enum action: { commented_to_own_review: 0, useful_to_own_review: 1 }
	
end
