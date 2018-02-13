class SearchesController < ApplicationController
  def search
  end

  def foursquare
    client_id = "BDR54DO52UGKVPQ0OJ2JYUODMHVOUN3YZVZYNRNCH3DIUENW"
    client_secret = "P2LYULAWD112VR4ORMOGQG4VVIJ2JLOLVHSBYEJ40URHMK0F"

    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
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
    render 'search'
  
  end
    

end
  

