class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :downloads, -> { order(weight: :asc, id: :asc) }, dependent: :destroy
end