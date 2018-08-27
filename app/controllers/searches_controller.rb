class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      #YIPEKBWE4DNCUJ2PQ2RC3KXK3DTWKCRRAMTJGKM4PMPZ5HIZ
      #R4XGWEYWATXNGA3MR52Y1HRBOJ4WR340STLGINBLNON5PDM4
      req.params['client_id'] = 'YIPEKBWE4DNCUJ2PQ2RC3KXK3DTWKCRRAMTJGKM4PMPZ5HIZ'
      req.params['client_secret'] = 'R4XGWEYWATXNGA3MR52Y1HRBOJ4WR340STLGINBLNON5PDM4'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      #req.options.timeout = 0
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end

    #rescue Faraday::ConnectionFailed
    #  @error = "There was a timeout. Please try again."
    #end
    render 'search'
  end
end
