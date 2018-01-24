class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "GQI2QTDW2YX4H0EP4SLLUGQF2SNCMQAXDFTGWTUF43AGVJGR"
      req.params['client_secret'] = "EXF1B2CAEWZMVDEAAYLXPGQV40JBKJJBPVHCU2DYLXDR0YOH"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end

end
