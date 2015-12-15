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
require 'json'

module KnifeAnalytics
  class NotificationCreate < KnifeAnalytics::Knife
    category "CHEF ANALYTICS"

    banner "knife notification create <notification.json>"

    option :identity_server_url,
      :long         => "--identity-server-url HOST",
      :description  => "URL of Chef identity server to use"

    option :analytics_server_url,
      :long         => "--analytics-server-url HOST",
      :description  => "URL of Chef analytics server to use"

    def run
      validate_and_set_params

      @rest = ChefAnalytics::ServerAPI.new(analytics_server_url, fetch_token)

      headers = {"Content-Type" => "application/json"}
      response = @rest.post("/aliases", File.read(name_args[0]), headers)
      output(response)
    end
  end
end
