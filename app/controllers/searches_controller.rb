class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'BQA302RXNSRK0U5K5KLNKV4OJEJZBPANH3KQWTKTU1DK322R'
      req.params['client_secret'] = 'ACTFXELKEIZ2EP5MT315AQCM40FNPTXIXFT3GFQX1EH0UUKE'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      req.options.timeout = 10
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
