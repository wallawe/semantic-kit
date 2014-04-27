class ThemeCategory < ActiveRecord::Base
  belongs_to :theme
  belongs_to :category
end
