/*
 * This file is generated by jOOQ.
 */
package org.bihealth.mi.easybackend.jooq.generated.tables.records;


import javax.annotation.processing.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

import org.bihealth.mi.easybackend.jooq.generated.tables.Message;
import org.bihealth.mi.easybackend.jooq.generated.tables.interfaces.IMessage;
import org.jooq.Field;
import org.jooq.Record1;
import org.jooq.Record4;
import org.jooq.Row4;
import org.jooq.impl.UpdatableRecordImpl;


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
@Entity
@Table(
    name = "message",
    schema = "public",
    indexes = {
        @Index(name = "userscopeidx", columnList = "receiver ASC, scope ASC")
    }
)
public class MessageRecord extends UpdatableRecordImpl<MessageRecord> implements Record4<Integer, String, String, String>, IMessage {

    private static final long serialVersionUID = 1L;

    /**
     * Setter for <code>public.message.id</code>.
     */
    @Override
    public MessageRecord setId(Integer value) {
        set(0, value);
        return this;
    }

    /**
     * Getter for <code>public.message.id</code>.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false, precision = 32)
    @Override
    public Integer getId() {
        return (Integer) get(0);
    }

    /**
     * Setter for <code>public.message.receiver</code>.
     */
    @Override
    public MessageRecord setReceiver(String value) {
        set(1, value);
        return this;
    }

    /**
     * Getter for <code>public.message.receiver</code>.
     */
    @Column(name = "receiver", nullable = false)
    @Override
    public String getReceiver() {
        return (String) get(1);
    }

    /**
     * Setter for <code>public.message.scope</code>.
     */
    @Override
    public MessageRecord setScope(String value) {
        set(2, value);
        return this;
    }

    /**
     * Getter for <code>public.message.scope</code>.
     */
    @Column(name = "scope", nullable = false)
    @Override
    public String getScope() {
        return (String) get(2);
    }

    /**
     * Setter for <code>public.message.content</code>.
     */
    @Override
    public MessageRecord setContent(String value) {
        set(3, value);
        return this;
    }

    /**
     * Getter for <code>public.message.content</code>.
     */
    @Column(name = "content", nullable = false)
    @Override
    public String getContent() {
        return (String) get(3);
    }

    // -------------------------------------------------------------------------
    // Primary key information
    // -------------------------------------------------------------------------

    @Override
    public Record1<Integer> key() {
        return (Record1) super.key();
    }

    // -------------------------------------------------------------------------
    // Record4 type implementation
    // -------------------------------------------------------------------------

    @Override
    public Row4<Integer, String, String, String> fieldsRow() {
        return (Row4) super.fieldsRow();
    }

    @Override
    public Row4<Integer, String, String, String> valuesRow() {
        return (Row4) super.valuesRow();
    }

    @Override
    public Field<Integer> field1() {
        return Message.MESSAGE.ID;
    }

    @Override
    public Field<String> field2() {
        return Message.MESSAGE.RECEIVER;
    }

    @Override
    public Field<String> field3() {
        return Message.MESSAGE.SCOPE;
    }

    @Override
    public Field<String> field4() {
        return Message.MESSAGE.CONTENT;
    }

    @Override
    public Integer component1() {
        return getId();
    }

    @Override
    public String component2() {
        return getReceiver();
    }

    @Override
    public String component3() {
        return getScope();
    }

    @Override
    public String component4() {
        return getContent();
    }

    @Override
    public Integer value1() {
        return getId();
    }

    @Override
    public String value2() {
        return getReceiver();
    }

    @Override
    public String value3() {
        return getScope();
    }

    @Override
    public String value4() {
        return getContent();
    }

    @Override
    public MessageRecord value1(Integer value) {
        setId(value);
        return this;
    }

    @Override
    public MessageRecord value2(String value) {
        setReceiver(value);
        return this;
    }

    @Override
    public MessageRecord value3(String value) {
        setScope(value);
        return this;
    }

    @Override
    public MessageRecord value4(String value) {
        setContent(value);
        return this;
    }

    @Override
    public MessageRecord values(Integer value1, String value2, String value3, String value4) {
        value1(value1);
        value2(value2);
        value3(value3);
        value4(value4);
        return this;
    }

    // -------------------------------------------------------------------------
    // FROM and INTO
    // -------------------------------------------------------------------------

    @Override
    public void from(IMessage from) {
        setId(from.getId());
        setReceiver(from.getReceiver());
        setScope(from.getScope());
        setContent(from.getContent());
    }

    @Override
    public <E extends IMessage> E into(E into) {
        into.from(this);
        return into;
    }

    // -------------------------------------------------------------------------
    // Constructors
    // -------------------------------------------------------------------------

    /**
     * Create a detached MessageRecord
     */
    public MessageRecord() {
        super(Message.MESSAGE);
    }

    /**
     * Create a detached, initialised MessageRecord
     */
    public MessageRecord(Integer id, String receiver, String scope, String content) {
        super(Message.MESSAGE);

        setId(id);
        setReceiver(receiver);
        setScope(scope);
        setContent(content);
    }

    /**
     * Create a detached, initialised MessageRecord
     */
    public MessageRecord(org.bihealth.mi.easybackend.jooq.generated.tables.pojos.Message value) {
        super(Message.MESSAGE);

        if (value != null) {
            setId(value.getId());
            setReceiver(value.getReceiver());
            setScope(value.getScope());
            setContent(value.getContent());
        }
    }
}