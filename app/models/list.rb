class List < ApplicationRecord
	has_and_belongs_to_many :users
	has_many :items
	default_scope -> { order(created_at: :desc) }
	validates :name, presence: true, length: { maximum: 30 }
end
