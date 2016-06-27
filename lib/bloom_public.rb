require 'bloom_public/configuration'
require 'bloom_public/filter'
require 'bloom_public/response'
require 'bloom_public/version'

require 'addressable/template'
require 'json'
require 'multi_json'
require 'rest-client'

#
# Access point
#
module BloomPublic
  def self.configure
    if block_given?
      yield configuration
    end
    configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.sources
    template = Addressable::Template.new("#{base_url}/sources{?query*}")
    uri = template.expand(query: secret_param)
    Response.new(get_json(uri))
  end

  def self.get_by_id(source:, id:)
    template = Addressable::Template.new("#{base_url}/sources/{source}/{id}{?query*}")
    uri = template.expand(source: source, id: id, query: secret_param)
    Response.new(get_json(uri))
  end

  def self.search(source:, filters: [], limit: 100, offset: 0)
    template = Addressable::Template.new("#{base_url}/search/{source}{?query*}")
    params = {
      source: source,
      query: secret_param.merge(limit: limit, offset: offset)
    }
    filters.each_with_index do |filter, idx|
      params[:query].merge!(filter.as_params(idx + 1))
    end
    uri = template.expand(params)
    Response.new(get_json(uri))
  end

  #
  # End public API
  #

  def self.base_url
    if configuration.secret
      'https://www.bloomapi.com/api'
    else
      'http://www.bloomapi.com/api'
    end
  end

  def self.get_json(uri)
    MultiJson.load(RestClient.get(uri.to_s).body)
  end

  def self.secret_param
    if configuration.secret && !configuration.secret.empty?
      { secret: configuration.secret }
    else
      {}
    end
  end
end
