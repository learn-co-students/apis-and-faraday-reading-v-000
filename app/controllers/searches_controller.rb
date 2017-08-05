class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp=Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
    req.params['client_id']='3VK4JBPPYV4340RUK3XLWVQAUIL0LAZ4FWKU01NNNYCUKQB0'
    req.params['client_secret']='243G0Y24BJM40PPW4N2W1HISK20XFEA5VWGKSODUATNLF23W'
    req.params['v']='20160201'
    req.params['near'] = params[:zipcode]
    req.params['query'] = 'coffee shop'
    #req.options.timeout = 0
  end
  body_hash=JSON.parse(@resp.body)
  if @resp.success?
  @venues=body_hash["response"]["venues"]
  else
    @error=body_hash['meta']['errorDetail']
  end
  rescue Faraday::TimeoutError
    @error = "There was a timeout. Please try again."
  end
  render 'search'
  end
end
