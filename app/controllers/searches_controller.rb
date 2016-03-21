class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "4MLZ4DPZ0LO4WTOPYBZFUGH35ITQUMEKUU2BVKJHPUFKOTDZ"
      req.params['client_secret'] = "ELLI4ZGBPY21SOBB3BFBO0V0O3QZAAEAPPQKSIQDENGYEY0E"
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
