# Knife Analytics

A knife plugin for use with the Chef analytics platform.

## Compatability
This plugin works with Chef analytics 1.1.0 and higher

## Commands
This plugin provides the following new Knife sub-commands:

```
** CHEF ANALYTICS COMMANDS **
knife action list
knife action show <id>
knife audit list
knife audit show <id>
knife notification list
knife notification show <id>
knife notification create <notification.json>
knife rule list
knife rule show <id>
knife rule create <rule.json>
```

## Example data for creating rules and notifications:

### Rules
```
{
  "name": "New Rule Group 1",
  "modified_by": "admin",
  "with": {
    "priority": 0
  },
  "active":true,
  "rule":"rules 'New Rule Group 1'\n  rule on action\n  when\n    true\n  then\n    noop()\n  end\nend"
}
```

### Notification
```
{
  "name": "chef-splunk-example",
  "notification_type": "Splunk",
  "modified_by": "admin",
  "delivery_options": {
    "hostname": "splunk.chef.inc.com",
    "port": 8089,
    "username": "serdar",
    "password": "SweetPassword",
    "index": "chef-analytics",
    "sourcetype": "chef-analytics-data"
  }
}
```

License & Authors
-----------------
- Author: James Casey  <james@chef.io>
- Author: Serdar Sutay <serdar@chef.io>

```text
Copyright 2014, Chef Software

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
