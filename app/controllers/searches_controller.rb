class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'CKWFX5JKZCXOJTNAKGQ5Y3RB3MFHRKOTIMQNBEPHBVIOGYNX'
        req.params['client_secret'] = 'V24GDPX4T0O1LH4RXQ3GZ51E5BCTM2FTM2VZW4DXWCIL1FTG'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body['response']['venues']
      else
        @error = body['meta']['errorDetail']
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
