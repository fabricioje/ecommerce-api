# frozen_string_literal: true

class User < ActiveRecord::Base
  include Paginatable
  include LikeSearchable

  has_many :wish_items
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
  validates :profile, presence: true

  enum profile: { admin: 0, client: 1 }

end