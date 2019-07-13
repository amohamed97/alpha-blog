class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: {minimum: 4, maximum: 24}
end