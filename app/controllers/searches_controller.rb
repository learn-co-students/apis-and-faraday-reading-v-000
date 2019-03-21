class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'BP2SN4NQMNENX41BS5G40EXW0VXTHX1SCLUNLQ2NHMMIYI3R'
      req.params['client_secret'] = '5TSIVQBSYTVIPS0QVOHSGUE0PKMYMXM2R3ZMH2LWUTKHYU0Y'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'espresso'
      
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    if @resp.success?
    @venues = body_hash["response"]["venues"]
  else
    @error = body_hash["meta"]["errorDetail"]
  end

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."

    render 'search'
  end
end
