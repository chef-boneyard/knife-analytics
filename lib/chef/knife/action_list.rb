#
# Copyright:: Copyright (c) 2013-2014 Chef Software, Inc.
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
    class ActionList < ChefAnalytics::Knife
      category "CHEF ANALYTICS"

      banner "knife action list"

      option :identity_server_url,
        :long         => "--identity-server-url HOST",
        :description  => "URL of Chef identity server to use"

      option :analytics_server_url,
        :long         => "--analytics-server-url HOST",
        :description  => "URL of Chef analytics server to use"

      option :since,
        :long => '--since TIME',
        :short => '-s TIME',
        :required => false,
        :description => 'Find actions since the time provided (format: YYYY-MM-DDThh:mm:ssZ).'

      option :before,
        :long => '--before TIME',
        :short => '-b TIME',
        :required => false,
        :description => 'Find actions before the time provided (format: YYYY-MM-DDThh:mm:ssZ).'

      option :page,
        :long => '--page N',
        :short => '-p N',
        :required => false,
        :description => 'Specifies the page to be returned from the database. The default is 1.'

      def run
        validate_and_set_params

        @rest = ChefAnalytics::ServerAPI.new(analytics_server_url, fetch_token)

        actions = @rest.get("actions#{query_params}")
        output(actions)
      end

      private

      def query_params
        query_params = []
        query_params << "before=#{config[:before]}" if config[:before]
        query_params << "since=#{config[:since]}" if config[:since]
        query_params << "page=#{config[:page]}" if config[:page]
        return '' if query_params.empty?

        "?#{query_params.join('&')}"
      end
    end
  end
end

