class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
         
         
 has_many :books, dependent: :destroy
 has_many :favorites, dependent: :destroy
 has_many :book_comments, dependent: :destroy
       validates :name, length:{ in: 2..20 }
       validates :name, uniqueness: true
       validates :email, uniqueness: true
          validates :introduction, length:{maximum: 50 }
         validates :email,presence: true
         validates :password,presence: true,on: :registration
      
         
         
         has_one_attached :profile_image
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
