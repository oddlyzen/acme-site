class Link < ActiveRecord::Base
  
  def logo_size
    [logo_width, logo_height].compact.join('x')
  end
  
end