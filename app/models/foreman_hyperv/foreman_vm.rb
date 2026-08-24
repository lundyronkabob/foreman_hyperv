module ForemanHyperv
  class ForemanVM
    attr_reader :compute_resource, :id, :name, :state, :memory, :cpus

    def initialize(compute_resource:, id:, name:, state:, memory:, cpus:)
      @compute_resource = compute_resource
      @id               = id
      @name             = name
      @state            = state
      @memory           = memory
      @cpus             = cpus
    end

    def to_s
      @name
    end
  end
end
