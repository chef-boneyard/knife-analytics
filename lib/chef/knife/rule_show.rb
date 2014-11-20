#
# Copyright:: Copyright (c) 2014 Chef Software, Inc.
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
    class RuleShow < ChefAnalytics::Knife
      category "CHEF ANALYTICS"

      banner "knife rule show <id>"

      option :identity_server_url,
        :long         => "--identity-server-url HOST",
        :description  => "URL of Chef identity server to use"

      option :analytics_server_url,
        :long         => "--analytics-server-url HOST",
        :description  => "URL of Chef analytics server to use"

      def run
        validate_and_set_params

        run_id = name_args[0]

        if run_id.nil?
          show_usage
          exit 1
        end

        @rest = ChefAnalytics::ServerAPI.new(analytics_server_url, fetch_token)

        action = @rest.get("rules/#{run_id}")
        output(action)
      end
    end
  end
end

