/*
 * Copyright 2013 Bud Byrd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.budjb.requestbuilder.httpexception

import com.budjb.requestbuilder.ResponseStatusException
import com.sun.jersey.api.client.ClientResponse

class HttpUseProxyException extends ResponseStatusException {
    HttpUseProxyException(int status, content, ClientResponse response, String logText) {
        super(status, content, response, logText)
    }
}
