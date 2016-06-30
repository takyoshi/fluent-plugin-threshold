# coding: utf-8
module Fluent
  class ThresholdOutput < Output
    include Fluent::HandleTagNameMixin

    Fluent::Plugin.register_output('threshold', self)

    config_param :operator,   :string
    config_param :threshold,  :string
    config_param :target_key, :string

    unless method_defined?(:router)
      define_method("router") { Fluent::Engine }
    end

    # <match *>
    #   operator eq | ne | gl | ge | lt | le
    #   threshold <float> | <integer>
    #   target_key <key_name>
    # </match>
    def initialize
      super
    end

    def configure(conf)
      super

      @labelled = !conf['@label'].nil?

      if !@labelled && !@remove_tag_prefix && !@remove_tag_suffix && !@add_tag_prefix && !@add_tag_suffix
        raise ConfigError, "fluent-plugin-threshold: Set 'remove_tag_prefix', 'remove_tag_suffix', 'add_tag_prefix' or 'add_tag_suffix'."
      end

      # You can also refer raw parameter via conf[name].
      unless @operator
        raise ConfigError, "fluent-plugin-threshold: 'operator' parameter is required"
      end

      unless @threshold
        raise ConfigError, "fluent-plugin-threshold: 'threshold' parameter is required"
      end

      unless @target_key
        raise ConfigError, "fluent-plugin-threshold: 'target_key' parameter is required"
      end
    end

    def start
      super
    end

    def shutdown
      super
    end

    # This method is called when an event reaches to Fluentd.
    # Convert the event to a raw string.
    def filter_record(tag, time, record)
      super

      filter_record = {}
      case @operator
      when "eq"
        if record.member?(@target_key) && record[@target_key].to_f == threshold.to_f
          filter_record = record
        end
      when "ne"
        if record.member?(@target_key) && record[@target_key].to_f != threshold.to_f
          filter_record = record
        end
      when "ge"
        if record.member?(@target_key) && record[@target_key].to_f >= threshold.to_f
          filter_record = record
        end
      when "gt"
        if record.member?(@target_key) && record[@target_key].to_f >  threshold.to_f
          filter_record = record
        end
      when "le"
        if record.member?(@target_key) && record[@target_key].to_f <= threshold.to_f
          filter_record = record
        end
      when "lt"
        if record.member?(@target_key) && record[@target_key].to_f <  threshold.to_f
          filter_record = record
        end
      else
        raise ArgumentError.new("no such operator: #{@operator}")
      end

      filter_record
    end

    def emit(tag, es, chain)
      es.each do |time, record|
        _tag = tag.clone
        record = filter_record(_tag, time, record)

        if record.any?
          router.emit(_tag, time, record)
        end
      end

      chain.next
    end
  end
end
