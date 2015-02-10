class Similarity < ActiveRecord::Base
  validates :calculated_similarity, presence: true
  validates :calculated_similarity, numericality: { greater_than: 0 }
  validates :first_user_id, presence: true
  validates :second_user_id, presence: true

  belongs_to :users, class_name: 'User'

  before_validation :already_exists?

  def already_exists?
    unless Similarity.where("(first_user_id = #{self.first_user_id} AND second_user_id = #{self.second_user_id}) OR (first_user_id = #{self.second_user_id} AND second_user_id = #{self.first_user_id})").empty?
      self.first_user_id = nil
      self.second_user_id = nil
    end
  end
end
