class Contact < ActiveRecord::Base
 has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
 has_many :phones, :dependent => :destroy
 belongs_to :user

 CATEGORIES = %w(Amigos Familiares Compañeros)

 accepts_nested_attributes_for :phones, :allow_destroy => true

 validates :user_id, presence: true
 validates :name, presence: true
 validates :surnames, presence: true
 validates :email, presence: true, uniqueness: true
 validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                             message: "invalid email" }
 validates :category,presence: true, inclusion: { in: CATEGORIES }
 validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

end
