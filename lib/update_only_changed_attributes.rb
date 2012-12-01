module UpdateOnlyChangedAttributes

  # attribute_change_delta compares the given hash against the attributes found in the model.
  # It just returns the values that are different.
  def attribute_change_delta(params)
    result = {}
    params.each do |key,value|
      result[key] = value if self[key] != value
    end
    result
  end
  
  # update_only_changed_attributes takes a hash like update_attributes, but just passes attributes which have changed.  
  # Doesn't currently support nested attributes.
  def update_only_changed_attributes(params)
    changes = attribute_change_delta(params)
    self.update_attributes(changes)
  end
  # update_only_changed_attributes! takes a hash like update_attributes!, but just passes attributes which have changed.
  # Doesn't currently support nested attributes.
  def update_only_changed_attributes!(params)
    changes = attribute_change_delta(params)
    self.update_attributes(changes)
  end 
  
end
ActiveRecord::Base.send :include, UpdateOnlyChangedAttributes
