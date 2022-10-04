--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Create db
CREATE DATABASE keycloak;

-- Connect to db
\connect keycloak



SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
0089cab5-182f-4e1e-8899-07df21ff99cd	\N	auth-cookie	master	8c782ee1-54ab-4b5c-a5ec-d952a6e1f3cb	2	10	f	\N	\N
f9897440-6740-4c5d-82e8-a9be6319e122	\N	auth-spnego	master	8c782ee1-54ab-4b5c-a5ec-d952a6e1f3cb	3	20	f	\N	\N
cc351f0f-d3ac-417e-a1b0-4f046f0967ec	\N	identity-provider-redirector	master	8c782ee1-54ab-4b5c-a5ec-d952a6e1f3cb	2	25	f	\N	\N
9ecf7ea5-0b41-494a-99ed-08b77ba3f75d	\N	\N	master	8c782ee1-54ab-4b5c-a5ec-d952a6e1f3cb	2	30	t	20ac506d-4cc7-4e97-a44d-05806b46ea22	\N
9de72798-a189-44a1-997f-878ebabb4e80	\N	auth-username-password-form	master	20ac506d-4cc7-4e97-a44d-05806b46ea22	0	10	f	\N	\N
bcd98603-8dc2-4905-97a7-6e971de9e6cd	\N	\N	master	20ac506d-4cc7-4e97-a44d-05806b46ea22	1	20	t	7ea3bb9a-b17a-41fc-ac83-86da71a1930d	\N
24838a9e-e3a0-4c4d-b9d7-a2fafb232f55	\N	conditional-user-configured	master	7ea3bb9a-b17a-41fc-ac83-86da71a1930d	0	10	f	\N	\N
f32f7c1b-d971-4d56-8b72-d72adce1b7fb	\N	auth-otp-form	master	7ea3bb9a-b17a-41fc-ac83-86da71a1930d	0	20	f	\N	\N
3be6caf7-96aa-4929-ae28-1705ab969094	\N	direct-grant-validate-username	master	82d5a563-b26a-461d-8c76-35811de00686	0	10	f	\N	\N
b0f15225-074b-4b96-a865-5e17ac584bce	\N	direct-grant-validate-password	master	82d5a563-b26a-461d-8c76-35811de00686	0	20	f	\N	\N
355a27d8-7563-4998-8664-42c079e011b1	\N	\N	master	82d5a563-b26a-461d-8c76-35811de00686	1	30	t	5caf4668-436c-45a2-924f-f2243aab3c0a	\N
1d3bf235-5ac9-4e07-863b-8396e43b2257	\N	conditional-user-configured	master	5caf4668-436c-45a2-924f-f2243aab3c0a	0	10	f	\N	\N
796bee32-8543-4563-838e-ca15cf839cfc	\N	direct-grant-validate-otp	master	5caf4668-436c-45a2-924f-f2243aab3c0a	0	20	f	\N	\N
5c3ba066-3a62-4025-899b-0c24b683f88b	\N	registration-page-form	master	4119c649-701e-4a9d-b7b1-1d1165a51537	0	10	t	9ac25b9a-4a44-4802-84ed-6cc5b0bd6834	\N
575a7caf-3e1c-4b75-aab6-258d780a7ba9	\N	registration-user-creation	master	9ac25b9a-4a44-4802-84ed-6cc5b0bd6834	0	20	f	\N	\N
21144652-410f-4121-852a-9d58e4375414	\N	registration-profile-action	master	9ac25b9a-4a44-4802-84ed-6cc5b0bd6834	0	40	f	\N	\N
e1b86e06-eddc-4503-95c0-1038590da261	\N	registration-password-action	master	9ac25b9a-4a44-4802-84ed-6cc5b0bd6834	0	50	f	\N	\N
6cbf9933-87c9-49db-99ad-a78ab5f15547	\N	registration-recaptcha-action	master	9ac25b9a-4a44-4802-84ed-6cc5b0bd6834	3	60	f	\N	\N
ec06de9f-10d1-4544-943b-5029f23a20fc	\N	reset-credentials-choose-user	master	f2dc59e8-bc3e-47b0-8216-f693782da99e	0	10	f	\N	\N
5043cbb5-4afb-4105-98ae-43bc71c9d5c2	\N	reset-credential-email	master	f2dc59e8-bc3e-47b0-8216-f693782da99e	0	20	f	\N	\N
98b82b55-cdd6-4cae-b9a5-3fbe19949d40	\N	reset-password	master	f2dc59e8-bc3e-47b0-8216-f693782da99e	0	30	f	\N	\N
399297c2-0df4-4fb7-a4be-bef53f269160	\N	\N	master	f2dc59e8-bc3e-47b0-8216-f693782da99e	1	40	t	22aa7c0f-3308-44c3-b336-092742a4aabd	\N
4e95af47-f97e-4db9-a24b-44abf77e8488	\N	conditional-user-configured	master	22aa7c0f-3308-44c3-b336-092742a4aabd	0	10	f	\N	\N
bdf71060-232d-452f-a791-633b86fca012	\N	reset-otp	master	22aa7c0f-3308-44c3-b336-092742a4aabd	0	20	f	\N	\N
b338dfc7-3a0d-4074-a24e-cb6860d7cb83	\N	client-secret	master	a16b9bc2-5015-416a-8882-453ac64b58cc	2	10	f	\N	\N
f30d56ce-08e7-43db-a28a-318401c7d763	\N	client-jwt	master	a16b9bc2-5015-416a-8882-453ac64b58cc	2	20	f	\N	\N
36bbfd5e-8ec9-4a7c-ad0c-22f9c7be9022	\N	client-secret-jwt	master	a16b9bc2-5015-416a-8882-453ac64b58cc	2	30	f	\N	\N
89a9ec6e-d44e-4679-8eea-ff480aaf8e40	\N	client-x509	master	a16b9bc2-5015-416a-8882-453ac64b58cc	2	40	f	\N	\N
754b13b3-4a3f-4980-bb2a-93f6f32b10ec	\N	idp-review-profile	master	f0202104-b1b1-461d-9c6f-bd73b75edae0	0	10	f	\N	38ebb1b9-11ed-4c7b-abe6-ba7a88bffc34
fada6a69-6da4-484c-ad98-0f5ef3bf60e3	\N	\N	master	f0202104-b1b1-461d-9c6f-bd73b75edae0	0	20	t	fdee934d-7eb9-4516-821f-31cbaef512fc	\N
d34c6fa5-27d6-43c1-a837-d79a7cadecd3	\N	idp-create-user-if-unique	master	fdee934d-7eb9-4516-821f-31cbaef512fc	2	10	f	\N	2ce00369-73a9-4de8-ad50-804e3f14029a
8f9eff45-47ab-431a-bb90-c8092d3009c5	\N	\N	master	fdee934d-7eb9-4516-821f-31cbaef512fc	2	20	t	8948265e-83d1-4952-8929-af29ed2094d4	\N
1ed5a429-5a7f-4e54-8075-5af065a69c98	\N	idp-confirm-link	master	8948265e-83d1-4952-8929-af29ed2094d4	0	10	f	\N	\N
52c9b41e-6c11-4bbf-8c5f-f02f5681cd7a	\N	\N	master	8948265e-83d1-4952-8929-af29ed2094d4	0	20	t	39a41c99-6ba7-4db2-81ef-20a29fafff48	\N
4a36693d-3dc1-423e-a8bb-bf06f5abdd89	\N	idp-email-verification	master	39a41c99-6ba7-4db2-81ef-20a29fafff48	2	10	f	\N	\N
95d21840-934f-43a8-a690-ad94525417de	\N	\N	master	39a41c99-6ba7-4db2-81ef-20a29fafff48	2	20	t	801c6dde-a116-471b-b268-c03e11c2aa28	\N
b8ad5b8e-305c-4b0c-b255-c5dc1bb5e2a0	\N	idp-username-password-form	master	801c6dde-a116-471b-b268-c03e11c2aa28	0	10	f	\N	\N
90a6ef23-9935-4bb4-95e6-b7ca11f8c3c8	\N	\N	master	801c6dde-a116-471b-b268-c03e11c2aa28	1	20	t	6791b99b-121a-4ff9-adba-3193bc3d2548	\N
849935cd-14b3-4c50-87b3-3ec50ec57fc3	\N	conditional-user-configured	master	6791b99b-121a-4ff9-adba-3193bc3d2548	0	10	f	\N	\N
f0f76c2c-3a95-4cc7-8b9e-ffac28b31af2	\N	auth-otp-form	master	6791b99b-121a-4ff9-adba-3193bc3d2548	0	20	f	\N	\N
031d88fe-44e3-4550-80e0-50c6e51b769b	\N	http-basic-authenticator	master	ceaf7d4e-454a-45f5-b521-2806a505a8a1	0	10	f	\N	\N
b71947c4-552b-49ab-8c58-7ce0a1685f8f	\N	docker-http-basic-authenticator	master	13a6a25d-9d02-406b-b294-58e90219d5d4	0	10	f	\N	\N
b4f22511-0fd9-4732-a07c-ce65ff258c6c	\N	no-cookie-redirect	master	5b66bf82-2f4f-4898-945b-14a77a23a15c	0	10	f	\N	\N
0885c014-3001-44be-9353-fa78faff358d	\N	\N	master	5b66bf82-2f4f-4898-945b-14a77a23a15c	0	20	t	51f487c9-5d88-4a42-97d2-28e564793e0c	\N
4f7d7f9f-a21a-41d0-abaf-7bf775e0cbd8	\N	basic-auth	master	51f487c9-5d88-4a42-97d2-28e564793e0c	0	10	f	\N	\N
954359f2-01bd-4e9e-bbe1-2223eb8474bd	\N	basic-auth-otp	master	51f487c9-5d88-4a42-97d2-28e564793e0c	3	20	f	\N	\N
b01823f9-5ae7-4454-9fa1-f662d3581546	\N	auth-spnego	master	51f487c9-5d88-4a42-97d2-28e564793e0c	3	30	f	\N	\N
2f6fccb8-1147-4a23-a00e-501c3064a933	\N	auth-cookie	easybackend	5645bc6c-fa10-4d3a-8a5e-90edb66812df	2	10	f	\N	\N
8d58c670-0119-469e-882d-a701ef298a98	\N	auth-spnego	easybackend	5645bc6c-fa10-4d3a-8a5e-90edb66812df	3	20	f	\N	\N
1fc98724-9262-42b2-b5cc-7dc3ba54fa1b	\N	identity-provider-redirector	easybackend	5645bc6c-fa10-4d3a-8a5e-90edb66812df	2	25	f	\N	\N
5f0e4a74-6fe4-46c1-a99e-4e283f1b7b3f	\N	\N	easybackend	5645bc6c-fa10-4d3a-8a5e-90edb66812df	2	30	t	1692989f-cfe4-4728-8211-b7fb78a24a3e	\N
b1608972-65da-407c-81d9-022a252b00e4	\N	auth-username-password-form	easybackend	1692989f-cfe4-4728-8211-b7fb78a24a3e	0	10	f	\N	\N
0703625b-9fa3-4100-b906-9778f9ff42de	\N	\N	easybackend	1692989f-cfe4-4728-8211-b7fb78a24a3e	1	20	t	e8c2ffc1-436f-4772-b682-e3a5c71ef5f9	\N
755485e7-729a-4b7f-917e-bc216f19ac09	\N	conditional-user-configured	easybackend	e8c2ffc1-436f-4772-b682-e3a5c71ef5f9	0	10	f	\N	\N
b9385512-4c28-4346-9da9-055aef74e0d9	\N	auth-otp-form	easybackend	e8c2ffc1-436f-4772-b682-e3a5c71ef5f9	0	20	f	\N	\N
af489a99-ab8b-40b0-8540-50fa542057eb	\N	direct-grant-validate-username	easybackend	44312ed3-3e5d-45a8-af11-f173acb9e155	0	10	f	\N	\N
b481b522-6f7c-40b2-a6b9-939e7698f1dd	\N	direct-grant-validate-password	easybackend	44312ed3-3e5d-45a8-af11-f173acb9e155	0	20	f	\N	\N
a94fac1c-c0ff-415c-83c3-b0660fcf84bf	\N	\N	easybackend	44312ed3-3e5d-45a8-af11-f173acb9e155	1	30	t	576cee4f-2143-41b6-ac89-3634bb9619d9	\N
38b3ffc3-06c8-45cb-8480-df531c6614cd	\N	conditional-user-configured	easybackend	576cee4f-2143-41b6-ac89-3634bb9619d9	0	10	f	\N	\N
9ed4546c-e02b-481c-9d28-80dd73c35465	\N	direct-grant-validate-otp	easybackend	576cee4f-2143-41b6-ac89-3634bb9619d9	0	20	f	\N	\N
1606a6aa-f62d-4af4-8063-e5315950e659	\N	registration-page-form	easybackend	ef83c91d-ea85-4006-b2ac-82de40f1aa80	0	10	t	2e3edfb5-333b-4ec7-8be6-439b25264bcc	\N
0aee3dde-2ddf-4544-a02b-3e795af1d640	\N	registration-user-creation	easybackend	2e3edfb5-333b-4ec7-8be6-439b25264bcc	0	20	f	\N	\N
096efa45-0e0e-4a28-ac76-8a62329ef405	\N	registration-profile-action	easybackend	2e3edfb5-333b-4ec7-8be6-439b25264bcc	0	40	f	\N	\N
d6bf594c-79bf-493c-bf91-0feca6a6ff6d	\N	registration-password-action	easybackend	2e3edfb5-333b-4ec7-8be6-439b25264bcc	0	50	f	\N	\N
da9c980d-a47a-4b7b-8b37-0a238f308209	\N	registration-recaptcha-action	easybackend	2e3edfb5-333b-4ec7-8be6-439b25264bcc	3	60	f	\N	\N
fb36522b-99d1-42ac-8bb0-37320769ae65	\N	reset-credentials-choose-user	easybackend	a0f68b61-5c4e-43a5-921a-a557b5a52364	0	10	f	\N	\N
96fa970b-e7d8-444d-acf8-750048f2003c	\N	reset-credential-email	easybackend	a0f68b61-5c4e-43a5-921a-a557b5a52364	0	20	f	\N	\N
6f027561-a29d-4e57-8b43-e178183ade29	\N	reset-password	easybackend	a0f68b61-5c4e-43a5-921a-a557b5a52364	0	30	f	\N	\N
2ecde36e-90d8-4364-952c-7be7108bbf94	\N	\N	easybackend	a0f68b61-5c4e-43a5-921a-a557b5a52364	1	40	t	7d61c3d6-2fe8-4f84-93b8-bf3041e1931a	\N
1fa463de-dde7-4860-a243-9b8779f67b1e	\N	conditional-user-configured	easybackend	7d61c3d6-2fe8-4f84-93b8-bf3041e1931a	0	10	f	\N	\N
58ad9a16-bf7a-4db3-982f-efa77fb12841	\N	reset-otp	easybackend	7d61c3d6-2fe8-4f84-93b8-bf3041e1931a	0	20	f	\N	\N
13a93050-0228-45c1-9874-f753d29f72e5	\N	client-secret	easybackend	4892e224-ef69-401b-af1d-f31c9d1f1c90	2	10	f	\N	\N
e4db55e6-a728-4a26-a9f3-c8ff98487a89	\N	client-jwt	easybackend	4892e224-ef69-401b-af1d-f31c9d1f1c90	2	20	f	\N	\N
47ed5692-b9cd-427f-bc5b-3216fcacc387	\N	client-secret-jwt	easybackend	4892e224-ef69-401b-af1d-f31c9d1f1c90	2	30	f	\N	\N
0608ddb0-196e-4a05-9bce-346ea275d0cf	\N	client-x509	easybackend	4892e224-ef69-401b-af1d-f31c9d1f1c90	2	40	f	\N	\N
56ea9e2c-e153-4e40-a44b-39189bf87151	\N	idp-review-profile	easybackend	785fe1f2-f3e9-4efc-8ec3-12df73b42a5d	0	10	f	\N	30b67b3c-03de-496c-9ed9-e935ee9093d9
8003ac05-0f90-495a-a1a6-0379bd241a79	\N	\N	easybackend	785fe1f2-f3e9-4efc-8ec3-12df73b42a5d	0	20	t	ae9d99b0-998c-4ede-91d2-6e56d2e0e639	\N
1b430653-38db-4126-a24d-eec307c51774	\N	idp-create-user-if-unique	easybackend	ae9d99b0-998c-4ede-91d2-6e56d2e0e639	2	10	f	\N	93163b6f-3e71-4c4e-8b4b-3036cb772359
5e7e3bbe-203b-4152-8ac9-8cc2beb4923d	\N	\N	easybackend	ae9d99b0-998c-4ede-91d2-6e56d2e0e639	2	20	t	24fe2af0-3f6e-4abd-aaee-3fac8f655d2b	\N
d783894c-a912-4d13-9158-7e015d833665	\N	idp-confirm-link	easybackend	24fe2af0-3f6e-4abd-aaee-3fac8f655d2b	0	10	f	\N	\N
a4bb4490-ba9d-4fd7-9f2a-cbbe3a8dc3e7	\N	\N	easybackend	24fe2af0-3f6e-4abd-aaee-3fac8f655d2b	0	20	t	2fe02ebc-2ce1-43b1-9467-78b06e7e5ff2	\N
1505f69a-36b5-4cc7-b1cd-ef6b86fc01b5	\N	idp-email-verification	easybackend	2fe02ebc-2ce1-43b1-9467-78b06e7e5ff2	2	10	f	\N	\N
964da775-c77a-4f72-8a31-0603e6d130ee	\N	\N	easybackend	2fe02ebc-2ce1-43b1-9467-78b06e7e5ff2	2	20	t	87dd8872-e4e5-4db1-85ee-23e48fc1d542	\N
dbd1e31b-876d-46ae-9c85-c77046e33543	\N	idp-username-password-form	easybackend	87dd8872-e4e5-4db1-85ee-23e48fc1d542	0	10	f	\N	\N
02146a5c-4be8-4a99-9e8f-d673d190e4ad	\N	\N	easybackend	87dd8872-e4e5-4db1-85ee-23e48fc1d542	1	20	t	db336039-61c8-447f-87f6-40734ae9f2b8	\N
565f7a47-fb58-4bc0-baa5-f00b5d5a0b29	\N	conditional-user-configured	easybackend	db336039-61c8-447f-87f6-40734ae9f2b8	0	10	f	\N	\N
b8b4ef85-048b-445c-be12-f748decb4353	\N	auth-otp-form	easybackend	db336039-61c8-447f-87f6-40734ae9f2b8	0	20	f	\N	\N
af3c7e85-d11f-42d4-b7f0-2bb946eeda7f	\N	http-basic-authenticator	easybackend	c3ae28e4-e903-4737-9e92-2593a9aee13a	0	10	f	\N	\N
86255258-3d31-44d8-8b2e-6814b57e2780	\N	docker-http-basic-authenticator	easybackend	f1bcb849-e5ee-401f-b8cc-ac3d145726d8	0	10	f	\N	\N
2d680d8d-4763-4265-9820-672c35a69821	\N	no-cookie-redirect	easybackend	12d61b02-931a-4b1a-89ac-e00d5fb32c7f	0	10	f	\N	\N
5da0194a-ea80-4cbc-a8c5-9c514ae6fb40	\N	\N	easybackend	12d61b02-931a-4b1a-89ac-e00d5fb32c7f	0	20	t	0ed1c4d8-303a-4ecb-8f97-31e3facae356	\N
b7011788-9d18-478d-ae93-a8950cbe2cd5	\N	basic-auth	easybackend	0ed1c4d8-303a-4ecb-8f97-31e3facae356	0	10	f	\N	\N
94395dbf-d3d5-4f8e-b844-004d6484701e	\N	basic-auth-otp	easybackend	0ed1c4d8-303a-4ecb-8f97-31e3facae356	3	20	f	\N	\N
8e905925-2703-442f-9969-cd18b439cee4	\N	auth-spnego	easybackend	0ed1c4d8-303a-4ecb-8f97-31e3facae356	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
8c782ee1-54ab-4b5c-a5ec-d952a6e1f3cb	browser	browser based authentication	master	basic-flow	t	t
20ac506d-4cc7-4e97-a44d-05806b46ea22	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
7ea3bb9a-b17a-41fc-ac83-86da71a1930d	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
82d5a563-b26a-461d-8c76-35811de00686	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
5caf4668-436c-45a2-924f-f2243aab3c0a	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
4119c649-701e-4a9d-b7b1-1d1165a51537	registration	registration flow	master	basic-flow	t	t
9ac25b9a-4a44-4802-84ed-6cc5b0bd6834	registration form	registration form	master	form-flow	f	t
f2dc59e8-bc3e-47b0-8216-f693782da99e	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
22aa7c0f-3308-44c3-b336-092742a4aabd	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
a16b9bc2-5015-416a-8882-453ac64b58cc	clients	Base authentication for clients	master	client-flow	t	t
f0202104-b1b1-461d-9c6f-bd73b75edae0	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
fdee934d-7eb9-4516-821f-31cbaef512fc	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
8948265e-83d1-4952-8929-af29ed2094d4	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
39a41c99-6ba7-4db2-81ef-20a29fafff48	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
801c6dde-a116-471b-b268-c03e11c2aa28	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
6791b99b-121a-4ff9-adba-3193bc3d2548	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
ceaf7d4e-454a-45f5-b521-2806a505a8a1	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
13a6a25d-9d02-406b-b294-58e90219d5d4	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
5b66bf82-2f4f-4898-945b-14a77a23a15c	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
51f487c9-5d88-4a42-97d2-28e564793e0c	Authentication Options	Authentication options.	master	basic-flow	f	t
5645bc6c-fa10-4d3a-8a5e-90edb66812df	browser	browser based authentication	easybackend	basic-flow	t	t
1692989f-cfe4-4728-8211-b7fb78a24a3e	forms	Username, password, otp and other auth forms.	easybackend	basic-flow	f	t
e8c2ffc1-436f-4772-b682-e3a5c71ef5f9	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	easybackend	basic-flow	f	t
44312ed3-3e5d-45a8-af11-f173acb9e155	direct grant	OpenID Connect Resource Owner Grant	easybackend	basic-flow	t	t
576cee4f-2143-41b6-ac89-3634bb9619d9	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	easybackend	basic-flow	f	t
ef83c91d-ea85-4006-b2ac-82de40f1aa80	registration	registration flow	easybackend	basic-flow	t	t
2e3edfb5-333b-4ec7-8be6-439b25264bcc	registration form	registration form	easybackend	form-flow	f	t
a0f68b61-5c4e-43a5-921a-a557b5a52364	reset credentials	Reset credentials for a user if they forgot their password or something	easybackend	basic-flow	t	t
7d61c3d6-2fe8-4f84-93b8-bf3041e1931a	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	easybackend	basic-flow	f	t
4892e224-ef69-401b-af1d-f31c9d1f1c90	clients	Base authentication for clients	easybackend	client-flow	t	t
785fe1f2-f3e9-4efc-8ec3-12df73b42a5d	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	easybackend	basic-flow	t	t
ae9d99b0-998c-4ede-91d2-6e56d2e0e639	User creation or linking	Flow for the existing/non-existing user alternatives	easybackend	basic-flow	f	t
24fe2af0-3f6e-4abd-aaee-3fac8f655d2b	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	easybackend	basic-flow	f	t
2fe02ebc-2ce1-43b1-9467-78b06e7e5ff2	Account verification options	Method with which to verity the existing account	easybackend	basic-flow	f	t
87dd8872-e4e5-4db1-85ee-23e48fc1d542	Verify Existing Account by Re-authentication	Reauthentication of existing account	easybackend	basic-flow	f	t
db336039-61c8-447f-87f6-40734ae9f2b8	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	easybackend	basic-flow	f	t
c3ae28e4-e903-4737-9e92-2593a9aee13a	saml ecp	SAML ECP Profile Authentication Flow	easybackend	basic-flow	t	t
f1bcb849-e5ee-401f-b8cc-ac3d145726d8	docker auth	Used by Docker clients to authenticate against the IDP	easybackend	basic-flow	t	t
12d61b02-931a-4b1a-89ac-e00d5fb32c7f	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	easybackend	basic-flow	t	t
0ed1c4d8-303a-4ecb-8f97-31e3facae356	Authentication Options	Authentication options.	easybackend	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
38ebb1b9-11ed-4c7b-abe6-ba7a88bffc34	review profile config	master
2ce00369-73a9-4de8-ad50-804e3f14029a	create unique user config	master
30b67b3c-03de-496c-9ed9-e935ee9093d9	review profile config	easybackend
93163b6f-3e71-4c4e-8b4b-3036cb772359	create unique user config	easybackend
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
38ebb1b9-11ed-4c7b-abe6-ba7a88bffc34	missing	update.profile.on.first.login
2ce00369-73a9-4de8-ad50-804e3f14029a	false	require.password.update.after.registration
30b67b3c-03de-496c-9ed9-e935ee9093d9	missing	update.profile.on.first.login
93163b6f-3e71-4c4e-8b4b-3036cb772359	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
c950d556-3e66-49b3-9c82-2d4063f0325a	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
c9650e94-0f17-45a9-89d7-aa1598d01650	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
b210e7d3-a550-4903-b4e0-29a0a2fc26d8	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
aa54d45a-4415-4228-9cf8-8970ae90dc8d	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
8b33fe4c-8c10-4ea3-9e3a-22e68d3ee954	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
19662c9f-1cf9-4ae3-8270-90befc12d8fb	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
7749e2fc-153f-452f-b3f4-809118805993	t	f	easybackend-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	easybackend Realm	f	client-secret	\N	\N	\N	t	f	f	f
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	f	realm-management	0	f	\N	\N	t	\N	f	easybackend	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
544e5eb0-3d17-4823-a9af-f15e289f63bc	t	f	account	0	t	\N	/realms/easybackend/account/	f	\N	f	easybackend	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4f8b866a-cccf-4fe0-b2fb-72261ea37634	t	f	account-console	0	t	\N	/realms/easybackend/account/	f	\N	f	easybackend	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
2ef67323-2a80-4467-91f7-a5dfc6491cae	t	f	broker	0	f	\N	\N	t	\N	f	easybackend	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
0c1072d0-fbe2-4759-9c08-a399a7faa47b	t	f	security-admin-console	0	t	\N	/admin/easybackend/console/	f	\N	f	easybackend	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
07a3c06c-18cf-4d21-bda1-995c98922c2b	t	f	admin-cli	0	t	\N	\N	f	\N	f	easybackend	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
465801a7-31ff-4a32-8201-2761bb5ab7ea	t	t	easy-client	0	t	\N	\N	f	\N	f	easybackend	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
b210e7d3-a550-4903-b4e0-29a0a2fc26d8	S256	pkce.code.challenge.method
8b33fe4c-8c10-4ea3-9e3a-22e68d3ee954	S256	pkce.code.challenge.method
4f8b866a-cccf-4fe0-b2fb-72261ea37634	S256	pkce.code.challenge.method
0c1072d0-fbe2-4759-9c08-a399a7faa47b	S256	pkce.code.challenge.method
465801a7-31ff-4a32-8201-2761bb5ab7ea	true	backchannel.logout.session.required
465801a7-31ff-4a32-8201-2761bb5ab7ea	false	backchannel.logout.revoke.offline.tokens
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
bebc1451-bb49-44e0-b88f-273c71bf6d93	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
fbe03fdc-9fb4-4ce1-a7ed-8706b2b1fa55	role_list	master	SAML role list	saml
64d10ade-3d36-4004-a958-b4cca90e49f5	profile	master	OpenID Connect built-in scope: profile	openid-connect
7f895973-cf6c-4f07-8a51-d48d2fcf632c	email	master	OpenID Connect built-in scope: email	openid-connect
5785129c-892b-4137-8b27-fe8299d380a5	address	master	OpenID Connect built-in scope: address	openid-connect
cc627dc7-7df6-4266-a5c6-248f2ae4abcf	phone	master	OpenID Connect built-in scope: phone	openid-connect
f4eb6714-24f0-4fd6-b55e-27c885a28897	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
a6f2d753-2f8e-4305-821f-774518562cad	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
ef61022d-f69c-41fe-8bd8-ed21b76ff2e0	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
3774e03a-fa92-4bd3-941a-bfd0b6ce9372	offline_access	easybackend	OpenID Connect built-in scope: offline_access	openid-connect
12ea9885-c85d-4ab3-bbfb-b9c706495db5	role_list	easybackend	SAML role list	saml
fb2df94f-824a-4682-baf9-9da7047671d2	profile	easybackend	OpenID Connect built-in scope: profile	openid-connect
b0df9abe-928c-45ce-847d-12a7251cee9a	email	easybackend	OpenID Connect built-in scope: email	openid-connect
d56a3de7-1416-4106-895d-ee839a2278fd	address	easybackend	OpenID Connect built-in scope: address	openid-connect
7209fb8c-3f21-442e-8c71-aa3336dc2f45	phone	easybackend	OpenID Connect built-in scope: phone	openid-connect
6cb0c8c9-4089-49a0-b39a-43268e5ae246	roles	easybackend	OpenID Connect scope for add user roles to the access token	openid-connect
240fc8d7-4ea6-4701-9d56-b9cca566061a	web-origins	easybackend	OpenID Connect scope for add allowed web origins to the access token	openid-connect
b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	microprofile-jwt	easybackend	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
bebc1451-bb49-44e0-b88f-273c71bf6d93	true	display.on.consent.screen
bebc1451-bb49-44e0-b88f-273c71bf6d93	${offlineAccessScopeConsentText}	consent.screen.text
fbe03fdc-9fb4-4ce1-a7ed-8706b2b1fa55	true	display.on.consent.screen
fbe03fdc-9fb4-4ce1-a7ed-8706b2b1fa55	${samlRoleListScopeConsentText}	consent.screen.text
64d10ade-3d36-4004-a958-b4cca90e49f5	true	display.on.consent.screen
64d10ade-3d36-4004-a958-b4cca90e49f5	${profileScopeConsentText}	consent.screen.text
64d10ade-3d36-4004-a958-b4cca90e49f5	true	include.in.token.scope
7f895973-cf6c-4f07-8a51-d48d2fcf632c	true	display.on.consent.screen
7f895973-cf6c-4f07-8a51-d48d2fcf632c	${emailScopeConsentText}	consent.screen.text
7f895973-cf6c-4f07-8a51-d48d2fcf632c	true	include.in.token.scope
5785129c-892b-4137-8b27-fe8299d380a5	true	display.on.consent.screen
5785129c-892b-4137-8b27-fe8299d380a5	${addressScopeConsentText}	consent.screen.text
5785129c-892b-4137-8b27-fe8299d380a5	true	include.in.token.scope
cc627dc7-7df6-4266-a5c6-248f2ae4abcf	true	display.on.consent.screen
cc627dc7-7df6-4266-a5c6-248f2ae4abcf	${phoneScopeConsentText}	consent.screen.text
cc627dc7-7df6-4266-a5c6-248f2ae4abcf	true	include.in.token.scope
f4eb6714-24f0-4fd6-b55e-27c885a28897	true	display.on.consent.screen
f4eb6714-24f0-4fd6-b55e-27c885a28897	${rolesScopeConsentText}	consent.screen.text
f4eb6714-24f0-4fd6-b55e-27c885a28897	false	include.in.token.scope
a6f2d753-2f8e-4305-821f-774518562cad	false	display.on.consent.screen
a6f2d753-2f8e-4305-821f-774518562cad		consent.screen.text
a6f2d753-2f8e-4305-821f-774518562cad	false	include.in.token.scope
ef61022d-f69c-41fe-8bd8-ed21b76ff2e0	false	display.on.consent.screen
ef61022d-f69c-41fe-8bd8-ed21b76ff2e0	true	include.in.token.scope
3774e03a-fa92-4bd3-941a-bfd0b6ce9372	true	display.on.consent.screen
3774e03a-fa92-4bd3-941a-bfd0b6ce9372	${offlineAccessScopeConsentText}	consent.screen.text
12ea9885-c85d-4ab3-bbfb-b9c706495db5	true	display.on.consent.screen
12ea9885-c85d-4ab3-bbfb-b9c706495db5	${samlRoleListScopeConsentText}	consent.screen.text
fb2df94f-824a-4682-baf9-9da7047671d2	true	display.on.consent.screen
fb2df94f-824a-4682-baf9-9da7047671d2	${profileScopeConsentText}	consent.screen.text
fb2df94f-824a-4682-baf9-9da7047671d2	true	include.in.token.scope
b0df9abe-928c-45ce-847d-12a7251cee9a	true	display.on.consent.screen
b0df9abe-928c-45ce-847d-12a7251cee9a	${emailScopeConsentText}	consent.screen.text
b0df9abe-928c-45ce-847d-12a7251cee9a	true	include.in.token.scope
d56a3de7-1416-4106-895d-ee839a2278fd	true	display.on.consent.screen
d56a3de7-1416-4106-895d-ee839a2278fd	${addressScopeConsentText}	consent.screen.text
d56a3de7-1416-4106-895d-ee839a2278fd	true	include.in.token.scope
7209fb8c-3f21-442e-8c71-aa3336dc2f45	true	display.on.consent.screen
7209fb8c-3f21-442e-8c71-aa3336dc2f45	${phoneScopeConsentText}	consent.screen.text
7209fb8c-3f21-442e-8c71-aa3336dc2f45	true	include.in.token.scope
6cb0c8c9-4089-49a0-b39a-43268e5ae246	true	display.on.consent.screen
6cb0c8c9-4089-49a0-b39a-43268e5ae246	${rolesScopeConsentText}	consent.screen.text
6cb0c8c9-4089-49a0-b39a-43268e5ae246	false	include.in.token.scope
240fc8d7-4ea6-4701-9d56-b9cca566061a	false	display.on.consent.screen
240fc8d7-4ea6-4701-9d56-b9cca566061a		consent.screen.text
240fc8d7-4ea6-4701-9d56-b9cca566061a	false	include.in.token.scope
b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	false	display.on.consent.screen
b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
c9650e94-0f17-45a9-89d7-aa1598d01650	64d10ade-3d36-4004-a958-b4cca90e49f5	t
c9650e94-0f17-45a9-89d7-aa1598d01650	a6f2d753-2f8e-4305-821f-774518562cad	t
c9650e94-0f17-45a9-89d7-aa1598d01650	7f895973-cf6c-4f07-8a51-d48d2fcf632c	t
c9650e94-0f17-45a9-89d7-aa1598d01650	f4eb6714-24f0-4fd6-b55e-27c885a28897	t
c9650e94-0f17-45a9-89d7-aa1598d01650	ef61022d-f69c-41fe-8bd8-ed21b76ff2e0	f
c9650e94-0f17-45a9-89d7-aa1598d01650	5785129c-892b-4137-8b27-fe8299d380a5	f
c9650e94-0f17-45a9-89d7-aa1598d01650	bebc1451-bb49-44e0-b88f-273c71bf6d93	f
c9650e94-0f17-45a9-89d7-aa1598d01650	cc627dc7-7df6-4266-a5c6-248f2ae4abcf	f
b210e7d3-a550-4903-b4e0-29a0a2fc26d8	64d10ade-3d36-4004-a958-b4cca90e49f5	t
b210e7d3-a550-4903-b4e0-29a0a2fc26d8	a6f2d753-2f8e-4305-821f-774518562cad	t
b210e7d3-a550-4903-b4e0-29a0a2fc26d8	7f895973-cf6c-4f07-8a51-d48d2fcf632c	t
b210e7d3-a550-4903-b4e0-29a0a2fc26d8	f4eb6714-24f0-4fd6-b55e-27c885a28897	t
b210e7d3-a550-4903-b4e0-29a0a2fc26d8	ef61022d-f69c-41fe-8bd8-ed21b76ff2e0	f
b210e7d3-a550-4903-b4e0-29a0a2fc26d8	5785129c-892b-4137-8b27-fe8299d380a5	f
b210e7d3-a550-4903-b4e0-29a0a2fc26d8	bebc1451-bb49-44e0-b88f-273c71bf6d93	f
b210e7d3-a550-4903-b4e0-29a0a2fc26d8	cc627dc7-7df6-4266-a5c6-248f2ae4abcf	f
19662c9f-1cf9-4ae3-8270-90befc12d8fb	64d10ade-3d36-4004-a958-b4cca90e49f5	t
19662c9f-1cf9-4ae3-8270-90befc12d8fb	a6f2d753-2f8e-4305-821f-774518562cad	t
19662c9f-1cf9-4ae3-8270-90befc12d8fb	7f895973-cf6c-4f07-8a51-d48d2fcf632c	t
19662c9f-1cf9-4ae3-8270-90befc12d8fb	f4eb6714-24f0-4fd6-b55e-27c885a28897	t
19662c9f-1cf9-4ae3-8270-90befc12d8fb	ef61022d-f69c-41fe-8bd8-ed21b76ff2e0	f
19662c9f-1cf9-4ae3-8270-90befc12d8fb	5785129c-892b-4137-8b27-fe8299d380a5	f
19662c9f-1cf9-4ae3-8270-90befc12d8fb	bebc1451-bb49-44e0-b88f-273c71bf6d93	f
19662c9f-1cf9-4ae3-8270-90befc12d8fb	cc627dc7-7df6-4266-a5c6-248f2ae4abcf	f
aa54d45a-4415-4228-9cf8-8970ae90dc8d	64d10ade-3d36-4004-a958-b4cca90e49f5	t
aa54d45a-4415-4228-9cf8-8970ae90dc8d	a6f2d753-2f8e-4305-821f-774518562cad	t
aa54d45a-4415-4228-9cf8-8970ae90dc8d	7f895973-cf6c-4f07-8a51-d48d2fcf632c	t
aa54d45a-4415-4228-9cf8-8970ae90dc8d	f4eb6714-24f0-4fd6-b55e-27c885a28897	t
aa54d45a-4415-4228-9cf8-8970ae90dc8d	ef61022d-f69c-41fe-8bd8-ed21b76ff2e0	f
aa54d45a-4415-4228-9cf8-8970ae90dc8d	5785129c-892b-4137-8b27-fe8299d380a5	f
aa54d45a-4415-4228-9cf8-8970ae90dc8d	bebc1451-bb49-44e0-b88f-273c71bf6d93	f
aa54d45a-4415-4228-9cf8-8970ae90dc8d	cc627dc7-7df6-4266-a5c6-248f2ae4abcf	f
c950d556-3e66-49b3-9c82-2d4063f0325a	64d10ade-3d36-4004-a958-b4cca90e49f5	t
c950d556-3e66-49b3-9c82-2d4063f0325a	a6f2d753-2f8e-4305-821f-774518562cad	t
c950d556-3e66-49b3-9c82-2d4063f0325a	7f895973-cf6c-4f07-8a51-d48d2fcf632c	t
c950d556-3e66-49b3-9c82-2d4063f0325a	f4eb6714-24f0-4fd6-b55e-27c885a28897	t
c950d556-3e66-49b3-9c82-2d4063f0325a	ef61022d-f69c-41fe-8bd8-ed21b76ff2e0	f
c950d556-3e66-49b3-9c82-2d4063f0325a	5785129c-892b-4137-8b27-fe8299d380a5	f
c950d556-3e66-49b3-9c82-2d4063f0325a	bebc1451-bb49-44e0-b88f-273c71bf6d93	f
c950d556-3e66-49b3-9c82-2d4063f0325a	cc627dc7-7df6-4266-a5c6-248f2ae4abcf	f
8b33fe4c-8c10-4ea3-9e3a-22e68d3ee954	64d10ade-3d36-4004-a958-b4cca90e49f5	t
8b33fe4c-8c10-4ea3-9e3a-22e68d3ee954	a6f2d753-2f8e-4305-821f-774518562cad	t
8b33fe4c-8c10-4ea3-9e3a-22e68d3ee954	7f895973-cf6c-4f07-8a51-d48d2fcf632c	t
8b33fe4c-8c10-4ea3-9e3a-22e68d3ee954	f4eb6714-24f0-4fd6-b55e-27c885a28897	t
8b33fe4c-8c10-4ea3-9e3a-22e68d3ee954	ef61022d-f69c-41fe-8bd8-ed21b76ff2e0	f
8b33fe4c-8c10-4ea3-9e3a-22e68d3ee954	5785129c-892b-4137-8b27-fe8299d380a5	f
8b33fe4c-8c10-4ea3-9e3a-22e68d3ee954	bebc1451-bb49-44e0-b88f-273c71bf6d93	f
8b33fe4c-8c10-4ea3-9e3a-22e68d3ee954	cc627dc7-7df6-4266-a5c6-248f2ae4abcf	f
544e5eb0-3d17-4823-a9af-f15e289f63bc	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
544e5eb0-3d17-4823-a9af-f15e289f63bc	b0df9abe-928c-45ce-847d-12a7251cee9a	t
544e5eb0-3d17-4823-a9af-f15e289f63bc	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
544e5eb0-3d17-4823-a9af-f15e289f63bc	fb2df94f-824a-4682-baf9-9da7047671d2	t
544e5eb0-3d17-4823-a9af-f15e289f63bc	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
544e5eb0-3d17-4823-a9af-f15e289f63bc	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
544e5eb0-3d17-4823-a9af-f15e289f63bc	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
544e5eb0-3d17-4823-a9af-f15e289f63bc	d56a3de7-1416-4106-895d-ee839a2278fd	f
4f8b866a-cccf-4fe0-b2fb-72261ea37634	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
4f8b866a-cccf-4fe0-b2fb-72261ea37634	b0df9abe-928c-45ce-847d-12a7251cee9a	t
4f8b866a-cccf-4fe0-b2fb-72261ea37634	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
4f8b866a-cccf-4fe0-b2fb-72261ea37634	fb2df94f-824a-4682-baf9-9da7047671d2	t
4f8b866a-cccf-4fe0-b2fb-72261ea37634	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
4f8b866a-cccf-4fe0-b2fb-72261ea37634	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
4f8b866a-cccf-4fe0-b2fb-72261ea37634	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
4f8b866a-cccf-4fe0-b2fb-72261ea37634	d56a3de7-1416-4106-895d-ee839a2278fd	f
07a3c06c-18cf-4d21-bda1-995c98922c2b	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
07a3c06c-18cf-4d21-bda1-995c98922c2b	b0df9abe-928c-45ce-847d-12a7251cee9a	t
07a3c06c-18cf-4d21-bda1-995c98922c2b	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
07a3c06c-18cf-4d21-bda1-995c98922c2b	fb2df94f-824a-4682-baf9-9da7047671d2	t
07a3c06c-18cf-4d21-bda1-995c98922c2b	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
07a3c06c-18cf-4d21-bda1-995c98922c2b	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
07a3c06c-18cf-4d21-bda1-995c98922c2b	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
07a3c06c-18cf-4d21-bda1-995c98922c2b	d56a3de7-1416-4106-895d-ee839a2278fd	f
2ef67323-2a80-4467-91f7-a5dfc6491cae	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
2ef67323-2a80-4467-91f7-a5dfc6491cae	b0df9abe-928c-45ce-847d-12a7251cee9a	t
2ef67323-2a80-4467-91f7-a5dfc6491cae	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
2ef67323-2a80-4467-91f7-a5dfc6491cae	fb2df94f-824a-4682-baf9-9da7047671d2	t
2ef67323-2a80-4467-91f7-a5dfc6491cae	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
2ef67323-2a80-4467-91f7-a5dfc6491cae	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
2ef67323-2a80-4467-91f7-a5dfc6491cae	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
2ef67323-2a80-4467-91f7-a5dfc6491cae	d56a3de7-1416-4106-895d-ee839a2278fd	f
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	b0df9abe-928c-45ce-847d-12a7251cee9a	t
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	fb2df94f-824a-4682-baf9-9da7047671d2	t
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
5fe57fb2-edfc-4d5d-aceb-648e30e2033c	d56a3de7-1416-4106-895d-ee839a2278fd	f
0c1072d0-fbe2-4759-9c08-a399a7faa47b	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
0c1072d0-fbe2-4759-9c08-a399a7faa47b	b0df9abe-928c-45ce-847d-12a7251cee9a	t
0c1072d0-fbe2-4759-9c08-a399a7faa47b	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
0c1072d0-fbe2-4759-9c08-a399a7faa47b	fb2df94f-824a-4682-baf9-9da7047671d2	t
0c1072d0-fbe2-4759-9c08-a399a7faa47b	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
0c1072d0-fbe2-4759-9c08-a399a7faa47b	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
0c1072d0-fbe2-4759-9c08-a399a7faa47b	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
0c1072d0-fbe2-4759-9c08-a399a7faa47b	d56a3de7-1416-4106-895d-ee839a2278fd	f
465801a7-31ff-4a32-8201-2761bb5ab7ea	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
465801a7-31ff-4a32-8201-2761bb5ab7ea	b0df9abe-928c-45ce-847d-12a7251cee9a	t
465801a7-31ff-4a32-8201-2761bb5ab7ea	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
465801a7-31ff-4a32-8201-2761bb5ab7ea	fb2df94f-824a-4682-baf9-9da7047671d2	t
465801a7-31ff-4a32-8201-2761bb5ab7ea	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
465801a7-31ff-4a32-8201-2761bb5ab7ea	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
465801a7-31ff-4a32-8201-2761bb5ab7ea	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
465801a7-31ff-4a32-8201-2761bb5ab7ea	d56a3de7-1416-4106-895d-ee839a2278fd	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
bebc1451-bb49-44e0-b88f-273c71bf6d93	cf6192a5-7e7e-455f-a75f-61b80be6fe1e
3774e03a-fa92-4bd3-941a-bfd0b6ce9372	678f24aa-3aba-4eb0-973f-d309185f17e6
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
c6c04900-9c54-463f-8fac-9428fd1c3df5	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
f74f8962-f54f-46f0-b320-b3591129cb2a	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
a57f676a-9daa-43de-abb6-0d0799c5f9bf	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
f001cf64-2981-44fb-9f58-aa3e35350f08	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
6515b024-af59-4cde-a972-3bf44c830e84	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
6cfc900c-a53f-4fd4-8821-bf76ea0c52a9	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
9f632f1c-5350-43f8-b135-c0c89c03254e	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
6ec49f1b-13a4-4acc-babc-09506cee5722	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
4bac438e-2fda-4f8f-8a93-a85ec943d489	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
c7293bb3-a46f-48ba-9f60-42f58dc91571	rsa-enc-generated	master	rsa-enc-generated	org.keycloak.keys.KeyProvider	master	\N
ec726067-d963-4d05-92b3-5565dc037d9e	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
47385bb7-ccdc-47b3-ba1a-69a644368654	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
8cd8c284-c649-4903-b41e-d6ebf8d8351e	rsa-generated	easybackend	rsa-generated	org.keycloak.keys.KeyProvider	easybackend	\N
03ed8280-7c45-44ca-83f6-363589c55b82	rsa-enc-generated	easybackend	rsa-enc-generated	org.keycloak.keys.KeyProvider	easybackend	\N
71ead344-21fd-4681-aba7-b18011f01638	hmac-generated	easybackend	hmac-generated	org.keycloak.keys.KeyProvider	easybackend	\N
2330b1b1-7bfc-402f-ac7c-282e7132f7eb	aes-generated	easybackend	aes-generated	org.keycloak.keys.KeyProvider	easybackend	\N
8e4cbedc-a28e-4dc7-9eef-5295a4844aa4	Trusted Hosts	easybackend	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	anonymous
5da1f15d-ab9f-4dfc-8d4b-a7789f540d3d	Consent Required	easybackend	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	anonymous
d8557e95-7de5-4ea3-afde-3d8964bb3bdc	Full Scope Disabled	easybackend	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	anonymous
36e9f968-e081-44ec-b4c8-b1b05aa09070	Max Clients Limit	easybackend	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	anonymous
84848ca9-be49-4b20-a666-aff5b11216fa	Allowed Protocol Mapper Types	easybackend	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	anonymous
b28839bf-6efa-4442-9be5-7379be25cda9	Allowed Client Scopes	easybackend	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	anonymous
02814cda-c71d-45a7-99c5-beded15d4359	Allowed Protocol Mapper Types	easybackend	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	authenticated
adc1273e-e6ff-49ca-95f8-0a8bf03dd6cf	Allowed Client Scopes	easybackend	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	easybackend	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
c6681359-fe5a-428f-b323-506bf9d49b22	c6c04900-9c54-463f-8fac-9428fd1c3df5	client-uris-must-match	true
99c7d62e-668e-4495-b6b5-c0675e0c71fc	c6c04900-9c54-463f-8fac-9428fd1c3df5	host-sending-registration-request-must-match	true
b9d5b52c-8ea2-45f1-8d36-c7d76bbf1662	6ec49f1b-13a4-4acc-babc-09506cee5722	allow-default-scopes	true
af004ab0-4776-4dec-b8d3-0e04630b0ab9	9f632f1c-5350-43f8-b135-c0c89c03254e	allowed-protocol-mapper-types	saml-user-property-mapper
07fc0bc7-ddf4-4930-92f9-70e915aa9bba	9f632f1c-5350-43f8-b135-c0c89c03254e	allowed-protocol-mapper-types	saml-user-attribute-mapper
dc758a78-60b9-41ee-b97a-974cc8614669	9f632f1c-5350-43f8-b135-c0c89c03254e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7d49a40e-676f-4e52-9f81-bab2769956db	9f632f1c-5350-43f8-b135-c0c89c03254e	allowed-protocol-mapper-types	oidc-full-name-mapper
e261326d-2841-4b5c-aa5c-e2df5d4e965a	9f632f1c-5350-43f8-b135-c0c89c03254e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
6d4db118-7945-4c87-8c2a-87631bd0edd2	9f632f1c-5350-43f8-b135-c0c89c03254e	allowed-protocol-mapper-types	oidc-address-mapper
2d98b2a0-76d0-46c8-bc41-ecb54f4b909d	9f632f1c-5350-43f8-b135-c0c89c03254e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
261c97c2-ac55-48ff-8b48-aa49413ddbff	9f632f1c-5350-43f8-b135-c0c89c03254e	allowed-protocol-mapper-types	saml-role-list-mapper
57962139-8487-4158-a558-20d6aed58182	f001cf64-2981-44fb-9f58-aa3e35350f08	max-clients	200
afde3186-a3b4-498e-97dc-561010def2e8	6515b024-af59-4cde-a972-3bf44c830e84	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2ba9c2ec-d15a-4a2c-ac2b-fa75fcbde854	6515b024-af59-4cde-a972-3bf44c830e84	allowed-protocol-mapper-types	saml-user-property-mapper
4f525153-f041-45dd-8c69-1c8d35c3b676	6515b024-af59-4cde-a972-3bf44c830e84	allowed-protocol-mapper-types	oidc-address-mapper
54a4ce4a-9b3d-400a-aff9-0348994863a0	6515b024-af59-4cde-a972-3bf44c830e84	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
6be20d08-865f-487a-88e7-a6b685c23022	6515b024-af59-4cde-a972-3bf44c830e84	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b81bcdb3-7e09-446d-a73a-495a17eb0213	6515b024-af59-4cde-a972-3bf44c830e84	allowed-protocol-mapper-types	oidc-full-name-mapper
d79e5a3c-3898-4ffa-b59f-12090bdd65ac	6515b024-af59-4cde-a972-3bf44c830e84	allowed-protocol-mapper-types	saml-role-list-mapper
654afff4-cc59-48c3-b3d0-82bad579179b	6515b024-af59-4cde-a972-3bf44c830e84	allowed-protocol-mapper-types	saml-user-attribute-mapper
3e0d7497-75f4-4f33-94ae-6c38fc36da44	6cfc900c-a53f-4fd4-8821-bf76ea0c52a9	allow-default-scopes	true
bf45b875-3f88-4387-8e63-c3270296d099	ec726067-d963-4d05-92b3-5565dc037d9e	priority	100
cb6f367d-b359-46a9-9912-9436e58493e2	ec726067-d963-4d05-92b3-5565dc037d9e	kid	19a1bbc2-243b-45ec-98b8-bca05ea24591
487b3b69-c8ed-49e9-8912-49a31721699c	ec726067-d963-4d05-92b3-5565dc037d9e	secret	-oCT9IUtz9LABobgwAjJ5zRKj8H4C4f0Cb0hiBAuQk4NfI3Ko_HMQf7GNr1UR1ad4dOOEoEyPZI3Pjud4ZKg_A
e6e809fc-250f-47ba-9a0d-b78501225987	ec726067-d963-4d05-92b3-5565dc037d9e	algorithm	HS256
163448e5-2ca8-4017-a6bd-62dc93f1d0b5	47385bb7-ccdc-47b3-ba1a-69a644368654	kid	a654f70f-5dfd-41f6-a098-ad0359b67c17
f5589701-9296-4075-8f90-01ae9aa477f6	47385bb7-ccdc-47b3-ba1a-69a644368654	secret	aBE1yhyVrnM1UYbfpGOCPQ
c6accd49-d20a-4949-9c03-a5f4b94f78de	47385bb7-ccdc-47b3-ba1a-69a644368654	priority	100
d9303fa4-fa2a-474c-b66a-9084dbd66a86	4bac438e-2fda-4f8f-8a93-a85ec943d489	keyUse	SIG
b5b94a71-d234-47bb-a97e-9cd5289dc87b	4bac438e-2fda-4f8f-8a93-a85ec943d489	privateKey	MIIEowIBAAKCAQEAiqBz9PDHz+snXHKHOY1VxOb/nRvR45nHM/6itH/l5alspgKjfHrYE4uNObQonccUnuORaJ9t7tDXrbj+PAiQAeqUqBB+SlMhed2CGLmyaRRpKOqCLsj7FblAHpXgw77LznXmFDNi+aBmWh1q9ScN8uBgfAFUgZOfzq/g4Y4gEdcMkVjU2h1DycpbZNOuKI3WDwD2TLcSnFEnlts34mEhbMQQ3Dx6HCzCRW/sZJ2HO4vcBaFi/VlzLEG43+Chl9KbMBb9+9kxFexBzZjiM2YB/VjyK6Tcv2B76JrVvB9pNwPpT6QOPPhW2+ZvsIi50r/Kscy9oM/2LOy3EMZraJAFKwIDAQABAoIBAAbiDJ/ezK0AKgYnEZvD7rxGE+8DEJrSadelDwMTTqDmlqRvgRqPJudhiHOTBGlBFz8EYZXmRJkU+YCArO7iJfRSZ2so1nxuQD1CyFDd94PMJaSIcEpOZFkhx5M9MdnGQWxQ4kmie4mVcz+KMmNVuxWSGnhNwJpmcArdJLdOTT1VczLbvzJ8P6KqSE9Wa4FS6TlbsU6tMcDCsN7evKNyD8GvHdFqL7DTDvVqLfTG5lcaTYsIiUNA9ItK1qh0anbwOURo9zzzfPUJW3TQB+VgtMpGLe613DvoTbYps0Npxijrf9KHpGhurJUTE61MGhrcHrBaA4k2u4pHjp/9etmOVKECgYEA3MO/KhJpGpTe5SgeJGvcfAD2nFjZQu5/TANCZvNDPCLpDMN790v4YIubp2ZsKegjU6UdVbXRBWSbm/GOHg2PMJiAppSKDhJrnNShrsfngQK9d0vVFvllzNFCm6rZirLg+VHSZKxW4zM393W4SZ4hKVsmRHnzo0Ko8Bs3SVkArEMCgYEAoMCfpE+JMkLFx51C7LokfC1v8Zqcy0bhnwiI9oZtauTtx3ol6VKVo00r9cX0EczT8stYwj4TOQzFlfwVjI8+hcNPkF5w0Naib0344DskVQCq4i4HPbA5Lggg4vfb2jaXoQCJNcDZs4+IfYzO6XFWSYDDbvwy9ijNObL+d5MqKPkCgYAo1WQUihc6vXKE/Gim3/SGUz9KJ/z3rlmJW8j6deBnzSVCIR5a3YhxgyElU4KKNc/i9tV4NwsUbkmCDKn20Rc9K9gP98WZWLri5UmKpJsjd7hHypT9jN/RhJtHY9CdIP0P4JyD1oSzvZOKiBGwPDlyBtQLMmtoNTo+Pyp4vKetNQKBgD8LDBC+eInTkgk07Zg1cDWbBDn2buNxyu45xK0aDzNK0M3YY6Hbl3/RthnPJmcMs1qW0RpsidFn5t1pXXIgg16mOD/gKdJdOpr4M1CNITSM7HeDoadZwzMAURVyKzCrFFA6C5WfKkG3WsoSPNtkbXiqHPsbwUi0u7eTMSTn/DLRAoGBAJkHxPszmObsaM0JOvwmV/2xGIxCnRd7qKBvEQ6Xxdyauc4kBUCFrFliLemZwsT8lPj+a5RWFnW/P8pZxUAGW2r0sVvtI22ZpT4Lll7gake7fggJrOOrmFBaoTU69DOwOuGq+rgSnvvnssi5Kk+IKE9+G3idYH2htRr2eOKpDJOE
0da8d387-9377-4b1a-9082-8094173e0ee9	4bac438e-2fda-4f8f-8a93-a85ec943d489	certificate	MIICmzCCAYMCBgGDRnZB7DANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwOTE2MTMxOTU4WhcNMzIwOTE2MTMyMTM4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCKoHP08MfP6ydccoc5jVXE5v+dG9Hjmccz/qK0f+XlqWymAqN8etgTi405tCidxxSe45Fon23u0NetuP48CJAB6pSoEH5KUyF53YIYubJpFGko6oIuyPsVuUAeleDDvsvOdeYUM2L5oGZaHWr1Jw3y4GB8AVSBk5/Or+DhjiAR1wyRWNTaHUPJyltk064ojdYPAPZMtxKcUSeW2zfiYSFsxBDcPHocLMJFb+xknYc7i9wFoWL9WXMsQbjf4KGX0pswFv372TEV7EHNmOIzZgH9WPIrpNy/YHvomtW8H2k3A+lPpA48+Fbb5m+wiLnSv8qxzL2gz/Ys7LcQxmtokAUrAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFWBVJH6HRzePL6Lb9BXHuwmupl0oO9H58iJved1+4ANCbEcm13k45EpL76BDgSmVT9U1OwTDAL1uagWhVYyc/IbCqfaP2JRRCK9EzTStL7MN6zzgwkP6AT2ZQUd1fwJDCfE8JseHNXGC4SxLoJnUBvEQxkSuHs80HiB6Rv5IQLJ4XOO6eOQmRewyaAexGeMwvxUaSBJp3djupVFqu9DCqcgvHBOmC+u1brYdlToPOndUgg2i4eqAuVhI3oHtiNTYcIGZz+nv4EebJd+sKM41qV3rZSKamGPUTD+tupFfmP5hhXWtZoje3RLGxiLgTlaJF0KxASwcQF7WjL5uhThbec=
73634289-c405-4f9d-9b72-593f99716166	4bac438e-2fda-4f8f-8a93-a85ec943d489	priority	100
9f5ccdb8-e8b0-4c5a-a9da-1e1f33006290	c7293bb3-a46f-48ba-9f60-42f58dc91571	keyUse	ENC
c5e79f42-fea3-48e3-84a2-99e73c24a410	c7293bb3-a46f-48ba-9f60-42f58dc91571	privateKey	MIIEpAIBAAKCAQEA5mO5eaSuhqC9uU+vYppW838zIKHuNKTkapvptATwITBcP2UTdILnNuZrOZf0czKo78XO2XyOtMoms6TjIAQprQwAD22tLzPY8vyyRbv1RSy6wY71CNfTJBcN6u3RKfDycu38J95/2kztLKlEgLw3eIjAvh0tNRYil4MA+meVm6P2zVu2ZjmV1MJAO9IMBBMCr8b/aoGBwTazC0UWYGR9J1JlL/al962JFcEUJLoJfnk5KWI0NZywmiBfznBVKQQqXyAAYb1PzXC741OQzqp5v9UjP/fJ3jd4XTNJAMJiHAfbqdkr6rX1zT/vopJkjhKXICb636GXHfVb8WxtXGqJsQIDAQABAoIBAQCz3pvJyravSQOWkA3fr5u/E0n5ajMtSqdCTGOTNl+7qaP7opAj4Kdfh1mjZ21kGuMl/4tU5RgNMd4xVsQ0FMvs3HeXlAsn1RTF8F/Gbc45qYhM4a2Qr9+aR52IEw+/7Ot8qyy4e8/ZwUFSIvzmfQvZwPqp8uF+lr9/BrpWxVRaY5b5K/WTqWMCFrh9x1CSlWiqt1DXPtizffiOUAHbRaYSwrSVhs4/IwD62He7jeywbPAYxaQndWTtreFmQLInveUDI4IA1tNZyp849ylO1Hp9LDWkQ8rqlh+ClD5qzYNi3TeVpi5NjwQUtS+XrVtLCvcQ7ueNbj4bvkUApNAdr/WZAoGBAP8nX12vInwBeDrox9JHDTo34JuYI5gTh8sU1OZQKy8gN7DJmIVvffacQ5niDQzMxZIqsRm+UV+B48le2IRBRaiNmy/OZSjeyk5rOOQuNwNS2nuWR6nlv2J4wwFZwD2Ht9uTHHYEYqlkVKSEE02X6gw551evE3rukVwLmC4W+iuTAoGBAOcnU7NoReia8/2jA5bhd4W5MYMUZvql5Qq0TS8EKxawX3GQd/xCF9DYxCRA04LueVdLHSaHTA4qNF3lz6GNNruxEx0QixhPNuDjSyAIj6y7xygbE3wmX9bEVBigO/XYr1TXPHSjPobHrPsFiP3Nh7SJngH4jxfSgc5AD1e0eOgrAoGBALpBI3xfu+yJphpakoMNGrrEz1DFXjZFC3tTWZZGLz/XZM/IWW4OVQUQTMioGp6dXBu2zlDcfMobJwx4D9V7UD4aII5lO7L57vQPkRgAJGhostREf0umSm63eKIjwhEoYS4H1V7RFLRSaPcu8mhR3KfQHPAE/VNfkvx9+jiqzTPBAoGAC5U46ICNID7Dgy4r+9+Icbb5+CuJjX3KoGKwi26WCikEX1hx6r4VG24BRh/JeYIhqnIlH80fzoXm4d2mLd45o+YXoxk1Hx65DUPWe+Bx8qHmNOhGba4ul0B3RlShLIyTHJk8ekvD0lUnId0BJFasOiu7MzYVVYhC4Obs3eQ5OskCgYB6X3LJy7ji5dH72oYPlqZ4gcHzZvSwk05uuzxvkGDpMnY9m7ZV3/PgAxccQTu4Hkt1drqjSCJZF6zn7DQSkuKSNTDFLfoBTafTp+GfdiMFzohlppYHMj9epfh4wcNQDUikq29c05Jq+YsrqFMiZixHWQIS01FZeBQEEmspQmlMvw==
96fc1bba-45bf-4ea7-a6e7-45e140e8cb6b	c7293bb3-a46f-48ba-9f60-42f58dc91571	certificate	MIICmzCCAYMCBgGDRnZC1TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwOTE2MTMxOTU5WhcNMzIwOTE2MTMyMTM5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDmY7l5pK6GoL25T69imlbzfzMgoe40pORqm+m0BPAhMFw/ZRN0guc25ms5l/RzMqjvxc7ZfI60yiazpOMgBCmtDAAPba0vM9jy/LJFu/VFLLrBjvUI19MkFw3q7dEp8PJy7fwn3n/aTO0sqUSAvDd4iMC+HS01FiKXgwD6Z5Wbo/bNW7ZmOZXUwkA70gwEEwKvxv9qgYHBNrMLRRZgZH0nUmUv9qX3rYkVwRQkugl+eTkpYjQ1nLCaIF/OcFUpBCpfIABhvU/NcLvjU5DOqnm/1SM/98neN3hdM0kAwmIcB9up2SvqtfXNP++ikmSOEpcgJvrfoZcd9VvxbG1caomxAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAKt+CmQFu/EyicvD8GNtUgsUCy09QjHb+zUDlWW5ylI5N45mrZc4o4+6BtunSnQxZhGvoPO/5M8HwNRZ8n4qXW3t6g3kgVkrRfm/Ljp+YK/4vfrMuzkPiqQpQ8NnPEO6yDSmptNoXdHQ+728MpCxzsVELADCc7QJVqSqZ0kabofdevu7xSvyZw8NIK6qbAavlw6qo4reloWy57QU3Ko6Et+QJOB6dp+cgOWMGWmCBYo7nq5pa1kU6A/LCQoIOgMXPhwk3h3ail489vZieCUHpaznxgxCOf8Kc9PZFkmWE/AbE4YpAm6g8Z2KKXSNF8IDfrSMvmhQTnY2cNNh5pkqdvA=
3655345d-f425-4305-a721-defa987cb1a8	c7293bb3-a46f-48ba-9f60-42f58dc91571	priority	100
3c6607e9-0783-4c56-b41a-caa89a8f9b23	c7293bb3-a46f-48ba-9f60-42f58dc91571	algorithm	RSA-OAEP
d27f2279-a6e1-4f4d-a8eb-580b3fa15acd	03ed8280-7c45-44ca-83f6-363589c55b82	certificate	MIICpTCCAY0CBgGDRnijIzANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtlYXN5YmFja2VuZDAeFw0yMjA5MTYxMzIyMzRaFw0zMjA5MTYxMzI0MTRaMBYxFDASBgNVBAMMC2Vhc3liYWNrZW5kMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvkfxji19D3LnNOWMr/Nk8xH4smxK3sUgVEtBgts0qVe1t+wGugY9z8xUbMJY59e3oLVySQ2RlIxrT02Xg+Ky3Df1RhRzmsBGICoHp+g3Nmrzpfn5B4VocKoEqYmcQGTNT93I3rJYfcP3LkwIVM9r86KMMngk1Yh9gHOirCnwm58Jks/sdOs68Ch+9F24Cg6nMtj3z8wlTu4C1CEJIwns3CZoJS95r04aeIh6I/Vrviz5Dro5pT3PQbrfvR/ggt4gPl9tOgFo/DEMy0POLKt3EYl5IUB/4ngVc+h3IA9jw7lVHr2HKByw+6yScdvmNLqRJCw8v1DNQcRFQCoq26EGUwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAK8DP2H1IXg34aeMih2NZocRj0fnCJA91pIWUM8anC6HahkX7sk4grBAlbR9QblBV/hlNJEa4H14IWAoRdMsMrWF1MMlnHLqiUT8b42nwy2Fz5/Zj6YXwYhOKlqvqCIDOdRHI7pMWRy+/dBO0s61mmnFjJabzOR2frRxEOlMLXl5B80Wz+lZnVEOFjavrVUYZGvuRMs2cSFSH7eisyLp0kjHeZ/iKWJf3KXuoS2eUiZZ0lOSo2NjbwCXJsh8oceowrbSdk8TZEWYn/UEqWQ1GhYIb5Qf02L1GfDiBAPnltEWsEN2WekpenLItbSHx2+M7PmVoUzIutKgDXVJIil7ze
3f7b782e-9432-45d7-bacf-bc3a67ee1826	03ed8280-7c45-44ca-83f6-363589c55b82	privateKey	MIIEpQIBAAKCAQEAvkfxji19D3LnNOWMr/Nk8xH4smxK3sUgVEtBgts0qVe1t+wGugY9z8xUbMJY59e3oLVySQ2RlIxrT02Xg+Ky3Df1RhRzmsBGICoHp+g3Nmrzpfn5B4VocKoEqYmcQGTNT93I3rJYfcP3LkwIVM9r86KMMngk1Yh9gHOirCnwm58Jks/sdOs68Ch+9F24Cg6nMtj3z8wlTu4C1CEJIwns3CZoJS95r04aeIh6I/Vrviz5Dro5pT3PQbrfvR/ggt4gPl9tOgFo/DEMy0POLKt3EYl5IUB/4ngVc+h3IA9jw7lVHr2HKByw+6yScdvmNLqRJCw8v1DNQcRFQCoq26EGUwIDAQABAoIBAEoK+MYYkVeXoLyGro4xKhEj5yCW3zN8ha4HcsCWyBE1XjLpl1x/3UGlAx0nKy1cVcolkQk4THP/iCpdyR2681qaM8lHYAzR0PfnIv+Fbyavy4vEj9ELaq6cmh/WuoScNQBlDysJP0IBJYhQcdV+uUUe9WsWMU8eQ6feV2ijEUuclMSaWY/4qS1udGN4KJSGkMs2NZRAp3m4oXXIxrMutS01Ztomhz+pf6RuqYkxNfzkhKBSPXAmBrgLndY6Kjtdr6Y5wq2N4YVdTCsedgIcOBm3rMuje8d10Bf1s6+9BFGbXk0JszTkrRO7lnVtG6SLDdW0KmqjvPKrxjyNNwH2J3ECgYEA8bexEcIzWkejHh/YzSxgXyqP3aRJel+icB+27/wB5i2TjOZHImK2czEmcjfj6kh3XQjyKIdWj4HEMz1Gb1y2gIFNZ/5rAO2RQdnwiUpPS9qd4yTNJtPeQRhN3kEjwScyUaMq+LgPhd4aFoZSrcy+loQydvfIeLFeXLHrn8TVCQ8CgYEAyYY0S3JPObfiLN88GSLfzDh64ohIgf6IUFOU1kbhEsoDTmk8XmJoj2NY0OSXoJkUas5HxzXCj1Vz1Ym/TByoxKko+rME5hEqbZnngVmYHb5caaSr+HAO3KwDhbkb0a92iAvN+z+RJ2rSPwlvT3peIYa4D1AYASP+8ffqEHfGxn0CgYEA2FtolhGy73sxyVQONdAjzusE7QoRbwTNG/l3QKXceVCQQs0YHPIoh0EWPaRDUEBe/xpzzs0dMMShfo+5TRK6lJmoVI5I7wK2QzA1el3WTno3WsplCv0XckKz6F18CHbyNlqLqybtVhCwXzsKJGEgsw9PMGenvEhewy/KTS7c1QcCgYEApyCsl/FZ8OUmJs6P2czJS2V/zAT4FQ7RX8ShR7+Kg3mTmmC+FwyH6HqcuskJUsABZb5jWruj+hkFMo/FXUrbUBV2DcuPgXm09SZRDz4NYIVxwI83q5bLTIk/dpQYlSJuK8+WaQrDx6vYZzzc2k4CaM2AMfrbnX6LvYI71KJw8EUCgYEAmK9pjtzeFOkDifohbo/IDP0ewbWxUPBwvwE7cmDGojQ4UN+9amhy2xFOZ+ulTC76zGwMQYsTTu9LdYe0JfX8fwBno1/xO9/KJlhaVdSUAj5bezn94pXagtpcIcfdxsCysQ3lut/A3ueO5PL0WbIVz9H7YoEhGNdZqSA4Nkd4DlI=
07250166-b74f-4da7-a658-b7880a850403	03ed8280-7c45-44ca-83f6-363589c55b82	keyUse	ENC
b364770d-2fc1-4592-8c02-3d8348e39343	03ed8280-7c45-44ca-83f6-363589c55b82	priority	100
0872ab2e-7d6d-4269-858b-23ee6c7969c5	03ed8280-7c45-44ca-83f6-363589c55b82	algorithm	RSA-OAEP
3fd406c8-72e1-4b22-b9e5-70526469fb4d	8cd8c284-c649-4903-b41e-d6ebf8d8351e	privateKey	MIIEpAIBAAKCAQEAgLuUIvmAwHPRdn/o1pkMHBj0tRWcnwYle6kA4SNgR5ryKY3AR9IdhwzW4yDkKO9Ku7PQSflVUcWCHPiDk/vXwum7Nn4oOER10N6LJcHHwUbPRhrax1R5/LOH756khjuO4HPTPX41quo9FhwD5WMZS9OrzH8xmHNbZFA5JxDZwTreeqQJHSKBPzZ6mFlKkSXcHfbnfo8x+JVAZxJZnNTFWk6kiB+zIB2mHZRxX+QaUjWkwVM2IEYnxGrXv9AI/a+Yz6D2SjArLY/VQgSQP47R84mASmFG4kmhmESFOhjeifIgb11duNbGO0WksCXJ6LMrSOmwwfoAj8axAqMoJbQb3QIDAQABAoIBAFFbOtGnsTDvgS9Mww/shXS0aOKQl/0AW2v9cOrX+p8GU4jjZuN87OBOwvej783W/PoHN9moU71r/0Dj5fP+M2uhX4mezThSO8sW+gWQo/eIErKRgjZ7MuT7aSuMrRmQRkmfqZ6xRqWPh6+TYPr1WCVNzsNclzFrphSNhrEjuxqcfZyeA/y7kWuyUXWpNOPW24Am2nzYSkEOdTGU98coaeZ9wkM0DpZ46CUTD+dw5a9hQCVMeCcA5+d5sk5Oy2F9r1UDoSf2jPxCYKANFquOrPuHsWri3mEsgzrxgzEa2J7anl56eBnXLukudGHGDVfJgqtscICIzCD91EblkfmOj4ECgYEAxCfADhPinZab4qDVA+n+M6hn/8hwIewh8Az6v8taNTkYFrg/DeOxdN0WWZ93FaEo4PIsVFILQRahseajyqof6fK60Ug6PxRZNh49dvAh3lZw0+JZXtdT0gY7rlWkQoK9DSkK4cYiNrvo2toJXBIyPMdS3Gxuw6oLGhEZMeriARECgYEAqAHyrM5isvhZ7zQ7zs+6Un07kgin9moS+h2t3+JQdvF2MA3rVvU/JGunBD3eQfFGnvSRMluxEvTU0Zcndh0Dt8vPIDnmRDIjfhTrr217KhDltl3LJx/rlct8ysL98CoMKaFftSs3JUuVOP32dYpQEBAKF1EMbTu1jJrFxmt5Lg0CgYEAuXwtLCK5o/MLLV6Qj8bwzcBtt32+KxWzcd+ULVEJ2FJI6RMI7QVmhO+bdtxIK3fdw/i82m9KnR3dgPBr6fS9gOg6qDP4gDWptncaACJKpIhw4Kulfv13EZ87SDtLvGkMhClPVPea2s8N/gU33IyIXNjPDgirJPLi1J9eh8loNUECgYEAherflA0CsWOy1C/PiH8eJoh6RmIt+AX/UGz93pqXxuebbJx7vZnJFe/VdlUWZ3u57hRF9F0QHWsYhGQ26TghcYy8chSUzkEk92gXoYLkDNjhMec7etk/wOwtcbXSEnCBt2FRV6i10T2ZGY+dt31jahpO4N0SybMxeH0aLpoWQrUCgYAbDNeweRroQQFUlIO28gXwtHFi84cUA0gZx8mclhpr0RTBjcoB45QZN3OBn23DjRhJ05gklsNDG5LsPEqLogvw3uTF78Xil5hziudY+wrgyJSSr3bRHAko9TeCRTk6d70QPlzd7WEXvrWSxH/6eUA9kNse8YXEhzl8j+KbGwmKtA==
1baf7250-82b9-41be-abcb-f05367d1472b	8cd8c284-c649-4903-b41e-d6ebf8d8351e	certificate	MIICpTCCAY0CBgGDRniivzANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtlYXN5YmFja2VuZDAeFw0yMjA5MTYxMzIyMzRaFw0zMjA5MTYxMzI0MTRaMBYxFDASBgNVBAMMC2Vhc3liYWNrZW5kMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgLuUIvmAwHPRdn/o1pkMHBj0tRWcnwYle6kA4SNgR5ryKY3AR9IdhwzW4yDkKO9Ku7PQSflVUcWCHPiDk/vXwum7Nn4oOER10N6LJcHHwUbPRhrax1R5/LOH756khjuO4HPTPX41quo9FhwD5WMZS9OrzH8xmHNbZFA5JxDZwTreeqQJHSKBPzZ6mFlKkSXcHfbnfo8x+JVAZxJZnNTFWk6kiB+zIB2mHZRxX+QaUjWkwVM2IEYnxGrXv9AI/a+Yz6D2SjArLY/VQgSQP47R84mASmFG4kmhmESFOhjeifIgb11duNbGO0WksCXJ6LMrSOmwwfoAj8axAqMoJbQb3QIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBE62CvI2mRnH9UAsZxAwN8TZWsHwe5iGurGxBmym8sd320kao5YtbjB1b151zzjOdfQ2djoIIWLQiXpgJcXpbLLAxHRp11NKPUD4/aOYLtRoa2LwnmCGgnQjxUHy//3OzaW2NHCcrMCaHot0Ala3V5CiN5HW5rjSrQS6iXoxJVYBbjUJYaR6ZbIgFo7zLK2jNCmWsKq7mlk7GrU1+6hQu5qadoE0lIVF6u1qfyHFJ8Zi7rf0IZD+zUdURhVS6R7Yaf/N2ig4a6AtV6pdp4gkbQVi12V/w+IVUIiNXZBrPVybty1YScShKQNB9YppCKTzUs6sLcWv+k/jgR3b6rfqLn
30146dfb-d8a3-46ed-b9f9-96d3a6cea5ef	8cd8c284-c649-4903-b41e-d6ebf8d8351e	keyUse	SIG
7105a0e0-0cfc-422d-8ebb-d885387731be	8cd8c284-c649-4903-b41e-d6ebf8d8351e	priority	100
55cc1380-461c-4111-84e0-5a61ab6f9f9c	2330b1b1-7bfc-402f-ac7c-282e7132f7eb	secret	txO8VqHTwWobtBip4c1jCA
336d7711-5424-41d5-9a67-1345d08553d1	2330b1b1-7bfc-402f-ac7c-282e7132f7eb	priority	100
ea4b3a40-d5b1-4862-841f-a58f6c534c12	2330b1b1-7bfc-402f-ac7c-282e7132f7eb	kid	fb6c1454-1a40-4eb3-a822-1c4021f293f1
ea68d3ec-949d-4ebd-bcd4-cf9f209aed36	71ead344-21fd-4681-aba7-b18011f01638	kid	2de7d904-6f59-454d-9789-a8426e867c43
6eadf486-4e58-485c-a62a-a80286b87e50	71ead344-21fd-4681-aba7-b18011f01638	algorithm	HS256
2032f605-13d1-4d9a-8217-bf6dabb5dfd9	71ead344-21fd-4681-aba7-b18011f01638	secret	ZjYLUM_Bw2txorWhFHrSXkkbn64Tka-ZZZDbHToTmrgUbsDLnRTxrlcr905xAbQD6GQqHp3fzjkaUVN9gZUzcw
b1f798f6-a0c0-43d7-9df2-3004e4ffc29a	71ead344-21fd-4681-aba7-b18011f01638	priority	100
13abd61a-34b5-4373-9e39-a3dee66d68bf	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	oidc-address-mapper
f8b918e2-da22-4556-8b1f-e39d20c138c7	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d6b15e07-b6e0-4f93-87f9-4ce6c7cb3e6e	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7e3a935d-ce48-4512-8daf-217232301411	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
47d464d6-695c-4897-a154-7850f894a4f1	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	saml-user-property-mapper
7a7c572d-9bc9-4238-b19b-0924919c5a38	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	saml-role-list-mapper
eacbda2d-5423-4a2a-a119-eafda5d9d944	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	saml-user-attribute-mapper
fce16dc9-51b8-4810-8a50-617514ae39fb	84848ca9-be49-4b20-a666-aff5b11216fa	allowed-protocol-mapper-types	oidc-full-name-mapper
095c7448-617c-4b79-b13b-a3e392513210	b28839bf-6efa-4442-9be5-7379be25cda9	allow-default-scopes	true
33aff818-0839-4bc3-be42-9b5562294b19	8e4cbedc-a28e-4dc7-9eef-5295a4844aa4	host-sending-registration-request-must-match	true
5ae638fa-d913-4a1e-91ca-81c267ebb64e	8e4cbedc-a28e-4dc7-9eef-5295a4844aa4	client-uris-must-match	true
9a0deaa0-2080-4028-ab04-08ead3352bf3	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
33331a58-5324-412d-abbe-93fe9d78cecc	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
49da10d1-347a-4a17-821c-1025e55c0959	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	saml-user-property-mapper
20da8b80-773d-4cae-b105-23c54413fec4	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	oidc-full-name-mapper
a84abdcb-fd48-4e1c-8ad0-1c356401405f	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	saml-role-list-mapper
38760b35-a76b-4c98-bb4c-715bcd534ada	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	saml-user-attribute-mapper
ec398cb6-c1ca-4235-adfc-bd66b67a2afe	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	oidc-address-mapper
22c58e1f-360f-4a36-aed9-813d8393d07e	02814cda-c71d-45a7-99c5-beded15d4359	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
28f0e83b-968e-4a9a-b8ca-58c01293f6e8	36e9f968-e081-44ec-b4c8-b1b05aa09070	max-clients	200
8996b68b-0b84-4624-99e1-ed4e7ca4fb8d	adc1273e-e6ff-49ca-95f8-0a8bf03dd6cf	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	cef9617c-520d-40f3-a001-0229bce60ea0
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	61a55b30-684c-4aab-b525-19c4d55b1795
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	dccab007-3b59-4ae4-a1e9-74ca86531b57
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	79ad9aa5-72ed-42f2-9837-a3b74ea78e99
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	b498f965-662b-421f-9f16-2b59869e42e1
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	4c6392a0-3b9d-4791-9eef-0da14fb82c6f
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	e551f6e9-ee0e-4eb7-8a93-7caada575f41
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	cc40af7f-df01-4696-a9c1-0f90af55721f
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	6a9fa1f8-bf37-4baa-ae36-d47af9da84c2
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	b2653182-4dff-457f-b546-fb599cb5af8b
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	7c02fca2-a8e5-4700-9e09-29be4e41238a
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	4b477e3b-d5f7-4ac6-a873-6e9e4ae7fee2
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	70a94dd2-7d03-47ec-bd33-70e2dd990353
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	8c31b24c-c3b7-4161-93b0-7395d966842d
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	de457a1c-b5dd-4344-9b6c-8b7ff62bf827
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	fb6b8002-77cc-423f-83a8-9dd3a1321674
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	a011bf61-4716-41e7-84da-f3bc793883cf
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	c40c585b-de68-4b1f-a386-93931b955555
b498f965-662b-421f-9f16-2b59869e42e1	fb6b8002-77cc-423f-83a8-9dd3a1321674
79ad9aa5-72ed-42f2-9837-a3b74ea78e99	c40c585b-de68-4b1f-a386-93931b955555
79ad9aa5-72ed-42f2-9837-a3b74ea78e99	de457a1c-b5dd-4344-9b6c-8b7ff62bf827
eb8a571c-62ac-448a-b8de-48476a92c0fe	b1eb41a4-9ee1-4aa6-a9e0-181d04fe5979
eb8a571c-62ac-448a-b8de-48476a92c0fe	e788fdd0-3c3c-42d7-b9c6-cfd1a7c74e08
e788fdd0-3c3c-42d7-b9c6-cfd1a7c74e08	a8d713c8-dc31-435f-990c-0c9159aa84b6
e4bc1200-745e-45fe-9281-a89fe18b9d3a	f93bfd40-4e0d-465a-93c7-ef50d239ee67
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	bd42d14d-fb13-4f4e-978e-e915f36a00d5
eb8a571c-62ac-448a-b8de-48476a92c0fe	cf6192a5-7e7e-455f-a75f-61b80be6fe1e
eb8a571c-62ac-448a-b8de-48476a92c0fe	e5680b39-95e2-49bc-9bb7-178d5e900723
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	f2f32605-2446-458e-a14f-8640cec8ccca
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	3de7f094-2cfc-48ae-b42c-bff55985b159
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	2a48c97b-01e1-47d3-a142-37786bb30f3d
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	12a8953e-8fcf-476b-abdc-85794317ea03
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	6a632034-57b0-4d2e-9484-04c8b15e4ae0
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	7633dc22-c98c-48b9-8b18-9e0c6b97709f
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	ab68d43b-760d-4b40-a923-765214446eb7
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	5d1f9674-511e-41f0-ba98-374389c58a75
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	8e134600-4c7f-4177-a679-5bc5d2698da7
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	31f1b680-0fe8-4919-9dcb-6d0a22bf1a80
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	013a475c-8f0d-4ed2-9a58-968f710d3f51
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	6dedd6d0-4236-48cb-a0c2-768dbfb806bb
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	496c5d8b-fcbc-4219-8aeb-b511efe1e611
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	23710f8f-b4fb-4263-80e4-bed6a30c76f7
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	dc6cf952-6c46-4b82-b50b-fbae13aadcb6
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	c9977e11-b8a2-4321-a62b-93d8741e27ae
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	ea5dbcb7-ded7-4979-8d0c-4f7e52f96c3a
12a8953e-8fcf-476b-abdc-85794317ea03	dc6cf952-6c46-4b82-b50b-fbae13aadcb6
2a48c97b-01e1-47d3-a142-37786bb30f3d	ea5dbcb7-ded7-4979-8d0c-4f7e52f96c3a
2a48c97b-01e1-47d3-a142-37786bb30f3d	23710f8f-b4fb-4263-80e4-bed6a30c76f7
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	528a52b1-116a-4d89-b076-940943166b65
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	deb1b766-7627-4d7a-a317-6cf3f4ee531f
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	6c5c69c2-0e29-4c64-81e1-488030cb3fed
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	8954002e-2513-4071-94f4-dfc01d01abe1
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	f895a986-5615-4bf0-9890-d98245ea9744
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	cb11ce1f-42f1-4468-8fc0-125b1d3b4de1
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	9f3df1c2-37d0-47cf-bd79-8190ac978267
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	518229c2-9cff-45bd-ba10-d9cc6af2f2f6
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	9a300a3a-5a09-4535-aae9-90fe34130f53
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	af549064-4cbc-4041-b90a-b8cfaca6d626
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	4df1c8c1-5cbd-4977-9141-8cef50417dea
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	4c020a6b-f944-47dd-8f39-b52328402a2f
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	67853e42-667c-4606-aa17-0420980581c1
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	fbbb02e8-b863-46a9-9fe3-b46006b99920
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	6ff59718-c3f1-4cf2-9e0a-bcdce9eddc18
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	1a448561-8d1b-4762-adfa-e5b84fd76eed
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	0401c523-b8a4-48e1-8cf1-456f336c1502
8954002e-2513-4071-94f4-dfc01d01abe1	6ff59718-c3f1-4cf2-9e0a-bcdce9eddc18
6c5c69c2-0e29-4c64-81e1-488030cb3fed	fbbb02e8-b863-46a9-9fe3-b46006b99920
6c5c69c2-0e29-4c64-81e1-488030cb3fed	0401c523-b8a4-48e1-8cf1-456f336c1502
780b83c6-426a-4bb4-9fe9-a6dadcb51044	ff61c29d-90a7-4999-a1f8-2fa1ecc07a8e
780b83c6-426a-4bb4-9fe9-a6dadcb51044	78c089cd-fe4e-4575-aa38-768840bfe270
78c089cd-fe4e-4575-aa38-768840bfe270	ad91a252-8374-499e-83b4-cf1f6127067a
111a3a46-1254-4e72-847c-b9b8bd5cf74e	0b40ecd4-19b3-43fd-ae93-d052393df4a7
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	c4d1dec7-9e2a-45ef-b620-75a45941b3f7
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	70154c3d-6dcc-48fa-9e3b-98ca18827c32
780b83c6-426a-4bb4-9fe9-a6dadcb51044	678f24aa-3aba-4eb0-973f-d309185f17e6
780b83c6-426a-4bb4-9fe9-a6dadcb51044	5a7a5750-1efe-45ed-8be0-ccf69665ce84
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
14a95803-f4fd-4da1-be30-fdd5b6841864	\N	password	ef457bb2-92d4-452c-934c-9c06092a28f2	1663334499550	\N	{"value":"OVE4L2rS85Y2Ede7uP46y8+37vK3hOQKiBs4HbmB+axshyXU1DWRp96okBzME86FtUlmV4tEN0ybMlDmWtNXRw==","salt":"GMC9NpJ/Qu7mTq4XKDUDRg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
1ceb4159-2fae-4bc6-92f0-b20dba3d06ff	\N	password	eca39438-43e1-42dd-bae0-17cb29343322	1663334902528	\N	{"value":"nba2vsiJBAMorBFsDIKxSgUjrN8/EQN7BEzBexE6izlv/8tjbNh/1XO87Ixz55Sq1ReMpCWdqFKM/E8Qu8iqGw==","salt":"sWAk3+erZsrYliPohBlBwQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
2c419baf-8a9f-41b8-8b1f-c93d44ecac13	\N	password	4cf81e1c-8bc6-4985-90a6-9b0a4982131e	1663335091765	\N	{"value":"2dTWDaNMorM8HwbC/Y151ts7vNfzN1bpls2NAr3SoMx2HZ60xI4KA2vfwzAFc1WQBAX77vTwpoDrFc+6SRlAIQ==","salt":"wp/damwj+qTtvO6f9tkCZQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
0580bd76-881f-4e3f-9540-9f10d4863171	\N	password	18da88ed-b8be-4822-a9a3-82617eca4d23	1663335133939	\N	{"value":"Dmvpmp/HPmGWuuLReuJF5N9ZAZfOvFJRPrHui/zwvJrA/IuAda5KYGOpOy3Kk87hwRH0hSIsvlkvYbjSzzaQ0g==","salt":"tZSzRxcNOCsPlIyTcyCa5A==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-09-16 15:21:28.319268	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3334487771
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-09-16 15:21:28.333809	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3334487771
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-09-16 15:21:28.40942	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	3334487771
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-09-16 15:21:28.41769	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	3334487771
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-09-16 15:21:28.611637	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3334487771
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-09-16 15:21:28.61773	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3334487771
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-09-16 15:21:28.792222	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3334487771
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-09-16 15:21:28.798137	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3334487771
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-09-16 15:21:28.806794	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	3334487771
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-09-16 15:21:29.004334	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	3334487771
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-09-16 15:21:29.099932	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3334487771
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-09-16 15:21:29.104131	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3334487771
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-09-16 15:21:29.135801	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3334487771
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-16 15:21:29.171751	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	3334487771
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-16 15:21:29.174708	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3334487771
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-16 15:21:29.179746	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	3334487771
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-09-16 15:21:29.183649	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	3334487771
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-09-16 15:21:29.298797	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	3334487771
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-09-16 15:21:29.403795	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3334487771
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-09-16 15:21:29.414037	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3334487771
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-16 15:21:31.623453	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3334487771
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-09-16 15:21:29.419273	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3334487771
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-09-16 15:21:29.423933	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3334487771
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-09-16 15:21:29.50063	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	3334487771
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-09-16 15:21:29.508246	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3334487771
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-09-16 15:21:29.511584	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3334487771
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-09-16 15:21:29.824373	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	3334487771
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-09-16 15:21:30.011028	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	3334487771
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-09-16 15:21:30.01548	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3334487771
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-09-16 15:21:30.203044	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	3334487771
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-09-16 15:21:30.236761	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	3334487771
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-09-16 15:21:30.27555	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	3334487771
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-09-16 15:21:30.284969	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	3334487771
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-16 15:21:30.298861	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3334487771
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-16 15:21:30.303439	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3334487771
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-16 15:21:30.365279	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3334487771
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-09-16 15:21:30.376654	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	3334487771
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-09-16 15:21:30.390179	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3334487771
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-09-16 15:21:30.398001	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	3334487771
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-09-16 15:21:30.406345	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	3334487771
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-16 15:21:30.410711	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3334487771
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-16 15:21:30.415271	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3334487771
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-09-16 15:21:30.426902	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	3334487771
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-09-16 15:21:31.604583	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	3334487771
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-09-16 15:21:31.612588	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	3334487771
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-16 15:21:31.634984	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	3334487771
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-16 15:21:31.638395	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3334487771
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-16 15:21:31.760509	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	3334487771
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-09-16 15:21:31.766821	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	3334487771
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-09-16 15:21:31.842998	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	3334487771
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-09-16 15:21:32.072109	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	3334487771
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-09-16 15:21:32.077285	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3334487771
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-09-16 15:21:32.081115	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	3334487771
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-09-16 15:21:32.084731	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	3334487771
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-16 15:21:32.097192	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	3334487771
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-16 15:21:32.108741	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	3334487771
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-16 15:21:32.173214	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	3334487771
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-09-16 15:21:32.709102	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	3334487771
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-09-16 15:21:32.771122	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	3334487771
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-09-16 15:21:32.783395	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3334487771
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-09-16 15:21:32.800209	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	3334487771
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-09-16 15:21:32.813286	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	3334487771
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-09-16 15:21:32.820691	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3334487771
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-09-16 15:21:32.826312	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3334487771
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-09-16 15:21:32.834697	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	3334487771
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-09-16 15:21:32.887034	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	3334487771
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-09-16 15:21:32.922404	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	3334487771
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-09-16 15:21:32.932412	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	3334487771
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-09-16 15:21:32.972274	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	3334487771
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-09-16 15:21:32.982252	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	3334487771
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-09-16 15:21:32.990672	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	3334487771
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-16 15:21:33.004757	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3334487771
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-16 15:21:33.015661	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3334487771
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-16 15:21:33.019753	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3334487771
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-16 15:21:33.060023	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	3334487771
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-09-16 15:21:33.087476	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	3334487771
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-16 15:21:33.093161	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	3334487771
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-16 15:21:33.096244	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	3334487771
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-16 15:21:33.138653	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	3334487771
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-09-16 15:21:33.142049	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	3334487771
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-16 15:21:33.172262	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	3334487771
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-16 15:21:33.17526	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3334487771
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-16 15:21:33.182359	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3334487771
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-16 15:21:33.185655	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3334487771
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-09-16 15:21:33.213843	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	3334487771
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-09-16 15:21:33.223612	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	3334487771
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-09-16 15:21:33.2441	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	3334487771
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-09-16 15:21:33.271689	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	3334487771
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-16 15:21:33.27954	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	3334487771
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-16 15:21:33.292913	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	3334487771
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-16 15:21:33.322685	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3334487771
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-16 15:21:33.342701	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	3334487771
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-16 15:21:33.345778	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	3334487771
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-16 15:21:33.367416	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	3334487771
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-16 15:21:33.372514	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	3334487771
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-09-16 15:21:33.393247	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	3334487771
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-16 15:21:33.464448	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3334487771
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-16 15:21:33.467172	98	MARK_RAN	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3334487771
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-16 15:21:33.484147	99	MARK_RAN	7:06499836520f4f6b3d05e35a59324910	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3334487771
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-16 15:21:33.519326	100	EXECUTED	7:fad08e83c77d0171ec166bc9bc5d390a	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3334487771
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-16 15:21:33.523438	101	MARK_RAN	7:3d2b23076e59c6f70bae703aa01be35b	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3334487771
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-16 15:21:33.555934	102	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	3334487771
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-09-16 15:21:33.562004	103	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	3334487771
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-09-16 15:21:33.57505	104	EXECUTED	7:b06356d66c2790ecc2ae54ba0458397a	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	3.5.4	\N	\N	3334487771
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	bebc1451-bb49-44e0-b88f-273c71bf6d93	f
master	fbe03fdc-9fb4-4ce1-a7ed-8706b2b1fa55	t
master	64d10ade-3d36-4004-a958-b4cca90e49f5	t
master	7f895973-cf6c-4f07-8a51-d48d2fcf632c	t
master	5785129c-892b-4137-8b27-fe8299d380a5	f
master	cc627dc7-7df6-4266-a5c6-248f2ae4abcf	f
master	f4eb6714-24f0-4fd6-b55e-27c885a28897	t
master	a6f2d753-2f8e-4305-821f-774518562cad	t
master	ef61022d-f69c-41fe-8bd8-ed21b76ff2e0	f
easybackend	3774e03a-fa92-4bd3-941a-bfd0b6ce9372	f
easybackend	12ea9885-c85d-4ab3-bbfb-b9c706495db5	t
easybackend	fb2df94f-824a-4682-baf9-9da7047671d2	t
easybackend	b0df9abe-928c-45ce-847d-12a7251cee9a	t
easybackend	d56a3de7-1416-4106-895d-ee839a2278fd	f
easybackend	7209fb8c-3f21-442e-8c71-aa3336dc2f45	f
easybackend	6cb0c8c9-4089-49a0-b39a-43268e5ae246	t
easybackend	240fc8d7-4ea6-4701-9d56-b9cca566061a	t
easybackend	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
eb8a571c-62ac-448a-b8de-48476a92c0fe	master	f	${role_default-roles}	default-roles-master	master	\N	\N
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	master	f	${role_admin}	admin	master	\N	\N
cef9617c-520d-40f3-a001-0229bce60ea0	master	f	${role_create-realm}	create-realm	master	\N	\N
61a55b30-684c-4aab-b525-19c4d55b1795	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_create-client}	create-client	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
dccab007-3b59-4ae4-a1e9-74ca86531b57	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_view-realm}	view-realm	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
79ad9aa5-72ed-42f2-9837-a3b74ea78e99	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_view-users}	view-users	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
b498f965-662b-421f-9f16-2b59869e42e1	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_view-clients}	view-clients	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
4c6392a0-3b9d-4791-9eef-0da14fb82c6f	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_view-events}	view-events	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
e551f6e9-ee0e-4eb7-8a93-7caada575f41	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_view-identity-providers}	view-identity-providers	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
cc40af7f-df01-4696-a9c1-0f90af55721f	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_view-authorization}	view-authorization	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
6a9fa1f8-bf37-4baa-ae36-d47af9da84c2	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_manage-realm}	manage-realm	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
b2653182-4dff-457f-b546-fb599cb5af8b	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_manage-users}	manage-users	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
7c02fca2-a8e5-4700-9e09-29be4e41238a	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_manage-clients}	manage-clients	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
4b477e3b-d5f7-4ac6-a873-6e9e4ae7fee2	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_manage-events}	manage-events	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
70a94dd2-7d03-47ec-bd33-70e2dd990353	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_manage-identity-providers}	manage-identity-providers	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
8c31b24c-c3b7-4161-93b0-7395d966842d	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_manage-authorization}	manage-authorization	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
de457a1c-b5dd-4344-9b6c-8b7ff62bf827	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_query-users}	query-users	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
fb6b8002-77cc-423f-83a8-9dd3a1321674	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_query-clients}	query-clients	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
a011bf61-4716-41e7-84da-f3bc793883cf	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_query-realms}	query-realms	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
c40c585b-de68-4b1f-a386-93931b955555	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_query-groups}	query-groups	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
b1eb41a4-9ee1-4aa6-a9e0-181d04fe5979	c9650e94-0f17-45a9-89d7-aa1598d01650	t	${role_view-profile}	view-profile	master	c9650e94-0f17-45a9-89d7-aa1598d01650	\N
e788fdd0-3c3c-42d7-b9c6-cfd1a7c74e08	c9650e94-0f17-45a9-89d7-aa1598d01650	t	${role_manage-account}	manage-account	master	c9650e94-0f17-45a9-89d7-aa1598d01650	\N
a8d713c8-dc31-435f-990c-0c9159aa84b6	c9650e94-0f17-45a9-89d7-aa1598d01650	t	${role_manage-account-links}	manage-account-links	master	c9650e94-0f17-45a9-89d7-aa1598d01650	\N
15ed6af4-36aa-4583-992f-aa54aa90507f	c9650e94-0f17-45a9-89d7-aa1598d01650	t	${role_view-applications}	view-applications	master	c9650e94-0f17-45a9-89d7-aa1598d01650	\N
f93bfd40-4e0d-465a-93c7-ef50d239ee67	c9650e94-0f17-45a9-89d7-aa1598d01650	t	${role_view-consent}	view-consent	master	c9650e94-0f17-45a9-89d7-aa1598d01650	\N
e4bc1200-745e-45fe-9281-a89fe18b9d3a	c9650e94-0f17-45a9-89d7-aa1598d01650	t	${role_manage-consent}	manage-consent	master	c9650e94-0f17-45a9-89d7-aa1598d01650	\N
54abb991-0d71-4ca8-a50a-a94774dc5d3a	c9650e94-0f17-45a9-89d7-aa1598d01650	t	${role_delete-account}	delete-account	master	c9650e94-0f17-45a9-89d7-aa1598d01650	\N
c5268629-89a8-41c7-9814-ae2ccc56f93e	aa54d45a-4415-4228-9cf8-8970ae90dc8d	t	${role_read-token}	read-token	master	aa54d45a-4415-4228-9cf8-8970ae90dc8d	\N
bd42d14d-fb13-4f4e-978e-e915f36a00d5	c950d556-3e66-49b3-9c82-2d4063f0325a	t	${role_impersonation}	impersonation	master	c950d556-3e66-49b3-9c82-2d4063f0325a	\N
cf6192a5-7e7e-455f-a75f-61b80be6fe1e	master	f	${role_offline-access}	offline_access	master	\N	\N
e5680b39-95e2-49bc-9bb7-178d5e900723	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
780b83c6-426a-4bb4-9fe9-a6dadcb51044	easybackend	f	${role_default-roles}	default-roles-easybackend	easybackend	\N	\N
f2f32605-2446-458e-a14f-8640cec8ccca	7749e2fc-153f-452f-b3f4-809118805993	t	${role_create-client}	create-client	master	7749e2fc-153f-452f-b3f4-809118805993	\N
3de7f094-2cfc-48ae-b42c-bff55985b159	7749e2fc-153f-452f-b3f4-809118805993	t	${role_view-realm}	view-realm	master	7749e2fc-153f-452f-b3f4-809118805993	\N
2a48c97b-01e1-47d3-a142-37786bb30f3d	7749e2fc-153f-452f-b3f4-809118805993	t	${role_view-users}	view-users	master	7749e2fc-153f-452f-b3f4-809118805993	\N
12a8953e-8fcf-476b-abdc-85794317ea03	7749e2fc-153f-452f-b3f4-809118805993	t	${role_view-clients}	view-clients	master	7749e2fc-153f-452f-b3f4-809118805993	\N
6a632034-57b0-4d2e-9484-04c8b15e4ae0	7749e2fc-153f-452f-b3f4-809118805993	t	${role_view-events}	view-events	master	7749e2fc-153f-452f-b3f4-809118805993	\N
7633dc22-c98c-48b9-8b18-9e0c6b97709f	7749e2fc-153f-452f-b3f4-809118805993	t	${role_view-identity-providers}	view-identity-providers	master	7749e2fc-153f-452f-b3f4-809118805993	\N
ab68d43b-760d-4b40-a923-765214446eb7	7749e2fc-153f-452f-b3f4-809118805993	t	${role_view-authorization}	view-authorization	master	7749e2fc-153f-452f-b3f4-809118805993	\N
5d1f9674-511e-41f0-ba98-374389c58a75	7749e2fc-153f-452f-b3f4-809118805993	t	${role_manage-realm}	manage-realm	master	7749e2fc-153f-452f-b3f4-809118805993	\N
8e134600-4c7f-4177-a679-5bc5d2698da7	7749e2fc-153f-452f-b3f4-809118805993	t	${role_manage-users}	manage-users	master	7749e2fc-153f-452f-b3f4-809118805993	\N
31f1b680-0fe8-4919-9dcb-6d0a22bf1a80	7749e2fc-153f-452f-b3f4-809118805993	t	${role_manage-clients}	manage-clients	master	7749e2fc-153f-452f-b3f4-809118805993	\N
013a475c-8f0d-4ed2-9a58-968f710d3f51	7749e2fc-153f-452f-b3f4-809118805993	t	${role_manage-events}	manage-events	master	7749e2fc-153f-452f-b3f4-809118805993	\N
6dedd6d0-4236-48cb-a0c2-768dbfb806bb	7749e2fc-153f-452f-b3f4-809118805993	t	${role_manage-identity-providers}	manage-identity-providers	master	7749e2fc-153f-452f-b3f4-809118805993	\N
496c5d8b-fcbc-4219-8aeb-b511efe1e611	7749e2fc-153f-452f-b3f4-809118805993	t	${role_manage-authorization}	manage-authorization	master	7749e2fc-153f-452f-b3f4-809118805993	\N
23710f8f-b4fb-4263-80e4-bed6a30c76f7	7749e2fc-153f-452f-b3f4-809118805993	t	${role_query-users}	query-users	master	7749e2fc-153f-452f-b3f4-809118805993	\N
dc6cf952-6c46-4b82-b50b-fbae13aadcb6	7749e2fc-153f-452f-b3f4-809118805993	t	${role_query-clients}	query-clients	master	7749e2fc-153f-452f-b3f4-809118805993	\N
c9977e11-b8a2-4321-a62b-93d8741e27ae	7749e2fc-153f-452f-b3f4-809118805993	t	${role_query-realms}	query-realms	master	7749e2fc-153f-452f-b3f4-809118805993	\N
ea5dbcb7-ded7-4979-8d0c-4f7e52f96c3a	7749e2fc-153f-452f-b3f4-809118805993	t	${role_query-groups}	query-groups	master	7749e2fc-153f-452f-b3f4-809118805993	\N
38a5f8ba-b43a-49f6-b113-c78cde2e9b65	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_realm-admin}	realm-admin	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
528a52b1-116a-4d89-b076-940943166b65	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_create-client}	create-client	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
deb1b766-7627-4d7a-a317-6cf3f4ee531f	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_view-realm}	view-realm	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
6c5c69c2-0e29-4c64-81e1-488030cb3fed	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_view-users}	view-users	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
8954002e-2513-4071-94f4-dfc01d01abe1	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_view-clients}	view-clients	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
f895a986-5615-4bf0-9890-d98245ea9744	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_view-events}	view-events	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
cb11ce1f-42f1-4468-8fc0-125b1d3b4de1	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_view-identity-providers}	view-identity-providers	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
9f3df1c2-37d0-47cf-bd79-8190ac978267	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_view-authorization}	view-authorization	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
518229c2-9cff-45bd-ba10-d9cc6af2f2f6	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_manage-realm}	manage-realm	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
9a300a3a-5a09-4535-aae9-90fe34130f53	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_manage-users}	manage-users	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
af549064-4cbc-4041-b90a-b8cfaca6d626	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_manage-clients}	manage-clients	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
4df1c8c1-5cbd-4977-9141-8cef50417dea	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_manage-events}	manage-events	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
4c020a6b-f944-47dd-8f39-b52328402a2f	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_manage-identity-providers}	manage-identity-providers	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
67853e42-667c-4606-aa17-0420980581c1	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_manage-authorization}	manage-authorization	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
fbbb02e8-b863-46a9-9fe3-b46006b99920	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_query-users}	query-users	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
6ff59718-c3f1-4cf2-9e0a-bcdce9eddc18	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_query-clients}	query-clients	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
1a448561-8d1b-4762-adfa-e5b84fd76eed	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_query-realms}	query-realms	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
0401c523-b8a4-48e1-8cf1-456f336c1502	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_query-groups}	query-groups	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
ff61c29d-90a7-4999-a1f8-2fa1ecc07a8e	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_view-profile}	view-profile	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
78c089cd-fe4e-4575-aa38-768840bfe270	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_manage-account}	manage-account	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
ad91a252-8374-499e-83b4-cf1f6127067a	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_manage-account-links}	manage-account-links	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
57419e0d-f59e-4d6e-8fd7-5696e67224d0	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_view-applications}	view-applications	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
0b40ecd4-19b3-43fd-ae93-d052393df4a7	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_view-consent}	view-consent	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
111a3a46-1254-4e72-847c-b9b8bd5cf74e	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_manage-consent}	manage-consent	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
c35b8499-4b50-4f07-b3d2-5764e38fbf1a	544e5eb0-3d17-4823-a9af-f15e289f63bc	t	${role_delete-account}	delete-account	easybackend	544e5eb0-3d17-4823-a9af-f15e289f63bc	\N
c4d1dec7-9e2a-45ef-b620-75a45941b3f7	7749e2fc-153f-452f-b3f4-809118805993	t	${role_impersonation}	impersonation	master	7749e2fc-153f-452f-b3f4-809118805993	\N
70154c3d-6dcc-48fa-9e3b-98ca18827c32	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	t	${role_impersonation}	impersonation	easybackend	5fe57fb2-edfc-4d5d-aceb-648e30e2033c	\N
5582d484-b152-4345-a33e-2a924115075b	2ef67323-2a80-4467-91f7-a5dfc6491cae	t	${role_read-token}	read-token	easybackend	2ef67323-2a80-4467-91f7-a5dfc6491cae	\N
678f24aa-3aba-4eb0-973f-d309185f17e6	easybackend	f	${role_offline-access}	offline_access	easybackend	\N	\N
5a7a5750-1efe-45ed-8be0-ccf69665ce84	easybackend	f	${role_uma_authorization}	uma_authorization	easybackend	\N	\N
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	easybackend	f	\N	easybackend_user	easybackend	\N	\N
72ba495b-3d6e-4940-a167-60b769f2f5dc	easybackend	f	\N	easybackend_admin	easybackend	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
qky4m	16.1.1	1663334497
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
ee11874a-464e-420d-8c56-87b3a26a82db	audience resolve	openid-connect	oidc-audience-resolve-mapper	b210e7d3-a550-4903-b4e0-29a0a2fc26d8	\N
8a9bd2c2-5e07-427e-81ac-4ce6006396d1	locale	openid-connect	oidc-usermodel-attribute-mapper	8b33fe4c-8c10-4ea3-9e3a-22e68d3ee954	\N
8517fac7-bd4e-49a7-bdcf-be52d6e981ad	role list	saml	saml-role-list-mapper	\N	fbe03fdc-9fb4-4ce1-a7ed-8706b2b1fa55
17ca67e8-f3c9-4e45-8111-75ce057c9ce3	full name	openid-connect	oidc-full-name-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
cc81a8af-08d2-4513-8cbf-10b3a9911c54	family name	openid-connect	oidc-usermodel-property-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
84a48846-3bc2-4028-a7e1-72fefe1e470d	given name	openid-connect	oidc-usermodel-property-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
8feb361e-8d04-4d8c-8bce-de0210a8e9e9	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
a545258b-cda6-4c70-92c9-0bde2ccafa24	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
100c6690-dc45-4f0c-8de6-f9f636422077	username	openid-connect	oidc-usermodel-property-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
24057746-01b6-4c6a-a77c-ee6fd2d50247	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
b7d21ec0-f960-47fe-9c1b-cc778a0858ed	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
028bc6c9-ed8a-4db9-9fa1-748331803be2	website	openid-connect	oidc-usermodel-attribute-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
3dd25cb8-334f-448b-9a77-289a7ab11536	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
65d48372-1585-4d51-8856-621af25a548e	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
a59a5a74-a795-4f89-9a67-8b6be1436da2	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
436aaf31-2fcd-4e7a-ad21-da9395c82da9	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
3e79be3b-c580-486d-967d-4c17733790be	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	64d10ade-3d36-4004-a958-b4cca90e49f5
508d1fd2-bae0-4dbe-becc-1303c6461b6b	email	openid-connect	oidc-usermodel-property-mapper	\N	7f895973-cf6c-4f07-8a51-d48d2fcf632c
44c76e41-a0d3-4bb2-aff6-4e8fbde43eef	email verified	openid-connect	oidc-usermodel-property-mapper	\N	7f895973-cf6c-4f07-8a51-d48d2fcf632c
4242bb8e-efa0-4390-86a5-1e0fd1f9730e	address	openid-connect	oidc-address-mapper	\N	5785129c-892b-4137-8b27-fe8299d380a5
cbccfe30-f072-4c82-8f0e-36642702dcc6	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	cc627dc7-7df6-4266-a5c6-248f2ae4abcf
8eec666c-1974-4c27-8676-d25e7919b67f	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	cc627dc7-7df6-4266-a5c6-248f2ae4abcf
f35e65e3-e958-4f0b-a35f-31b3081dd1f8	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	f4eb6714-24f0-4fd6-b55e-27c885a28897
631df30f-7777-48ec-af18-3dab14aa5f51	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	f4eb6714-24f0-4fd6-b55e-27c885a28897
498e7668-5329-4aee-b247-953ade1284da	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	f4eb6714-24f0-4fd6-b55e-27c885a28897
3d3eae3b-adc6-4281-bc03-1d440f22c634	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	a6f2d753-2f8e-4305-821f-774518562cad
01db4b5f-dc45-4681-a693-66c088ee3c45	upn	openid-connect	oidc-usermodel-property-mapper	\N	ef61022d-f69c-41fe-8bd8-ed21b76ff2e0
bdb3e2c3-80af-4598-ad01-3d434a6174cc	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	ef61022d-f69c-41fe-8bd8-ed21b76ff2e0
c0699a7b-e55a-4c11-bde9-50ff140db1aa	audience resolve	openid-connect	oidc-audience-resolve-mapper	4f8b866a-cccf-4fe0-b2fb-72261ea37634	\N
6896dbf2-8ded-4933-a98e-6a148a835e96	role list	saml	saml-role-list-mapper	\N	12ea9885-c85d-4ab3-bbfb-b9c706495db5
700eb412-f80c-42ef-a0a0-350f8578274a	full name	openid-connect	oidc-full-name-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	family name	openid-connect	oidc-usermodel-property-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	given name	openid-connect	oidc-usermodel-property-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
d079a677-f367-4e6a-92e2-d32d2c03ff12	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
79009f2e-12cf-4022-ab87-070d418d6a17	username	openid-connect	oidc-usermodel-property-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
7c97b048-915e-4742-8879-6e28b457f014	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
1fbe377f-b45d-43cc-9272-a539bc656e2d	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
d2405431-6415-4547-9cbf-6ad491b4f851	website	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
5268821b-7d20-46ba-8a4f-05793c43269b	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
45f4de79-9096-4dbd-bd4a-957d40bbe01f	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
4bbfe834-87d2-4a04-a079-d0e4206cc406	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	fb2df94f-824a-4682-baf9-9da7047671d2
23cba6c0-9ade-4921-92d3-0edb9d671f0f	email	openid-connect	oidc-usermodel-property-mapper	\N	b0df9abe-928c-45ce-847d-12a7251cee9a
96197993-2e17-477a-bced-9971caffbfab	email verified	openid-connect	oidc-usermodel-property-mapper	\N	b0df9abe-928c-45ce-847d-12a7251cee9a
1be633bc-17d6-44f9-b5d9-161c6277a62e	address	openid-connect	oidc-address-mapper	\N	d56a3de7-1416-4106-895d-ee839a2278fd
28f94d9d-d8cd-4b53-ad7b-308fd186f739	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	7209fb8c-3f21-442e-8c71-aa3336dc2f45
7d712ea3-b357-4a6b-a8dc-79c6189cf517	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	7209fb8c-3f21-442e-8c71-aa3336dc2f45
9f437a33-577a-428e-814b-7b895c67addc	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	6cb0c8c9-4089-49a0-b39a-43268e5ae246
b27919bf-df5f-463a-a91b-cfcde4580de7	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	6cb0c8c9-4089-49a0-b39a-43268e5ae246
efaf397b-9763-4aee-a568-dafc13822e61	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	6cb0c8c9-4089-49a0-b39a-43268e5ae246
28e369c4-0f48-49cf-ac43-86735623e5ed	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	240fc8d7-4ea6-4701-9d56-b9cca566061a
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	upn	openid-connect	oidc-usermodel-property-mapper	\N	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	b2dd9bb7-b057-46ed-ac26-b05694ceb3fb
92d38df7-7473-491e-b132-f78748a23de6	locale	openid-connect	oidc-usermodel-attribute-mapper	0c1072d0-fbe2-4759-9c08-a399a7faa47b	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
8a9bd2c2-5e07-427e-81ac-4ce6006396d1	true	userinfo.token.claim
8a9bd2c2-5e07-427e-81ac-4ce6006396d1	locale	user.attribute
8a9bd2c2-5e07-427e-81ac-4ce6006396d1	true	id.token.claim
8a9bd2c2-5e07-427e-81ac-4ce6006396d1	true	access.token.claim
8a9bd2c2-5e07-427e-81ac-4ce6006396d1	locale	claim.name
8a9bd2c2-5e07-427e-81ac-4ce6006396d1	String	jsonType.label
8517fac7-bd4e-49a7-bdcf-be52d6e981ad	false	single
8517fac7-bd4e-49a7-bdcf-be52d6e981ad	Basic	attribute.nameformat
8517fac7-bd4e-49a7-bdcf-be52d6e981ad	Role	attribute.name
17ca67e8-f3c9-4e45-8111-75ce057c9ce3	true	userinfo.token.claim
17ca67e8-f3c9-4e45-8111-75ce057c9ce3	true	id.token.claim
17ca67e8-f3c9-4e45-8111-75ce057c9ce3	true	access.token.claim
cc81a8af-08d2-4513-8cbf-10b3a9911c54	true	userinfo.token.claim
cc81a8af-08d2-4513-8cbf-10b3a9911c54	lastName	user.attribute
cc81a8af-08d2-4513-8cbf-10b3a9911c54	true	id.token.claim
cc81a8af-08d2-4513-8cbf-10b3a9911c54	true	access.token.claim
cc81a8af-08d2-4513-8cbf-10b3a9911c54	family_name	claim.name
cc81a8af-08d2-4513-8cbf-10b3a9911c54	String	jsonType.label
84a48846-3bc2-4028-a7e1-72fefe1e470d	true	userinfo.token.claim
84a48846-3bc2-4028-a7e1-72fefe1e470d	firstName	user.attribute
84a48846-3bc2-4028-a7e1-72fefe1e470d	true	id.token.claim
84a48846-3bc2-4028-a7e1-72fefe1e470d	true	access.token.claim
84a48846-3bc2-4028-a7e1-72fefe1e470d	given_name	claim.name
84a48846-3bc2-4028-a7e1-72fefe1e470d	String	jsonType.label
8feb361e-8d04-4d8c-8bce-de0210a8e9e9	true	userinfo.token.claim
8feb361e-8d04-4d8c-8bce-de0210a8e9e9	middleName	user.attribute
8feb361e-8d04-4d8c-8bce-de0210a8e9e9	true	id.token.claim
8feb361e-8d04-4d8c-8bce-de0210a8e9e9	true	access.token.claim
8feb361e-8d04-4d8c-8bce-de0210a8e9e9	middle_name	claim.name
8feb361e-8d04-4d8c-8bce-de0210a8e9e9	String	jsonType.label
a545258b-cda6-4c70-92c9-0bde2ccafa24	true	userinfo.token.claim
a545258b-cda6-4c70-92c9-0bde2ccafa24	nickname	user.attribute
a545258b-cda6-4c70-92c9-0bde2ccafa24	true	id.token.claim
a545258b-cda6-4c70-92c9-0bde2ccafa24	true	access.token.claim
a545258b-cda6-4c70-92c9-0bde2ccafa24	nickname	claim.name
a545258b-cda6-4c70-92c9-0bde2ccafa24	String	jsonType.label
100c6690-dc45-4f0c-8de6-f9f636422077	true	userinfo.token.claim
100c6690-dc45-4f0c-8de6-f9f636422077	username	user.attribute
100c6690-dc45-4f0c-8de6-f9f636422077	true	id.token.claim
100c6690-dc45-4f0c-8de6-f9f636422077	true	access.token.claim
100c6690-dc45-4f0c-8de6-f9f636422077	preferred_username	claim.name
100c6690-dc45-4f0c-8de6-f9f636422077	String	jsonType.label
24057746-01b6-4c6a-a77c-ee6fd2d50247	true	userinfo.token.claim
24057746-01b6-4c6a-a77c-ee6fd2d50247	profile	user.attribute
24057746-01b6-4c6a-a77c-ee6fd2d50247	true	id.token.claim
24057746-01b6-4c6a-a77c-ee6fd2d50247	true	access.token.claim
24057746-01b6-4c6a-a77c-ee6fd2d50247	profile	claim.name
24057746-01b6-4c6a-a77c-ee6fd2d50247	String	jsonType.label
b7d21ec0-f960-47fe-9c1b-cc778a0858ed	true	userinfo.token.claim
b7d21ec0-f960-47fe-9c1b-cc778a0858ed	picture	user.attribute
b7d21ec0-f960-47fe-9c1b-cc778a0858ed	true	id.token.claim
b7d21ec0-f960-47fe-9c1b-cc778a0858ed	true	access.token.claim
b7d21ec0-f960-47fe-9c1b-cc778a0858ed	picture	claim.name
b7d21ec0-f960-47fe-9c1b-cc778a0858ed	String	jsonType.label
028bc6c9-ed8a-4db9-9fa1-748331803be2	true	userinfo.token.claim
028bc6c9-ed8a-4db9-9fa1-748331803be2	website	user.attribute
028bc6c9-ed8a-4db9-9fa1-748331803be2	true	id.token.claim
028bc6c9-ed8a-4db9-9fa1-748331803be2	true	access.token.claim
028bc6c9-ed8a-4db9-9fa1-748331803be2	website	claim.name
028bc6c9-ed8a-4db9-9fa1-748331803be2	String	jsonType.label
3dd25cb8-334f-448b-9a77-289a7ab11536	true	userinfo.token.claim
3dd25cb8-334f-448b-9a77-289a7ab11536	gender	user.attribute
3dd25cb8-334f-448b-9a77-289a7ab11536	true	id.token.claim
3dd25cb8-334f-448b-9a77-289a7ab11536	true	access.token.claim
3dd25cb8-334f-448b-9a77-289a7ab11536	gender	claim.name
3dd25cb8-334f-448b-9a77-289a7ab11536	String	jsonType.label
65d48372-1585-4d51-8856-621af25a548e	true	userinfo.token.claim
65d48372-1585-4d51-8856-621af25a548e	birthdate	user.attribute
65d48372-1585-4d51-8856-621af25a548e	true	id.token.claim
65d48372-1585-4d51-8856-621af25a548e	true	access.token.claim
65d48372-1585-4d51-8856-621af25a548e	birthdate	claim.name
65d48372-1585-4d51-8856-621af25a548e	String	jsonType.label
a59a5a74-a795-4f89-9a67-8b6be1436da2	true	userinfo.token.claim
a59a5a74-a795-4f89-9a67-8b6be1436da2	zoneinfo	user.attribute
a59a5a74-a795-4f89-9a67-8b6be1436da2	true	id.token.claim
a59a5a74-a795-4f89-9a67-8b6be1436da2	true	access.token.claim
a59a5a74-a795-4f89-9a67-8b6be1436da2	zoneinfo	claim.name
a59a5a74-a795-4f89-9a67-8b6be1436da2	String	jsonType.label
436aaf31-2fcd-4e7a-ad21-da9395c82da9	true	userinfo.token.claim
436aaf31-2fcd-4e7a-ad21-da9395c82da9	locale	user.attribute
436aaf31-2fcd-4e7a-ad21-da9395c82da9	true	id.token.claim
436aaf31-2fcd-4e7a-ad21-da9395c82da9	true	access.token.claim
436aaf31-2fcd-4e7a-ad21-da9395c82da9	locale	claim.name
436aaf31-2fcd-4e7a-ad21-da9395c82da9	String	jsonType.label
3e79be3b-c580-486d-967d-4c17733790be	true	userinfo.token.claim
3e79be3b-c580-486d-967d-4c17733790be	updatedAt	user.attribute
3e79be3b-c580-486d-967d-4c17733790be	true	id.token.claim
3e79be3b-c580-486d-967d-4c17733790be	true	access.token.claim
3e79be3b-c580-486d-967d-4c17733790be	updated_at	claim.name
3e79be3b-c580-486d-967d-4c17733790be	String	jsonType.label
508d1fd2-bae0-4dbe-becc-1303c6461b6b	true	userinfo.token.claim
508d1fd2-bae0-4dbe-becc-1303c6461b6b	email	user.attribute
508d1fd2-bae0-4dbe-becc-1303c6461b6b	true	id.token.claim
508d1fd2-bae0-4dbe-becc-1303c6461b6b	true	access.token.claim
508d1fd2-bae0-4dbe-becc-1303c6461b6b	email	claim.name
508d1fd2-bae0-4dbe-becc-1303c6461b6b	String	jsonType.label
44c76e41-a0d3-4bb2-aff6-4e8fbde43eef	true	userinfo.token.claim
44c76e41-a0d3-4bb2-aff6-4e8fbde43eef	emailVerified	user.attribute
44c76e41-a0d3-4bb2-aff6-4e8fbde43eef	true	id.token.claim
44c76e41-a0d3-4bb2-aff6-4e8fbde43eef	true	access.token.claim
44c76e41-a0d3-4bb2-aff6-4e8fbde43eef	email_verified	claim.name
44c76e41-a0d3-4bb2-aff6-4e8fbde43eef	boolean	jsonType.label
4242bb8e-efa0-4390-86a5-1e0fd1f9730e	formatted	user.attribute.formatted
4242bb8e-efa0-4390-86a5-1e0fd1f9730e	country	user.attribute.country
4242bb8e-efa0-4390-86a5-1e0fd1f9730e	postal_code	user.attribute.postal_code
4242bb8e-efa0-4390-86a5-1e0fd1f9730e	true	userinfo.token.claim
4242bb8e-efa0-4390-86a5-1e0fd1f9730e	street	user.attribute.street
4242bb8e-efa0-4390-86a5-1e0fd1f9730e	true	id.token.claim
4242bb8e-efa0-4390-86a5-1e0fd1f9730e	region	user.attribute.region
4242bb8e-efa0-4390-86a5-1e0fd1f9730e	true	access.token.claim
4242bb8e-efa0-4390-86a5-1e0fd1f9730e	locality	user.attribute.locality
cbccfe30-f072-4c82-8f0e-36642702dcc6	true	userinfo.token.claim
cbccfe30-f072-4c82-8f0e-36642702dcc6	phoneNumber	user.attribute
cbccfe30-f072-4c82-8f0e-36642702dcc6	true	id.token.claim
cbccfe30-f072-4c82-8f0e-36642702dcc6	true	access.token.claim
cbccfe30-f072-4c82-8f0e-36642702dcc6	phone_number	claim.name
cbccfe30-f072-4c82-8f0e-36642702dcc6	String	jsonType.label
8eec666c-1974-4c27-8676-d25e7919b67f	true	userinfo.token.claim
8eec666c-1974-4c27-8676-d25e7919b67f	phoneNumberVerified	user.attribute
8eec666c-1974-4c27-8676-d25e7919b67f	true	id.token.claim
8eec666c-1974-4c27-8676-d25e7919b67f	true	access.token.claim
8eec666c-1974-4c27-8676-d25e7919b67f	phone_number_verified	claim.name
8eec666c-1974-4c27-8676-d25e7919b67f	boolean	jsonType.label
f35e65e3-e958-4f0b-a35f-31b3081dd1f8	true	multivalued
f35e65e3-e958-4f0b-a35f-31b3081dd1f8	foo	user.attribute
f35e65e3-e958-4f0b-a35f-31b3081dd1f8	true	access.token.claim
f35e65e3-e958-4f0b-a35f-31b3081dd1f8	realm_access.roles	claim.name
f35e65e3-e958-4f0b-a35f-31b3081dd1f8	String	jsonType.label
631df30f-7777-48ec-af18-3dab14aa5f51	true	multivalued
631df30f-7777-48ec-af18-3dab14aa5f51	foo	user.attribute
631df30f-7777-48ec-af18-3dab14aa5f51	true	access.token.claim
631df30f-7777-48ec-af18-3dab14aa5f51	resource_access.${client_id}.roles	claim.name
631df30f-7777-48ec-af18-3dab14aa5f51	String	jsonType.label
01db4b5f-dc45-4681-a693-66c088ee3c45	true	userinfo.token.claim
01db4b5f-dc45-4681-a693-66c088ee3c45	username	user.attribute
01db4b5f-dc45-4681-a693-66c088ee3c45	true	id.token.claim
01db4b5f-dc45-4681-a693-66c088ee3c45	true	access.token.claim
01db4b5f-dc45-4681-a693-66c088ee3c45	upn	claim.name
01db4b5f-dc45-4681-a693-66c088ee3c45	String	jsonType.label
bdb3e2c3-80af-4598-ad01-3d434a6174cc	true	multivalued
bdb3e2c3-80af-4598-ad01-3d434a6174cc	foo	user.attribute
bdb3e2c3-80af-4598-ad01-3d434a6174cc	true	id.token.claim
bdb3e2c3-80af-4598-ad01-3d434a6174cc	true	access.token.claim
bdb3e2c3-80af-4598-ad01-3d434a6174cc	groups	claim.name
bdb3e2c3-80af-4598-ad01-3d434a6174cc	String	jsonType.label
6896dbf2-8ded-4933-a98e-6a148a835e96	false	single
6896dbf2-8ded-4933-a98e-6a148a835e96	Basic	attribute.nameformat
6896dbf2-8ded-4933-a98e-6a148a835e96	Role	attribute.name
700eb412-f80c-42ef-a0a0-350f8578274a	true	userinfo.token.claim
700eb412-f80c-42ef-a0a0-350f8578274a	true	id.token.claim
700eb412-f80c-42ef-a0a0-350f8578274a	true	access.token.claim
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	true	userinfo.token.claim
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	lastName	user.attribute
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	true	id.token.claim
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	true	access.token.claim
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	family_name	claim.name
71e10fef-e3f4-4e85-b1bf-fdbaa52626cb	String	jsonType.label
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	true	userinfo.token.claim
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	firstName	user.attribute
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	true	id.token.claim
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	true	access.token.claim
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	given_name	claim.name
a1d1e466-a6ba-4d91-a07b-4de1a91fdebe	String	jsonType.label
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	true	userinfo.token.claim
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	middleName	user.attribute
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	true	id.token.claim
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	true	access.token.claim
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	middle_name	claim.name
f36b9c7e-e5ec-4c53-9b38-8873da2a1f67	String	jsonType.label
d079a677-f367-4e6a-92e2-d32d2c03ff12	true	userinfo.token.claim
d079a677-f367-4e6a-92e2-d32d2c03ff12	nickname	user.attribute
d079a677-f367-4e6a-92e2-d32d2c03ff12	true	id.token.claim
d079a677-f367-4e6a-92e2-d32d2c03ff12	true	access.token.claim
d079a677-f367-4e6a-92e2-d32d2c03ff12	nickname	claim.name
d079a677-f367-4e6a-92e2-d32d2c03ff12	String	jsonType.label
79009f2e-12cf-4022-ab87-070d418d6a17	true	userinfo.token.claim
79009f2e-12cf-4022-ab87-070d418d6a17	username	user.attribute
79009f2e-12cf-4022-ab87-070d418d6a17	true	id.token.claim
79009f2e-12cf-4022-ab87-070d418d6a17	true	access.token.claim
79009f2e-12cf-4022-ab87-070d418d6a17	preferred_username	claim.name
79009f2e-12cf-4022-ab87-070d418d6a17	String	jsonType.label
7c97b048-915e-4742-8879-6e28b457f014	true	userinfo.token.claim
7c97b048-915e-4742-8879-6e28b457f014	profile	user.attribute
7c97b048-915e-4742-8879-6e28b457f014	true	id.token.claim
7c97b048-915e-4742-8879-6e28b457f014	true	access.token.claim
7c97b048-915e-4742-8879-6e28b457f014	profile	claim.name
7c97b048-915e-4742-8879-6e28b457f014	String	jsonType.label
1fbe377f-b45d-43cc-9272-a539bc656e2d	true	userinfo.token.claim
1fbe377f-b45d-43cc-9272-a539bc656e2d	picture	user.attribute
1fbe377f-b45d-43cc-9272-a539bc656e2d	true	id.token.claim
1fbe377f-b45d-43cc-9272-a539bc656e2d	true	access.token.claim
1fbe377f-b45d-43cc-9272-a539bc656e2d	picture	claim.name
1fbe377f-b45d-43cc-9272-a539bc656e2d	String	jsonType.label
d2405431-6415-4547-9cbf-6ad491b4f851	true	userinfo.token.claim
d2405431-6415-4547-9cbf-6ad491b4f851	website	user.attribute
d2405431-6415-4547-9cbf-6ad491b4f851	true	id.token.claim
d2405431-6415-4547-9cbf-6ad491b4f851	true	access.token.claim
d2405431-6415-4547-9cbf-6ad491b4f851	website	claim.name
d2405431-6415-4547-9cbf-6ad491b4f851	String	jsonType.label
5268821b-7d20-46ba-8a4f-05793c43269b	true	userinfo.token.claim
5268821b-7d20-46ba-8a4f-05793c43269b	gender	user.attribute
5268821b-7d20-46ba-8a4f-05793c43269b	true	id.token.claim
5268821b-7d20-46ba-8a4f-05793c43269b	true	access.token.claim
5268821b-7d20-46ba-8a4f-05793c43269b	gender	claim.name
5268821b-7d20-46ba-8a4f-05793c43269b	String	jsonType.label
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	true	userinfo.token.claim
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	birthdate	user.attribute
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	true	id.token.claim
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	true	access.token.claim
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	birthdate	claim.name
f4e376cf-2dcf-4a9d-a1ea-8a735bbb9b02	String	jsonType.label
45f4de79-9096-4dbd-bd4a-957d40bbe01f	true	userinfo.token.claim
45f4de79-9096-4dbd-bd4a-957d40bbe01f	zoneinfo	user.attribute
45f4de79-9096-4dbd-bd4a-957d40bbe01f	true	id.token.claim
45f4de79-9096-4dbd-bd4a-957d40bbe01f	true	access.token.claim
45f4de79-9096-4dbd-bd4a-957d40bbe01f	zoneinfo	claim.name
45f4de79-9096-4dbd-bd4a-957d40bbe01f	String	jsonType.label
4bbfe834-87d2-4a04-a079-d0e4206cc406	true	userinfo.token.claim
4bbfe834-87d2-4a04-a079-d0e4206cc406	locale	user.attribute
4bbfe834-87d2-4a04-a079-d0e4206cc406	true	id.token.claim
4bbfe834-87d2-4a04-a079-d0e4206cc406	true	access.token.claim
4bbfe834-87d2-4a04-a079-d0e4206cc406	locale	claim.name
4bbfe834-87d2-4a04-a079-d0e4206cc406	String	jsonType.label
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	true	userinfo.token.claim
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	updatedAt	user.attribute
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	true	id.token.claim
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	true	access.token.claim
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	updated_at	claim.name
55dd7fdb-0a6e-4afe-8f96-5e78bbb3e3e8	String	jsonType.label
23cba6c0-9ade-4921-92d3-0edb9d671f0f	true	userinfo.token.claim
23cba6c0-9ade-4921-92d3-0edb9d671f0f	email	user.attribute
23cba6c0-9ade-4921-92d3-0edb9d671f0f	true	id.token.claim
23cba6c0-9ade-4921-92d3-0edb9d671f0f	true	access.token.claim
23cba6c0-9ade-4921-92d3-0edb9d671f0f	email	claim.name
23cba6c0-9ade-4921-92d3-0edb9d671f0f	String	jsonType.label
96197993-2e17-477a-bced-9971caffbfab	true	userinfo.token.claim
96197993-2e17-477a-bced-9971caffbfab	emailVerified	user.attribute
96197993-2e17-477a-bced-9971caffbfab	true	id.token.claim
96197993-2e17-477a-bced-9971caffbfab	true	access.token.claim
96197993-2e17-477a-bced-9971caffbfab	email_verified	claim.name
96197993-2e17-477a-bced-9971caffbfab	boolean	jsonType.label
1be633bc-17d6-44f9-b5d9-161c6277a62e	formatted	user.attribute.formatted
1be633bc-17d6-44f9-b5d9-161c6277a62e	country	user.attribute.country
1be633bc-17d6-44f9-b5d9-161c6277a62e	postal_code	user.attribute.postal_code
1be633bc-17d6-44f9-b5d9-161c6277a62e	true	userinfo.token.claim
1be633bc-17d6-44f9-b5d9-161c6277a62e	street	user.attribute.street
1be633bc-17d6-44f9-b5d9-161c6277a62e	true	id.token.claim
1be633bc-17d6-44f9-b5d9-161c6277a62e	region	user.attribute.region
1be633bc-17d6-44f9-b5d9-161c6277a62e	true	access.token.claim
1be633bc-17d6-44f9-b5d9-161c6277a62e	locality	user.attribute.locality
28f94d9d-d8cd-4b53-ad7b-308fd186f739	true	userinfo.token.claim
28f94d9d-d8cd-4b53-ad7b-308fd186f739	phoneNumber	user.attribute
28f94d9d-d8cd-4b53-ad7b-308fd186f739	true	id.token.claim
28f94d9d-d8cd-4b53-ad7b-308fd186f739	true	access.token.claim
28f94d9d-d8cd-4b53-ad7b-308fd186f739	phone_number	claim.name
28f94d9d-d8cd-4b53-ad7b-308fd186f739	String	jsonType.label
7d712ea3-b357-4a6b-a8dc-79c6189cf517	true	userinfo.token.claim
7d712ea3-b357-4a6b-a8dc-79c6189cf517	phoneNumberVerified	user.attribute
7d712ea3-b357-4a6b-a8dc-79c6189cf517	true	id.token.claim
7d712ea3-b357-4a6b-a8dc-79c6189cf517	true	access.token.claim
7d712ea3-b357-4a6b-a8dc-79c6189cf517	phone_number_verified	claim.name
7d712ea3-b357-4a6b-a8dc-79c6189cf517	boolean	jsonType.label
9f437a33-577a-428e-814b-7b895c67addc	true	multivalued
9f437a33-577a-428e-814b-7b895c67addc	foo	user.attribute
9f437a33-577a-428e-814b-7b895c67addc	true	access.token.claim
9f437a33-577a-428e-814b-7b895c67addc	realm_access.roles	claim.name
9f437a33-577a-428e-814b-7b895c67addc	String	jsonType.label
b27919bf-df5f-463a-a91b-cfcde4580de7	true	multivalued
b27919bf-df5f-463a-a91b-cfcde4580de7	foo	user.attribute
b27919bf-df5f-463a-a91b-cfcde4580de7	true	access.token.claim
b27919bf-df5f-463a-a91b-cfcde4580de7	resource_access.${client_id}.roles	claim.name
b27919bf-df5f-463a-a91b-cfcde4580de7	String	jsonType.label
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	true	userinfo.token.claim
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	username	user.attribute
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	true	id.token.claim
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	true	access.token.claim
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	upn	claim.name
22f6e1df-29c3-4ca6-9d2f-fc666e3c296f	String	jsonType.label
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	true	multivalued
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	foo	user.attribute
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	true	id.token.claim
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	true	access.token.claim
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	groups	claim.name
d7e3ac96-3eec-4fa5-9c80-1ea8b6b54b6d	String	jsonType.label
92d38df7-7473-491e-b132-f78748a23de6	true	userinfo.token.claim
92d38df7-7473-491e-b132-f78748a23de6	locale	user.attribute
92d38df7-7473-491e-b132-f78748a23de6	true	id.token.claim
92d38df7-7473-491e-b132-f78748a23de6	true	access.token.claim
92d38df7-7473-491e-b132-f78748a23de6	locale	claim.name
92d38df7-7473-491e-b132-f78748a23de6	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	c950d556-3e66-49b3-9c82-2d4063f0325a	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	8c782ee1-54ab-4b5c-a5ec-d952a6e1f3cb	4119c649-701e-4a9d-b7b1-1d1165a51537	82d5a563-b26a-461d-8c76-35811de00686	f2dc59e8-bc3e-47b0-8216-f693782da99e	a16b9bc2-5015-416a-8882-453ac64b58cc	2592000	f	900	t	f	13a6a25d-9d02-406b-b294-58e90219d5d4	0	f	0	0	eb8a571c-62ac-448a-b8de-48476a92c0fe
easybackend	60	300	300	\N	\N	\N	t	f	0	\N	easybackend	0	\N	f	f	f	f	NONE	1800	36000	f	f	7749e2fc-153f-452f-b3f4-809118805993	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	5645bc6c-fa10-4d3a-8a5e-90edb66812df	ef83c91d-ea85-4006-b2ac-82de40f1aa80	44312ed3-3e5d-45a8-af11-f173acb9e155	a0f68b61-5c4e-43a5-921a-a557b5a52364	4892e224-ef69-401b-af1d-f31c9d1f1c90	2592000	f	900	t	f	f1bcb849-e5ee-401f-b8cc-ac3d145726d8	0	f	0	0	780b83c6-426a-4bb4-9fe9-a6dadcb51044
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
oauth2DeviceCodeLifespan	easybackend	600
oauth2DevicePollingInterval	easybackend	5
cibaBackchannelTokenDeliveryMode	easybackend	poll
cibaExpiresIn	easybackend	120
cibaInterval	easybackend	5
cibaAuthRequestedUserHint	easybackend	login_hint
parRequestUriLifespan	easybackend	60
userProfileEnabled	easybackend	false
frontendUrl	easybackend	http://eb-keycloak:8080/auth
clientSessionIdleTimeout	easybackend	0
clientSessionMaxLifespan	easybackend	0
clientOfflineSessionIdleTimeout	easybackend	0
clientOfflineSessionMaxLifespan	easybackend	0
bruteForceProtected	easybackend	false
permanentLockout	easybackend	false
maxFailureWaitSeconds	easybackend	900
minimumQuickLoginWaitSeconds	easybackend	60
waitIncrementSeconds	easybackend	60
quickLoginCheckMilliSeconds	easybackend	1000
maxDeltaTimeSeconds	easybackend	43200
failureFactor	easybackend	30
actionTokenGeneratedByAdminLifespan	easybackend	43200
actionTokenGeneratedByUserLifespan	easybackend	300
defaultSignatureAlgorithm	easybackend	RS256
offlineSessionMaxLifespanEnabled	easybackend	false
offlineSessionMaxLifespan	easybackend	5184000
webAuthnPolicyRpEntityName	easybackend	keycloak
webAuthnPolicySignatureAlgorithms	easybackend	ES256
webAuthnPolicyRpId	easybackend	
webAuthnPolicyAttestationConveyancePreference	easybackend	not specified
webAuthnPolicyAuthenticatorAttachment	easybackend	not specified
webAuthnPolicyRequireResidentKey	easybackend	not specified
webAuthnPolicyUserVerificationRequirement	easybackend	not specified
webAuthnPolicyCreateTimeout	easybackend	0
webAuthnPolicyAvoidSameAuthenticatorRegister	easybackend	false
webAuthnPolicyRpEntityNamePasswordless	easybackend	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	easybackend	ES256
webAuthnPolicyRpIdPasswordless	easybackend	
webAuthnPolicyAttestationConveyancePreferencePasswordless	easybackend	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	easybackend	not specified
webAuthnPolicyRequireResidentKeyPasswordless	easybackend	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	easybackend	not specified
webAuthnPolicyCreateTimeoutPasswordless	easybackend	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	easybackend	false
client-policies.profiles	easybackend	{"profiles":[]}
client-policies.policies	easybackend	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	easybackend	
_browser_header.xContentTypeOptions	easybackend	nosniff
_browser_header.xRobotsTag	easybackend	none
_browser_header.xFrameOptions	easybackend	SAMEORIGIN
_browser_header.contentSecurityPolicy	easybackend	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	easybackend	1; mode=block
_browser_header.strictTransportSecurity	easybackend	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
easybackend	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	easybackend
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
c9650e94-0f17-45a9-89d7-aa1598d01650	/realms/master/account/*
b210e7d3-a550-4903-b4e0-29a0a2fc26d8	/realms/master/account/*
8b33fe4c-8c10-4ea3-9e3a-22e68d3ee954	/admin/master/console/*
544e5eb0-3d17-4823-a9af-f15e289f63bc	/realms/easybackend/account/*
4f8b866a-cccf-4fe0-b2fb-72261ea37634	/realms/easybackend/account/*
0c1072d0-fbe2-4759-9c08-a399a7faa47b	/admin/easybackend/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
634df24e-a56f-4f7b-b7b5-882496a56fab	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
8cc34048-2175-408e-918f-9ea2dc6200cf	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
ef41bed6-20b9-48ff-bb3a-539ad803c39a	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
d3346cf8-ae6a-4c7f-8fea-bb8bd18f7a4a	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
42966d1a-f8b9-417a-b2b3-d77d1c2397f1	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
6ef30485-62f7-43dc-845b-a26cc55e6c3f	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
f346498f-8201-44c0-8d9b-68db246e1ec7	delete_account	Delete Account	master	f	f	delete_account	60
639fc230-cf8d-49e5-8b8d-6db4bd986096	VERIFY_EMAIL	Verify Email	easybackend	t	f	VERIFY_EMAIL	50
162b8e2d-9e9b-41e9-bb36-ad39358cb63d	UPDATE_PROFILE	Update Profile	easybackend	t	f	UPDATE_PROFILE	40
365eb3c1-fe59-482b-8cdf-2b968a034edc	CONFIGURE_TOTP	Configure OTP	easybackend	t	f	CONFIGURE_TOTP	10
bab11fa5-9348-4d49-87a6-46bc0e9df4ec	UPDATE_PASSWORD	Update Password	easybackend	t	f	UPDATE_PASSWORD	30
6d79b74b-f67d-4e21-a353-bf9ea7a13e8c	terms_and_conditions	Terms and Conditions	easybackend	f	f	terms_and_conditions	20
f58ffb27-2ecf-4cab-acef-a8e9d1222ff3	update_user_locale	Update User Locale	easybackend	t	f	update_user_locale	1000
ede444b9-4fe2-4802-97a9-34c85ea864f3	delete_account	Delete Account	easybackend	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
b210e7d3-a550-4903-b4e0-29a0a2fc26d8	e788fdd0-3c3c-42d7-b9c6-cfd1a7c74e08
4f8b866a-cccf-4fe0-b2fb-72261ea37634	78c089cd-fe4e-4575-aa38-768840bfe270
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
ef457bb2-92d4-452c-934c-9c06092a28f2	\N	6f63f163-8cae-4f33-93ff-6bdc84356a5f	f	t	\N	\N	\N	master	admin	1663334499507	\N	0
eca39438-43e1-42dd-bae0-17cb29343322	easysmpc.dev0@insutec.de	easysmpc.dev0@insutec.de	f	t	\N	\N	\N	easybackend	easysmpc.dev0	1663334710258	\N	0
4cf81e1c-8bc6-4985-90a6-9b0a4982131e	easysmpc.dev1@insutec.de	easysmpc.dev1@insutec.de	f	t	\N	\N	\N	easybackend	easysmpc.dev1	1663335080457	\N	0
18da88ed-b8be-4822-a9a3-82617eca4d23	easysmpc.dev2@insutec.de	easysmpc.dev2@insutec.de	f	t	\N	\N	\N	easybackend	easysmpc.dev2	1663335123428	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
eb8a571c-62ac-448a-b8de-48476a92c0fe	ef457bb2-92d4-452c-934c-9c06092a28f2
6162e132-1e18-40d3-9f2d-d0c2d58bbee0	ef457bb2-92d4-452c-934c-9c06092a28f2
f2f32605-2446-458e-a14f-8640cec8ccca	ef457bb2-92d4-452c-934c-9c06092a28f2
3de7f094-2cfc-48ae-b42c-bff55985b159	ef457bb2-92d4-452c-934c-9c06092a28f2
2a48c97b-01e1-47d3-a142-37786bb30f3d	ef457bb2-92d4-452c-934c-9c06092a28f2
12a8953e-8fcf-476b-abdc-85794317ea03	ef457bb2-92d4-452c-934c-9c06092a28f2
6a632034-57b0-4d2e-9484-04c8b15e4ae0	ef457bb2-92d4-452c-934c-9c06092a28f2
7633dc22-c98c-48b9-8b18-9e0c6b97709f	ef457bb2-92d4-452c-934c-9c06092a28f2
ab68d43b-760d-4b40-a923-765214446eb7	ef457bb2-92d4-452c-934c-9c06092a28f2
5d1f9674-511e-41f0-ba98-374389c58a75	ef457bb2-92d4-452c-934c-9c06092a28f2
8e134600-4c7f-4177-a679-5bc5d2698da7	ef457bb2-92d4-452c-934c-9c06092a28f2
31f1b680-0fe8-4919-9dcb-6d0a22bf1a80	ef457bb2-92d4-452c-934c-9c06092a28f2
013a475c-8f0d-4ed2-9a58-968f710d3f51	ef457bb2-92d4-452c-934c-9c06092a28f2
6dedd6d0-4236-48cb-a0c2-768dbfb806bb	ef457bb2-92d4-452c-934c-9c06092a28f2
496c5d8b-fcbc-4219-8aeb-b511efe1e611	ef457bb2-92d4-452c-934c-9c06092a28f2
23710f8f-b4fb-4263-80e4-bed6a30c76f7	ef457bb2-92d4-452c-934c-9c06092a28f2
dc6cf952-6c46-4b82-b50b-fbae13aadcb6	ef457bb2-92d4-452c-934c-9c06092a28f2
c9977e11-b8a2-4321-a62b-93d8741e27ae	ef457bb2-92d4-452c-934c-9c06092a28f2
ea5dbcb7-ded7-4979-8d0c-4f7e52f96c3a	ef457bb2-92d4-452c-934c-9c06092a28f2
780b83c6-426a-4bb4-9fe9-a6dadcb51044	eca39438-43e1-42dd-bae0-17cb29343322
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	eca39438-43e1-42dd-bae0-17cb29343322
780b83c6-426a-4bb4-9fe9-a6dadcb51044	4cf81e1c-8bc6-4985-90a6-9b0a4982131e
780b83c6-426a-4bb4-9fe9-a6dadcb51044	18da88ed-b8be-4822-a9a3-82617eca4d23
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	18da88ed-b8be-4822-a9a3-82617eca4d23
2a7cdfe6-7ff2-4d49-ba6d-3b747df285a6	4cf81e1c-8bc6-4985-90a6-9b0a4982131e
72ba495b-3d6e-4940-a167-60b769f2f5dc	eca39438-43e1-42dd-bae0-17cb29343322
72ba495b-3d6e-4940-a167-60b769f2f5dc	4cf81e1c-8bc6-4985-90a6-9b0a4982131e
72ba495b-3d6e-4940-a167-60b769f2f5dc	18da88ed-b8be-4822-a9a3-82617eca4d23
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
8b33fe4c-8c10-4ea3-9e3a-22e68d3ee954	+
0c1072d0-fbe2-4759-9c08-a399a7faa47b	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

