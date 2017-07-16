class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'EUFAH3ZOSHU2WO4UYYPKCHXV1SPWVKMMGCCAUXHKSWSML0XZ'
        req.params['client_secret'] = 'QT2Y4IIGPGC0EGDHX3QWDD33LVDWE21IXGV4YYRNU20HX02S'
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
