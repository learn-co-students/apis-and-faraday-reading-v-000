class SearchesController < ApplicationController
  def search
  end

  
  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'A02K0TVDDMQG4RD3H3IS0FNKANRPAGBK2H35V1OOW3AJXHP4'
      req.params['client_secret'] = 'BCLLANVLUDHCE1KPVGD3AYINAQFRIRVKQI1F4N40O0EUDT4O'
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
