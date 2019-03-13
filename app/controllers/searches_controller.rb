class SearchesController < ApplicationController

  def search
  end

  def foursquare
    @response = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '01DJSSMQ1BIU0TLXYEUD5Y1Y4TXLVXM2G3FOQXLI0YEVYHAQ' 
      req.params['client_secret'] = 'E3PLHPUVSXAKEDVXFMHDYTGFHX2OYKTAEDBLB3ANLEPAOVCK' 
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      
    end
    body_hash = JSON.parse(@response.body)
    if @response.success?
      @venues = body_hash['response']['venues']
    else
      @error = body_hash["meta"]["errorDetail"]
    end

    render 'search'
  end

end

