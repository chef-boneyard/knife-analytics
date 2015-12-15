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

require 'chef-analytics/identity'
require 'chef/config'

module KnifeAnalytics
  class Knife < Chef::Knife
    attr_accessor :analytics_server_url

    def initialize(arg)
      super(arg)
    end

    def fetch_token
      identity = ChefAnalytics::Identity.new(identity_server_url: @identity_server_url)
      token = identity.token
      if token.nil?
        ui.error 'Couldn\'t get OAuth2 token from OC-ID server'
        exit 1
      end
      token
    end

    def validate_and_set_params
      @analytics_server_url ||= Chef::Config[:analytics_server_url]
      @analytics_server_url ||= config[:analytics_server_url]
      @identity_server_url ||= Chef::Config[:identity_server_url]
      @identity_server_url ||= config[:identity_server_url]

      unless @analytics_server_url
        ui.error 'analytics_server_url not set in config or command line'
        exit 1
      end
    end

    def analytics_server_root
      URI.join(@analytics_server_url, '/').to_s
    end
  end
end
