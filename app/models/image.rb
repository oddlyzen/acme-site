class Image < ActiveRecord::Base
  
  belongs_to :product

  has_attachment  :content_type =>  :image,
                  :storage      =>  :file_system,
                  :max_size     =>  500.kilobytes,
                  :resize_to    =>  '200x200>',
                  :thumbnails => { :thumb => '50x50>', :thumb_large => '100X100>' }
                  
  validates_as_attachment

end
