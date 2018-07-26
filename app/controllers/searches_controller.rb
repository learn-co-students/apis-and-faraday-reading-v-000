class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
       @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'P40FZMLGK4GBQCBMXY0EFMZPH5K40GMRVVBF0EUOTCHANETA'
        req.params['client_secret'] = 'MJH14JCIKR1N2XPEJQXGJZSRB5B2RVB5YNXNHTYTHHZULGLO'
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
