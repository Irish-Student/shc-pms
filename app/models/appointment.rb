class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :clinic
  belongs_to :condition
  belongs_to :doctor
  # associations with other tables/models
end
