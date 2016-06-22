module BloomPublic
  #
  # This represents a data source
  #
  class Response
    attr_reader :data

    def initialize(json)
      @data = json['result']
    end
  end
end
