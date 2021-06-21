class ProductCategory < ApplicationRecord
  include Paginatable
  include LikeSearchable
  
  belongs_to :product
  belongs_to :category
end
