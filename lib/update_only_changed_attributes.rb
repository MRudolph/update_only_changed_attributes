module UpdateOnlyChangedAttributes

  def attribute_change_delta(params)
    result = {}
    params.each do |key,value|
      result[key] = value if self[key] != value
    end
    result
  end
  
  def update_only_changed_attributes(params)
    changes = attribute_change_delta(params)
    self.update_attributes(changes)
  end 
end
ActiveRecord::Base.send :include, UpdateOnlyChangedAttributes
