class Instapost < ActiveRecord::Base
  validates :message, presence: true
end
