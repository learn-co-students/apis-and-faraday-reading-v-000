class SearchesController < ApplicationController
  def search
  end

  def foursquare
  begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'GBRL4N4CBDUDLJHGJMRAB3E3US1L1T1O3OK3UXT5MWVHDOYI'
      req.params['client_secret'] = 'UVT0FBTBO5YM144NXTGJMJJ3YJHWFNGZKTX0GZQW1QOKWBQQ'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash["response"]["venues"]
    else
      @error = body_hash["meta"]["errorDetail"]
    end
      rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end



end
