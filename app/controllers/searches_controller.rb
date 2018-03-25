class SearchesController < ApplicationController
  def search
  end

 def foursquare
    #make request to API endpoint
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      #Faraday allows us to pass block to get method and add any parameters via a hash of params
      req.params['client_id'] = 'PJDSWHOQ3ET3SPZ5H0VHGB5MJ4FND5CVIZ1KYKMN0B05VCDH'
      req.params['client_secret'] = 'KZLDOJVMNYZTMR0STJFVUYB5G1LACOYT0JI3JDIWGVDL3MZO'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    #obtain venues from JSON object

    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash["response"]["venues"]
    else
      @error = body_hash["meta"]["errorDetail"]
    end
    render 'search'
  end

end


