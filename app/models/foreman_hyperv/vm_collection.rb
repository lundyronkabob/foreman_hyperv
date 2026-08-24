module ForemanHyperv
  class VMCollection
    def initialize(vms)
      @vms = vms
    end

    def all(*args)
      @vms
    end

    def to_a(*args)
      @vms
    end
  end
end
