class Report < ActiveRecord::Base
  include RelationReport
  include ValidationReport
end
