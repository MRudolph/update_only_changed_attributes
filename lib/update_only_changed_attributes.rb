module UpdateOnlyChangedAttributes

  def update_only_changed_attributes(params)
    
  end 
end
ActiveRecord::Base.send :include, UpdateOnlyChangedAttributes
