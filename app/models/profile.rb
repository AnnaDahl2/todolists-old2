class Profile < ActiveRecord::Base
    belongs_to :user
  
    validates :gender, inclusion: { in: %w(female male), message: "%{value} is not a valid gender" }
    
    validate :both_names_null
    validate :male_not_sue
    
    def both_names_null 
        if (first_name == nil) and (last_name == nil)
            errors.add(:profile, "Both names can't be missing")
        end
    end
    
    def male_not_sue
        if (gender == "male") and (first_name == "Sue")
            errors.add(:profile, "Sue is not a male name")
        end
    end
    
    scope :ordered_by_birth_year, -> { order birth_year: :asc }
    
    def self.get_all_profiles(miny, maxy)
       Profile.ordered_by_birth_year.where("birth_year BETWEEN ? AND ?", miny, maxy).to_a 
    end
end
