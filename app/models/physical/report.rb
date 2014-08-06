class Report < ActiveRecord::Base
  include RelationWeekReport
  include ValidationReport
end
