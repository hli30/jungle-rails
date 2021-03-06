class Review < ActiveRecord::Base

  belongs_to :product

  validates :description, presence: true
  validates :product_id, presence: true
  validates :user_id, presence: true
  validates :rating, presence: true

end
