module HyperV
  class VM
    attr_reader :id, :name, :state, :cpu_usage, :memory_assigned, :uptime, :status, :version

    def initialize(id:, name:, state:, cpu_usage:, memory_assigned:, uptime:, status:, version:)
      @id              = id
      @name            = name
      @state           = state
      @cpu_usage       = cpu_usage
      @memory_assigned = memory_assigned
      @uptime          = uptime
      @status          = status
      @version         = version
    end

    def normalized_state
      case @state
      when 0 then "Off"
      when 2 then "Running"
      when 3 then "Paused"
      when 4 then "Saved"
      else "Unknown"
      end
    end

    def normalized_memory
      mb = @memory_assigned.to_f / (1024 * 1024)
      gb = mb / 1024

      if gb >= 1
        "#{gb.round(2)} GB"
      else
        "#{mb.round} MB"
      end
    end

    def normalized_uptime
      days    = @uptime["Days"]    || 0
      hours   = @uptime["Hours"]   || 0
      minutes = @uptime["Minutes"] || 0
      seconds = @uptime["Seconds"] || 0

      "#{days}d #{hours}h #{minutes}m #{seconds}s"
    end
  end
end
