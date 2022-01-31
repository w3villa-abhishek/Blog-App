class Category < ApplicationRecord

	validates :name, presence: true, length: {in: 5..25}

	has_many :article_categories
	has_many :articles, through: :article_categories
end