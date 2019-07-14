class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories

  validates :name, presence: true, uniqueness: true, length: {minimum: 4, maximum: 24}
end