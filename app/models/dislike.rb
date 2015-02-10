class Dislike < ActiveRecord::Base
  belongs_to :user
  belongs_to :image

  validates :user_id, presence: true
  validates :image_id, presence: true

  before_validation :already_exists?

  def already_exists?
    unless Dislike.where("image_id = #{self.image_id} and user_id = #{self.user_id}").empty?
      self.user_id = nil
      self.image_id = nil
    end
  end
end
