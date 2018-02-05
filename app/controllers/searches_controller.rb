class SearchesController < ApplicationController
  require 'pry'
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'JXX3PZ5FCY5L4AQ3Q40MNOLOAYYAOKSYKYYC4RJE23XSMP2C'
      req.params['client_secret'] = '0HX0N2MKJNZJMS4YEICHAN1HQKYCUA2CFACBZBUW0CB4SQLI'
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
