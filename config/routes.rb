Rails.application.routes.draw do
  root 'searches#search'
  get '/search', to: 'searches#search'
	post '/search', to: 'searches#foursquare'
	
  get '/venue_details', to: 'searches#venue_details'
  get '/venue_photos', to: 'searches#venue_photos'

	get '/cloud', to: 'cloud#search'
	post '/cloud', to: 'cloud#cloudinary'
end
