/*
 * Pseudonymization Service
 * Copyright 2022 Armin Müller and contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.bihealth.mi.easybackend.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * This class allows to send and receive messages
 *
 * @author Felix Wirth
 */
@RestController
@RequestMapping(value = "/api/easybackend")
public class MessageRESTController {
    
    /** The logger object for this class. */
    private static Logger LOGGER = LoggerFactory.getLogger(MessageRESTController.class);
    
    /**
     * Send a message
     * 
     * @param scope
     * @param user
     * @return
     */
    @GetMapping("/message/{scope}/{user}")
    public ResponseEntity<String> sendMessage(@PathVariable("scope") String scope,
                                              @PathVariable("user") String user,
                                              @RequestParam(name = "message", required = true) String message) {
        // Logger
        LOGGER.debug(String.format("Request for scope %s, user %s with content %s", scope, user, message));
        System.out.println(String.format("Request for scope %s, user %s with content %s", scope, user, message));
        
        // Return
        return ResponseEntity.ok("Message sent");
    }
    
    @GetMapping("/hello")
    public ResponseEntity<String> hello(Authentication authentication) {
        final String body = "Hello " + authentication.getName();
        return ResponseEntity.ok(body);
    }
}
