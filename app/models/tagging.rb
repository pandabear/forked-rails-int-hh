class Tagging < ActiveRecord::Base
  
  belongs_to :book, touch: true
  belongs_to :tag
  
  validates :tag_id, uniqueness: { scope: :book_id }
  
end
