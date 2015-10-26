#
# Copyright:: Copyright (c) 2013-2015 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef-analytics'

class Chef
  class Knife
    class AnalyticsRaw < ChefAnalytics::Knife
      category "CHEF ANALYTICS"

      banner "knife analytics raw <request_path>"

      option :identity_server_url,
             :long         => "--identity-server-url HOST",
             :description  => "URL of Chef identity server to use"

      option :analytics_server_url,
             :long         => "--analytics-server-url HOST",
             :description  => "URL of Chef analytics server to use"

      option :method,
             :long => '--method METHOD',
             :short => '-m METHOD',
             :default => "GET",
             :description => "Request method (GET, POST, PUT or DELETE).  Default: GET"

      option :pretty,
             :long => '--[no-]pretty',
             :boolean => true,
             :default => true,
             :description => "Pretty-print JSON output.  Default: true"

      option :input,
             :long => '--input FILE',
             :short => '-i FILE',
             :description => "Name of file to use for PUT or POST"

      def run
        if name_args.length == 0
          show_usage
          ui.fatal("You must provide the path you want to access on the server")
          exit(1)
        elsif name_args.length > 1
          show_usage
          ui.fatal("Only one path accepted for knife analytics raw")
          exit(1)
        end

        request_path = name_args[0]
        data = false
        if config[:input]
          data = IO.read(config[:input])
        end
        validate_and_set_params

        begin
          method = config[:method].to_sym

          headers = {'Content-Type' => 'application/json'}

          if config[:pretty]
            @rest = ChefAnalytics::ServerAPI.new(analytics_server_root, fetch_token)
            result = @rest.request(method, request_path, headers, data)
            unless result.is_a?(String)
              result = Chef::JSONCompat.to_json_pretty(result)
            end
          else
            @rest = ChefAnalytics::ServerAPI.new(analytics_server_root, fetch_token, { :raw_output => true })
            result = @rest.request(method, request_path, headers, data)
          end
          output result
        rescue Timeout::Error => e
          ui.error "Server timeout"
          exit 1
        rescue Net::HTTPServerException => e
          ui.error "Server responded with error #{e.response.code} \"#{e.response.message}\""
          ui.error "Error Body: #{e.response.body}" if e.response.body && e.response.body != ''
          exit 1
        end
      end

    end # end class AnalyticsRaw
  end
end

