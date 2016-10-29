class Factory

  def self.new(*params, &block)

    klass = Class.new do

      attr_accessor(*params) 
      attr_accessor :init_args

      def initialize(*args)
        @init_args = args
        members.zip(args).each do |member, argument|
                          instance_variable_set("@#{member}", argument)
        end
      end

      def [](param)
        param = instance_variables[param][1..-1] if param.is_a? Fixnum
        instance_variable_get("@#{param}")
      end

      define_method :members do        
        params
      end
      
      def values
        @init_args
      end

      def values_at(*args)
        values = []
        args.each do |argument|
          if argument.is_a? Fixnum
            values << send("#{members[argument]}")
          else
            values << send("#{argument}")
          end        
        end
        values
      end

      def ==(other_obj)
        return true if ((self.class == other_obj.class) && 
                          (values == other_obj.values))
          false
      end

      class_eval(block) if block_given?

    end
  end
end