class SearchesController < ApplicationController

	def foursquare
		Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
			req.params['client_id'] = 'GOABZ1TCAB0KR32FXI2GNPUWW2ELCWN44G3FPVKP01N5JFGS'
			req.params['client_secret'] = 'MK5AWYIAWKNPM3VHVLGL2JVJCUOIXVALJU5ENA3RZYL5IPQ3'
			req.params['v'] = '20160201'
			req.params['near'] = params[:zipcode]
			req.params['query'] = 'coffee shop'
		end
		render 'search'
	end

  def search
  end

  def foursquare
  end
end
