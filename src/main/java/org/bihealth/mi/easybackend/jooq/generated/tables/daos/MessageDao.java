/*
 * This file is generated by jOOQ.
 */
package org.bihealth.mi.easybackend.jooq.generated.tables.daos;


import java.util.List;

import javax.annotation.processing.Generated;

import org.bihealth.mi.easybackend.jooq.generated.tables.Message;
import org.bihealth.mi.easybackend.jooq.generated.tables.records.MessageRecord;
import org.jooq.Configuration;
import org.jooq.impl.DAOImpl;


/**
 * This class is generated by jOOQ.
 */
@Generated(
    value = {
        "https://www.jooq.org",
        "jOOQ version:3.15.10"
    },
    comments = "This class is generated by jOOQ"
)
@SuppressWarnings({ "all", "unchecked", "rawtypes" })
public class MessageDao extends DAOImpl<MessageRecord, org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message, Integer> {

    /**
     * Create a new MessageDao without any configuration
     */
    public MessageDao() {
        super(Message.MESSAGE, org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message.class);
    }

    /**
     * Create a new MessageDao with an attached configuration
     */
    public MessageDao(Configuration configuration) {
        super(Message.MESSAGE, org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message.class, configuration);
    }

    @Override
    public Integer getId(org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message object) {
        return object.getId();
    }

    /**
     * Fetch records that have <code>id BETWEEN lowerInclusive AND
     * upperInclusive</code>
     */
    public List<org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message> fetchRangeOfId(Integer lowerInclusive, Integer upperInclusive) {
        return fetchRange(Message.MESSAGE.ID, lowerInclusive, upperInclusive);
    }

    /**
     * Fetch records that have <code>id IN (values)</code>
     */
    public List<org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message> fetchById(Integer... values) {
        return fetch(Message.MESSAGE.ID, values);
    }

    /**
     * Fetch a unique record that has <code>id = value</code>
     */
    public org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message fetchOneById(Integer value) {
        return fetchOne(Message.MESSAGE.ID, value);
    }

    /**
     * Fetch records that have <code>receiver BETWEEN lowerInclusive AND
     * upperInclusive</code>
     */
    public List<org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message> fetchRangeOfReceiver(String lowerInclusive, String upperInclusive) {
        return fetchRange(Message.MESSAGE.RECEIVER, lowerInclusive, upperInclusive);
    }

    /**
     * Fetch records that have <code>receiver IN (values)</code>
     */
    public List<org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message> fetchByReceiver(String... values) {
        return fetch(Message.MESSAGE.RECEIVER, values);
    }

    /**
     * Fetch records that have <code>scope BETWEEN lowerInclusive AND
     * upperInclusive</code>
     */
    public List<org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message> fetchRangeOfScope(String lowerInclusive, String upperInclusive) {
        return fetchRange(Message.MESSAGE.SCOPE, lowerInclusive, upperInclusive);
    }

    /**
     * Fetch records that have <code>scope IN (values)</code>
     */
    public List<org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message> fetchByScope(String... values) {
        return fetch(Message.MESSAGE.SCOPE, values);
    }

    /**
     * Fetch records that have <code>content BETWEEN lowerInclusive AND
     * upperInclusive</code>
     */
    public List<org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message> fetchRangeOfContent(String lowerInclusive, String upperInclusive) {
        return fetchRange(Message.MESSAGE.CONTENT, lowerInclusive, upperInclusive);
    }

    /**
     * Fetch records that have <code>content IN (values)</code>
     */
    public List<org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message> fetchByContent(String... values) {
        return fetch(Message.MESSAGE.CONTENT, values);
    }
}
