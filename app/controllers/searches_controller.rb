class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @response = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |request|
      request.params[:client_id] = 'UQPVT0RCHTBBXP3KOKQMMSYXEZDX3BMAWTR2ABJ0JAIFKPNT'
      request.params[:client_secret] = 'BD5KM1LKV5TRAZWE5RROG0GL4IJQ3UYWB4W11E2GA1VDADBO'
      request.params[:near] = params[:zipcode]
      request.params[:query] = 'coffee shop'
      request.params[:v] = '20180808'
      #request.options.timeout = 0
    end

    body_hash = JSON.parse(@response.body)
    if @response.success?
      @venues = body_hash["response"]["venues"]
    else
      @error = body_hash["meta"]["errorDetail"]
    end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end

  
end
