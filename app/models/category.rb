# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  color       :string
#  glyph       :string
#  slug        :string
#

class Category < ActiveRecord::Base
	has_many :services
end
