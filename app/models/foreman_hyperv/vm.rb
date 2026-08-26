  module ForemanHyperv
    class VM
      attr_reader :id, :name, :state, :cpu_count, :cpu_usage, :memory_assigned,
                  :uptime, :status, :version

      def initialize(id:, name:, state:, cpu_count:, cpu_usage:, memory_assigned:, uptime:, status:, version:)
        @id              = id
        @name            = name
        @state           = state
        @cpu_count       = cpu_count
        @cpu_usage       = cpu_usage
        @memory_assigned = memory_assigned
        @uptime          = uptime
        @status          = status
        @version         = version
      end

      def identity
        id
      end

      def to_s
        name
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
        # Case 1: Hyper-V returned a Hash (JSON TimeSpan object)
        if @uptime.is_a?(Hash)
          days    = @uptime["Days"].to_i
          hours   = @uptime["Hours"].to_i
          minutes = @uptime["Minutes"].to_i
          seconds = @uptime["Seconds"].to_i

          if days > 0
            "#{days}d #{hours}h #{minutes}m #{seconds}s"
          else
            "#{hours}h #{minutes}m #{seconds}s"
          end

        # Case 2: Hyper-V returned a string (e.g. "0.17:31:40")
        elsif @uptime.is_a?(String)
          parts = @uptime.split(":")
          return @uptime unless parts.length == 3

          days_hours = parts[0].split(".")
          days = days_hours.length == 2 ? days_hours[0].to_i : 0
          hours = days_hours.length == 2 ? days_hours[1].to_i : days_hours[0].to_i
          minutes = parts[1].to_i
          seconds = parts[2].to_i

          if days > 0
            "#{days}d #{hours}h #{minutes}m #{seconds}s"
          else
            "#{hours}h #{minutes}m #{seconds}s"
          end

        # Case 3: Unknown format — fallback
        else
          @uptime.to_s
        end
      end
    end
  end
