class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "Q2AXJUWUK2UGQMI55DCW25L0LVK3HROIG1IAVPXUWUTSH54P"
      req.params['client_secret'] = "EBWPJ5ENGCWJ5XU3VOZ5OGR4XHPB5UD5ZNNABJYX15DWRGZ5"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      # req.options.timeout = 0
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