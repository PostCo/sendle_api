module SendleAPI
  class Connection < ActiveResource::Connection
    # def request(method, path, *arguments)
    #   result = ActiveSupport::Notifications.instrument("request.active_resource") do |payload|
    #     payload[:method]      = method
    #     payload[:request_uri] = "#{site.scheme}://#{site.host}:#{site.port}#{path}"
    #     payload[:result]      = http.send(method, path, *arguments)
    #     require 'pry-byebug'; binding.pry
    #     payload[:result]
    #   end
    #   handle_response(result)
    # rescue Timeout::Error => e
    #   raise TimeoutError.new(e.message)
    # rescue OpenSSL::SSL::SSLError => e
    #   raise SSLError.new(e.message)
    # end
  end
end
