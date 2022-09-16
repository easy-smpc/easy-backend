/* 
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

import java.security.Principal;
import java.util.List;

import org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message;
import org.bihealth.mi.easybackend.service.MessageDBAccessService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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
    
    /** Enables the access to the message specific database access methods. */
    @Autowired
    private MessageDBAccessService messageDBAccessService;
    
    /**
     * Sends a message
     * 
     * @param scope
     * @param receiver
     * @param message
     * @return
     */
    @PreAuthorize("hasAuthority('easybackend_user')")
    @PostMapping("/send/{scope}/{receiver}")
    public ResponseEntity<String> sendMessage(@PathVariable("scope") String scope,
                                              @PathVariable("receiver") String receiver,
                                              @RequestBody(required = true) String message) {
        
        // Logger
        LOGGER.debug(String.format("Send message for scope %s and receiver %s", scope, receiver));
        
        if(!messageDBAccessService.insertMessage(new Message().setReceiver(receiver).setScope(scope).setContent(message))) {
            // Return error
            LOGGER.debug(String.format("Unable to write message for scope %s and receiver %s", scope, receiver));
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        
        // Return success
        return ResponseEntity.ok("Message sent");
    }
    
    /**
     *  Receives all messages for a scope and a receiving user
     * 
     * @param scope
     * @param principal
     * @return
     */
    @PreAuthorize("hasAuthority('easybackend_user')")
    @GetMapping("/receive/{scope}")
    public ResponseEntity<?> getMessages(@PathVariable("scope") String scope, Principal principal) {
        // Logger
        LOGGER.debug(String.format("Get messages for receiver %s", principal.getName()));

        // Get data
        List<Message> messages = messageDBAccessService.getMessages(principal.getName(), scope);

        // Return
        return ResponseEntity.status(HttpStatus.OK).body(messages);
    }
       
    /**
     * Deletes a message
     * 
     * @param messageId
     * @param principal
     * @return
     */
    @PreAuthorize("hasAuthority('easybackend_user')")
    @DeleteMapping("/message/{messageId}")
    public ResponseEntity<?> deleteMessage(@PathVariable("messageId") int messageId, Principal principal) {
        // Logger
        LOGGER.debug(String.format("Delete message with id %d for receiver %s", messageId, principal.getName()));

        // Delete data
        if(!messageDBAccessService.deleteMessage(messageId, principal.getName())) {
            
            // Return error
            LOGGER.debug(String.format("Unable to delete message with id %d and receiver %s", messageId, principal.getName()));
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }

        // Return success
        return ResponseEntity.ok("Message deleted");
    }
}
