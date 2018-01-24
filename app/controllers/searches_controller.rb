class SearchesController < ApplicationController
  def search
  end

  def foursquare
  begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'QU4JGX0TZ4KNPGYWRUEMKAJB2ESD5JK5YDCYWDWPDGACQ1UT'
      req.params['client_secret'] = 'VATMVDQNBEBEFLNTNYM2FOV0YLOBNGU1EHCKLBN1AB0GVNA5'
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
  rescue Faraday::TimeoutError
    @error = "There was a timeout. Please try again."
  end
  render 'search'
  end
end
