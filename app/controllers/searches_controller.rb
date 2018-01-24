class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = VWSE5QJQY3DJUIEA33D3GFCEG2XWDRNZD5YRG1DLU15UJZAG
        req.params['client_secret'] = MDNSH1HP0GZOQP5UJWAIMDFO414EJZPMH3QPWVGFMBI5QGRA
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
