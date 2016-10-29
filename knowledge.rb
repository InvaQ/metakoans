class Module

  def attribute(name, &block)
    name, default_name = name.to_a.first if name.is_a?(Hash)

    define_method("#{name}") do 
      !instance_variable_get("@#{name}").nil?
    end

    define_method("#{name}=") do |value|
      instance_variable_set("@#{name}", value)
    end

    define_method("#{name}") do 
      if instance_variable_defined?("@#{name}")
        instance_variable_get("@#{name}")
      else
        instance_variable_set("@#{name}", (block ? instance_eval(&block) : default_name))
      end
    end

  end


end
