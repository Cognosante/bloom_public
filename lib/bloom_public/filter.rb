module BloomPublic
  #
  # This describes a filter that can be applied to a search
  #
  class Filter
    attr_reader :key
    attr_reader :op
    attr_reader :value

    def initialize(key:, op:, value:)
      @key = key
      @op = op
      @value = value

      raise 'Invalid operation' unless %w(eq gt lt gte lte prefix fuzzy).include?(@op)
    end

    def as_params(index)
      {
        "key#{index}" => @key,
        "op#{index}" => @op,
        "value#{index}" => @value.upcase
      }
    end
  end
end
