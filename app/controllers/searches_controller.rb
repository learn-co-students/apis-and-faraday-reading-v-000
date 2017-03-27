class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin 
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
    req.params['client_id'] = 'CT5EMD5CIBG2MXJDYRVB4YYRO1502ABW0ANG0E3RR0WPABZI'
    req.params['client_secret'] = 'GKSYQVSGPTG01ZBF4HVEQ33ZPDND2CEOGZPLMSGK15K3FEP5'
    req.params['v'] = '20160201'
    req.params['near'] = params[:zipcode]
    req.params['query'] = 'coffee shop' 
    end 
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash["response"]["venues"]
    else 
      @error = body_hash["meta"]["errorDetail"]
    end 
  rescue Faraday::TimeoutError 
    @error = "There was a timeout. Please try again."
  end 
    render 'search'
  end
end
