class Snippet < ActiveRecord::Base
  belongs_to :user, :foreign_key => "user_id"

  validates_presence_of :title, :html

  mount_uploader :image, ImageUploader

  def to_param
    "#{id} #{title}".parameterize
  end
end
