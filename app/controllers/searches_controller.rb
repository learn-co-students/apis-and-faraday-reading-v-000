class SearchesController < ApplicationController

    begin
      @resp =  Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'QISYBYCA5ZPZAVKNSJ23ATOV1XFQUHXKWGJI24MFYFDXPK3L'
      req.params['client_secret'] = '5CGO1MA1KMLCZHN5FAIJNB1JQESLAE13WFGTZVXLZIOEDFM'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      req.options.timeout = 0
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
