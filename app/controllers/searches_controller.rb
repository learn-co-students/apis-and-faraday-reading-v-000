class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'AMGMZBNJ5WXLS5AU1NAR5RYREWS2UCZVBMWK2MFT2Q5NQJAK'
      req.params['client_secret'] = 'Y03WFJZ4OCZISXDIWZ5AUTHHTR3QQMOEZRKHCDR10ZF53A3S'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee'
    end
  body_hash = JSON.parse(@resp.body)
  if @resp.success?
    @venues = body_hash["response"]["venues"]
  else
    @error = "You need to enter a zipcode!!! Come ON!!"
  end

  render 'search'  
  end

end
