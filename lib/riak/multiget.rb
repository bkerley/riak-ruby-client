# Copyright 2010-present Basho Technologies, Inc.
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

require 'riak/client'
require 'riak/bucket'
require 'riak/multi'

module Riak
  # Coordinates a parallel fetch operation for multiple keys.
  class Multiget < Multi
    # @deprecated use perform
    class << self
      alias_method :get_all, :perform
    end

    private

    def work(bucket, key)
      bucket[key]
    rescue Riak::FailedRequest => e
      raise e unless e.not_found?
      nil
    end
  end
end
