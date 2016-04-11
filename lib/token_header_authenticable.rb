class TokenHeaderAuthenticable < ::Devise::Strategies::Authenticatable
  def valid?
    self.authentication_hash = {}
    self.authentication_type = :token_auth
    if token = token_value
      self.authentication_hash[:auth_token] = token
    else
      false
    end
  end

  def authenticate!
    resource_scope = mapping.to
    resource = resource_scope.find_by_authentication_token(token_value)

    if resource
      success!(resource)
    else
      fail!
    end
  end

  private

  def token_value
     header_values[header_key]
  end

  def header_key
        "HTTP_#{mapping.to.http_authentication_key.gsub('-', '_').upcase}"
  end

  def header_values
        env.select { |k, v| k =~ /^HTTP_/ }
  end

end
