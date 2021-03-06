class Reservation < ActiveRecord::Base
  
  STATES = %w( free reserved )
  
  validates :book_id, presence: true
  validates :state,   inclusion: { in: STATES }
  validates :user,    presence: true
  
  validates :book_id, uniqueness: { 
                        scope: :state, 
                        message: 'book has been already reserved' 
                   }, if: "state == 'reserved'"
                   
                   
  before_validation :make_reserved, :on => :create
  
  belongs_to :book, touch: true
  belongs_to :user
  
  def free
    self.state = 'free'
    self.save
  end
  
  
  private
  
  def make_reserved
    self.state = 'reserved'
  end
  
end
