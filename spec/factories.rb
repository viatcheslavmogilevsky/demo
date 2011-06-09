Factory.define :user do |user|
 user.name 			"Ivan_Ivanych"
 user.email			"ivan@rus.su"
 user.password			"skazka"
 user.password_confirmation 	"skazka"
end



Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
