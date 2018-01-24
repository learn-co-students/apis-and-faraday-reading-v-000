class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
              req.params['client_id'] = 'REDACTED'
              req.params['client_secret'] = 'REDACTED'
              req.params['v'] = '20160426'
              req.params['radius'] = '1000'
              req.params['near'] = params[:zipcode]
              req.params['query'] = 'coffee shop'
              req.options.timeout = 1
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
