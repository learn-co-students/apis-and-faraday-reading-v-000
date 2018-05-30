class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'L4FQOHHYOR3XZWZAR1RQ2LLPFKXV01YQABPCIRWQSP3DKNFJ'
      req.params['client_secret'] = 'B405XTE1O2V3CVS5EEQBQ2U1B51RO1HGZO24YE23Q4OIKJDQ'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    
     render 'search'
    end
  end
  
