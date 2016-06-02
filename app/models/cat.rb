require 'action_view'

class Cat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  CAT_COLORS = %w(black white orange brown)
  belongs_to :owner,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    dependent: :destroy
  )

  validates(
    :user_id,
    :birth_date,
    :color,
    :name,
    :sex,
    presence: true
  )

  validate :owned

  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: %w(M F)

  def age
    time_ago_in_words(birth_date)
  end

  def owned
    User.exists?(id: user_id)
  end
end
