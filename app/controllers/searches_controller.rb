class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'H1DICSJLN2MLLP4IAKIEJYSDJXKW1RCQJUR54KC11GW0BF52'
        req.params['client_secret'] = 'XHBXUTM5UT1APBZX0NSNUACJ2LCUSMAZLWZK0QB2JSET5DJO'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'beer'
      end
      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash['response']['venues']
      else
        @error = body_hash['meta']['errorDetail']
      end
    rescue Faraday::ConnectionFailed
      @error = 'There was a timeout. Please try again.'
    end
    render 'search'
    end
  end
