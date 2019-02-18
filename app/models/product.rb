class Product < ApplicationRecord
  belongs_to :category
  has_many :options  , dependent: :destroy
  has_attached_file :image , styles: {large:"600x600", medium: "300x300>", thumb: "100x100>" }
  has_one :cart_item ,dependent: :destroy
  has_many :order_items ,dependent: :destroy
  enum status:[:unpublished,:published]
  
  accepts_nested_attributes_for :options ,allow_destroy:true
  
  validates :name ,:price,:stock ,:category_id,:image ,presence:true
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :discount ,numericality:[:greater_then_or_equal_to=>0.1]
  #validates :name ,uniqueness:true
  #validates_attachment_file_type :image 
  scope :unpublished ,->{where(:status=>0)}
  scope :published ,  ->{where.not(:status=>0)}
  
  def total_price(product)
    product.total=product.price
    product.total+=product.options.sum(&:price)
    product.save
    product.total
  end
  def discount_price(product)
      product.total*product.discount/100.0
  end

  def self.search (search)
      if search
      where(["name LIKE ? ","%#{search}%"]).where(:status=>"published")  
      else
        all.where(:status=>"published")
      end
  end
end
