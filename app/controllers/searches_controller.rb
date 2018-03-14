class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '2UDQI0YTKCLGLNI3JHR0UA2IFKK0TOCATZ0GVKHZNF3JIBR0'
        req.params['client_secret'] = 'T5UASBO0L1MW4FOEW0C5AWLFHLVKLR2BAMS1LABMZQBPZFRX'
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

