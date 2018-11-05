class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'OP1PWD5FE0HAOIUVNLPYCOAGNRX4XA00RRXQYHQN1QLBOPHR'
      req.params['client_secret'] = 'ODY55SBSXZ3PP10ZIB2RPN5VRD3KLBPI3NGR0FTID1CR3H3J'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffe shop'

    end

    body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        flash[:message] = "must enter zip code!"
      end

    rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
      render 'search'
  end
  
end
