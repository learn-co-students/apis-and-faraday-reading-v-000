class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'TWN3GGLAP0GDZZ4IL4OVYZFTGJYC1MUYRKYSTAXKRJ4NCZ4C'
        req.params['client_secret'] = 'K24QHJJFYZG0U1JXVWSGEDQOHZZ4GDKOHCKLH0EIDTPPETJQ'
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
