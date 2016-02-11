# encoding: UTF-8
class ExperienceFormatRatios < ActiveRecord::Base

  belongs_to :format
  belongs_to :outer_format, foreign_key: :outer_format_id, class_name: 'Format'

end
