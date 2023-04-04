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
package org.bihealth.mi.easybackend.service;


import static org.bihealth.mi.easybackend.jooq.generated.Tables.MESSAGE;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message;
import org.jooq.Configuration;
import org.jooq.DSLContext;
import org.jooq.TransactionalRunnable;
import org.jooq.impl.DSL;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Service to access the message database
 * 
 * @author Felix Wirth
 *
 */
@Service
public class MessageDBAccessService {
    
    /** Logger */
    private static Logger LOGGER = LoggerFactory.getLogger(MessageDBAccessService.class);
    
    /** References a jOOQ configuration */
    @Autowired
    private DSLContext dslCtx;
    
    /**
     * Represents an erroneous insertion of a record into the database.
     */
    public static final String INSERTION_ERROR = "error";

    /**
     * Represents a successful insertion of a record into the database.
     */
    public static final String INSERTION_SUCCESS = "success";
    
    /**
     * Method to insert a message into the database.
     *
     * @param message the message object that should be inserted
     * @return {@code INSERTION_SUCCESS} when the insertion was successful, {@code INSERTION_ERROR} otherwise
     */
    public boolean insertMessage(Message message) {
        
        // Execute query
        try {
            dslCtx.transaction(new TransactionalRunnable() {

                @Override
                public void run(Configuration configuration) throws Throwable {
                    // Insert into table
                    int insertedRecords = DSL.using(configuration)
                            .insertInto(MESSAGE, MESSAGE.RECEIVER, MESSAGE.SCOPE, MESSAGE.CONTENT)
                            .values(message.getReceiver(),message.getScope(), message.getContent()).execute();
                    
                    // Determine insertion success
                    if (insertedRecords != 1) {
                        // An unexpected number of records was affected. Log it and abort by throwing an exception (which will rollback everything from the transaction).
                        LOGGER.error("Couldn't insert the record into the database.");
                        throw new IOException();
                    }

                    // Implicit transaction commit here
                }
            });

            // Log success and return
            LOGGER.debug("Successfully inserted the message into the database");
            return true;
        } catch (Exception e) {
            // Log error and return
            LOGGER.error("Couldn't insert the record into the database: " + e.getMessage() + "\n");
            return false;
        }
    }
    
    
    /**
     *  Retrieves all messages for a user and scope
     * 
     * @param receiver
     * @param scope
     * @return
     */
    public List<Message> getMessages(String receiver, String scope) {
        // Prepare
        List<Message> messages = new ArrayList<>();
        
        // Execute query
        try {
            dslCtx.transaction(new TransactionalRunnable() {

                @Override
                public void run(Configuration configuration) throws Throwable {

                    // Build and execute the query
                    messages.addAll(DSL.using(configuration)
                                       .selectFrom(MESSAGE)
                                       .where(MESSAGE.RECEIVER.equal(receiver))
                                       .and(MESSAGE.SCOPE.equal(scope))
                                       .fetchInto(Message.class));
                    // Return
                    return;
                }
            });

            // Return
            return messages.size() > 0 ? messages : null;
        } catch (Exception e) {
            // Handle error
            LOGGER.error("Couldn't query the database: " + e.getMessage() + "\n");
            return null;
        }
    }

    /**
     *  List all messages for a user and pattern
     * 
     * @param receiver
     * @param pattern
     * @return
     */
    public List<Message> listMessages(String receiver, String pattern) {
        // Prepare
        List<Message> messages = new ArrayList<>();
        
        // Execute query
        try {
            dslCtx.transaction(new TransactionalRunnable() {

                @Override
                public void run(Configuration configuration) throws Throwable {

                    // Build and execute the query
                    messages.addAll(DSL.using(configuration)
                                       .selectFrom(MESSAGE)
                                       .where(MESSAGE.RECEIVER.equal(receiver))
                                       .and(MESSAGE.SCOPE.contains(pattern))
                                       .fetchInto(Message.class));
                    // Return
                    return;
                }
            });

            // Return
            return messages.size() > 0 ? messages : null;
        } catch (Exception e) {
            // Handle error
            LOGGER.error("Couldn't query the database: " + e.getMessage() + "\n");
            return null;
        }
    }
    
    /**
     * Delete message
     *
     * @param messageId
     * @param receiver
     * @return deletion successful
     */
    public boolean deleteMessage(int messageId, String receiver) {
        
        // Execute query
        try {
            dslCtx.transaction(new TransactionalRunnable() {

                @Override
                public void run(Configuration configuration) throws Throwable {

                    // Delete message
                    int deletedMessages = DSL.using(configuration).deleteFrom(MESSAGE)
                            .where(MESSAGE.ID.equal(messageId))
                            .and(MESSAGE.RECEIVER.equal(receiver))
                            .execute();
                    
                    // Determine deletion success
                    if (deletedMessages != 1) {
                        // An unexpected number of records was affected. Log it and abort by throwing  an exception (which will rollback everything from the transaction).
                        LOGGER.error("Couldn't delete the message \"" + messageId + "\" from the database.");
                        throw new IOException();
                    }
                }
            });

            // Return
            return true;
        } catch (Exception e) {
            // Handle error
            LOGGER.error("Couldn't query the database: " + e.getMessage() + "\n");
            return false;
        }
    }

    /**
     * Delete message
     *
     * @return deletion successful
     */
    public boolean deleteAllMessages() {
        
        // Execute query
        try {
            dslCtx.transaction(new TransactionalRunnable() {
    
                @Override
                public void run(Configuration configuration) throws Throwable {
                    
                    // Delete message
                    int deletedMessages = DSL.using(configuration).deleteFrom(MESSAGE).execute();
                    
                    // Determine deletion success
                    if (deletedMessages < 0) {
                        LOGGER.error("Couldn't delete all messages");
                        throw new IOException();
                    }
                }
            });
    
            // Return
            return true;
        } catch (Exception e) {
            // Handle error
            LOGGER.error("Couldn't query the database: " + e.getMessage() + "\n");
            return false;
        }
    }
}
