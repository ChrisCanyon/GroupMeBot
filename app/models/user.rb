class User < ApplicationRecord
  has_many :requests
  has_many :group_members
end
