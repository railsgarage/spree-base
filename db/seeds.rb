a = Account.create!(url: '0.0.0.0', name: 'rec')
a.users.create!(email: 'thogg4@gmail.com', password: 'hello', first_name: 'tim', last_name: 'hogg', phone: '0000000000', admin: true)
s = a.sports.create!(name: 'Softball')
a.activities.create!(name: 'Mens Advanced', sport_id: s.id)


Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
