class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '5CN5QQNZWX1QWFFWKCYEDUWKT4GJA0GDHYXVLQQPQXJUAG1U'
      req.params['client_secret'] = 'P1JUDR5EXMIIKKTWTGDUYUVHDGRGDYJTRD0OUULSRBCSFA1Y'
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
    
  rescue Faraday::ConnectionFailed
  @error = "There was a timeout. Please try again."
  end
    render 'search'
  end
end
