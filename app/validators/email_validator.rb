class EmailValidator < ActiveRecord::Validator
 def validate()
    record.errors[:email] << "is not valid" unless
      record.email =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  end
end

# uses validates_each instead of validate_with
# validates :my_email_field, email: true # <-- custom email validator
# class EmailValidator < ActiveModel::EachValidator
 # def validate_each(record, attribute, value)
  #  unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  #    record.errors[attribute] << (options[:message] || "wrong email address")
   # end
 # end
#end
