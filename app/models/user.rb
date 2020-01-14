class User < ActiveRecord::Base
    has_many :goals
    
    validates_uniqueness_of :username, case_sensitive: false

    has_secure_password
end