--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Debian 16.9-1.pgdg120+1)
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
-- SET transaction_timeout = 0;
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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
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
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
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
    priority integer,
    version integer DEFAULT 0
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
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
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
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
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: org; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO keycloak;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: server_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.server_config (
    server_config_key character varying(255) NOT NULL,
    value text NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.server_config OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
1b004ab7-d40f-42b2-8b44-53d87ac39563	\N	auth-cookie	7f4bc72e-99dc-4684-8265-a601599a1fb1	eefee08a-636c-42c7-a4a4-5b87e90cead4	2	10	f	\N	\N
131ee479-b0f0-4190-8193-f92f69d20016	\N	auth-spnego	7f4bc72e-99dc-4684-8265-a601599a1fb1	eefee08a-636c-42c7-a4a4-5b87e90cead4	3	20	f	\N	\N
0ecd6679-5a0b-49b5-af73-3ee67cbe5a75	\N	identity-provider-redirector	7f4bc72e-99dc-4684-8265-a601599a1fb1	eefee08a-636c-42c7-a4a4-5b87e90cead4	2	25	f	\N	\N
b8e5a8f7-eff4-4243-9a66-da407ba6c028	\N	\N	7f4bc72e-99dc-4684-8265-a601599a1fb1	eefee08a-636c-42c7-a4a4-5b87e90cead4	2	30	t	f79ff7a6-4aa1-409a-950c-9d7a977bd432	\N
9060fe53-01f2-4237-b0b7-498c76fb3767	\N	auth-username-password-form	7f4bc72e-99dc-4684-8265-a601599a1fb1	f79ff7a6-4aa1-409a-950c-9d7a977bd432	0	10	f	\N	\N
dab76f66-a21f-44e0-961a-9d75f6183e1b	\N	\N	7f4bc72e-99dc-4684-8265-a601599a1fb1	f79ff7a6-4aa1-409a-950c-9d7a977bd432	1	20	t	78e89e5f-87a1-4670-9472-c0bd097e2434	\N
3a157b04-9407-4393-943e-ab4d4c9b649b	\N	conditional-user-configured	7f4bc72e-99dc-4684-8265-a601599a1fb1	78e89e5f-87a1-4670-9472-c0bd097e2434	0	10	f	\N	\N
d0138a91-5523-4028-920e-7468cc13771b	\N	auth-otp-form	7f4bc72e-99dc-4684-8265-a601599a1fb1	78e89e5f-87a1-4670-9472-c0bd097e2434	0	20	f	\N	\N
d5ce1fc6-b204-4e16-8f8f-a0b3bfe32359	\N	direct-grant-validate-username	7f4bc72e-99dc-4684-8265-a601599a1fb1	50fc651b-ea1c-49f7-b056-600b9a1b408e	0	10	f	\N	\N
e2cbee16-7315-4c29-86cf-39166f2c874f	\N	direct-grant-validate-password	7f4bc72e-99dc-4684-8265-a601599a1fb1	50fc651b-ea1c-49f7-b056-600b9a1b408e	0	20	f	\N	\N
2cd41896-9716-4316-ad54-431be6dbe2eb	\N	\N	7f4bc72e-99dc-4684-8265-a601599a1fb1	50fc651b-ea1c-49f7-b056-600b9a1b408e	1	30	t	1caa1918-aa5a-42b0-a505-0984641c408e	\N
33375f48-8d48-4086-90f9-f4d97d3f4d45	\N	conditional-user-configured	7f4bc72e-99dc-4684-8265-a601599a1fb1	1caa1918-aa5a-42b0-a505-0984641c408e	0	10	f	\N	\N
2adf0869-22f1-4ea6-9504-445da434fe86	\N	direct-grant-validate-otp	7f4bc72e-99dc-4684-8265-a601599a1fb1	1caa1918-aa5a-42b0-a505-0984641c408e	0	20	f	\N	\N
ed9e1316-eecb-47d3-8bb4-540eb5b93b3d	\N	registration-page-form	7f4bc72e-99dc-4684-8265-a601599a1fb1	474f4f28-b911-4c57-bde4-757c5fcd8bd4	0	10	t	59d4b85a-5f75-42cc-995e-5e9dfefb8a89	\N
ffc19414-32dc-4d1b-9eb7-f7762bcc223a	\N	registration-user-creation	7f4bc72e-99dc-4684-8265-a601599a1fb1	59d4b85a-5f75-42cc-995e-5e9dfefb8a89	0	20	f	\N	\N
33010f96-f5bf-440a-8f38-9bb30e116d12	\N	registration-password-action	7f4bc72e-99dc-4684-8265-a601599a1fb1	59d4b85a-5f75-42cc-995e-5e9dfefb8a89	0	50	f	\N	\N
e89b355e-f3bb-49cb-96bf-3f7b4357ee8c	\N	registration-recaptcha-action	7f4bc72e-99dc-4684-8265-a601599a1fb1	59d4b85a-5f75-42cc-995e-5e9dfefb8a89	3	60	f	\N	\N
3a2a7eb0-6ca3-4cd5-8674-4eeb353ce5f9	\N	registration-terms-and-conditions	7f4bc72e-99dc-4684-8265-a601599a1fb1	59d4b85a-5f75-42cc-995e-5e9dfefb8a89	3	70	f	\N	\N
8bbdeee9-3a09-43de-bfaa-7b73be167865	\N	reset-credentials-choose-user	7f4bc72e-99dc-4684-8265-a601599a1fb1	4f4af586-e775-47e0-9902-f6b4df6a87d4	0	10	f	\N	\N
dc4599bc-8abd-43b4-a4ec-5aaef0226a0c	\N	reset-credential-email	7f4bc72e-99dc-4684-8265-a601599a1fb1	4f4af586-e775-47e0-9902-f6b4df6a87d4	0	20	f	\N	\N
f41a1b53-6ead-4266-b906-d0006388f6d0	\N	reset-password	7f4bc72e-99dc-4684-8265-a601599a1fb1	4f4af586-e775-47e0-9902-f6b4df6a87d4	0	30	f	\N	\N
a6905d7c-875b-4862-a41e-a1147cf0190e	\N	\N	7f4bc72e-99dc-4684-8265-a601599a1fb1	4f4af586-e775-47e0-9902-f6b4df6a87d4	1	40	t	c9a2ed5b-5ed4-407d-aa38-bd7f29366ee3	\N
3f69f5fb-4642-476d-8c9a-6fa334d2bf04	\N	conditional-user-configured	7f4bc72e-99dc-4684-8265-a601599a1fb1	c9a2ed5b-5ed4-407d-aa38-bd7f29366ee3	0	10	f	\N	\N
7a9a6535-6a03-40db-8f97-2af664748ae7	\N	reset-otp	7f4bc72e-99dc-4684-8265-a601599a1fb1	c9a2ed5b-5ed4-407d-aa38-bd7f29366ee3	0	20	f	\N	\N
0f55f64e-f6a1-4119-aca0-907d88c1f101	\N	client-secret	7f4bc72e-99dc-4684-8265-a601599a1fb1	3b6d78fa-6e9e-44d2-a089-92159d0a8dd4	2	10	f	\N	\N
e9201ec7-ce2a-4db2-9711-199850c55090	\N	client-jwt	7f4bc72e-99dc-4684-8265-a601599a1fb1	3b6d78fa-6e9e-44d2-a089-92159d0a8dd4	2	20	f	\N	\N
8e61b42d-d1a1-4c14-88d5-93b3af0212da	\N	client-secret-jwt	7f4bc72e-99dc-4684-8265-a601599a1fb1	3b6d78fa-6e9e-44d2-a089-92159d0a8dd4	2	30	f	\N	\N
2b18390e-5227-4b3c-83e0-92bcbe175642	\N	client-x509	7f4bc72e-99dc-4684-8265-a601599a1fb1	3b6d78fa-6e9e-44d2-a089-92159d0a8dd4	2	40	f	\N	\N
9b6bfe20-68ec-4909-b9b6-6e1d3d3f0d9e	\N	idp-review-profile	7f4bc72e-99dc-4684-8265-a601599a1fb1	dbbdcc56-251a-4b08-b86d-c79390fc75c6	0	10	f	\N	177f48c7-5b7b-4409-9bee-880269963978
c876b656-4dc1-4be1-87d6-8b6e62a82651	\N	\N	7f4bc72e-99dc-4684-8265-a601599a1fb1	dbbdcc56-251a-4b08-b86d-c79390fc75c6	0	20	t	c5dfb477-e04d-4a61-ab16-66104aab2b2e	\N
f83a7d2f-c2a3-45b1-a6b4-cd4ae541b6fb	\N	idp-create-user-if-unique	7f4bc72e-99dc-4684-8265-a601599a1fb1	c5dfb477-e04d-4a61-ab16-66104aab2b2e	2	10	f	\N	cacd07cb-866b-4e70-a7c7-88a64c2aac55
ed509e9f-336c-49ba-a771-c62c684e4e23	\N	\N	7f4bc72e-99dc-4684-8265-a601599a1fb1	c5dfb477-e04d-4a61-ab16-66104aab2b2e	2	20	t	94afc43d-c783-4c45-a276-7df1078c2d08	\N
b7f7387d-e5b2-4b24-b224-86d3f8baac7f	\N	idp-confirm-link	7f4bc72e-99dc-4684-8265-a601599a1fb1	94afc43d-c783-4c45-a276-7df1078c2d08	0	10	f	\N	\N
c42b585b-18ef-4b7c-af6c-eed46f5da9b3	\N	\N	7f4bc72e-99dc-4684-8265-a601599a1fb1	94afc43d-c783-4c45-a276-7df1078c2d08	0	20	t	2098e0a6-7e49-4fbb-86ff-a20b4f21edb1	\N
5640fa7d-d5ee-4d81-9b2d-36ff4ee9a6b4	\N	idp-email-verification	7f4bc72e-99dc-4684-8265-a601599a1fb1	2098e0a6-7e49-4fbb-86ff-a20b4f21edb1	2	10	f	\N	\N
d8e74130-a909-44b6-a0dd-2cc8b3bb52d9	\N	\N	7f4bc72e-99dc-4684-8265-a601599a1fb1	2098e0a6-7e49-4fbb-86ff-a20b4f21edb1	2	20	t	c5a3a652-d87b-4ffd-a052-8245e99e3891	\N
eb1502f5-ef80-4927-8c26-9072df5badea	\N	idp-username-password-form	7f4bc72e-99dc-4684-8265-a601599a1fb1	c5a3a652-d87b-4ffd-a052-8245e99e3891	0	10	f	\N	\N
3a5c930b-a964-4d9d-b5b5-17aee494e7ff	\N	\N	7f4bc72e-99dc-4684-8265-a601599a1fb1	c5a3a652-d87b-4ffd-a052-8245e99e3891	1	20	t	0b8ac5e6-2cca-471a-aad6-6cd08ef7289f	\N
dd038441-7468-4ef4-a4bc-988e97d98c4e	\N	conditional-user-configured	7f4bc72e-99dc-4684-8265-a601599a1fb1	0b8ac5e6-2cca-471a-aad6-6cd08ef7289f	0	10	f	\N	\N
3241cbfc-5662-4ab0-92a3-b4914b561310	\N	auth-otp-form	7f4bc72e-99dc-4684-8265-a601599a1fb1	0b8ac5e6-2cca-471a-aad6-6cd08ef7289f	0	20	f	\N	\N
2ac80404-bdbf-4884-9a5c-68b8e804b5a7	\N	http-basic-authenticator	7f4bc72e-99dc-4684-8265-a601599a1fb1	7abe490b-42e8-4453-901a-d8f8746d53b5	0	10	f	\N	\N
9648aa8e-76ec-44b9-ba4f-e965eeb9b6ab	\N	docker-http-basic-authenticator	7f4bc72e-99dc-4684-8265-a601599a1fb1	20462a35-54f3-4544-bb04-63ef804eceac	0	10	f	\N	\N
5587849b-665f-4f6d-93ea-8e587965c9a6	\N	auth-cookie	d8293cec-b966-4170-8fed-d0f1f6161baa	d18ed81e-7306-4eae-83c3-6b234bc26150	2	10	f	\N	\N
30a7962a-c1fe-447b-a510-29ec6eee7cdc	\N	auth-spnego	d8293cec-b966-4170-8fed-d0f1f6161baa	d18ed81e-7306-4eae-83c3-6b234bc26150	3	20	f	\N	\N
55b58beb-d89a-4550-a024-cc8a3d303b21	\N	identity-provider-redirector	d8293cec-b966-4170-8fed-d0f1f6161baa	d18ed81e-7306-4eae-83c3-6b234bc26150	2	25	f	\N	\N
0eb2660d-5810-42f6-9a98-933f45821bbb	\N	\N	d8293cec-b966-4170-8fed-d0f1f6161baa	d18ed81e-7306-4eae-83c3-6b234bc26150	2	30	t	ccfd67f8-ec1e-41dd-bbfa-65ab3da92c1f	\N
0b7956e7-d625-4117-b664-d98eb56f4065	\N	auth-username-password-form	d8293cec-b966-4170-8fed-d0f1f6161baa	ccfd67f8-ec1e-41dd-bbfa-65ab3da92c1f	0	10	f	\N	\N
82738765-0df2-4d81-af57-b83e553b720f	\N	\N	d8293cec-b966-4170-8fed-d0f1f6161baa	ccfd67f8-ec1e-41dd-bbfa-65ab3da92c1f	1	20	t	d0a2969c-ffdc-4aa7-ac41-252427e77d2a	\N
ff60ace6-9bfc-431c-9c09-24058ea38bf7	\N	conditional-user-configured	d8293cec-b966-4170-8fed-d0f1f6161baa	d0a2969c-ffdc-4aa7-ac41-252427e77d2a	0	10	f	\N	\N
36c9f89a-d262-4c70-a1b6-a71b4e4bebe1	\N	auth-otp-form	d8293cec-b966-4170-8fed-d0f1f6161baa	d0a2969c-ffdc-4aa7-ac41-252427e77d2a	0	20	f	\N	\N
f851440b-2dd8-43ad-a3fa-0f45b7da520f	\N	\N	d8293cec-b966-4170-8fed-d0f1f6161baa	d18ed81e-7306-4eae-83c3-6b234bc26150	2	26	t	e9543969-0c04-4626-9fa1-af8dc41b8a21	\N
72931afc-1fd2-433a-89ba-2e38c04f4f35	\N	\N	d8293cec-b966-4170-8fed-d0f1f6161baa	e9543969-0c04-4626-9fa1-af8dc41b8a21	1	10	t	4db4d208-e0f9-4ab9-bf23-175f35d317e7	\N
15525813-e899-4346-bdd1-e5204883bf33	\N	conditional-user-configured	d8293cec-b966-4170-8fed-d0f1f6161baa	4db4d208-e0f9-4ab9-bf23-175f35d317e7	0	10	f	\N	\N
5c6c9e92-06a9-46ff-97c1-c133ef5f30b6	\N	organization	d8293cec-b966-4170-8fed-d0f1f6161baa	4db4d208-e0f9-4ab9-bf23-175f35d317e7	2	20	f	\N	\N
91b40841-f0a6-4e60-8e6d-92cc2e40405e	\N	direct-grant-validate-username	d8293cec-b966-4170-8fed-d0f1f6161baa	4aead574-73aa-4b76-9931-1d6e0346678a	0	10	f	\N	\N
f52a6ba0-e46c-4a3a-9522-aebc5f7af1da	\N	direct-grant-validate-password	d8293cec-b966-4170-8fed-d0f1f6161baa	4aead574-73aa-4b76-9931-1d6e0346678a	0	20	f	\N	\N
0736c2e0-b4e7-4de3-b6b2-23b0e0bd4887	\N	\N	d8293cec-b966-4170-8fed-d0f1f6161baa	4aead574-73aa-4b76-9931-1d6e0346678a	1	30	t	59538523-d934-4865-a227-c16df48e1eaa	\N
0f07b3c3-24b8-4c83-9057-059e729b574c	\N	conditional-user-configured	d8293cec-b966-4170-8fed-d0f1f6161baa	59538523-d934-4865-a227-c16df48e1eaa	0	10	f	\N	\N
e917998b-f341-4bf7-bb19-d9fa8fb2fa50	\N	direct-grant-validate-otp	d8293cec-b966-4170-8fed-d0f1f6161baa	59538523-d934-4865-a227-c16df48e1eaa	0	20	f	\N	\N
95bc7ae0-624b-4382-8db8-5acb9c6e6812	\N	registration-page-form	d8293cec-b966-4170-8fed-d0f1f6161baa	6d37a6fb-bd93-4ce3-bfaa-565b7cb64380	0	10	t	f899250c-7506-426b-aef9-77dec8821d4c	\N
267d6552-243f-4cf7-8baa-c4c750d236db	\N	registration-user-creation	d8293cec-b966-4170-8fed-d0f1f6161baa	f899250c-7506-426b-aef9-77dec8821d4c	0	20	f	\N	\N
c18339db-1e10-4302-8649-d97f1b42765e	\N	registration-password-action	d8293cec-b966-4170-8fed-d0f1f6161baa	f899250c-7506-426b-aef9-77dec8821d4c	0	50	f	\N	\N
dcdea118-87d2-4c04-9978-d734e7ed1f85	\N	registration-recaptcha-action	d8293cec-b966-4170-8fed-d0f1f6161baa	f899250c-7506-426b-aef9-77dec8821d4c	3	60	f	\N	\N
9aad4082-66ed-4079-811e-e6465d7ec148	\N	registration-terms-and-conditions	d8293cec-b966-4170-8fed-d0f1f6161baa	f899250c-7506-426b-aef9-77dec8821d4c	3	70	f	\N	\N
d1ff0ec5-8e57-4616-a687-16e1c088bc6b	\N	reset-credentials-choose-user	d8293cec-b966-4170-8fed-d0f1f6161baa	7bb2cfaa-cf10-48f5-9a19-aa7c2568e2c4	0	10	f	\N	\N
8ea503d7-d860-452d-a7d1-6d946fa8283a	\N	reset-credential-email	d8293cec-b966-4170-8fed-d0f1f6161baa	7bb2cfaa-cf10-48f5-9a19-aa7c2568e2c4	0	20	f	\N	\N
ec1de973-9de1-4b4a-9dc8-456c4efc88f4	\N	reset-password	d8293cec-b966-4170-8fed-d0f1f6161baa	7bb2cfaa-cf10-48f5-9a19-aa7c2568e2c4	0	30	f	\N	\N
dfaf219a-d762-48a3-b24b-3299df5c720e	\N	\N	d8293cec-b966-4170-8fed-d0f1f6161baa	7bb2cfaa-cf10-48f5-9a19-aa7c2568e2c4	1	40	t	ae47d655-9738-49b1-94ca-19bc3e880139	\N
6cf8f83c-6609-40d8-9c1f-6f35eb4317f7	\N	conditional-user-configured	d8293cec-b966-4170-8fed-d0f1f6161baa	ae47d655-9738-49b1-94ca-19bc3e880139	0	10	f	\N	\N
d33645c4-86fb-4a31-acbe-87bb071bb7c0	\N	reset-otp	d8293cec-b966-4170-8fed-d0f1f6161baa	ae47d655-9738-49b1-94ca-19bc3e880139	0	20	f	\N	\N
79306dce-fdc4-4008-8eb6-81f9152a03e6	\N	client-secret	d8293cec-b966-4170-8fed-d0f1f6161baa	015b8349-1f05-4f2b-9929-cf5470ffdc90	2	10	f	\N	\N
071dda87-e59b-4697-8721-2f5ce58e878c	\N	client-jwt	d8293cec-b966-4170-8fed-d0f1f6161baa	015b8349-1f05-4f2b-9929-cf5470ffdc90	2	20	f	\N	\N
bf744826-8dc3-4463-957a-e549a3634dcb	\N	client-secret-jwt	d8293cec-b966-4170-8fed-d0f1f6161baa	015b8349-1f05-4f2b-9929-cf5470ffdc90	2	30	f	\N	\N
0598323f-52c1-41e7-9858-3acce52cd93a	\N	client-x509	d8293cec-b966-4170-8fed-d0f1f6161baa	015b8349-1f05-4f2b-9929-cf5470ffdc90	2	40	f	\N	\N
415f4fef-9d8d-48be-b1e1-08e436c4dd36	\N	idp-review-profile	d8293cec-b966-4170-8fed-d0f1f6161baa	53c4d65c-0e69-4f93-9814-aa9e8e18c7fd	0	10	f	\N	d5f09598-f592-4407-aea3-426097abf0a5
881d2253-eb5c-4cff-a343-52f44b3aa091	\N	\N	d8293cec-b966-4170-8fed-d0f1f6161baa	53c4d65c-0e69-4f93-9814-aa9e8e18c7fd	0	20	t	990c36c6-e467-4272-8e2c-68bce531f1f3	\N
bdca9227-b9b8-4d38-b9c8-51f5edcff201	\N	idp-create-user-if-unique	d8293cec-b966-4170-8fed-d0f1f6161baa	990c36c6-e467-4272-8e2c-68bce531f1f3	2	10	f	\N	e0e9a895-0a42-4f4a-b6d6-270b2f9882d1
5519c74a-0ada-4b5c-ab91-c2556218bd6d	\N	\N	d8293cec-b966-4170-8fed-d0f1f6161baa	990c36c6-e467-4272-8e2c-68bce531f1f3	2	20	t	5eccc3f5-66d4-420b-8b2e-721b457a5cb8	\N
cef4a2d1-fd47-449e-b9b2-1b2917675984	\N	idp-confirm-link	d8293cec-b966-4170-8fed-d0f1f6161baa	5eccc3f5-66d4-420b-8b2e-721b457a5cb8	0	10	f	\N	\N
52577876-8fa2-4e1a-ba05-d631d13e1db0	\N	\N	d8293cec-b966-4170-8fed-d0f1f6161baa	5eccc3f5-66d4-420b-8b2e-721b457a5cb8	0	20	t	a714c93e-3e39-4bec-9c5c-7ef75035cb6b	\N
4846ab41-973a-488f-a4a7-353e095ed927	\N	idp-email-verification	d8293cec-b966-4170-8fed-d0f1f6161baa	a714c93e-3e39-4bec-9c5c-7ef75035cb6b	2	10	f	\N	\N
0b097011-8866-48a0-8042-f8434593739c	\N	\N	d8293cec-b966-4170-8fed-d0f1f6161baa	a714c93e-3e39-4bec-9c5c-7ef75035cb6b	2	20	t	881399c1-3081-4fc4-95ac-248348d36d33	\N
c7064fb2-2ebf-44e7-a5c9-7198b3bd3ebe	\N	idp-username-password-form	d8293cec-b966-4170-8fed-d0f1f6161baa	881399c1-3081-4fc4-95ac-248348d36d33	0	10	f	\N	\N
ac944ca7-e2cb-481b-b0fc-c9a8edca7863	\N	\N	d8293cec-b966-4170-8fed-d0f1f6161baa	881399c1-3081-4fc4-95ac-248348d36d33	1	20	t	3753468f-ec52-40f3-ae43-30cdbc891f76	\N
d34cc045-2e0b-4f49-966d-09fcf9e58868	\N	conditional-user-configured	d8293cec-b966-4170-8fed-d0f1f6161baa	3753468f-ec52-40f3-ae43-30cdbc891f76	0	10	f	\N	\N
c30832ce-b58a-4275-82bf-39c1f5f7be9c	\N	auth-otp-form	d8293cec-b966-4170-8fed-d0f1f6161baa	3753468f-ec52-40f3-ae43-30cdbc891f76	0	20	f	\N	\N
fd62ad19-8aa2-4ca8-bffd-7cdbaa44ae2e	\N	\N	d8293cec-b966-4170-8fed-d0f1f6161baa	53c4d65c-0e69-4f93-9814-aa9e8e18c7fd	1	50	t	eb6e5730-23ac-46ac-bc23-03159db2135f	\N
c8e40e15-06cb-4038-a272-caecf405463d	\N	conditional-user-configured	d8293cec-b966-4170-8fed-d0f1f6161baa	eb6e5730-23ac-46ac-bc23-03159db2135f	0	10	f	\N	\N
9f3452e6-0063-42f4-9ba2-c2e7613394f9	\N	idp-add-organization-member	d8293cec-b966-4170-8fed-d0f1f6161baa	eb6e5730-23ac-46ac-bc23-03159db2135f	0	20	f	\N	\N
377e5be5-f1b6-4b85-8aa1-87a4e0213947	\N	http-basic-authenticator	d8293cec-b966-4170-8fed-d0f1f6161baa	dd2a12e8-9b5b-48e9-a831-187820dcec66	0	10	f	\N	\N
8fafaa20-ac44-4b44-960b-71462422a838	\N	docker-http-basic-authenticator	d8293cec-b966-4170-8fed-d0f1f6161baa	53ce3839-521d-451c-8521-daca5b5cc9c5	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
eefee08a-636c-42c7-a4a4-5b87e90cead4	browser	Browser based authentication	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	t	t
f79ff7a6-4aa1-409a-950c-9d7a977bd432	forms	Username, password, otp and other auth forms.	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	f	t
78e89e5f-87a1-4670-9472-c0bd097e2434	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	f	t
50fc651b-ea1c-49f7-b056-600b9a1b408e	direct grant	OpenID Connect Resource Owner Grant	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	t	t
1caa1918-aa5a-42b0-a505-0984641c408e	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	f	t
474f4f28-b911-4c57-bde4-757c5fcd8bd4	registration	Registration flow	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	t	t
59d4b85a-5f75-42cc-995e-5e9dfefb8a89	registration form	Registration form	7f4bc72e-99dc-4684-8265-a601599a1fb1	form-flow	f	t
4f4af586-e775-47e0-9902-f6b4df6a87d4	reset credentials	Reset credentials for a user if they forgot their password or something	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	t	t
c9a2ed5b-5ed4-407d-aa38-bd7f29366ee3	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	f	t
3b6d78fa-6e9e-44d2-a089-92159d0a8dd4	clients	Base authentication for clients	7f4bc72e-99dc-4684-8265-a601599a1fb1	client-flow	t	t
dbbdcc56-251a-4b08-b86d-c79390fc75c6	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	t	t
c5dfb477-e04d-4a61-ab16-66104aab2b2e	User creation or linking	Flow for the existing/non-existing user alternatives	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	f	t
94afc43d-c783-4c45-a276-7df1078c2d08	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	f	t
2098e0a6-7e49-4fbb-86ff-a20b4f21edb1	Account verification options	Method with which to verity the existing account	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	f	t
c5a3a652-d87b-4ffd-a052-8245e99e3891	Verify Existing Account by Re-authentication	Reauthentication of existing account	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	f	t
0b8ac5e6-2cca-471a-aad6-6cd08ef7289f	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	f	t
7abe490b-42e8-4453-901a-d8f8746d53b5	saml ecp	SAML ECP Profile Authentication Flow	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	t	t
20462a35-54f3-4544-bb04-63ef804eceac	docker auth	Used by Docker clients to authenticate against the IDP	7f4bc72e-99dc-4684-8265-a601599a1fb1	basic-flow	t	t
d18ed81e-7306-4eae-83c3-6b234bc26150	browser	Browser based authentication	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	t	t
ccfd67f8-ec1e-41dd-bbfa-65ab3da92c1f	forms	Username, password, otp and other auth forms.	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	f	t
d0a2969c-ffdc-4aa7-ac41-252427e77d2a	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	f	t
e9543969-0c04-4626-9fa1-af8dc41b8a21	Organization	\N	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	f	t
4db4d208-e0f9-4ab9-bf23-175f35d317e7	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	f	t
4aead574-73aa-4b76-9931-1d6e0346678a	direct grant	OpenID Connect Resource Owner Grant	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	t	t
59538523-d934-4865-a227-c16df48e1eaa	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	f	t
6d37a6fb-bd93-4ce3-bfaa-565b7cb64380	registration	Registration flow	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	t	t
f899250c-7506-426b-aef9-77dec8821d4c	registration form	Registration form	d8293cec-b966-4170-8fed-d0f1f6161baa	form-flow	f	t
7bb2cfaa-cf10-48f5-9a19-aa7c2568e2c4	reset credentials	Reset credentials for a user if they forgot their password or something	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	t	t
ae47d655-9738-49b1-94ca-19bc3e880139	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	f	t
015b8349-1f05-4f2b-9929-cf5470ffdc90	clients	Base authentication for clients	d8293cec-b966-4170-8fed-d0f1f6161baa	client-flow	t	t
53c4d65c-0e69-4f93-9814-aa9e8e18c7fd	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	t	t
990c36c6-e467-4272-8e2c-68bce531f1f3	User creation or linking	Flow for the existing/non-existing user alternatives	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	f	t
5eccc3f5-66d4-420b-8b2e-721b457a5cb8	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	f	t
a714c93e-3e39-4bec-9c5c-7ef75035cb6b	Account verification options	Method with which to verity the existing account	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	f	t
881399c1-3081-4fc4-95ac-248348d36d33	Verify Existing Account by Re-authentication	Reauthentication of existing account	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	f	t
3753468f-ec52-40f3-ae43-30cdbc891f76	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	f	t
eb6e5730-23ac-46ac-bc23-03159db2135f	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	f	t
dd2a12e8-9b5b-48e9-a831-187820dcec66	saml ecp	SAML ECP Profile Authentication Flow	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	t	t
53ce3839-521d-451c-8521-daca5b5cc9c5	docker auth	Used by Docker clients to authenticate against the IDP	d8293cec-b966-4170-8fed-d0f1f6161baa	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
177f48c7-5b7b-4409-9bee-880269963978	review profile config	7f4bc72e-99dc-4684-8265-a601599a1fb1
cacd07cb-866b-4e70-a7c7-88a64c2aac55	create unique user config	7f4bc72e-99dc-4684-8265-a601599a1fb1
d5f09598-f592-4407-aea3-426097abf0a5	review profile config	d8293cec-b966-4170-8fed-d0f1f6161baa
e0e9a895-0a42-4f4a-b6d6-270b2f9882d1	create unique user config	d8293cec-b966-4170-8fed-d0f1f6161baa
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
177f48c7-5b7b-4409-9bee-880269963978	missing	update.profile.on.first.login
cacd07cb-866b-4e70-a7c7-88a64c2aac55	false	require.password.update.after.registration
d5f09598-f592-4407-aea3-426097abf0a5	missing	update.profile.on.first.login
e0e9a895-0a42-4f4a-b6d6-270b2f9882d1	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
537c9c47-f74f-4410-a3de-9eb64e1eb981	t	f	master-realm	0	f	\N	\N	t	\N	f	7f4bc72e-99dc-4684-8265-a601599a1fb1	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
92585ea0-fda0-4277-8d52-1824bde1d052	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	7f4bc72e-99dc-4684-8265-a601599a1fb1	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
aa668fed-c3bd-448b-b628-b4ce5270941b	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	7f4bc72e-99dc-4684-8265-a601599a1fb1	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
70bcd274-1971-4ae9-ba56-3f4c41efa90e	t	f	broker	0	f	\N	\N	t	\N	f	7f4bc72e-99dc-4684-8265-a601599a1fb1	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
e3642221-4079-4480-9bf6-9cf40d6d4651	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	7f4bc72e-99dc-4684-8265-a601599a1fb1	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
aa7c09ea-3979-45b3-8b6e-f6923559a65c	t	t	admin-cli	0	t	\N	\N	f	\N	f	7f4bc72e-99dc-4684-8265-a601599a1fb1	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
6eebb183-341a-448b-bc3b-9496a36cb863	t	f	taskflow-realm	0	f	\N	\N	t	\N	f	7f4bc72e-99dc-4684-8265-a601599a1fb1	\N	0	f	f	taskflow Realm	f	client-secret	\N	\N	\N	t	f	f	f
6e234d18-a278-4e94-8ca0-813e9dd47afb	t	f	realm-management	0	f	\N	\N	t	\N	f	d8293cec-b966-4170-8fed-d0f1f6161baa	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	t	f	account	0	t	\N	/realms/taskflow/account/	f	\N	f	d8293cec-b966-4170-8fed-d0f1f6161baa	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
12867e04-92e1-40a8-85fa-8b396cdd7135	t	f	account-console	0	t	\N	/realms/taskflow/account/	f	\N	f	d8293cec-b966-4170-8fed-d0f1f6161baa	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
08451956-9c96-47db-b097-c4347bc91b31	t	f	broker	0	f	\N	\N	t	\N	f	d8293cec-b966-4170-8fed-d0f1f6161baa	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	t	t	security-admin-console	0	t	\N	/admin/taskflow/console/	f	\N	f	d8293cec-b966-4170-8fed-d0f1f6161baa	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
85dfea40-d752-48fc-b9c7-2a7b12dd0723	t	t	admin-cli	0	t	\N	\N	f	\N	f	d8293cec-b966-4170-8fed-d0f1f6161baa	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
2c2afe53-e35b-4e11-bc76-816cbf59f621	t	t	angular	0	t	\N		f		f	d8293cec-b966-4170-8fed-d0f1f6161baa	openid-connect	-1	t	f	Angular Frontend	f	client-secret			\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
92585ea0-fda0-4277-8d52-1824bde1d052	post.logout.redirect.uris	+
aa668fed-c3bd-448b-b628-b4ce5270941b	post.logout.redirect.uris	+
aa668fed-c3bd-448b-b628-b4ce5270941b	pkce.code.challenge.method	S256
e3642221-4079-4480-9bf6-9cf40d6d4651	post.logout.redirect.uris	+
e3642221-4079-4480-9bf6-9cf40d6d4651	pkce.code.challenge.method	S256
e3642221-4079-4480-9bf6-9cf40d6d4651	client.use.lightweight.access.token.enabled	true
aa7c09ea-3979-45b3-8b6e-f6923559a65c	client.use.lightweight.access.token.enabled	true
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	post.logout.redirect.uris	+
12867e04-92e1-40a8-85fa-8b396cdd7135	post.logout.redirect.uris	+
12867e04-92e1-40a8-85fa-8b396cdd7135	pkce.code.challenge.method	S256
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	post.logout.redirect.uris	+
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	pkce.code.challenge.method	S256
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	client.use.lightweight.access.token.enabled	true
85dfea40-d752-48fc-b9c7-2a7b12dd0723	client.use.lightweight.access.token.enabled	true
2c2afe53-e35b-4e11-bc76-816cbf59f621	standard.token.exchange.enabled	false
2c2afe53-e35b-4e11-bc76-816cbf59f621	oauth2.device.authorization.grant.enabled	false
2c2afe53-e35b-4e11-bc76-816cbf59f621	oidc.ciba.grant.enabled	false
2c2afe53-e35b-4e11-bc76-816cbf59f621	backchannel.logout.session.required	true
2c2afe53-e35b-4e11-bc76-816cbf59f621	backchannel.logout.revoke.offline.tokens	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
2aff5466-31ee-4ec2-bafb-f8feba60fdf9	offline_access	7f4bc72e-99dc-4684-8265-a601599a1fb1	OpenID Connect built-in scope: offline_access	openid-connect
44780d72-451e-454c-ab0d-cb446115f9e9	role_list	7f4bc72e-99dc-4684-8265-a601599a1fb1	SAML role list	saml
ff30731b-f63e-40a5-9adc-c8c3f1aca3bd	saml_organization	7f4bc72e-99dc-4684-8265-a601599a1fb1	Organization Membership	saml
426406bd-19b0-4dfe-bdab-4789ed05a462	profile	7f4bc72e-99dc-4684-8265-a601599a1fb1	OpenID Connect built-in scope: profile	openid-connect
dc446a9e-b6e4-4214-a932-0094e0604351	email	7f4bc72e-99dc-4684-8265-a601599a1fb1	OpenID Connect built-in scope: email	openid-connect
b2542a1b-91df-4ba9-9c94-28912a990f39	address	7f4bc72e-99dc-4684-8265-a601599a1fb1	OpenID Connect built-in scope: address	openid-connect
8c171fcb-fc9a-4a62-af93-d8cbd77739df	phone	7f4bc72e-99dc-4684-8265-a601599a1fb1	OpenID Connect built-in scope: phone	openid-connect
8289f1a1-dad5-4932-a41c-56462a3c6275	roles	7f4bc72e-99dc-4684-8265-a601599a1fb1	OpenID Connect scope for add user roles to the access token	openid-connect
2f555480-3cfc-47b0-a9fc-29fbd1b967c6	web-origins	7f4bc72e-99dc-4684-8265-a601599a1fb1	OpenID Connect scope for add allowed web origins to the access token	openid-connect
d131512a-e48c-4068-8e4f-3b717ae074b1	microprofile-jwt	7f4bc72e-99dc-4684-8265-a601599a1fb1	Microprofile - JWT built-in scope	openid-connect
d7a0b387-b843-40ac-b405-51b6fa3c3076	acr	7f4bc72e-99dc-4684-8265-a601599a1fb1	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
2f849b7b-8403-4af7-800e-9aa2df44640b	basic	7f4bc72e-99dc-4684-8265-a601599a1fb1	OpenID Connect scope for add all basic claims to the token	openid-connect
d5e21af8-5e70-41a1-a055-d2ec5583834d	service_account	7f4bc72e-99dc-4684-8265-a601599a1fb1	Specific scope for a client enabled for service accounts	openid-connect
51bd92b1-1880-4496-b95e-59c1dc23ff13	organization	7f4bc72e-99dc-4684-8265-a601599a1fb1	Additional claims about the organization a subject belongs to	openid-connect
009818e4-a616-4928-a16d-8e3128fd7252	offline_access	d8293cec-b966-4170-8fed-d0f1f6161baa	OpenID Connect built-in scope: offline_access	openid-connect
72720f00-30dc-4b02-ad51-28e79c098434	role_list	d8293cec-b966-4170-8fed-d0f1f6161baa	SAML role list	saml
ad28074f-78b8-4fb3-bc80-b2fea5e3cbc6	saml_organization	d8293cec-b966-4170-8fed-d0f1f6161baa	Organization Membership	saml
979c6d63-c3cd-4c71-939e-322210bb1788	profile	d8293cec-b966-4170-8fed-d0f1f6161baa	OpenID Connect built-in scope: profile	openid-connect
6fad151d-1cd0-461f-82fe-0a2b68e8b6e1	email	d8293cec-b966-4170-8fed-d0f1f6161baa	OpenID Connect built-in scope: email	openid-connect
0e7692aa-cb57-4895-9d73-d438b5b0ba7a	address	d8293cec-b966-4170-8fed-d0f1f6161baa	OpenID Connect built-in scope: address	openid-connect
7b21d67e-0060-4822-8a3e-d246ed96bb38	phone	d8293cec-b966-4170-8fed-d0f1f6161baa	OpenID Connect built-in scope: phone	openid-connect
5795a0f9-25b6-4881-a093-d2eec7b6ac71	roles	d8293cec-b966-4170-8fed-d0f1f6161baa	OpenID Connect scope for add user roles to the access token	openid-connect
5c6270ab-3ff0-462d-ac23-4f59edb7b549	web-origins	d8293cec-b966-4170-8fed-d0f1f6161baa	OpenID Connect scope for add allowed web origins to the access token	openid-connect
a2581802-b167-4151-bf1e-2dea131e5358	microprofile-jwt	d8293cec-b966-4170-8fed-d0f1f6161baa	Microprofile - JWT built-in scope	openid-connect
c38100dd-d19b-478b-adaa-41d280f1482a	acr	d8293cec-b966-4170-8fed-d0f1f6161baa	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
6a979929-d6cc-4b0b-a52b-f9bdf0b61688	basic	d8293cec-b966-4170-8fed-d0f1f6161baa	OpenID Connect scope for add all basic claims to the token	openid-connect
1b5c9af0-f601-479a-b3d2-ce40136b8f8f	service_account	d8293cec-b966-4170-8fed-d0f1f6161baa	Specific scope for a client enabled for service accounts	openid-connect
6b541969-936c-4d20-990e-651490fd8064	organization	d8293cec-b966-4170-8fed-d0f1f6161baa	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
2aff5466-31ee-4ec2-bafb-f8feba60fdf9	true	display.on.consent.screen
2aff5466-31ee-4ec2-bafb-f8feba60fdf9	${offlineAccessScopeConsentText}	consent.screen.text
44780d72-451e-454c-ab0d-cb446115f9e9	true	display.on.consent.screen
44780d72-451e-454c-ab0d-cb446115f9e9	${samlRoleListScopeConsentText}	consent.screen.text
ff30731b-f63e-40a5-9adc-c8c3f1aca3bd	false	display.on.consent.screen
426406bd-19b0-4dfe-bdab-4789ed05a462	true	display.on.consent.screen
426406bd-19b0-4dfe-bdab-4789ed05a462	${profileScopeConsentText}	consent.screen.text
426406bd-19b0-4dfe-bdab-4789ed05a462	true	include.in.token.scope
dc446a9e-b6e4-4214-a932-0094e0604351	true	display.on.consent.screen
dc446a9e-b6e4-4214-a932-0094e0604351	${emailScopeConsentText}	consent.screen.text
dc446a9e-b6e4-4214-a932-0094e0604351	true	include.in.token.scope
b2542a1b-91df-4ba9-9c94-28912a990f39	true	display.on.consent.screen
b2542a1b-91df-4ba9-9c94-28912a990f39	${addressScopeConsentText}	consent.screen.text
b2542a1b-91df-4ba9-9c94-28912a990f39	true	include.in.token.scope
8c171fcb-fc9a-4a62-af93-d8cbd77739df	true	display.on.consent.screen
8c171fcb-fc9a-4a62-af93-d8cbd77739df	${phoneScopeConsentText}	consent.screen.text
8c171fcb-fc9a-4a62-af93-d8cbd77739df	true	include.in.token.scope
8289f1a1-dad5-4932-a41c-56462a3c6275	true	display.on.consent.screen
8289f1a1-dad5-4932-a41c-56462a3c6275	${rolesScopeConsentText}	consent.screen.text
8289f1a1-dad5-4932-a41c-56462a3c6275	false	include.in.token.scope
2f555480-3cfc-47b0-a9fc-29fbd1b967c6	false	display.on.consent.screen
2f555480-3cfc-47b0-a9fc-29fbd1b967c6		consent.screen.text
2f555480-3cfc-47b0-a9fc-29fbd1b967c6	false	include.in.token.scope
d131512a-e48c-4068-8e4f-3b717ae074b1	false	display.on.consent.screen
d131512a-e48c-4068-8e4f-3b717ae074b1	true	include.in.token.scope
d7a0b387-b843-40ac-b405-51b6fa3c3076	false	display.on.consent.screen
d7a0b387-b843-40ac-b405-51b6fa3c3076	false	include.in.token.scope
2f849b7b-8403-4af7-800e-9aa2df44640b	false	display.on.consent.screen
2f849b7b-8403-4af7-800e-9aa2df44640b	false	include.in.token.scope
d5e21af8-5e70-41a1-a055-d2ec5583834d	false	display.on.consent.screen
d5e21af8-5e70-41a1-a055-d2ec5583834d	false	include.in.token.scope
51bd92b1-1880-4496-b95e-59c1dc23ff13	true	display.on.consent.screen
51bd92b1-1880-4496-b95e-59c1dc23ff13	${organizationScopeConsentText}	consent.screen.text
51bd92b1-1880-4496-b95e-59c1dc23ff13	true	include.in.token.scope
009818e4-a616-4928-a16d-8e3128fd7252	true	display.on.consent.screen
009818e4-a616-4928-a16d-8e3128fd7252	${offlineAccessScopeConsentText}	consent.screen.text
72720f00-30dc-4b02-ad51-28e79c098434	true	display.on.consent.screen
72720f00-30dc-4b02-ad51-28e79c098434	${samlRoleListScopeConsentText}	consent.screen.text
ad28074f-78b8-4fb3-bc80-b2fea5e3cbc6	false	display.on.consent.screen
979c6d63-c3cd-4c71-939e-322210bb1788	true	display.on.consent.screen
979c6d63-c3cd-4c71-939e-322210bb1788	${profileScopeConsentText}	consent.screen.text
979c6d63-c3cd-4c71-939e-322210bb1788	true	include.in.token.scope
6fad151d-1cd0-461f-82fe-0a2b68e8b6e1	true	display.on.consent.screen
6fad151d-1cd0-461f-82fe-0a2b68e8b6e1	${emailScopeConsentText}	consent.screen.text
6fad151d-1cd0-461f-82fe-0a2b68e8b6e1	true	include.in.token.scope
0e7692aa-cb57-4895-9d73-d438b5b0ba7a	true	display.on.consent.screen
0e7692aa-cb57-4895-9d73-d438b5b0ba7a	${addressScopeConsentText}	consent.screen.text
0e7692aa-cb57-4895-9d73-d438b5b0ba7a	true	include.in.token.scope
7b21d67e-0060-4822-8a3e-d246ed96bb38	true	display.on.consent.screen
7b21d67e-0060-4822-8a3e-d246ed96bb38	${phoneScopeConsentText}	consent.screen.text
7b21d67e-0060-4822-8a3e-d246ed96bb38	true	include.in.token.scope
5795a0f9-25b6-4881-a093-d2eec7b6ac71	true	display.on.consent.screen
5795a0f9-25b6-4881-a093-d2eec7b6ac71	${rolesScopeConsentText}	consent.screen.text
5795a0f9-25b6-4881-a093-d2eec7b6ac71	false	include.in.token.scope
5c6270ab-3ff0-462d-ac23-4f59edb7b549	false	display.on.consent.screen
5c6270ab-3ff0-462d-ac23-4f59edb7b549		consent.screen.text
5c6270ab-3ff0-462d-ac23-4f59edb7b549	false	include.in.token.scope
a2581802-b167-4151-bf1e-2dea131e5358	false	display.on.consent.screen
a2581802-b167-4151-bf1e-2dea131e5358	true	include.in.token.scope
c38100dd-d19b-478b-adaa-41d280f1482a	false	display.on.consent.screen
c38100dd-d19b-478b-adaa-41d280f1482a	false	include.in.token.scope
6a979929-d6cc-4b0b-a52b-f9bdf0b61688	false	display.on.consent.screen
6a979929-d6cc-4b0b-a52b-f9bdf0b61688	false	include.in.token.scope
1b5c9af0-f601-479a-b3d2-ce40136b8f8f	false	display.on.consent.screen
1b5c9af0-f601-479a-b3d2-ce40136b8f8f	false	include.in.token.scope
6b541969-936c-4d20-990e-651490fd8064	true	display.on.consent.screen
6b541969-936c-4d20-990e-651490fd8064	${organizationScopeConsentText}	consent.screen.text
6b541969-936c-4d20-990e-651490fd8064	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
92585ea0-fda0-4277-8d52-1824bde1d052	426406bd-19b0-4dfe-bdab-4789ed05a462	t
92585ea0-fda0-4277-8d52-1824bde1d052	dc446a9e-b6e4-4214-a932-0094e0604351	t
92585ea0-fda0-4277-8d52-1824bde1d052	8289f1a1-dad5-4932-a41c-56462a3c6275	t
92585ea0-fda0-4277-8d52-1824bde1d052	d7a0b387-b843-40ac-b405-51b6fa3c3076	t
92585ea0-fda0-4277-8d52-1824bde1d052	2f849b7b-8403-4af7-800e-9aa2df44640b	t
92585ea0-fda0-4277-8d52-1824bde1d052	2f555480-3cfc-47b0-a9fc-29fbd1b967c6	t
92585ea0-fda0-4277-8d52-1824bde1d052	8c171fcb-fc9a-4a62-af93-d8cbd77739df	f
92585ea0-fda0-4277-8d52-1824bde1d052	d131512a-e48c-4068-8e4f-3b717ae074b1	f
92585ea0-fda0-4277-8d52-1824bde1d052	b2542a1b-91df-4ba9-9c94-28912a990f39	f
92585ea0-fda0-4277-8d52-1824bde1d052	2aff5466-31ee-4ec2-bafb-f8feba60fdf9	f
92585ea0-fda0-4277-8d52-1824bde1d052	51bd92b1-1880-4496-b95e-59c1dc23ff13	f
aa668fed-c3bd-448b-b628-b4ce5270941b	426406bd-19b0-4dfe-bdab-4789ed05a462	t
aa668fed-c3bd-448b-b628-b4ce5270941b	dc446a9e-b6e4-4214-a932-0094e0604351	t
aa668fed-c3bd-448b-b628-b4ce5270941b	8289f1a1-dad5-4932-a41c-56462a3c6275	t
aa668fed-c3bd-448b-b628-b4ce5270941b	d7a0b387-b843-40ac-b405-51b6fa3c3076	t
aa668fed-c3bd-448b-b628-b4ce5270941b	2f849b7b-8403-4af7-800e-9aa2df44640b	t
aa668fed-c3bd-448b-b628-b4ce5270941b	2f555480-3cfc-47b0-a9fc-29fbd1b967c6	t
aa668fed-c3bd-448b-b628-b4ce5270941b	8c171fcb-fc9a-4a62-af93-d8cbd77739df	f
aa668fed-c3bd-448b-b628-b4ce5270941b	d131512a-e48c-4068-8e4f-3b717ae074b1	f
aa668fed-c3bd-448b-b628-b4ce5270941b	b2542a1b-91df-4ba9-9c94-28912a990f39	f
aa668fed-c3bd-448b-b628-b4ce5270941b	2aff5466-31ee-4ec2-bafb-f8feba60fdf9	f
aa668fed-c3bd-448b-b628-b4ce5270941b	51bd92b1-1880-4496-b95e-59c1dc23ff13	f
aa7c09ea-3979-45b3-8b6e-f6923559a65c	426406bd-19b0-4dfe-bdab-4789ed05a462	t
aa7c09ea-3979-45b3-8b6e-f6923559a65c	dc446a9e-b6e4-4214-a932-0094e0604351	t
aa7c09ea-3979-45b3-8b6e-f6923559a65c	8289f1a1-dad5-4932-a41c-56462a3c6275	t
aa7c09ea-3979-45b3-8b6e-f6923559a65c	d7a0b387-b843-40ac-b405-51b6fa3c3076	t
aa7c09ea-3979-45b3-8b6e-f6923559a65c	2f849b7b-8403-4af7-800e-9aa2df44640b	t
aa7c09ea-3979-45b3-8b6e-f6923559a65c	2f555480-3cfc-47b0-a9fc-29fbd1b967c6	t
aa7c09ea-3979-45b3-8b6e-f6923559a65c	8c171fcb-fc9a-4a62-af93-d8cbd77739df	f
aa7c09ea-3979-45b3-8b6e-f6923559a65c	d131512a-e48c-4068-8e4f-3b717ae074b1	f
aa7c09ea-3979-45b3-8b6e-f6923559a65c	b2542a1b-91df-4ba9-9c94-28912a990f39	f
aa7c09ea-3979-45b3-8b6e-f6923559a65c	2aff5466-31ee-4ec2-bafb-f8feba60fdf9	f
aa7c09ea-3979-45b3-8b6e-f6923559a65c	51bd92b1-1880-4496-b95e-59c1dc23ff13	f
70bcd274-1971-4ae9-ba56-3f4c41efa90e	426406bd-19b0-4dfe-bdab-4789ed05a462	t
70bcd274-1971-4ae9-ba56-3f4c41efa90e	dc446a9e-b6e4-4214-a932-0094e0604351	t
70bcd274-1971-4ae9-ba56-3f4c41efa90e	8289f1a1-dad5-4932-a41c-56462a3c6275	t
70bcd274-1971-4ae9-ba56-3f4c41efa90e	d7a0b387-b843-40ac-b405-51b6fa3c3076	t
70bcd274-1971-4ae9-ba56-3f4c41efa90e	2f849b7b-8403-4af7-800e-9aa2df44640b	t
70bcd274-1971-4ae9-ba56-3f4c41efa90e	2f555480-3cfc-47b0-a9fc-29fbd1b967c6	t
70bcd274-1971-4ae9-ba56-3f4c41efa90e	8c171fcb-fc9a-4a62-af93-d8cbd77739df	f
70bcd274-1971-4ae9-ba56-3f4c41efa90e	d131512a-e48c-4068-8e4f-3b717ae074b1	f
70bcd274-1971-4ae9-ba56-3f4c41efa90e	b2542a1b-91df-4ba9-9c94-28912a990f39	f
70bcd274-1971-4ae9-ba56-3f4c41efa90e	2aff5466-31ee-4ec2-bafb-f8feba60fdf9	f
70bcd274-1971-4ae9-ba56-3f4c41efa90e	51bd92b1-1880-4496-b95e-59c1dc23ff13	f
537c9c47-f74f-4410-a3de-9eb64e1eb981	426406bd-19b0-4dfe-bdab-4789ed05a462	t
537c9c47-f74f-4410-a3de-9eb64e1eb981	dc446a9e-b6e4-4214-a932-0094e0604351	t
537c9c47-f74f-4410-a3de-9eb64e1eb981	8289f1a1-dad5-4932-a41c-56462a3c6275	t
537c9c47-f74f-4410-a3de-9eb64e1eb981	d7a0b387-b843-40ac-b405-51b6fa3c3076	t
537c9c47-f74f-4410-a3de-9eb64e1eb981	2f849b7b-8403-4af7-800e-9aa2df44640b	t
537c9c47-f74f-4410-a3de-9eb64e1eb981	2f555480-3cfc-47b0-a9fc-29fbd1b967c6	t
537c9c47-f74f-4410-a3de-9eb64e1eb981	8c171fcb-fc9a-4a62-af93-d8cbd77739df	f
537c9c47-f74f-4410-a3de-9eb64e1eb981	d131512a-e48c-4068-8e4f-3b717ae074b1	f
537c9c47-f74f-4410-a3de-9eb64e1eb981	b2542a1b-91df-4ba9-9c94-28912a990f39	f
537c9c47-f74f-4410-a3de-9eb64e1eb981	2aff5466-31ee-4ec2-bafb-f8feba60fdf9	f
537c9c47-f74f-4410-a3de-9eb64e1eb981	51bd92b1-1880-4496-b95e-59c1dc23ff13	f
e3642221-4079-4480-9bf6-9cf40d6d4651	426406bd-19b0-4dfe-bdab-4789ed05a462	t
e3642221-4079-4480-9bf6-9cf40d6d4651	dc446a9e-b6e4-4214-a932-0094e0604351	t
e3642221-4079-4480-9bf6-9cf40d6d4651	8289f1a1-dad5-4932-a41c-56462a3c6275	t
e3642221-4079-4480-9bf6-9cf40d6d4651	d7a0b387-b843-40ac-b405-51b6fa3c3076	t
e3642221-4079-4480-9bf6-9cf40d6d4651	2f849b7b-8403-4af7-800e-9aa2df44640b	t
e3642221-4079-4480-9bf6-9cf40d6d4651	2f555480-3cfc-47b0-a9fc-29fbd1b967c6	t
e3642221-4079-4480-9bf6-9cf40d6d4651	8c171fcb-fc9a-4a62-af93-d8cbd77739df	f
e3642221-4079-4480-9bf6-9cf40d6d4651	d131512a-e48c-4068-8e4f-3b717ae074b1	f
e3642221-4079-4480-9bf6-9cf40d6d4651	b2542a1b-91df-4ba9-9c94-28912a990f39	f
e3642221-4079-4480-9bf6-9cf40d6d4651	2aff5466-31ee-4ec2-bafb-f8feba60fdf9	f
e3642221-4079-4480-9bf6-9cf40d6d4651	51bd92b1-1880-4496-b95e-59c1dc23ff13	f
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	979c6d63-c3cd-4c71-939e-322210bb1788	t
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	6fad151d-1cd0-461f-82fe-0a2b68e8b6e1	t
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	5795a0f9-25b6-4881-a093-d2eec7b6ac71	t
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	6a979929-d6cc-4b0b-a52b-f9bdf0b61688	t
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	c38100dd-d19b-478b-adaa-41d280f1482a	t
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	5c6270ab-3ff0-462d-ac23-4f59edb7b549	t
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	009818e4-a616-4928-a16d-8e3128fd7252	f
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	7b21d67e-0060-4822-8a3e-d246ed96bb38	f
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	0e7692aa-cb57-4895-9d73-d438b5b0ba7a	f
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	a2581802-b167-4151-bf1e-2dea131e5358	f
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	6b541969-936c-4d20-990e-651490fd8064	f
12867e04-92e1-40a8-85fa-8b396cdd7135	979c6d63-c3cd-4c71-939e-322210bb1788	t
12867e04-92e1-40a8-85fa-8b396cdd7135	6fad151d-1cd0-461f-82fe-0a2b68e8b6e1	t
12867e04-92e1-40a8-85fa-8b396cdd7135	5795a0f9-25b6-4881-a093-d2eec7b6ac71	t
12867e04-92e1-40a8-85fa-8b396cdd7135	6a979929-d6cc-4b0b-a52b-f9bdf0b61688	t
12867e04-92e1-40a8-85fa-8b396cdd7135	c38100dd-d19b-478b-adaa-41d280f1482a	t
12867e04-92e1-40a8-85fa-8b396cdd7135	5c6270ab-3ff0-462d-ac23-4f59edb7b549	t
12867e04-92e1-40a8-85fa-8b396cdd7135	009818e4-a616-4928-a16d-8e3128fd7252	f
12867e04-92e1-40a8-85fa-8b396cdd7135	7b21d67e-0060-4822-8a3e-d246ed96bb38	f
12867e04-92e1-40a8-85fa-8b396cdd7135	0e7692aa-cb57-4895-9d73-d438b5b0ba7a	f
12867e04-92e1-40a8-85fa-8b396cdd7135	a2581802-b167-4151-bf1e-2dea131e5358	f
12867e04-92e1-40a8-85fa-8b396cdd7135	6b541969-936c-4d20-990e-651490fd8064	f
85dfea40-d752-48fc-b9c7-2a7b12dd0723	979c6d63-c3cd-4c71-939e-322210bb1788	t
85dfea40-d752-48fc-b9c7-2a7b12dd0723	6fad151d-1cd0-461f-82fe-0a2b68e8b6e1	t
85dfea40-d752-48fc-b9c7-2a7b12dd0723	5795a0f9-25b6-4881-a093-d2eec7b6ac71	t
85dfea40-d752-48fc-b9c7-2a7b12dd0723	6a979929-d6cc-4b0b-a52b-f9bdf0b61688	t
85dfea40-d752-48fc-b9c7-2a7b12dd0723	c38100dd-d19b-478b-adaa-41d280f1482a	t
85dfea40-d752-48fc-b9c7-2a7b12dd0723	5c6270ab-3ff0-462d-ac23-4f59edb7b549	t
85dfea40-d752-48fc-b9c7-2a7b12dd0723	009818e4-a616-4928-a16d-8e3128fd7252	f
85dfea40-d752-48fc-b9c7-2a7b12dd0723	7b21d67e-0060-4822-8a3e-d246ed96bb38	f
85dfea40-d752-48fc-b9c7-2a7b12dd0723	0e7692aa-cb57-4895-9d73-d438b5b0ba7a	f
85dfea40-d752-48fc-b9c7-2a7b12dd0723	a2581802-b167-4151-bf1e-2dea131e5358	f
85dfea40-d752-48fc-b9c7-2a7b12dd0723	6b541969-936c-4d20-990e-651490fd8064	f
08451956-9c96-47db-b097-c4347bc91b31	979c6d63-c3cd-4c71-939e-322210bb1788	t
08451956-9c96-47db-b097-c4347bc91b31	6fad151d-1cd0-461f-82fe-0a2b68e8b6e1	t
08451956-9c96-47db-b097-c4347bc91b31	5795a0f9-25b6-4881-a093-d2eec7b6ac71	t
08451956-9c96-47db-b097-c4347bc91b31	6a979929-d6cc-4b0b-a52b-f9bdf0b61688	t
08451956-9c96-47db-b097-c4347bc91b31	c38100dd-d19b-478b-adaa-41d280f1482a	t
08451956-9c96-47db-b097-c4347bc91b31	5c6270ab-3ff0-462d-ac23-4f59edb7b549	t
08451956-9c96-47db-b097-c4347bc91b31	009818e4-a616-4928-a16d-8e3128fd7252	f
08451956-9c96-47db-b097-c4347bc91b31	7b21d67e-0060-4822-8a3e-d246ed96bb38	f
08451956-9c96-47db-b097-c4347bc91b31	0e7692aa-cb57-4895-9d73-d438b5b0ba7a	f
08451956-9c96-47db-b097-c4347bc91b31	a2581802-b167-4151-bf1e-2dea131e5358	f
08451956-9c96-47db-b097-c4347bc91b31	6b541969-936c-4d20-990e-651490fd8064	f
6e234d18-a278-4e94-8ca0-813e9dd47afb	979c6d63-c3cd-4c71-939e-322210bb1788	t
6e234d18-a278-4e94-8ca0-813e9dd47afb	6fad151d-1cd0-461f-82fe-0a2b68e8b6e1	t
6e234d18-a278-4e94-8ca0-813e9dd47afb	5795a0f9-25b6-4881-a093-d2eec7b6ac71	t
6e234d18-a278-4e94-8ca0-813e9dd47afb	6a979929-d6cc-4b0b-a52b-f9bdf0b61688	t
6e234d18-a278-4e94-8ca0-813e9dd47afb	c38100dd-d19b-478b-adaa-41d280f1482a	t
6e234d18-a278-4e94-8ca0-813e9dd47afb	5c6270ab-3ff0-462d-ac23-4f59edb7b549	t
6e234d18-a278-4e94-8ca0-813e9dd47afb	009818e4-a616-4928-a16d-8e3128fd7252	f
6e234d18-a278-4e94-8ca0-813e9dd47afb	7b21d67e-0060-4822-8a3e-d246ed96bb38	f
6e234d18-a278-4e94-8ca0-813e9dd47afb	0e7692aa-cb57-4895-9d73-d438b5b0ba7a	f
6e234d18-a278-4e94-8ca0-813e9dd47afb	a2581802-b167-4151-bf1e-2dea131e5358	f
6e234d18-a278-4e94-8ca0-813e9dd47afb	6b541969-936c-4d20-990e-651490fd8064	f
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	979c6d63-c3cd-4c71-939e-322210bb1788	t
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	6fad151d-1cd0-461f-82fe-0a2b68e8b6e1	t
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	5795a0f9-25b6-4881-a093-d2eec7b6ac71	t
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	6a979929-d6cc-4b0b-a52b-f9bdf0b61688	t
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	c38100dd-d19b-478b-adaa-41d280f1482a	t
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	5c6270ab-3ff0-462d-ac23-4f59edb7b549	t
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	009818e4-a616-4928-a16d-8e3128fd7252	f
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	7b21d67e-0060-4822-8a3e-d246ed96bb38	f
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	0e7692aa-cb57-4895-9d73-d438b5b0ba7a	f
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	a2581802-b167-4151-bf1e-2dea131e5358	f
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	6b541969-936c-4d20-990e-651490fd8064	f
2c2afe53-e35b-4e11-bc76-816cbf59f621	979c6d63-c3cd-4c71-939e-322210bb1788	t
2c2afe53-e35b-4e11-bc76-816cbf59f621	6fad151d-1cd0-461f-82fe-0a2b68e8b6e1	t
2c2afe53-e35b-4e11-bc76-816cbf59f621	5795a0f9-25b6-4881-a093-d2eec7b6ac71	t
2c2afe53-e35b-4e11-bc76-816cbf59f621	6a979929-d6cc-4b0b-a52b-f9bdf0b61688	t
2c2afe53-e35b-4e11-bc76-816cbf59f621	c38100dd-d19b-478b-adaa-41d280f1482a	t
2c2afe53-e35b-4e11-bc76-816cbf59f621	5c6270ab-3ff0-462d-ac23-4f59edb7b549	t
2c2afe53-e35b-4e11-bc76-816cbf59f621	009818e4-a616-4928-a16d-8e3128fd7252	f
2c2afe53-e35b-4e11-bc76-816cbf59f621	7b21d67e-0060-4822-8a3e-d246ed96bb38	f
2c2afe53-e35b-4e11-bc76-816cbf59f621	0e7692aa-cb57-4895-9d73-d438b5b0ba7a	f
2c2afe53-e35b-4e11-bc76-816cbf59f621	a2581802-b167-4151-bf1e-2dea131e5358	f
2c2afe53-e35b-4e11-bc76-816cbf59f621	6b541969-936c-4d20-990e-651490fd8064	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
2aff5466-31ee-4ec2-bafb-f8feba60fdf9	d094fd58-34a6-4a6d-988a-5482534c71b1
009818e4-a616-4928-a16d-8e3128fd7252	83724866-841b-432c-88b1-154c7905950b
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
83b40f6e-3ea1-4ed0-bcd8-3db28cfa2d19	Trusted Hosts	7f4bc72e-99dc-4684-8265-a601599a1fb1	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f4bc72e-99dc-4684-8265-a601599a1fb1	anonymous
68b8f863-c1da-476d-9293-c00bac74641e	Consent Required	7f4bc72e-99dc-4684-8265-a601599a1fb1	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f4bc72e-99dc-4684-8265-a601599a1fb1	anonymous
c51449e1-eea1-464d-8994-743abba12982	Full Scope Disabled	7f4bc72e-99dc-4684-8265-a601599a1fb1	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f4bc72e-99dc-4684-8265-a601599a1fb1	anonymous
fc66d940-bbd3-417c-be5e-708c9a37d73b	Max Clients Limit	7f4bc72e-99dc-4684-8265-a601599a1fb1	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f4bc72e-99dc-4684-8265-a601599a1fb1	anonymous
c6fe63e1-be58-4e36-9f4f-dd3e553d7c04	Allowed Protocol Mapper Types	7f4bc72e-99dc-4684-8265-a601599a1fb1	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f4bc72e-99dc-4684-8265-a601599a1fb1	anonymous
b6c5f08e-e78d-4a9e-8855-1ecd31b43dce	Allowed Client Scopes	7f4bc72e-99dc-4684-8265-a601599a1fb1	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f4bc72e-99dc-4684-8265-a601599a1fb1	anonymous
69254d14-9839-48b7-9a06-256e199e821b	Allowed Protocol Mapper Types	7f4bc72e-99dc-4684-8265-a601599a1fb1	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f4bc72e-99dc-4684-8265-a601599a1fb1	authenticated
98fde214-a6f5-447e-90f7-38c9b9c7ecaf	Allowed Client Scopes	7f4bc72e-99dc-4684-8265-a601599a1fb1	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	7f4bc72e-99dc-4684-8265-a601599a1fb1	authenticated
9739e578-0a9f-4f9a-a95f-98450fa62ef7	rsa-generated	7f4bc72e-99dc-4684-8265-a601599a1fb1	rsa-generated	org.keycloak.keys.KeyProvider	7f4bc72e-99dc-4684-8265-a601599a1fb1	\N
6e23b7fc-7246-4644-a429-221af7fd1a54	rsa-enc-generated	7f4bc72e-99dc-4684-8265-a601599a1fb1	rsa-enc-generated	org.keycloak.keys.KeyProvider	7f4bc72e-99dc-4684-8265-a601599a1fb1	\N
b6b0650f-dd0b-4a6d-818a-d9307f90315c	hmac-generated-hs512	7f4bc72e-99dc-4684-8265-a601599a1fb1	hmac-generated	org.keycloak.keys.KeyProvider	7f4bc72e-99dc-4684-8265-a601599a1fb1	\N
a689c18d-f541-4f44-9289-b2b9197172be	aes-generated	7f4bc72e-99dc-4684-8265-a601599a1fb1	aes-generated	org.keycloak.keys.KeyProvider	7f4bc72e-99dc-4684-8265-a601599a1fb1	\N
381f1e81-7f13-4fa8-90bd-1e9a67c17a87	\N	7f4bc72e-99dc-4684-8265-a601599a1fb1	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	7f4bc72e-99dc-4684-8265-a601599a1fb1	\N
b3dbd712-6405-4ee9-b2c4-5009d6add69b	rsa-generated	d8293cec-b966-4170-8fed-d0f1f6161baa	rsa-generated	org.keycloak.keys.KeyProvider	d8293cec-b966-4170-8fed-d0f1f6161baa	\N
fbd02e55-04f5-42c1-a747-3baf6774b5a9	rsa-enc-generated	d8293cec-b966-4170-8fed-d0f1f6161baa	rsa-enc-generated	org.keycloak.keys.KeyProvider	d8293cec-b966-4170-8fed-d0f1f6161baa	\N
634be8e5-55e8-415d-9639-22c120bb407e	hmac-generated-hs512	d8293cec-b966-4170-8fed-d0f1f6161baa	hmac-generated	org.keycloak.keys.KeyProvider	d8293cec-b966-4170-8fed-d0f1f6161baa	\N
635d4560-232c-49a7-905f-9845ccfed5ac	aes-generated	d8293cec-b966-4170-8fed-d0f1f6161baa	aes-generated	org.keycloak.keys.KeyProvider	d8293cec-b966-4170-8fed-d0f1f6161baa	\N
3abdffd2-f09a-4896-a799-a259c97ca49b	Trusted Hosts	d8293cec-b966-4170-8fed-d0f1f6161baa	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d8293cec-b966-4170-8fed-d0f1f6161baa	anonymous
9e24a67e-bee1-4831-bf02-8612c83e1374	Consent Required	d8293cec-b966-4170-8fed-d0f1f6161baa	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d8293cec-b966-4170-8fed-d0f1f6161baa	anonymous
f53482ce-08aa-4e22-a3f3-e39f77872d69	Full Scope Disabled	d8293cec-b966-4170-8fed-d0f1f6161baa	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d8293cec-b966-4170-8fed-d0f1f6161baa	anonymous
3680750b-c0d8-4526-9d43-ac402f80686f	Max Clients Limit	d8293cec-b966-4170-8fed-d0f1f6161baa	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d8293cec-b966-4170-8fed-d0f1f6161baa	anonymous
1773d064-e7e0-4965-bafa-6701bb192f94	Allowed Protocol Mapper Types	d8293cec-b966-4170-8fed-d0f1f6161baa	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d8293cec-b966-4170-8fed-d0f1f6161baa	anonymous
5ec6e58b-245f-4783-856c-40233128e5af	Allowed Client Scopes	d8293cec-b966-4170-8fed-d0f1f6161baa	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d8293cec-b966-4170-8fed-d0f1f6161baa	anonymous
7ea63403-526c-4e9d-a285-c211b5cf33d8	Allowed Protocol Mapper Types	d8293cec-b966-4170-8fed-d0f1f6161baa	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d8293cec-b966-4170-8fed-d0f1f6161baa	authenticated
d9729313-17b1-4b60-a4ed-ec61ac5f8ca0	Allowed Client Scopes	d8293cec-b966-4170-8fed-d0f1f6161baa	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d8293cec-b966-4170-8fed-d0f1f6161baa	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
8e4625e6-45ad-4acd-9097-925532fb3147	69254d14-9839-48b7-9a06-256e199e821b	allowed-protocol-mapper-types	oidc-address-mapper
052504e9-c96f-47ba-ac8b-d3ca77586ffd	69254d14-9839-48b7-9a06-256e199e821b	allowed-protocol-mapper-types	saml-user-property-mapper
8a0c4b2d-2958-40dc-8156-4c010d0b00ec	69254d14-9839-48b7-9a06-256e199e821b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
6d7f508f-59bf-4ce8-9be6-39f7e5c30d1f	69254d14-9839-48b7-9a06-256e199e821b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
dded803c-d94d-45cd-8d61-0248bbdafafa	69254d14-9839-48b7-9a06-256e199e821b	allowed-protocol-mapper-types	oidc-full-name-mapper
a710723e-e0c2-4120-892a-ef7f39cff462	69254d14-9839-48b7-9a06-256e199e821b	allowed-protocol-mapper-types	saml-user-attribute-mapper
bb07f22f-4d20-4d73-9c66-6d335a3cb4ab	69254d14-9839-48b7-9a06-256e199e821b	allowed-protocol-mapper-types	saml-role-list-mapper
1ea2b9de-b1e8-4dd2-9280-663d2c8996f2	69254d14-9839-48b7-9a06-256e199e821b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
ad38f205-194a-4b24-94ce-8494f0824046	98fde214-a6f5-447e-90f7-38c9b9c7ecaf	allow-default-scopes	true
555b9d0c-b19e-4b16-9b10-a155aac346e9	83b40f6e-3ea1-4ed0-bcd8-3db28cfa2d19	host-sending-registration-request-must-match	true
c3e8003f-291b-4d4c-b83c-c57397376faa	83b40f6e-3ea1-4ed0-bcd8-3db28cfa2d19	client-uris-must-match	true
6c122ada-d530-43d2-8fd5-fe4cf2437d7d	b6c5f08e-e78d-4a9e-8855-1ecd31b43dce	allow-default-scopes	true
c80a2e9b-407e-4586-82eb-c562d4d7d3d1	c6fe63e1-be58-4e36-9f4f-dd3e553d7c04	allowed-protocol-mapper-types	saml-user-attribute-mapper
37c4f91a-0758-465d-b955-4785a4e8224e	c6fe63e1-be58-4e36-9f4f-dd3e553d7c04	allowed-protocol-mapper-types	saml-user-property-mapper
62a673ec-b8d1-449f-99a6-21c923954593	c6fe63e1-be58-4e36-9f4f-dd3e553d7c04	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4acb60d1-4230-4f8c-93a1-852c737ab218	c6fe63e1-be58-4e36-9f4f-dd3e553d7c04	allowed-protocol-mapper-types	oidc-full-name-mapper
fadc9c66-12f3-4e76-a8d8-8bc21ab0919d	c6fe63e1-be58-4e36-9f4f-dd3e553d7c04	allowed-protocol-mapper-types	oidc-address-mapper
041ebffe-9db1-4220-8ce8-c0e6e304e062	c6fe63e1-be58-4e36-9f4f-dd3e553d7c04	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5c597d04-e41b-4110-a992-41cd9b358270	c6fe63e1-be58-4e36-9f4f-dd3e553d7c04	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d69ff62f-f468-4299-9691-eb6802d43db8	c6fe63e1-be58-4e36-9f4f-dd3e553d7c04	allowed-protocol-mapper-types	saml-role-list-mapper
c088a16f-e537-4731-8e09-6929cb1ef5b3	fc66d940-bbd3-417c-be5e-708c9a37d73b	max-clients	200
294406f0-2569-4ddb-800f-f694788aa1e3	381f1e81-7f13-4fa8-90bd-1e9a67c17a87	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
df44ecdd-f3bf-4863-b115-ea8cea3fc07c	b6b0650f-dd0b-4a6d-818a-d9307f90315c	kid	aeeb095d-6624-4498-afc2-3eb09ff0f870
574131e7-a1aa-443d-9a41-9a3408b1d7c8	b6b0650f-dd0b-4a6d-818a-d9307f90315c	secret	yGI6rbBZEbD9Y_MfbRFqyAHU-AUH44KIeL4KbNtg6IoTF0aKgMgcp_g_jez8sMJQ3Sj60kwVHEsQNXDrhkRCHu1xevlBF5k4ZP0c6XC4nm8Qu0yluBIMG37klg2wPbXyuSixT_GXZri7CHFh0qYNwMkvN90Q80wW9VXgqctu2VY
e1a2ab82-b438-4fe7-8f28-1a0049446f58	b6b0650f-dd0b-4a6d-818a-d9307f90315c	algorithm	HS512
32bf44ad-d483-4633-92a4-7763d451a60a	b6b0650f-dd0b-4a6d-818a-d9307f90315c	priority	100
a88b031a-5957-4f6b-9d4e-337c5831034a	a689c18d-f541-4f44-9289-b2b9197172be	secret	G0lo_jafpkDe-Q1JFR9WFA
7f6458ed-ef73-4642-9799-df87a39ee3a7	a689c18d-f541-4f44-9289-b2b9197172be	priority	100
cbf63957-1a12-4ec8-9974-ed013e8b210c	a689c18d-f541-4f44-9289-b2b9197172be	kid	e933afe7-bd61-4420-930c-c54639554a51
1bd2ec16-3883-4d24-99d7-a007df4f17c0	6e23b7fc-7246-4644-a429-221af7fd1a54	privateKey	MIIEogIBAAKCAQEAsxhIgKWC6D/xYrsp67SIlmPOh3VtxKBJo4H4nt6jE4SciYn8jlxlxXuEhdZr6GiL9ygx55b0AWoIZKi6qru3oKZKG9Oh9lJ8SLierwSTflRbGPOjJEkUWbcSXIyA5OwNAFcUzr8QxtPQtMIM9z2AHvjgcf1K1EtGvnTOXcUGJDcTPiQCpTdY+dCsyjLqioOfkrtQuKeF4j0c2aBh3O8XLlbuA2Ys0TAMR+jRpFz0frGIrKV2RNV4Z8p+gvyWMcOt8q8plDMTmeiNvE0IR8BUuodPhKBUhcjiFgTP5Ppu0Q15ii870IilkPgWAI8HKqk73OqHbpCuImi26Ku0ZHhCKQIDAQABAoIBAAY/6Dl0snY2PgSI8rrBjTx57Y6gox9tNv32+/+s61H+lY5Uo6eC81UM/S1vnjVz3teAU55+Or6pDjOCB6fhKVR4h7tDxeH66VCfKwAWl9WHmM63TiJRj7Lc7o3Ozt7ThcAfvyTYT3FFb2HmvXhWu8eePcnTMecUMeWqnTrHNHJzb8fm258bsLp5oHpNgcFnWhDxxbLo/3x0Z/ooaNhqF2B/rdQZ2uDVIyXjFIqZ6CZJM7dANpoCeMqlRTyO0cwiwKiD4iCvkqN36PLZ1T0BJygfYncNKzW9Hszk0wyBxo3LcSAeuOZhORdBf9RDt2C21efn5dtrKJsW/2BtyBwhdmECgYEA2JVLb3cVprdUSbqLqhv90u+3cMpITX29SqHxotR5xDzXy5B3JWJwj8yGWhJkKeRd2sF5IhmNRur14Wi9HoXefDvnf0bsJk6qgM0+Xc5qfS9n36I20qmloDWLaV9gT/DvXQjSKlG5y57/kIwZYbTDRwWY5+j89QXRY0uATgmqckkCgYEA07BkGYZeuK6uj0HI/Ee5R9zOyk1D0iCl9nNb2t/QFoTQ8HvEA5w/3lnvmi5Y4bcgNeSAhzT9OcgCYvqNtd4ybV7wv+JmQcLmWwT5o62Iz+osUHD9J1SIgHj3yT438qk2RDfWLMOwJpMUDbAZbg74P+p1hX9yVaPW2eNwsfJbUOECgYBaXJeXjtiysQRyqmkA9SLGcgtX/J2D7zUdwUk+hWW0USo7nS+IonSSGmPniorNy6C410XBy2VdNESX4godhP7ZWGjyelWmeeW7TWZ63tchGbk93cD/zZXzrMNYmFlnoP9NEpQU4fohkVnRJhKk6DUdGaG9CEEZvW6p/eMvK+s4OQKBgGscwLmtpPYb5VW1esY0YIr9LmFs0Rlczb0zR9IrF3adg797UIZnJGYU6ckBFJY5fAHo+iPv6wW2r4Z3swbIRInU1Uqyev1haf+6N7rbTvOtUPjvAxlIi709+FsKsXKGrl+8RRHnfpU2LJp0dZmb13832nlPMIIm4crka5yOvifhAoGAZPRuZuZllIHoOWyY5/i+WBKfKetJOWEbQrEhRRPoWJwNYf8YbjWJUp/VvxrX7DYIrTtNJ0l8QQS0ItKsg5Boy4Ku3c4xT1SiILsHpRmQhvHFtWf1h0cgLNR6aut6BeSj0MEYQ7S9rB3H8FSj1Ma4BsXO+d1kFmM7yUr5h6DESnE=
22295a93-faac-4e17-83bc-768982316c7d	6e23b7fc-7246-4644-a429-221af7fd1a54	certificate	MIICmzCCAYMCBgGXuK0tvjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNjI4MjIzMjI2WhcNMzUwNjI4MjIzNDA2WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCzGEiApYLoP/FiuynrtIiWY86HdW3EoEmjgfie3qMThJyJifyOXGXFe4SF1mvoaIv3KDHnlvQBaghkqLqqu7egpkob06H2UnxIuJ6vBJN+VFsY86MkSRRZtxJcjIDk7A0AVxTOvxDG09C0wgz3PYAe+OBx/UrUS0a+dM5dxQYkNxM+JAKlN1j50KzKMuqKg5+Su1C4p4XiPRzZoGHc7xcuVu4DZizRMAxH6NGkXPR+sYispXZE1Xhnyn6C/JYxw63yrymUMxOZ6I28TQhHwFS6h0+EoFSFyOIWBM/k+m7RDXmKLzvQiKWQ+BYAjwcqqTvc6odukK4iaLboq7RkeEIpAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAG0j6eQPsqhWAl4nRdUgLqvBPhrtV0ZloOXVDtQFUJvVVWKr7sEHtdHSMcXX/JzOArRNMHWInxECpaj6OWdMDTh7gsfQw98RWhKw/PoYkE0/48Fzq7WAe02o7Yz+Ubqz2xCzZ6n9sjYUspxpppXhAx18eWdrGaA+or+wMfsofquIBjZzbP5515pXAV5xNd9oAnytN9knDFu4fM4ln3DweN6D3Ax4ZKWnSy8fFHZpUNYCIgkimu2dCwpMNFE6u1VCdYmnas6ey88BdiC1dtJDGCaGWMXb7a8G6Je1/NdY+B4iZcMUEclOQIIMy5/a1pVgJduXkp78I16ZNpTWyyuZXnU=
348bcb59-22c4-4857-9087-01c1db8a8f86	6e23b7fc-7246-4644-a429-221af7fd1a54	priority	100
d784ffc6-a90f-444f-97f1-aee254d019d6	6e23b7fc-7246-4644-a429-221af7fd1a54	algorithm	RSA-OAEP
d09287d9-4b09-4b63-916f-c0d7508a0290	6e23b7fc-7246-4644-a429-221af7fd1a54	keyUse	ENC
2b601c22-a022-418b-972a-67ace2b1f2ad	9739e578-0a9f-4f9a-a95f-98450fa62ef7	certificate	MIICmzCCAYMCBgGXuK0rFzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNjI4MjIzMjI1WhcNMzUwNjI4MjIzNDA1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDWIntwzC+K9wUjzOH+RaRTXtMbC1OIfrfmNA6nPDek1rLs00FVv4iNcjf/WvvpDzfVEY3NG8jFcw05ZtcxVo0tpW8IL8Eg2j5gxT3XYOA/hsFIC5siWMhbyOjMxqShcZtoshK/dlQjT2VGtg0en2Qf8g3Uq/a7n8wHjhQ1fxspMp6oLXU/G5B9Ln9Q+aMUhjZTSbQknxdKBdysvtlSgLXiZCAEhhLvrX0aBXJLVXUcjw2kk2GbzsgH/T7zKB17R+InnUw5YfuXriaZ7RMMTPssnwdEsZdPdUDdzoNNJu6XIA/QyQQXA7djO/Q0Go+WSguTvKwmPCwif8ZZo1FKCPbxAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFfXESy2rFs42871LptH/Xazz6qENXM9YOKXkmyRvJ2c0T0mbkSnstYYA+BRpCFJ8CxAYKj3eqs71XFqtdkA/URutwbcuiiDhAqajdcqEtgxq2SPwzhzIgCfrIgNZvcTKsoLYfBa+KnKarNBjS623CrCZnOVe6VZWOIzNjb3FlVO676wWLJw5K71i8HmF1BzkADR+p3WAUxuBPAaRdyX+RcedvJPy7Qk5yo/snKXPwH5Mv96q8v+M8Y79N1hQWMkHUCffwh+5SVuRWDgayotpUCFQ4MzhKeNidCEK2dL8Dm0JU71i1VSfoEdZukV6iPcBJ11i+hFunFebWB76c5RlUk=
91fdfa7d-151b-4011-a014-4b0dbbf945f5	9739e578-0a9f-4f9a-a95f-98450fa62ef7	keyUse	SIG
adfcae91-7caa-4efa-9a96-e318052b165f	9739e578-0a9f-4f9a-a95f-98450fa62ef7	priority	100
2bb4c8e8-b85c-4220-9c8a-b8cf4aa2e589	9739e578-0a9f-4f9a-a95f-98450fa62ef7	privateKey	MIIEpAIBAAKCAQEA1iJ7cMwvivcFI8zh/kWkU17TGwtTiH635jQOpzw3pNay7NNBVb+IjXI3/1r76Q831RGNzRvIxXMNOWbXMVaNLaVvCC/BINo+YMU912DgP4bBSAubIljIW8jozMakoXGbaLISv3ZUI09lRrYNHp9kH/IN1Kv2u5/MB44UNX8bKTKeqC11PxuQfS5/UPmjFIY2U0m0JJ8XSgXcrL7ZUoC14mQgBIYS7619GgVyS1V1HI8NpJNhm87IB/0+8ygde0fiJ51MOWH7l64mme0TDEz7LJ8HRLGXT3VA3c6DTSbulyAP0MkEFwO3Yzv0NBqPlkoLk7ysJjwsIn/GWaNRSgj28QIDAQABAoIBAARZeRTJhffydGuVrVu6CAhkPUEf79V+fu9lbGyF0OrHjGT6dcnXSQ+X88abX1FspGV+3LivRTrK/2hUhB+ZvqaAJS8nMqrfWfvi18KqomVx8BY9u5wFDgVMwXtK1+RaW5Xy44X5ciQxODk5aI7wHYNXWiPxLgLhwB4BaxxK0Zc6qSSycvGQBgYQ7hdm1J1AAZyOTDA1M1vJX4AsStrOyfhDUVVeAgaYX/0nOVoA8MQrUn81Jy4AWvmOBYoDdQfOTr3c7H2FemDW32qMU6g4c8gBZq0JN6XEGa/ozp7dBTMkyyAxN9kpq3Y/eozoQyQJp0c+RHY7AwhhZDyHprNpicECgYEA+z7QLdzrsEPNp75wAeBGwZHDPelKwkF2b8/y2n880uhoC/NjA6v+WVFl/QZYlktGMtZR2PbszCM5PX3mFn9jQjH++6feMDuxgCACdwHkBYqwgixb8XmLq0IZEkbWY1ISfrpKdpXoYQRU16VCJ0R0JpUiPX/krDGKNZ5z1ij7fzECgYEA2i/h0z0HjvTEzPrL4JQghVe8hqYtv9PoNHiMGGIWY1tuKNMo35+5K/m3jlJ0D/exguDhlLrY7Qr/9tOAl24PVRsx89Zzq/OrvCmOdCzolJ7bEuMoT8StVydi+6i3iaO+II2yN1MRuNMwd+QP/NtsqhuMjvtxnYFpBlTf2DHYg8ECgYEAnrpkU1VLIaT0fJF3ufezO/+W1bpZnLg21xUNXLUd/DEP6tztJRi4LD2crWog9XLA+sUkGGqH18A5HXw4rOX2E4/6g4reeKJ91XBjnkP3hvjD4rmbrMcZUi0EIePW9hCX1rBi8uBqW0CdSVACp0Q8DVQSub/e/Fqf8pgUnqxtl0ECgYBAHhAT3nxpIz7uKcld/smrxcOuIgmRtLkpKj+pLrH7krPFpX/+b1agOKsbVNmsk5KDrog8B8iVqETeCPtiBMLWtL4yNNQbNOlDy0aEl2nluuUQINcI0fhKg1WQNN1ywj6uHFXB8lRj5xP4N3oHSYgeWSguIHAb5Bqz9J8vTj6dQQKBgQC/XMsvUKI6e36V1ywsWHPAMwwaTxdV9Cy6aW7zosVvW8PgrKYMarC42ugE108cZ5BPlHA8qf/neGWWR5rcUVqiCGLqy7JQCFG+bSB9+NbciKjhPiVmAvDPFljE+Cd1HetOS/Vj7Anl4xtnSRdQAYv4h76eQhsulRLIjarbOXfgLA==
530773b9-4c5c-49c2-970a-1d6c60f34b82	fbd02e55-04f5-42c1-a747-3baf6774b5a9	certificate	MIICnzCCAYcCBgGXuK6bATANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAh0YXNrZmxvdzAeFw0yNTA2MjgyMjM0MDBaFw0zNTA2MjgyMjM1NDBaMBMxETAPBgNVBAMMCHRhc2tmbG93MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmuB+ZxbHZLjKjWKq9oJTwaNQn5VT3eTjAzOwGvnrcPGobYKnh+mZXSAy8tirv+z9bv8oVTOeuiGBcWPHG+EUWIonRQ8zp1asHKuMo0FV8LcIAQRdFSAHKqhzOa4NpINtJPmRGWkH/MecWnKGGRQpPHIW1Jy1abAhN83Pb9rp7lAgMJziPtKBaaJFQcaL48RhG0unhmtZeukWep8mT8vc7f+q8oyeA/wye7ajRjlXMy28hMllrN5gP3XaZKpkXrmmUv4PQIGi+aTCfZR3BcbdQv7glqz/ZF0oRW7o1Woci3xQNKQLYt+aadGAH0IjZj5Y1cz5g87aqm3f9lk2j40cuQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQA9N5Qk+DeJnezJWMz7i5lilzlWLlYAdqcrblCVi4pE3frnP7wA9blSHO4Z+vEVYwor8uQDWbhWHTInYbcjyg4zClc2CAjOPhd/F5RE4wvp1a89i29+urHMzNhL8ulYVF4im2yCQZsBURViEmcS5peT/nQN6el64JVuu1vmvT8sfF9tD++jmXbmTAw3eWFewGwfio2TsFTNT3ehfnKukFdSBCzoDUYQg+g1Px1NOXZ0y6DGSEH0JFenvyjho2YQmkQE/s6ppconeWHyw8rt2O3JSJtJcq7RCMvN0PBqQy0/nc769ce8MsWL5dZnjS0KUayXnwdIZMFDDgRYzjmpXSv2
89eea2b7-adcc-4a68-a185-9826b5d4295f	fbd02e55-04f5-42c1-a747-3baf6774b5a9	privateKey	MIIEpAIBAAKCAQEAmuB+ZxbHZLjKjWKq9oJTwaNQn5VT3eTjAzOwGvnrcPGobYKnh+mZXSAy8tirv+z9bv8oVTOeuiGBcWPHG+EUWIonRQ8zp1asHKuMo0FV8LcIAQRdFSAHKqhzOa4NpINtJPmRGWkH/MecWnKGGRQpPHIW1Jy1abAhN83Pb9rp7lAgMJziPtKBaaJFQcaL48RhG0unhmtZeukWep8mT8vc7f+q8oyeA/wye7ajRjlXMy28hMllrN5gP3XaZKpkXrmmUv4PQIGi+aTCfZR3BcbdQv7glqz/ZF0oRW7o1Woci3xQNKQLYt+aadGAH0IjZj5Y1cz5g87aqm3f9lk2j40cuQIDAQABAoIBABBXbZ7s/V74TI78gTN/btz4oXIlLHM2Smm1E3jVM+134iCj749cq4zy781F5WFb3SXQEG5lAvN6w5C2SXT8m8v3z8runrGiaIih5TX4l9vNRC/vSO8IsRjkKzxDzDa2k1aaap/2wBwA59N3UATnZq51D0mhu1aKegbMVX3k6Ff3vDin6msm1PllDUpNDLxdn1/YrZYxfpV4K89uH4x3S0wEzlQ+R5USXDyn3Rp3IWmN2IOJpzhxTXU3NcIGlBad/dP/8XS8qKBWgaU7jcQIJqW+C/RU+Grw0D1CKcMgA5RKoG2L9gy3CRMGr6U/VqAIrdWPR14PPMzRTOswUikW5W0CgYEA1xU6n8GFY0PoRP/UzX7TJkFKWKlsTjEM69ZbjwqS7lTa40YQxPmeA+lHvhvL/q9MbqwcpYIOrpS7mdBVx+CsFftYJJzyGoUWFoccAVDkCJrk3wI4T+82lQPw72AQB3GEJuALQ2wzVc+lL2VF9IZKBfP0ahmHf764gq7MXS87vgMCgYEAuFcq6R5L0T8VwClGmCxcakuL5gZPBIPYDADIKez4YFCnHjCgSGxwRhRo+xHpHIQOPrpGP6B7SjYMvGfklOVWqeyXiRm6NGr2xnq9NTHCyEur6sLPEBXsl/3p9r7F0wtzFNn4DQ6C4ubQvNSHm9nMMqpF9bqEjldAKm58xONxq5MCgYEAkWVhdwOsdzk9t/81zSDx/kdeyebmN0mDUZ5b0Ku2PfUQ71i7F10jC8PUYtiJo4a/ZYVl7CCqaixTUZx7kJ351vZNVJrgMztKfjohnWYgcQy8sWDfznGIdV3vrvJCg7WiP2FvW8m2Pkkbgpm0m6N4QOP0kxDk/19ffcBKmKfIfB8CgYEAkiJ4IAombKEoKwgNsMEqGhH9u8KwjZG/ifRsud/kHuaRNTuzNPbSIpw3hSHzvOlrKYsd+X7Nfk1O12U9LlSI2Xh3wPYmSTuqmjnfGPZzxblHdnotEEFxKCTgfv1Jcj8XYiZRoHgqhpoYTDnnr0N/v4KAp4bPYtAETB7+xk7QZAUCgYBD3Ax1o0lavQw1abzeWPzgCUnL8EFt5RueOHYhkaKsRlh6dudOIgYlKgtisJSFYvrsENDN6XgwAZCY4251ykJKGVy/QL6lajN8jW72YWE5z8awA69Gf4NoGqu9vu6DvF5qHFWnJWvhZOvVAUr+vq/M75r/1iFMrkyJ2y51fqHltA==
092fafc6-4225-4cb4-a1f7-2fe9c617ba2a	fbd02e55-04f5-42c1-a747-3baf6774b5a9	algorithm	RSA-OAEP
08796b0a-28f7-4352-807b-b1dd6f0e8557	fbd02e55-04f5-42c1-a747-3baf6774b5a9	priority	100
560a5cc5-2559-4f0e-9c9f-084df676b76c	fbd02e55-04f5-42c1-a747-3baf6774b5a9	keyUse	ENC
0234c142-82d2-4576-a905-ba65addd2c6b	635d4560-232c-49a7-905f-9845ccfed5ac	priority	100
7bb9a37a-f396-4c13-bbfb-6c82e9fb8559	635d4560-232c-49a7-905f-9845ccfed5ac	secret	OrtkGIIe4cO0MsEBRPaH5g
53aa8c6e-6a72-47ac-91eb-f381113e41cd	635d4560-232c-49a7-905f-9845ccfed5ac	kid	e5b2be2e-4d97-4af3-967f-6d2f2bd9a109
fd425cdb-4636-4f7f-8a5c-6a76966d0aad	b3dbd712-6405-4ee9-b2c4-5009d6add69b	keyUse	SIG
a7e50374-8b37-4923-9db3-cfdd49cb8021	b3dbd712-6405-4ee9-b2c4-5009d6add69b	priority	100
208441cc-a52d-4c65-a115-d23c42148ec2	b3dbd712-6405-4ee9-b2c4-5009d6add69b	certificate	MIICnzCCAYcCBgGXuK6ZlTANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAh0YXNrZmxvdzAeFw0yNTA2MjgyMjMzNTlaFw0zNTA2MjgyMjM1MzlaMBMxETAPBgNVBAMMCHRhc2tmbG93MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0aXht3v51VI/3zQM1epnqwiMQqPAEXiYRlE03BNyGPgtI+uO90R8ADpymTOAc5QeSmK0lCojymBVj2jRKuK5+OD0LieWOonif4jLMAYHyrWeC7Cbuqihzylw4vzLo7OH+vdZIzKah8qUS2t/34xvO2OYbUUyUmiLkI1zN+NuHiK+uZLao686SY3t+My+k15B84ysbgsOjs5an4NJLebXB7vY91savQhSj7+sV20MCXDfURUWgMs9x4L6liGvwWYCqxncY2yzCawN9ahSsZjdLfd3CUw3oG+7zv3tpEjQ7BmiOg7GwzqK0XkSW1Mrt0lKULfDUxGICtvc3p2W8ZeYnQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQA1iGBFSxz+C6nwJPfxWyumaslOB9l94jp3JJph7jBTAy0++4ajGZ9JyTLH5M6PfP7u5GCI232OthVqiGxVAv25gjYZE/e7lzvT+jqlqsGyfPJS8Gc6sKHDSsRRBn+z7W6xCcf+ovmgQpgMg2OaC0VrXMK04POGGq9VVS56F6T/J+tmatJdsFnpTHGHtG2Y38dvc5u1eR8T2/sWyNM896gJgGEk1DpnA/Wu/sh960PktQ2OVP1EuIbvmpfCWg0DoR/tP8wVCycDmAyHpZxIoXdGHKbRkEdVjDz8asU2IzimrNntLu9M13gtK90dTASA/ojVJK+NW78Pm99uBO7Ye+d3
b05579a9-48a4-4a8f-a634-0e11f3732d58	b3dbd712-6405-4ee9-b2c4-5009d6add69b	privateKey	MIIEpAIBAAKCAQEA0aXht3v51VI/3zQM1epnqwiMQqPAEXiYRlE03BNyGPgtI+uO90R8ADpymTOAc5QeSmK0lCojymBVj2jRKuK5+OD0LieWOonif4jLMAYHyrWeC7Cbuqihzylw4vzLo7OH+vdZIzKah8qUS2t/34xvO2OYbUUyUmiLkI1zN+NuHiK+uZLao686SY3t+My+k15B84ysbgsOjs5an4NJLebXB7vY91savQhSj7+sV20MCXDfURUWgMs9x4L6liGvwWYCqxncY2yzCawN9ahSsZjdLfd3CUw3oG+7zv3tpEjQ7BmiOg7GwzqK0XkSW1Mrt0lKULfDUxGICtvc3p2W8ZeYnQIDAQABAoIBADCsWhi+5FSWCXU5QOejSdlIHURVf0CvJm9g6CxWKW3JpLVLucAHuuBUsYmHDwIGd/feLb2egPu53PN0KufRhsrU82wJzdOecqMYb9Ag/kseWmitYqJ2B0cxAF/6wA6sHlxyc9P7qivvqPlPpnsQwDxiFZ/86j9+vTRc2sy1dTnyfJEa76g5YEWi2gMaVZq/dJrTNospvcU2I7pDVMo3wvhaOHff2NzhzeuK08CEtxne4ckjX0utEzYrnWyi0j8/O6JWway9GNsER7+rTkkuLimgLGv7drwQchaST1nIqlazYzv/70pHnJ2W/zrUtMqKbKU2uffbEral2oTsHMb+v4MCgYEA6UhY0bfi7xYvx4u0PWQo9O1hiXn1yMkzQK5m7IdyypgAv7IKmHnL4rPBtjKQH5lRh926ENIOzG1hLoc4p6gZpOuJPja4afKiN3Ioi/3jh6ebl5N5g0gHuEE+j2YowTMTjArpp16Bk/91UzU7dmQEOnnVB22H9EmjhEl+hPMJ73MCgYEA5hBU7vuUSr8Fa9aXOgWbhfjJjdYFQZ3vJJoiG1OW7pQjB4kha5QpSPq+bxe9dXvxNp/yilaKuhlZuL0t0GHBWiE12Nfilg/td3Qcnn2Xad6VT/3FRB9ZkS1rAlfd/N9lzgyRICFQpI9Pa3+AX87t9LtppnGFMW84+4kwtThDM68CgYEAzYdcGYk1ewfFGL3RErWIECKEaKb3EOuTKE1/iKzdSfkZz8qA402LgDR3Wpq5t91Qo6+KGv+24g0MLf4cwDmuPkr2I8X6O/31RXxilNQe/omA386ipDN1+bQh9h0/ktf5RMzohvkQmN/c8m5X8Tq1Lv/f3Cd4PJYUZpyJx4CJJFkCgYAiEoUhp6y8rTG2WN+ovi/cVY40LWA16ZgDSbiHZ4fQ6auOcCa88gJzRn9xoIh0n9iHiIS5LDv7d8mr7IiedfvWx1hcNwzdwJoguNeMOXl1OnvOjvzqK+Jt99YDUNQVoVhIfd/4bDavSHIwr39psRHYzvDEr8dUHO7JgfXuwNhjDQKBgQDLOeUQuY54W8LAhWDTL52/xNGbGghi/WSL8bxjhYjWn5gIh57ZeBF9BdCCMYdj5sNm6mQlfsVZXcz0VnSnNIQky3kYLDqLvYKkIppdQQyCbE476A2DJy72Dq/r3P1KG7jTxrfmIqDPawcj1cgJi2tCXqH0XXdIjxBnDqgfYi87pw==
7e5d9f1d-999e-4e8c-b88d-968c5f57fd1a	634be8e5-55e8-415d-9639-22c120bb407e	secret	0jDHLWRNj9X-r2tmeB0TjaJ1oEodtSZ2vObUILdqlXE8PJit3K2u9i0qYp4J7XK73q9usLlGeFjg-aEddjsdpyR4wTSnj-FByOZVd4aAwFm235D-THuyq4zBkX7ixTkzr7anpAUFfh5nBOy5TA6x6WvbTSPOHO_ojMhEC1SNb1I
bddc819f-c049-4c93-8aa9-a9cccff802ce	634be8e5-55e8-415d-9639-22c120bb407e	priority	100
90a0ec77-f275-4f97-ac46-ac2ba313b12d	634be8e5-55e8-415d-9639-22c120bb407e	algorithm	HS512
caba2644-c9d9-40d2-a139-e57e8e0c61b0	634be8e5-55e8-415d-9639-22c120bb407e	kid	941f55cd-7ec1-4f67-a453-fd744ccc64f0
3065c4ee-b590-41b4-8404-e7147bd9c201	1773d064-e7e0-4965-bafa-6701bb192f94	allowed-protocol-mapper-types	saml-user-attribute-mapper
d57b8643-7158-4574-8090-b685cce80809	1773d064-e7e0-4965-bafa-6701bb192f94	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
a30f9cb6-0a53-40ff-80b2-d7b1bdccb541	1773d064-e7e0-4965-bafa-6701bb192f94	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
1f7a1792-05c6-4f3d-af3f-ee340ddee56b	1773d064-e7e0-4965-bafa-6701bb192f94	allowed-protocol-mapper-types	oidc-address-mapper
dc2eff25-86a5-4221-bf4c-485168a5b763	1773d064-e7e0-4965-bafa-6701bb192f94	allowed-protocol-mapper-types	saml-user-property-mapper
0a274599-6279-42a0-ab59-e5686c20e7b0	1773d064-e7e0-4965-bafa-6701bb192f94	allowed-protocol-mapper-types	oidc-full-name-mapper
95f57159-ce02-4ce4-87bf-1d9ac57fc341	1773d064-e7e0-4965-bafa-6701bb192f94	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
6443af71-2d67-41ce-8b01-a54cb6998895	1773d064-e7e0-4965-bafa-6701bb192f94	allowed-protocol-mapper-types	saml-role-list-mapper
6f085ee5-e1a6-414b-b8bb-0ffe70c9b2a0	d9729313-17b1-4b60-a4ed-ec61ac5f8ca0	allow-default-scopes	true
4c02488a-2a41-43eb-9a2a-229f2962418b	3680750b-c0d8-4526-9d43-ac402f80686f	max-clients	200
ffdd8f18-508d-41a8-8e9c-8e8eba5d8083	7ea63403-526c-4e9d-a285-c211b5cf33d8	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
a13098da-d34b-4791-877a-1d347c20444a	7ea63403-526c-4e9d-a285-c211b5cf33d8	allowed-protocol-mapper-types	oidc-address-mapper
1d758f43-33f4-43f7-8c46-1a91a0f4e71f	7ea63403-526c-4e9d-a285-c211b5cf33d8	allowed-protocol-mapper-types	saml-user-attribute-mapper
f25fe32c-e644-4f00-b258-a77404dba241	7ea63403-526c-4e9d-a285-c211b5cf33d8	allowed-protocol-mapper-types	saml-role-list-mapper
8725d061-bbb9-4603-ba78-83122f09af4f	7ea63403-526c-4e9d-a285-c211b5cf33d8	allowed-protocol-mapper-types	saml-user-property-mapper
fda505fa-8051-4e32-b801-9b809a1845ab	7ea63403-526c-4e9d-a285-c211b5cf33d8	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
6430ea54-9d1b-48ed-9f99-b4ca6633f9b0	7ea63403-526c-4e9d-a285-c211b5cf33d8	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
e8b38cb0-3c94-4ca5-8842-a6a50bd4ce09	7ea63403-526c-4e9d-a285-c211b5cf33d8	allowed-protocol-mapper-types	oidc-full-name-mapper
6f1a4543-a54c-4ada-b903-c9cae36a4e7c	3abdffd2-f09a-4896-a799-a259c97ca49b	client-uris-must-match	true
836b0080-5e19-4fee-a8fa-44316afa924f	3abdffd2-f09a-4896-a799-a259c97ca49b	host-sending-registration-request-must-match	true
3d849017-5db9-4d2a-ad84-c4687517d312	5ec6e58b-245f-4783-856c-40233128e5af	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
3032665b-2718-47ec-a299-d5c66bbc5f85	1d9191b8-eb93-4735-8b47-32f617527acd
3032665b-2718-47ec-a299-d5c66bbc5f85	d946fc2f-05d9-44d2-9670-ad1fcb4d4471
3032665b-2718-47ec-a299-d5c66bbc5f85	5927a3a6-d932-43c6-bace-2754c398ae77
3032665b-2718-47ec-a299-d5c66bbc5f85	580656c6-3944-4e61-b7c7-7f652b40557a
3032665b-2718-47ec-a299-d5c66bbc5f85	afc10619-6c13-4251-92ec-8913abc32409
3032665b-2718-47ec-a299-d5c66bbc5f85	329de2cd-fd1d-4ae3-8083-ca798c279b13
3032665b-2718-47ec-a299-d5c66bbc5f85	f8e94721-5ac4-4f65-a15f-688ff8058203
3032665b-2718-47ec-a299-d5c66bbc5f85	361102a3-bdc2-4698-a706-119a85d611db
3032665b-2718-47ec-a299-d5c66bbc5f85	833fcdf6-a775-4b96-a24b-2c410a43153f
3032665b-2718-47ec-a299-d5c66bbc5f85	2e1ee562-5dae-4b18-9d22-87dd8b013ffc
3032665b-2718-47ec-a299-d5c66bbc5f85	fa4004ae-fb5d-4945-bacc-f24f4ba317f3
3032665b-2718-47ec-a299-d5c66bbc5f85	561027b8-19ce-4560-8e03-5dc50018d105
3032665b-2718-47ec-a299-d5c66bbc5f85	ed5df0b4-6355-43cc-a891-7da247bad8d2
3032665b-2718-47ec-a299-d5c66bbc5f85	b6c64cc4-e495-45d0-905f-4fe672d4c61e
3032665b-2718-47ec-a299-d5c66bbc5f85	6d8a1ff3-9806-4b0a-b440-d125885887f9
3032665b-2718-47ec-a299-d5c66bbc5f85	34e58392-061f-4466-b9c3-035b4c432236
3032665b-2718-47ec-a299-d5c66bbc5f85	43772d8d-0e6b-4ec8-9535-e10669c8f612
3032665b-2718-47ec-a299-d5c66bbc5f85	690e4f37-d463-4cb5-bdf1-f3877b5fca7b
55586ac1-5a47-469d-bfe8-1a5ab889be4d	c94be786-7ef1-4438-829a-35ed30e1d538
580656c6-3944-4e61-b7c7-7f652b40557a	690e4f37-d463-4cb5-bdf1-f3877b5fca7b
580656c6-3944-4e61-b7c7-7f652b40557a	6d8a1ff3-9806-4b0a-b440-d125885887f9
afc10619-6c13-4251-92ec-8913abc32409	34e58392-061f-4466-b9c3-035b4c432236
55586ac1-5a47-469d-bfe8-1a5ab889be4d	dff67640-1709-4fdb-b143-cb37ebbe7ea6
dff67640-1709-4fdb-b143-cb37ebbe7ea6	813b2b6e-d699-41d8-9984-1291846d3303
29a17387-ad02-4a65-882f-4e4fe8c8a319	3f56b19e-ddbf-4d30-9b3c-7e2a9ea8b5b7
3032665b-2718-47ec-a299-d5c66bbc5f85	655763ba-88f4-4d68-aff6-a1422d0b7fd1
55586ac1-5a47-469d-bfe8-1a5ab889be4d	d094fd58-34a6-4a6d-988a-5482534c71b1
55586ac1-5a47-469d-bfe8-1a5ab889be4d	8989e753-76a5-4767-b763-a0ad7862cee3
3032665b-2718-47ec-a299-d5c66bbc5f85	1e7d5ff7-26e3-4ae7-94bf-db59431be3b4
3032665b-2718-47ec-a299-d5c66bbc5f85	1d3b6e13-c380-4a30-b2d2-b664acff8429
3032665b-2718-47ec-a299-d5c66bbc5f85	6ffea228-ed9b-4cf1-a6f4-f957d6c898f3
3032665b-2718-47ec-a299-d5c66bbc5f85	45ff3ef0-842c-4e17-9b0b-45e1fbd0d591
3032665b-2718-47ec-a299-d5c66bbc5f85	0f99ca53-2f37-4f33-b880-f0b19927e318
3032665b-2718-47ec-a299-d5c66bbc5f85	2d613f79-871b-44ec-9902-a257d440f4c5
3032665b-2718-47ec-a299-d5c66bbc5f85	0a33123c-3fe1-4d38-ba0c-0c1c213c3809
3032665b-2718-47ec-a299-d5c66bbc5f85	1a23d9e2-b784-48bf-84fc-d79c6fb3fcb8
3032665b-2718-47ec-a299-d5c66bbc5f85	f68a577c-6766-48d3-b24a-e1f09a8ad41b
3032665b-2718-47ec-a299-d5c66bbc5f85	53aa74f0-38cb-47d4-a4dc-91e82edda20c
3032665b-2718-47ec-a299-d5c66bbc5f85	d1cc2f58-cf27-4a8d-84e0-1f85ad0173fd
3032665b-2718-47ec-a299-d5c66bbc5f85	fc293a91-e61b-40c1-a2a3-fd2e9fd62b76
3032665b-2718-47ec-a299-d5c66bbc5f85	803c2d05-3fae-41ec-86ac-8e84cfbf14fb
3032665b-2718-47ec-a299-d5c66bbc5f85	7737ac08-6375-4c26-b752-5cb87357513a
3032665b-2718-47ec-a299-d5c66bbc5f85	5bf815ac-414b-47db-b6dd-dd80b059c624
3032665b-2718-47ec-a299-d5c66bbc5f85	70f890cf-efc0-4977-86a3-ea030a401f01
3032665b-2718-47ec-a299-d5c66bbc5f85	e9322144-90a2-45d8-b471-a321e6494bc2
45ff3ef0-842c-4e17-9b0b-45e1fbd0d591	5bf815ac-414b-47db-b6dd-dd80b059c624
6ffea228-ed9b-4cf1-a6f4-f957d6c898f3	e9322144-90a2-45d8-b471-a321e6494bc2
6ffea228-ed9b-4cf1-a6f4-f957d6c898f3	7737ac08-6375-4c26-b752-5cb87357513a
426ee743-bfc5-4012-b830-ce201497bb43	26ed4a30-c40f-44a2-b51c-4c4f97a9dbf3
426ee743-bfc5-4012-b830-ce201497bb43	7bf0d35e-597e-43a7-acaf-cfc732cb393c
426ee743-bfc5-4012-b830-ce201497bb43	0d4264dc-dffc-4676-b2c2-b396648d3c81
426ee743-bfc5-4012-b830-ce201497bb43	81d16a2e-68ed-4524-abda-7ed737d9e5c7
426ee743-bfc5-4012-b830-ce201497bb43	aa6fe16a-5393-4caa-bcc8-d27888cafdd5
426ee743-bfc5-4012-b830-ce201497bb43	cda9096f-69b9-4f4b-80d2-069d6694619f
426ee743-bfc5-4012-b830-ce201497bb43	32fe97a4-3693-45d0-800c-799de973888a
426ee743-bfc5-4012-b830-ce201497bb43	6125e1ce-e8d2-4c9f-b702-10df52e1ed81
426ee743-bfc5-4012-b830-ce201497bb43	177360e7-f994-4f8b-a8ab-13fdf87a96b8
426ee743-bfc5-4012-b830-ce201497bb43	578a51fe-09c2-4392-a475-7a281ffa8021
426ee743-bfc5-4012-b830-ce201497bb43	1adedba0-ff56-4347-b529-598b20360187
426ee743-bfc5-4012-b830-ce201497bb43	45d19708-a2dd-4b6d-a7b3-3c6b462d50a8
426ee743-bfc5-4012-b830-ce201497bb43	f71e4b74-6a83-431a-b242-f5752c5a87e9
426ee743-bfc5-4012-b830-ce201497bb43	0f6dc1a4-a93b-400a-8bbe-511cc4d74574
426ee743-bfc5-4012-b830-ce201497bb43	0c34a9a9-a101-4e3b-a643-c3ba1519bbdf
426ee743-bfc5-4012-b830-ce201497bb43	7376f0b4-6078-47ba-9112-743457b9ab83
426ee743-bfc5-4012-b830-ce201497bb43	b0e273ed-8fe3-485c-b98a-f1d124741d41
0d4264dc-dffc-4676-b2c2-b396648d3c81	b0e273ed-8fe3-485c-b98a-f1d124741d41
0d4264dc-dffc-4676-b2c2-b396648d3c81	0f6dc1a4-a93b-400a-8bbe-511cc4d74574
81d16a2e-68ed-4524-abda-7ed737d9e5c7	0c34a9a9-a101-4e3b-a643-c3ba1519bbdf
c58a26c8-1395-442b-95b4-3c4801f3a399	1977f6da-34c2-42c4-a5ad-50f7a72fcdf2
c58a26c8-1395-442b-95b4-3c4801f3a399	fbb6d25a-1a21-4185-9c85-c93f7c1111d6
fbb6d25a-1a21-4185-9c85-c93f7c1111d6	da4ab7fc-0c5e-4de4-895b-376987aee243
bf5602b0-61a8-4584-a552-a9a99e2ff121	d8b37d93-d6a3-4f7a-bc3e-38fa508ecba6
3032665b-2718-47ec-a299-d5c66bbc5f85	42fb3347-0448-41d8-be91-bb116349f713
426ee743-bfc5-4012-b830-ce201497bb43	d1c6b533-fbb6-4495-bf8b-674f81440c90
c58a26c8-1395-442b-95b4-3c4801f3a399	83724866-841b-432c-88b1-154c7905950b
c58a26c8-1395-442b-95b4-3c4801f3a399	786293a8-c2f0-43c7-84b8-c8550a62a5f0
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority, version) FROM stdin;
7707336e-46d6-4bfb-a539-b40bb390d3c6	\N	password	ba0d1f73-b733-4de1-b253-a954a9a7d705	1751150047090	\N	{"value":"FHAQm5I0E+2wEFJPCxwy1Wt378N92v4MUAhSzqrSL9Y=","salt":"xFMDgIPLMPInUck7vfXc8Q==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
1a1a5d1b-196f-45cf-a242-f70a6645c92c	\N	password	bb5fee16-2732-4a59-972c-a6db9bd0005a	1751150239639	My password	{"value":"yxiGQLG5D+0z/wgTcxoN9hDDefhp5FGvbhwUeChzwSY=","salt":"pIUZQfyhcdn25v4U8g46ow==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	1
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-06-28 22:33:45.481742	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	1150023846
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-06-28 22:33:45.528097	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	1150023846
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-06-28 22:33:45.634861	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	1150023846
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-06-28 22:33:45.651321	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1150023846
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-06-28 22:33:45.869363	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	1150023846
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-06-28 22:33:45.894248	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	1150023846
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-06-28 22:33:46.117002	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	1150023846
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-06-28 22:33:46.171001	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	1150023846
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-06-28 22:33:46.21864	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	1150023846
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-06-28 22:33:46.541508	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	1150023846
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-06-28 22:33:46.699527	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1150023846
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-06-28 22:33:46.715017	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1150023846
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-06-28 22:33:46.765964	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1150023846
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-06-28 22:33:46.806382	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	1150023846
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-06-28 22:33:46.810263	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1150023846
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-06-28 22:33:46.815242	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	1150023846
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-06-28 22:33:46.821858	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	1150023846
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-06-28 22:33:46.93637	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	1150023846
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-06-28 22:33:47.043632	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	1150023846
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-06-28 22:33:47.055745	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	1150023846
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-06-28 22:33:47.062394	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	1150023846
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-06-28 22:33:47.068311	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	1150023846
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-06-28 22:33:47.430489	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	1150023846
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-06-28 22:33:47.441785	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	1150023846
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-06-28 22:33:47.444678	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	1150023846
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-06-28 22:33:49.003167	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	1150023846
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-06-28 22:33:49.300946	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	1150023846
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-06-28 22:33:49.307301	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	1150023846
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-06-28 22:33:49.412343	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	1150023846
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-06-28 22:33:49.436333	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	1150023846
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-06-28 22:33:49.471898	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	1150023846
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-06-28 22:33:49.481971	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	1150023846
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-06-28 22:33:49.494045	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1150023846
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-06-28 22:33:49.498873	34	MARK_RAN	9:f9753208029f582525ed12011a19d054	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	1150023846
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-06-28 22:33:49.545361	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	1150023846
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-06-28 22:33:49.5554	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	1150023846
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-06-28 22:33:49.565915	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1150023846
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-06-28 22:33:49.572516	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	1150023846
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-06-28 22:33:49.579197	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	1150023846
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-06-28 22:33:49.583231	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	1150023846
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-06-28 22:33:49.58684	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	1150023846
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-06-28 22:33:49.596335	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	1150023846
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-06-28 22:33:53.301873	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	1150023846
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-06-28 22:33:53.309381	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	1150023846
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-06-28 22:33:53.320525	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	1150023846
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-06-28 22:33:53.333582	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	1150023846
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-06-28 22:33:53.336592	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	1150023846
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-06-28 22:33:53.56997	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	1150023846
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-06-28 22:33:53.577518	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	1150023846
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-06-28 22:33:53.656254	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	1150023846
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-06-28 22:33:54.465864	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	1150023846
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-06-28 22:33:54.470933	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1150023846
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-06-28 22:33:54.475834	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	1150023846
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-06-28 22:33:54.481869	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	1150023846
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-06-28 22:33:54.492976	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	1150023846
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-06-28 22:33:54.500362	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	1150023846
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-06-28 22:33:54.56652	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	1150023846
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-06-28 22:33:55.317367	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	1150023846
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-06-28 22:33:55.356092	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	1150023846
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-06-28 22:33:55.366002	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	1150023846
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-06-28 22:33:55.378391	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	1150023846
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-06-28 22:33:55.386661	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	1150023846
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-06-28 22:33:55.392587	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	1150023846
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-06-28 22:33:55.398076	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	1150023846
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-06-28 22:33:55.402366	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	1150023846
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-06-28 22:33:55.487953	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	1150023846
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-06-28 22:33:55.553729	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	1150023846
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-06-28 22:33:55.561261	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	1150023846
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-06-28 22:33:55.635867	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	1150023846
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-06-28 22:33:55.644892	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	1150023846
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-06-28 22:33:55.652171	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	1150023846
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-06-28 22:33:55.672978	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1150023846
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-06-28 22:33:55.688978	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1150023846
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-06-28 22:33:55.691612	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1150023846
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-06-28 22:33:55.729919	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	1150023846
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-06-28 22:33:55.803317	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	1150023846
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-06-28 22:33:55.808649	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	1150023846
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-06-28 22:33:55.810498	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	1150023846
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-06-28 22:33:55.840163	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	1150023846
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-06-28 22:33:55.843511	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	1150023846
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-06-28 22:33:55.897634	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	1150023846
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-06-28 22:33:55.900453	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1150023846
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-06-28 22:33:55.911649	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1150023846
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-06-28 22:33:55.914385	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1150023846
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-06-28 22:33:55.991431	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1150023846
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-06-28 22:33:56.000397	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	1150023846
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-06-28 22:33:56.010417	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	1150023846
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-06-28 22:33:56.025689	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	1150023846
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-28 22:33:56.033238	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	1150023846
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-28 22:33:56.040104	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	1150023846
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-28 22:33:56.084619	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1150023846
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-28 22:33:56.094973	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	1150023846
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-28 22:33:56.097317	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	1150023846
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-28 22:33:56.126847	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	1150023846
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-28 22:33:56.133075	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	1150023846
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-28 22:33:56.151275	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	1150023846
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-28 22:33:56.375815	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1150023846
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-28 22:33:56.378689	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1150023846
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-28 22:33:56.393861	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1150023846
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-28 22:33:56.475785	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1150023846
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-28 22:33:56.478266	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1150023846
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-28 22:33:56.550317	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	1150023846
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-28 22:33:56.556734	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	1150023846
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-06-28 22:33:56.567666	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	1150023846
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-06-28 22:33:56.639	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	1150023846
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-06-28 22:33:56.74212	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	1150023846
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-06-28 22:33:56.824465	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	1150023846
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-06-28 22:33:56.83229	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	1150023846
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-06-28 22:33:56.905336	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	1150023846
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-06-28 22:33:56.907862	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	1150023846
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-06-28 22:33:56.92776	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1150023846
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-06-28 22:33:56.939432	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	1150023846
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-06-28 22:33:56.985397	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	1150023846
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-06-28 22:33:56.989434	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	1150023846
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-06-28 22:33:56.997695	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	1150023846
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-06-28 22:33:56.999566	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	1150023846
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-06-28 22:33:57.011804	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	1150023846
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-06-28 22:33:57.018446	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1150023846
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-06-28 22:33:57.49297	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	1150023846
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-06-28 22:33:57.498975	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	1150023846
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-06-28 22:33:57.508761	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1150023846
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-06-28 22:33:57.575825	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1150023846
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-06-28 22:33:57.582622	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	1150023846
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-06-28 22:33:57.585353	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1150023846
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-06-28 22:33:57.588955	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1150023846
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-28 22:33:57.598146	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1150023846
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-28 22:33:57.664149	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1150023846
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-28 22:33:57.931864	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1150023846
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-28 22:33:58.409477	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1150023846
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-28 22:33:58.731531	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1150023846
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-28 22:33:59.015652	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1150023846
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-28 22:33:59.017668	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1150023846
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-28 22:33:59.09551	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1150023846
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-28 22:33:59.174018	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	1150023846
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-28 22:33:59.211741	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	1150023846
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-28 22:33:59.240047	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	1150023846
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-28 22:33:59.456263	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	1150023846
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-28 22:33:59.469519	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	1150023846
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-28 22:33:59.481665	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	1150023846
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-28 22:33:59.544055	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	1150023846
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-28 22:33:59.552127	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	1150023846
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-28 22:33:59.561965	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	1150023846
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-28 22:33:59.612893	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	1150023846
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-28 22:33:59.786015	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	1150023846
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-28 22:34:00.167331	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1150023846
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-28 22:34:00.202436	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	1150023846
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-28 22:34:00.224253	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	1150023846
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-06-28 22:34:00.277786	148	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.29.1	\N	\N	1150023846
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-06-28 22:34:00.287295	149	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	1150023846
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-06-28 22:34:00.294956	150	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.29.1	\N	\N	1150023846
26.2.0-36750	keycloak	META-INF/jpa-changelog-26.2.0.xml	2025-06-28 22:34:00.306404	151	EXECUTED	9:b49ce951c22f7eb16480ff085640a33a	createTable tableName=SERVER_CONFIG		\N	4.29.1	\N	\N	1150023846
26.2.0-26106	keycloak	META-INF/jpa-changelog-26.2.0.xml	2025-06-28 22:34:00.311402	152	EXECUTED	9:b5877d5dab7d10ff3a9d209d7beb6680	addColumn tableName=CREDENTIAL		\N	4.29.1	\N	\N	1150023846
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
7f4bc72e-99dc-4684-8265-a601599a1fb1	2aff5466-31ee-4ec2-bafb-f8feba60fdf9	f
7f4bc72e-99dc-4684-8265-a601599a1fb1	44780d72-451e-454c-ab0d-cb446115f9e9	t
7f4bc72e-99dc-4684-8265-a601599a1fb1	ff30731b-f63e-40a5-9adc-c8c3f1aca3bd	t
7f4bc72e-99dc-4684-8265-a601599a1fb1	426406bd-19b0-4dfe-bdab-4789ed05a462	t
7f4bc72e-99dc-4684-8265-a601599a1fb1	dc446a9e-b6e4-4214-a932-0094e0604351	t
7f4bc72e-99dc-4684-8265-a601599a1fb1	b2542a1b-91df-4ba9-9c94-28912a990f39	f
7f4bc72e-99dc-4684-8265-a601599a1fb1	8c171fcb-fc9a-4a62-af93-d8cbd77739df	f
7f4bc72e-99dc-4684-8265-a601599a1fb1	8289f1a1-dad5-4932-a41c-56462a3c6275	t
7f4bc72e-99dc-4684-8265-a601599a1fb1	2f555480-3cfc-47b0-a9fc-29fbd1b967c6	t
7f4bc72e-99dc-4684-8265-a601599a1fb1	d131512a-e48c-4068-8e4f-3b717ae074b1	f
7f4bc72e-99dc-4684-8265-a601599a1fb1	d7a0b387-b843-40ac-b405-51b6fa3c3076	t
7f4bc72e-99dc-4684-8265-a601599a1fb1	2f849b7b-8403-4af7-800e-9aa2df44640b	t
7f4bc72e-99dc-4684-8265-a601599a1fb1	51bd92b1-1880-4496-b95e-59c1dc23ff13	f
d8293cec-b966-4170-8fed-d0f1f6161baa	009818e4-a616-4928-a16d-8e3128fd7252	f
d8293cec-b966-4170-8fed-d0f1f6161baa	72720f00-30dc-4b02-ad51-28e79c098434	t
d8293cec-b966-4170-8fed-d0f1f6161baa	ad28074f-78b8-4fb3-bc80-b2fea5e3cbc6	t
d8293cec-b966-4170-8fed-d0f1f6161baa	979c6d63-c3cd-4c71-939e-322210bb1788	t
d8293cec-b966-4170-8fed-d0f1f6161baa	6fad151d-1cd0-461f-82fe-0a2b68e8b6e1	t
d8293cec-b966-4170-8fed-d0f1f6161baa	0e7692aa-cb57-4895-9d73-d438b5b0ba7a	f
d8293cec-b966-4170-8fed-d0f1f6161baa	7b21d67e-0060-4822-8a3e-d246ed96bb38	f
d8293cec-b966-4170-8fed-d0f1f6161baa	5795a0f9-25b6-4881-a093-d2eec7b6ac71	t
d8293cec-b966-4170-8fed-d0f1f6161baa	5c6270ab-3ff0-462d-ac23-4f59edb7b549	t
d8293cec-b966-4170-8fed-d0f1f6161baa	a2581802-b167-4151-bf1e-2dea131e5358	f
d8293cec-b966-4170-8fed-d0f1f6161baa	c38100dd-d19b-478b-adaa-41d280f1482a	t
d8293cec-b966-4170-8fed-d0f1f6161baa	6a979929-d6cc-4b0b-a52b-f9bdf0b61688	t
d8293cec-b966-4170-8fed-d0f1f6161baa	6b541969-936c-4d20-990e-651490fd8064	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
55586ac1-5a47-469d-bfe8-1a5ab889be4d	7f4bc72e-99dc-4684-8265-a601599a1fb1	f	${role_default-roles}	default-roles-master	7f4bc72e-99dc-4684-8265-a601599a1fb1	\N	\N
1d9191b8-eb93-4735-8b47-32f617527acd	7f4bc72e-99dc-4684-8265-a601599a1fb1	f	${role_create-realm}	create-realm	7f4bc72e-99dc-4684-8265-a601599a1fb1	\N	\N
3032665b-2718-47ec-a299-d5c66bbc5f85	7f4bc72e-99dc-4684-8265-a601599a1fb1	f	${role_admin}	admin	7f4bc72e-99dc-4684-8265-a601599a1fb1	\N	\N
d946fc2f-05d9-44d2-9670-ad1fcb4d4471	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_create-client}	create-client	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
5927a3a6-d932-43c6-bace-2754c398ae77	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_view-realm}	view-realm	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
580656c6-3944-4e61-b7c7-7f652b40557a	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_view-users}	view-users	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
afc10619-6c13-4251-92ec-8913abc32409	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_view-clients}	view-clients	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
329de2cd-fd1d-4ae3-8083-ca798c279b13	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_view-events}	view-events	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
f8e94721-5ac4-4f65-a15f-688ff8058203	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_view-identity-providers}	view-identity-providers	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
361102a3-bdc2-4698-a706-119a85d611db	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_view-authorization}	view-authorization	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
833fcdf6-a775-4b96-a24b-2c410a43153f	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_manage-realm}	manage-realm	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
2e1ee562-5dae-4b18-9d22-87dd8b013ffc	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_manage-users}	manage-users	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
fa4004ae-fb5d-4945-bacc-f24f4ba317f3	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_manage-clients}	manage-clients	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
561027b8-19ce-4560-8e03-5dc50018d105	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_manage-events}	manage-events	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
ed5df0b4-6355-43cc-a891-7da247bad8d2	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_manage-identity-providers}	manage-identity-providers	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
b6c64cc4-e495-45d0-905f-4fe672d4c61e	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_manage-authorization}	manage-authorization	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
6d8a1ff3-9806-4b0a-b440-d125885887f9	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_query-users}	query-users	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
34e58392-061f-4466-b9c3-035b4c432236	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_query-clients}	query-clients	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
43772d8d-0e6b-4ec8-9535-e10669c8f612	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_query-realms}	query-realms	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
690e4f37-d463-4cb5-bdf1-f3877b5fca7b	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_query-groups}	query-groups	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
c94be786-7ef1-4438-829a-35ed30e1d538	92585ea0-fda0-4277-8d52-1824bde1d052	t	${role_view-profile}	view-profile	7f4bc72e-99dc-4684-8265-a601599a1fb1	92585ea0-fda0-4277-8d52-1824bde1d052	\N
dff67640-1709-4fdb-b143-cb37ebbe7ea6	92585ea0-fda0-4277-8d52-1824bde1d052	t	${role_manage-account}	manage-account	7f4bc72e-99dc-4684-8265-a601599a1fb1	92585ea0-fda0-4277-8d52-1824bde1d052	\N
813b2b6e-d699-41d8-9984-1291846d3303	92585ea0-fda0-4277-8d52-1824bde1d052	t	${role_manage-account-links}	manage-account-links	7f4bc72e-99dc-4684-8265-a601599a1fb1	92585ea0-fda0-4277-8d52-1824bde1d052	\N
871503e9-4a41-48f6-a86c-86dc57ee76a5	92585ea0-fda0-4277-8d52-1824bde1d052	t	${role_view-applications}	view-applications	7f4bc72e-99dc-4684-8265-a601599a1fb1	92585ea0-fda0-4277-8d52-1824bde1d052	\N
3f56b19e-ddbf-4d30-9b3c-7e2a9ea8b5b7	92585ea0-fda0-4277-8d52-1824bde1d052	t	${role_view-consent}	view-consent	7f4bc72e-99dc-4684-8265-a601599a1fb1	92585ea0-fda0-4277-8d52-1824bde1d052	\N
29a17387-ad02-4a65-882f-4e4fe8c8a319	92585ea0-fda0-4277-8d52-1824bde1d052	t	${role_manage-consent}	manage-consent	7f4bc72e-99dc-4684-8265-a601599a1fb1	92585ea0-fda0-4277-8d52-1824bde1d052	\N
1ed7c30c-95eb-47ea-9868-1962054b1676	92585ea0-fda0-4277-8d52-1824bde1d052	t	${role_view-groups}	view-groups	7f4bc72e-99dc-4684-8265-a601599a1fb1	92585ea0-fda0-4277-8d52-1824bde1d052	\N
19483454-f6ae-4569-80ce-14c821e5b878	92585ea0-fda0-4277-8d52-1824bde1d052	t	${role_delete-account}	delete-account	7f4bc72e-99dc-4684-8265-a601599a1fb1	92585ea0-fda0-4277-8d52-1824bde1d052	\N
e400ac65-8036-4377-9c4f-a9e7c7c0a1ab	70bcd274-1971-4ae9-ba56-3f4c41efa90e	t	${role_read-token}	read-token	7f4bc72e-99dc-4684-8265-a601599a1fb1	70bcd274-1971-4ae9-ba56-3f4c41efa90e	\N
655763ba-88f4-4d68-aff6-a1422d0b7fd1	537c9c47-f74f-4410-a3de-9eb64e1eb981	t	${role_impersonation}	impersonation	7f4bc72e-99dc-4684-8265-a601599a1fb1	537c9c47-f74f-4410-a3de-9eb64e1eb981	\N
d094fd58-34a6-4a6d-988a-5482534c71b1	7f4bc72e-99dc-4684-8265-a601599a1fb1	f	${role_offline-access}	offline_access	7f4bc72e-99dc-4684-8265-a601599a1fb1	\N	\N
8989e753-76a5-4767-b763-a0ad7862cee3	7f4bc72e-99dc-4684-8265-a601599a1fb1	f	${role_uma_authorization}	uma_authorization	7f4bc72e-99dc-4684-8265-a601599a1fb1	\N	\N
c58a26c8-1395-442b-95b4-3c4801f3a399	d8293cec-b966-4170-8fed-d0f1f6161baa	f	${role_default-roles}	default-roles-taskflow	d8293cec-b966-4170-8fed-d0f1f6161baa	\N	\N
1e7d5ff7-26e3-4ae7-94bf-db59431be3b4	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_create-client}	create-client	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
1d3b6e13-c380-4a30-b2d2-b664acff8429	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_view-realm}	view-realm	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
6ffea228-ed9b-4cf1-a6f4-f957d6c898f3	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_view-users}	view-users	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
45ff3ef0-842c-4e17-9b0b-45e1fbd0d591	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_view-clients}	view-clients	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
0f99ca53-2f37-4f33-b880-f0b19927e318	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_view-events}	view-events	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
2d613f79-871b-44ec-9902-a257d440f4c5	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_view-identity-providers}	view-identity-providers	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
0a33123c-3fe1-4d38-ba0c-0c1c213c3809	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_view-authorization}	view-authorization	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
1a23d9e2-b784-48bf-84fc-d79c6fb3fcb8	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_manage-realm}	manage-realm	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
f68a577c-6766-48d3-b24a-e1f09a8ad41b	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_manage-users}	manage-users	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
53aa74f0-38cb-47d4-a4dc-91e82edda20c	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_manage-clients}	manage-clients	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
d1cc2f58-cf27-4a8d-84e0-1f85ad0173fd	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_manage-events}	manage-events	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
fc293a91-e61b-40c1-a2a3-fd2e9fd62b76	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_manage-identity-providers}	manage-identity-providers	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
803c2d05-3fae-41ec-86ac-8e84cfbf14fb	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_manage-authorization}	manage-authorization	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
7737ac08-6375-4c26-b752-5cb87357513a	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_query-users}	query-users	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
5bf815ac-414b-47db-b6dd-dd80b059c624	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_query-clients}	query-clients	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
70f890cf-efc0-4977-86a3-ea030a401f01	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_query-realms}	query-realms	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
e9322144-90a2-45d8-b471-a321e6494bc2	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_query-groups}	query-groups	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
426ee743-bfc5-4012-b830-ce201497bb43	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_realm-admin}	realm-admin	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
26ed4a30-c40f-44a2-b51c-4c4f97a9dbf3	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_create-client}	create-client	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
7bf0d35e-597e-43a7-acaf-cfc732cb393c	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_view-realm}	view-realm	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
0d4264dc-dffc-4676-b2c2-b396648d3c81	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_view-users}	view-users	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
81d16a2e-68ed-4524-abda-7ed737d9e5c7	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_view-clients}	view-clients	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
aa6fe16a-5393-4caa-bcc8-d27888cafdd5	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_view-events}	view-events	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
cda9096f-69b9-4f4b-80d2-069d6694619f	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_view-identity-providers}	view-identity-providers	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
32fe97a4-3693-45d0-800c-799de973888a	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_view-authorization}	view-authorization	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
6125e1ce-e8d2-4c9f-b702-10df52e1ed81	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_manage-realm}	manage-realm	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
177360e7-f994-4f8b-a8ab-13fdf87a96b8	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_manage-users}	manage-users	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
578a51fe-09c2-4392-a475-7a281ffa8021	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_manage-clients}	manage-clients	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
1adedba0-ff56-4347-b529-598b20360187	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_manage-events}	manage-events	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
45d19708-a2dd-4b6d-a7b3-3c6b462d50a8	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_manage-identity-providers}	manage-identity-providers	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
f71e4b74-6a83-431a-b242-f5752c5a87e9	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_manage-authorization}	manage-authorization	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
0f6dc1a4-a93b-400a-8bbe-511cc4d74574	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_query-users}	query-users	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
0c34a9a9-a101-4e3b-a643-c3ba1519bbdf	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_query-clients}	query-clients	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
7376f0b4-6078-47ba-9112-743457b9ab83	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_query-realms}	query-realms	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
b0e273ed-8fe3-485c-b98a-f1d124741d41	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_query-groups}	query-groups	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
1977f6da-34c2-42c4-a5ad-50f7a72fcdf2	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	t	${role_view-profile}	view-profile	d8293cec-b966-4170-8fed-d0f1f6161baa	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	\N
fbb6d25a-1a21-4185-9c85-c93f7c1111d6	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	t	${role_manage-account}	manage-account	d8293cec-b966-4170-8fed-d0f1f6161baa	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	\N
da4ab7fc-0c5e-4de4-895b-376987aee243	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	t	${role_manage-account-links}	manage-account-links	d8293cec-b966-4170-8fed-d0f1f6161baa	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	\N
97501f8d-9d6b-488a-9eb4-fe53ba4e5101	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	t	${role_view-applications}	view-applications	d8293cec-b966-4170-8fed-d0f1f6161baa	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	\N
d8b37d93-d6a3-4f7a-bc3e-38fa508ecba6	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	t	${role_view-consent}	view-consent	d8293cec-b966-4170-8fed-d0f1f6161baa	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	\N
bf5602b0-61a8-4584-a552-a9a99e2ff121	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	t	${role_manage-consent}	manage-consent	d8293cec-b966-4170-8fed-d0f1f6161baa	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	\N
3a178f65-5a1b-46c5-862c-c0dcdf4f655e	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	t	${role_view-groups}	view-groups	d8293cec-b966-4170-8fed-d0f1f6161baa	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	\N
34a60eaa-37b5-4711-a3ac-64959f44a2f8	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	t	${role_delete-account}	delete-account	d8293cec-b966-4170-8fed-d0f1f6161baa	8e5d9c2b-c962-4c54-9422-b56ca6d347f8	\N
42fb3347-0448-41d8-be91-bb116349f713	6eebb183-341a-448b-bc3b-9496a36cb863	t	${role_impersonation}	impersonation	7f4bc72e-99dc-4684-8265-a601599a1fb1	6eebb183-341a-448b-bc3b-9496a36cb863	\N
d1c6b533-fbb6-4495-bf8b-674f81440c90	6e234d18-a278-4e94-8ca0-813e9dd47afb	t	${role_impersonation}	impersonation	d8293cec-b966-4170-8fed-d0f1f6161baa	6e234d18-a278-4e94-8ca0-813e9dd47afb	\N
ee51cb28-7a24-4cbf-9c77-584dfef11480	08451956-9c96-47db-b097-c4347bc91b31	t	${role_read-token}	read-token	d8293cec-b966-4170-8fed-d0f1f6161baa	08451956-9c96-47db-b097-c4347bc91b31	\N
83724866-841b-432c-88b1-154c7905950b	d8293cec-b966-4170-8fed-d0f1f6161baa	f	${role_offline-access}	offline_access	d8293cec-b966-4170-8fed-d0f1f6161baa	\N	\N
786293a8-c2f0-43c7-84b8-c8550a62a5f0	d8293cec-b966-4170-8fed-d0f1f6161baa	f	${role_uma_authorization}	uma_authorization	d8293cec-b966-4170-8fed-d0f1f6161baa	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
p4tfb	26.2.5	1751150042
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
2c9d7b0f-5eb9-4c59-a6d0-ea6a9e416a66	2c2afe53-e35b-4e11-bc76-816cbf59f621	0	1751150848	{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/","notes":{"clientId":"2c2afe53-e35b-4e11-bc76-816cbf59f621","iss":"http://localhost:7080/realms/taskflow","startedAt":"1751150798","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"baa6becd-6b32-413e-ba67-974f38a01a1a","response_mode":"fragment","scope":"openid","userSessionStartedAt":"1751150798","redirect_uri":"http://localhost:4200/","state":"8b9fa8d9-e555-466b-acfb-7be6989dc599","code_challenge":"LOqiqDP8F_Zf6IJE1Z5lTNq1KePgu7OTqyNH7A5S6J4","SSO_AUTH":"true"}}	local	local	2
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
2c9d7b0f-5eb9-4c59-a6d0-ea6a9e416a66	bb5fee16-2732-4a59-972c-a6db9bd0005a	d8293cec-b966-4170-8fed-d0f1f6161baa	1751150798	0	{"ipAddress":"172.22.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjIuMC4xIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiQ2hyb21lLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751150798","authenticators-completed":"{\\"0b7956e7-d625-4117-b664-d98eb56f4065\\":1751150798,\\"5587849b-665f-4f6d-93ea-8e587965c9a6\\":1751150848}"},"state":"LOGGED_IN"}	1751150848	\N	2
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
717e6f8d-06bf-441a-933a-3101a918f605	audience resolve	openid-connect	oidc-audience-resolve-mapper	aa668fed-c3bd-448b-b628-b4ce5270941b	\N
f652abe4-c822-426b-9b93-a252fdd251af	locale	openid-connect	oidc-usermodel-attribute-mapper	e3642221-4079-4480-9bf6-9cf40d6d4651	\N
d20556b3-5868-43eb-91c9-7760aaabbc11	role list	saml	saml-role-list-mapper	\N	44780d72-451e-454c-ab0d-cb446115f9e9
50786489-79a8-4233-ac7c-68671bffc744	organization	saml	saml-organization-membership-mapper	\N	ff30731b-f63e-40a5-9adc-c8c3f1aca3bd
e3da47e4-22b1-4f63-b81c-2fd0f5e62225	full name	openid-connect	oidc-full-name-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
3a70c9b3-0bf5-4d55-8ea8-29f4a8952cce	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
614a36d6-4741-4900-85a0-5d088f111820	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
b558db35-27c3-416e-8ab8-e617f83c0da3	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
8d17ad50-90e0-4a20-a3ca-cfa71977fc8f	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
0331d97f-6b49-411d-92e1-a3300a637d98	username	openid-connect	oidc-usermodel-attribute-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
cd1560e5-dde9-4293-b5db-bbc43588fc54	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
029fef5b-ec03-436b-ad57-f9eb46d8844c	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
482aef01-2e4d-4ff9-87d1-27a1890d3f29	website	openid-connect	oidc-usermodel-attribute-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
554ab82a-12e8-4d08-84f3-369dcae5a4a1	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
c0042084-812b-46c1-8386-7fbb73b92f92	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
27cd7f94-6a53-40fe-ad0b-cbd78e391bf5	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
002d2ed4-8687-487e-be2f-4a7c2b1eaaf3	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
e190c946-addf-4fe0-b149-b11e15f681b9	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	426406bd-19b0-4dfe-bdab-4789ed05a462
42a22da7-e878-4621-b4f9-e2b50f9be1be	email	openid-connect	oidc-usermodel-attribute-mapper	\N	dc446a9e-b6e4-4214-a932-0094e0604351
4e17f7eb-fda9-4237-92e2-34bf18c64c2a	email verified	openid-connect	oidc-usermodel-property-mapper	\N	dc446a9e-b6e4-4214-a932-0094e0604351
5c7c47ca-d113-45bf-98e7-1d10a4edd45a	address	openid-connect	oidc-address-mapper	\N	b2542a1b-91df-4ba9-9c94-28912a990f39
7a581336-27a5-41d6-9ccb-a1289dc8fab4	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	8c171fcb-fc9a-4a62-af93-d8cbd77739df
04c6f584-ccbe-4e58-9cec-aa5e590e29cb	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	8c171fcb-fc9a-4a62-af93-d8cbd77739df
c8c4ba20-f2e4-421d-870d-ff9fef8205cb	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	8289f1a1-dad5-4932-a41c-56462a3c6275
ed563d1e-16e5-4fa4-bd37-079b4cb8c39a	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	8289f1a1-dad5-4932-a41c-56462a3c6275
393e0c03-c694-462b-9b48-b07579998d4b	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	8289f1a1-dad5-4932-a41c-56462a3c6275
b0ec6da8-23a1-48f3-8428-d8176135556b	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	2f555480-3cfc-47b0-a9fc-29fbd1b967c6
7f833e3b-2fa3-4a55-afbe-f038d157aa7a	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	d131512a-e48c-4068-8e4f-3b717ae074b1
2a52ccbc-1fe7-458e-a7d2-2bfa41fc8aff	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	d131512a-e48c-4068-8e4f-3b717ae074b1
7719de33-000e-440b-b732-cf4fb75e65d0	acr loa level	openid-connect	oidc-acr-mapper	\N	d7a0b387-b843-40ac-b405-51b6fa3c3076
34e4dc7f-a56f-4b48-a3ba-aa9eb44401e4	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	2f849b7b-8403-4af7-800e-9aa2df44640b
9cdef89a-c0cf-49ef-829d-dab41437c292	sub	openid-connect	oidc-sub-mapper	\N	2f849b7b-8403-4af7-800e-9aa2df44640b
3f4a532c-2a4d-42e8-b2fb-cbfb9422f52e	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	d5e21af8-5e70-41a1-a055-d2ec5583834d
1d218e57-ac09-4d32-b89c-07ae4ed58cce	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	d5e21af8-5e70-41a1-a055-d2ec5583834d
12334289-61b6-40ec-bb6f-3f618ba1045a	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	d5e21af8-5e70-41a1-a055-d2ec5583834d
24528f67-6f3a-4275-ae08-79ca4ba58eff	organization	openid-connect	oidc-organization-membership-mapper	\N	51bd92b1-1880-4496-b95e-59c1dc23ff13
144a9d8a-cc43-40f5-9241-c0da75ccc88a	audience resolve	openid-connect	oidc-audience-resolve-mapper	12867e04-92e1-40a8-85fa-8b396cdd7135	\N
438ab2c1-d3b2-4a9a-be41-831e3e54f62f	role list	saml	saml-role-list-mapper	\N	72720f00-30dc-4b02-ad51-28e79c098434
e158799a-8d69-404e-af0d-e066beed0c00	organization	saml	saml-organization-membership-mapper	\N	ad28074f-78b8-4fb3-bc80-b2fea5e3cbc6
b43203a3-9fb7-4781-9b89-bdcdb6a7c868	full name	openid-connect	oidc-full-name-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
1b1e7dc6-4d69-4d2e-af5d-80e42e7cc203	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
7edc371e-f17f-43b9-be2b-c7960067b599	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
5b030dce-f8eb-4642-8b37-857c68dd2cfe	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
ecf35e52-5f85-425b-affd-e410d8273f0d	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
96920e73-7b44-45ab-80d0-daf2505d3fc0	username	openid-connect	oidc-usermodel-attribute-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
25127411-91c5-465e-8af9-8921ec4c096d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
4235c058-f79a-48a9-a6a9-bd5e5d73b15b	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
163c675a-47fb-4070-979a-6ba569140b52	website	openid-connect	oidc-usermodel-attribute-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
9a0261ee-85ef-4ef8-a601-0bc832cfa9e9	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
42f3f259-4f32-4248-8000-ad4a8b889930	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
2c0d5fce-f8c3-4712-80ad-03776f48f0f3	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
67d5a6f7-252f-4275-9ced-36a1acb6d09f	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
849d4441-75f7-42e2-ae34-bc01b0437d9c	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	979c6d63-c3cd-4c71-939e-322210bb1788
802b6db9-fa31-44be-97ba-ae3d1d6d5cf7	email	openid-connect	oidc-usermodel-attribute-mapper	\N	6fad151d-1cd0-461f-82fe-0a2b68e8b6e1
f473d6c1-d9c0-41b4-aea8-d7438ff76e28	email verified	openid-connect	oidc-usermodel-property-mapper	\N	6fad151d-1cd0-461f-82fe-0a2b68e8b6e1
7ab792b5-b72f-4cd5-914a-9bebfa2830c0	address	openid-connect	oidc-address-mapper	\N	0e7692aa-cb57-4895-9d73-d438b5b0ba7a
34ecc71d-5fdb-404f-a167-ae08f02de82e	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	7b21d67e-0060-4822-8a3e-d246ed96bb38
6176adb7-add4-49ad-ab31-a485de36a849	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	7b21d67e-0060-4822-8a3e-d246ed96bb38
a2e0f7ee-08cf-41c6-a7f9-4cc16209cc6a	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	5795a0f9-25b6-4881-a093-d2eec7b6ac71
1ecc6159-c4fc-48c1-b648-1b1901921728	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	5795a0f9-25b6-4881-a093-d2eec7b6ac71
f9ebadfc-daeb-4f0b-94ea-340ba3d3472d	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	5795a0f9-25b6-4881-a093-d2eec7b6ac71
991fbf96-c418-47e2-bb95-2b841766edbd	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	5c6270ab-3ff0-462d-ac23-4f59edb7b549
a03d9fcd-7fef-436a-83ff-6b7be9388c55	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	a2581802-b167-4151-bf1e-2dea131e5358
034d4de4-7968-4161-9748-e0783f75ca5e	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	a2581802-b167-4151-bf1e-2dea131e5358
4c842d07-f94b-40f0-ac02-9c9f69281e85	acr loa level	openid-connect	oidc-acr-mapper	\N	c38100dd-d19b-478b-adaa-41d280f1482a
7a465222-a064-4781-be89-84123b46786d	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	6a979929-d6cc-4b0b-a52b-f9bdf0b61688
68b38ca1-37ea-4ddc-a8a7-5373607bdd46	sub	openid-connect	oidc-sub-mapper	\N	6a979929-d6cc-4b0b-a52b-f9bdf0b61688
84135c49-bf96-4697-879c-4c9c5c46c197	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	1b5c9af0-f601-479a-b3d2-ce40136b8f8f
73d4adbc-b764-421c-b40d-1ea90d21930d	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	1b5c9af0-f601-479a-b3d2-ce40136b8f8f
ffa96937-8924-4c89-9fb5-c43612c6adc5	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	1b5c9af0-f601-479a-b3d2-ce40136b8f8f
7f93cc63-2aae-4e66-b2b4-b7b576bdbf2c	organization	openid-connect	oidc-organization-membership-mapper	\N	6b541969-936c-4d20-990e-651490fd8064
5e4e97a2-ae2e-401a-b2eb-2598f0a2d678	locale	openid-connect	oidc-usermodel-attribute-mapper	a1e33eeb-b6b0-4d4f-b16e-943d773e174f	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
f652abe4-c822-426b-9b93-a252fdd251af	true	introspection.token.claim
f652abe4-c822-426b-9b93-a252fdd251af	true	userinfo.token.claim
f652abe4-c822-426b-9b93-a252fdd251af	locale	user.attribute
f652abe4-c822-426b-9b93-a252fdd251af	true	id.token.claim
f652abe4-c822-426b-9b93-a252fdd251af	true	access.token.claim
f652abe4-c822-426b-9b93-a252fdd251af	locale	claim.name
f652abe4-c822-426b-9b93-a252fdd251af	String	jsonType.label
d20556b3-5868-43eb-91c9-7760aaabbc11	false	single
d20556b3-5868-43eb-91c9-7760aaabbc11	Basic	attribute.nameformat
d20556b3-5868-43eb-91c9-7760aaabbc11	Role	attribute.name
002d2ed4-8687-487e-be2f-4a7c2b1eaaf3	true	introspection.token.claim
002d2ed4-8687-487e-be2f-4a7c2b1eaaf3	true	userinfo.token.claim
002d2ed4-8687-487e-be2f-4a7c2b1eaaf3	locale	user.attribute
002d2ed4-8687-487e-be2f-4a7c2b1eaaf3	true	id.token.claim
002d2ed4-8687-487e-be2f-4a7c2b1eaaf3	true	access.token.claim
002d2ed4-8687-487e-be2f-4a7c2b1eaaf3	locale	claim.name
002d2ed4-8687-487e-be2f-4a7c2b1eaaf3	String	jsonType.label
029fef5b-ec03-436b-ad57-f9eb46d8844c	true	introspection.token.claim
029fef5b-ec03-436b-ad57-f9eb46d8844c	true	userinfo.token.claim
029fef5b-ec03-436b-ad57-f9eb46d8844c	picture	user.attribute
029fef5b-ec03-436b-ad57-f9eb46d8844c	true	id.token.claim
029fef5b-ec03-436b-ad57-f9eb46d8844c	true	access.token.claim
029fef5b-ec03-436b-ad57-f9eb46d8844c	picture	claim.name
029fef5b-ec03-436b-ad57-f9eb46d8844c	String	jsonType.label
0331d97f-6b49-411d-92e1-a3300a637d98	true	introspection.token.claim
0331d97f-6b49-411d-92e1-a3300a637d98	true	userinfo.token.claim
0331d97f-6b49-411d-92e1-a3300a637d98	username	user.attribute
0331d97f-6b49-411d-92e1-a3300a637d98	true	id.token.claim
0331d97f-6b49-411d-92e1-a3300a637d98	true	access.token.claim
0331d97f-6b49-411d-92e1-a3300a637d98	preferred_username	claim.name
0331d97f-6b49-411d-92e1-a3300a637d98	String	jsonType.label
27cd7f94-6a53-40fe-ad0b-cbd78e391bf5	true	introspection.token.claim
27cd7f94-6a53-40fe-ad0b-cbd78e391bf5	true	userinfo.token.claim
27cd7f94-6a53-40fe-ad0b-cbd78e391bf5	zoneinfo	user.attribute
27cd7f94-6a53-40fe-ad0b-cbd78e391bf5	true	id.token.claim
27cd7f94-6a53-40fe-ad0b-cbd78e391bf5	true	access.token.claim
27cd7f94-6a53-40fe-ad0b-cbd78e391bf5	zoneinfo	claim.name
27cd7f94-6a53-40fe-ad0b-cbd78e391bf5	String	jsonType.label
3a70c9b3-0bf5-4d55-8ea8-29f4a8952cce	true	introspection.token.claim
3a70c9b3-0bf5-4d55-8ea8-29f4a8952cce	true	userinfo.token.claim
3a70c9b3-0bf5-4d55-8ea8-29f4a8952cce	lastName	user.attribute
3a70c9b3-0bf5-4d55-8ea8-29f4a8952cce	true	id.token.claim
3a70c9b3-0bf5-4d55-8ea8-29f4a8952cce	true	access.token.claim
3a70c9b3-0bf5-4d55-8ea8-29f4a8952cce	family_name	claim.name
3a70c9b3-0bf5-4d55-8ea8-29f4a8952cce	String	jsonType.label
482aef01-2e4d-4ff9-87d1-27a1890d3f29	true	introspection.token.claim
482aef01-2e4d-4ff9-87d1-27a1890d3f29	true	userinfo.token.claim
482aef01-2e4d-4ff9-87d1-27a1890d3f29	website	user.attribute
482aef01-2e4d-4ff9-87d1-27a1890d3f29	true	id.token.claim
482aef01-2e4d-4ff9-87d1-27a1890d3f29	true	access.token.claim
482aef01-2e4d-4ff9-87d1-27a1890d3f29	website	claim.name
482aef01-2e4d-4ff9-87d1-27a1890d3f29	String	jsonType.label
554ab82a-12e8-4d08-84f3-369dcae5a4a1	true	introspection.token.claim
554ab82a-12e8-4d08-84f3-369dcae5a4a1	true	userinfo.token.claim
554ab82a-12e8-4d08-84f3-369dcae5a4a1	gender	user.attribute
554ab82a-12e8-4d08-84f3-369dcae5a4a1	true	id.token.claim
554ab82a-12e8-4d08-84f3-369dcae5a4a1	true	access.token.claim
554ab82a-12e8-4d08-84f3-369dcae5a4a1	gender	claim.name
554ab82a-12e8-4d08-84f3-369dcae5a4a1	String	jsonType.label
614a36d6-4741-4900-85a0-5d088f111820	true	introspection.token.claim
614a36d6-4741-4900-85a0-5d088f111820	true	userinfo.token.claim
614a36d6-4741-4900-85a0-5d088f111820	firstName	user.attribute
614a36d6-4741-4900-85a0-5d088f111820	true	id.token.claim
614a36d6-4741-4900-85a0-5d088f111820	true	access.token.claim
614a36d6-4741-4900-85a0-5d088f111820	given_name	claim.name
614a36d6-4741-4900-85a0-5d088f111820	String	jsonType.label
8d17ad50-90e0-4a20-a3ca-cfa71977fc8f	true	introspection.token.claim
8d17ad50-90e0-4a20-a3ca-cfa71977fc8f	true	userinfo.token.claim
8d17ad50-90e0-4a20-a3ca-cfa71977fc8f	nickname	user.attribute
8d17ad50-90e0-4a20-a3ca-cfa71977fc8f	true	id.token.claim
8d17ad50-90e0-4a20-a3ca-cfa71977fc8f	true	access.token.claim
8d17ad50-90e0-4a20-a3ca-cfa71977fc8f	nickname	claim.name
8d17ad50-90e0-4a20-a3ca-cfa71977fc8f	String	jsonType.label
b558db35-27c3-416e-8ab8-e617f83c0da3	true	introspection.token.claim
b558db35-27c3-416e-8ab8-e617f83c0da3	true	userinfo.token.claim
b558db35-27c3-416e-8ab8-e617f83c0da3	middleName	user.attribute
b558db35-27c3-416e-8ab8-e617f83c0da3	true	id.token.claim
b558db35-27c3-416e-8ab8-e617f83c0da3	true	access.token.claim
b558db35-27c3-416e-8ab8-e617f83c0da3	middle_name	claim.name
b558db35-27c3-416e-8ab8-e617f83c0da3	String	jsonType.label
c0042084-812b-46c1-8386-7fbb73b92f92	true	introspection.token.claim
c0042084-812b-46c1-8386-7fbb73b92f92	true	userinfo.token.claim
c0042084-812b-46c1-8386-7fbb73b92f92	birthdate	user.attribute
c0042084-812b-46c1-8386-7fbb73b92f92	true	id.token.claim
c0042084-812b-46c1-8386-7fbb73b92f92	true	access.token.claim
c0042084-812b-46c1-8386-7fbb73b92f92	birthdate	claim.name
c0042084-812b-46c1-8386-7fbb73b92f92	String	jsonType.label
cd1560e5-dde9-4293-b5db-bbc43588fc54	true	introspection.token.claim
cd1560e5-dde9-4293-b5db-bbc43588fc54	true	userinfo.token.claim
cd1560e5-dde9-4293-b5db-bbc43588fc54	profile	user.attribute
cd1560e5-dde9-4293-b5db-bbc43588fc54	true	id.token.claim
cd1560e5-dde9-4293-b5db-bbc43588fc54	true	access.token.claim
cd1560e5-dde9-4293-b5db-bbc43588fc54	profile	claim.name
cd1560e5-dde9-4293-b5db-bbc43588fc54	String	jsonType.label
e190c946-addf-4fe0-b149-b11e15f681b9	true	introspection.token.claim
e190c946-addf-4fe0-b149-b11e15f681b9	true	userinfo.token.claim
e190c946-addf-4fe0-b149-b11e15f681b9	updatedAt	user.attribute
e190c946-addf-4fe0-b149-b11e15f681b9	true	id.token.claim
e190c946-addf-4fe0-b149-b11e15f681b9	true	access.token.claim
e190c946-addf-4fe0-b149-b11e15f681b9	updated_at	claim.name
e190c946-addf-4fe0-b149-b11e15f681b9	long	jsonType.label
e3da47e4-22b1-4f63-b81c-2fd0f5e62225	true	introspection.token.claim
e3da47e4-22b1-4f63-b81c-2fd0f5e62225	true	userinfo.token.claim
e3da47e4-22b1-4f63-b81c-2fd0f5e62225	true	id.token.claim
e3da47e4-22b1-4f63-b81c-2fd0f5e62225	true	access.token.claim
42a22da7-e878-4621-b4f9-e2b50f9be1be	true	introspection.token.claim
42a22da7-e878-4621-b4f9-e2b50f9be1be	true	userinfo.token.claim
42a22da7-e878-4621-b4f9-e2b50f9be1be	email	user.attribute
42a22da7-e878-4621-b4f9-e2b50f9be1be	true	id.token.claim
42a22da7-e878-4621-b4f9-e2b50f9be1be	true	access.token.claim
42a22da7-e878-4621-b4f9-e2b50f9be1be	email	claim.name
42a22da7-e878-4621-b4f9-e2b50f9be1be	String	jsonType.label
4e17f7eb-fda9-4237-92e2-34bf18c64c2a	true	introspection.token.claim
4e17f7eb-fda9-4237-92e2-34bf18c64c2a	true	userinfo.token.claim
4e17f7eb-fda9-4237-92e2-34bf18c64c2a	emailVerified	user.attribute
4e17f7eb-fda9-4237-92e2-34bf18c64c2a	true	id.token.claim
4e17f7eb-fda9-4237-92e2-34bf18c64c2a	true	access.token.claim
4e17f7eb-fda9-4237-92e2-34bf18c64c2a	email_verified	claim.name
4e17f7eb-fda9-4237-92e2-34bf18c64c2a	boolean	jsonType.label
5c7c47ca-d113-45bf-98e7-1d10a4edd45a	formatted	user.attribute.formatted
5c7c47ca-d113-45bf-98e7-1d10a4edd45a	country	user.attribute.country
5c7c47ca-d113-45bf-98e7-1d10a4edd45a	true	introspection.token.claim
5c7c47ca-d113-45bf-98e7-1d10a4edd45a	postal_code	user.attribute.postal_code
5c7c47ca-d113-45bf-98e7-1d10a4edd45a	true	userinfo.token.claim
5c7c47ca-d113-45bf-98e7-1d10a4edd45a	street	user.attribute.street
5c7c47ca-d113-45bf-98e7-1d10a4edd45a	true	id.token.claim
5c7c47ca-d113-45bf-98e7-1d10a4edd45a	region	user.attribute.region
5c7c47ca-d113-45bf-98e7-1d10a4edd45a	true	access.token.claim
5c7c47ca-d113-45bf-98e7-1d10a4edd45a	locality	user.attribute.locality
04c6f584-ccbe-4e58-9cec-aa5e590e29cb	true	introspection.token.claim
04c6f584-ccbe-4e58-9cec-aa5e590e29cb	true	userinfo.token.claim
04c6f584-ccbe-4e58-9cec-aa5e590e29cb	phoneNumberVerified	user.attribute
04c6f584-ccbe-4e58-9cec-aa5e590e29cb	true	id.token.claim
04c6f584-ccbe-4e58-9cec-aa5e590e29cb	true	access.token.claim
04c6f584-ccbe-4e58-9cec-aa5e590e29cb	phone_number_verified	claim.name
04c6f584-ccbe-4e58-9cec-aa5e590e29cb	boolean	jsonType.label
7a581336-27a5-41d6-9ccb-a1289dc8fab4	true	introspection.token.claim
7a581336-27a5-41d6-9ccb-a1289dc8fab4	true	userinfo.token.claim
7a581336-27a5-41d6-9ccb-a1289dc8fab4	phoneNumber	user.attribute
7a581336-27a5-41d6-9ccb-a1289dc8fab4	true	id.token.claim
7a581336-27a5-41d6-9ccb-a1289dc8fab4	true	access.token.claim
7a581336-27a5-41d6-9ccb-a1289dc8fab4	phone_number	claim.name
7a581336-27a5-41d6-9ccb-a1289dc8fab4	String	jsonType.label
393e0c03-c694-462b-9b48-b07579998d4b	true	introspection.token.claim
393e0c03-c694-462b-9b48-b07579998d4b	true	access.token.claim
c8c4ba20-f2e4-421d-870d-ff9fef8205cb	true	introspection.token.claim
c8c4ba20-f2e4-421d-870d-ff9fef8205cb	true	multivalued
c8c4ba20-f2e4-421d-870d-ff9fef8205cb	foo	user.attribute
c8c4ba20-f2e4-421d-870d-ff9fef8205cb	true	access.token.claim
c8c4ba20-f2e4-421d-870d-ff9fef8205cb	realm_access.roles	claim.name
c8c4ba20-f2e4-421d-870d-ff9fef8205cb	String	jsonType.label
ed563d1e-16e5-4fa4-bd37-079b4cb8c39a	true	introspection.token.claim
ed563d1e-16e5-4fa4-bd37-079b4cb8c39a	true	multivalued
ed563d1e-16e5-4fa4-bd37-079b4cb8c39a	foo	user.attribute
ed563d1e-16e5-4fa4-bd37-079b4cb8c39a	true	access.token.claim
ed563d1e-16e5-4fa4-bd37-079b4cb8c39a	resource_access.${client_id}.roles	claim.name
ed563d1e-16e5-4fa4-bd37-079b4cb8c39a	String	jsonType.label
b0ec6da8-23a1-48f3-8428-d8176135556b	true	introspection.token.claim
b0ec6da8-23a1-48f3-8428-d8176135556b	true	access.token.claim
2a52ccbc-1fe7-458e-a7d2-2bfa41fc8aff	true	introspection.token.claim
2a52ccbc-1fe7-458e-a7d2-2bfa41fc8aff	true	multivalued
2a52ccbc-1fe7-458e-a7d2-2bfa41fc8aff	foo	user.attribute
2a52ccbc-1fe7-458e-a7d2-2bfa41fc8aff	true	id.token.claim
2a52ccbc-1fe7-458e-a7d2-2bfa41fc8aff	true	access.token.claim
2a52ccbc-1fe7-458e-a7d2-2bfa41fc8aff	groups	claim.name
2a52ccbc-1fe7-458e-a7d2-2bfa41fc8aff	String	jsonType.label
7f833e3b-2fa3-4a55-afbe-f038d157aa7a	true	introspection.token.claim
7f833e3b-2fa3-4a55-afbe-f038d157aa7a	true	userinfo.token.claim
7f833e3b-2fa3-4a55-afbe-f038d157aa7a	username	user.attribute
7f833e3b-2fa3-4a55-afbe-f038d157aa7a	true	id.token.claim
7f833e3b-2fa3-4a55-afbe-f038d157aa7a	true	access.token.claim
7f833e3b-2fa3-4a55-afbe-f038d157aa7a	upn	claim.name
7f833e3b-2fa3-4a55-afbe-f038d157aa7a	String	jsonType.label
7719de33-000e-440b-b732-cf4fb75e65d0	true	introspection.token.claim
7719de33-000e-440b-b732-cf4fb75e65d0	true	id.token.claim
7719de33-000e-440b-b732-cf4fb75e65d0	true	access.token.claim
34e4dc7f-a56f-4b48-a3ba-aa9eb44401e4	AUTH_TIME	user.session.note
34e4dc7f-a56f-4b48-a3ba-aa9eb44401e4	true	introspection.token.claim
34e4dc7f-a56f-4b48-a3ba-aa9eb44401e4	true	id.token.claim
34e4dc7f-a56f-4b48-a3ba-aa9eb44401e4	true	access.token.claim
34e4dc7f-a56f-4b48-a3ba-aa9eb44401e4	auth_time	claim.name
34e4dc7f-a56f-4b48-a3ba-aa9eb44401e4	long	jsonType.label
9cdef89a-c0cf-49ef-829d-dab41437c292	true	introspection.token.claim
9cdef89a-c0cf-49ef-829d-dab41437c292	true	access.token.claim
12334289-61b6-40ec-bb6f-3f618ba1045a	clientAddress	user.session.note
12334289-61b6-40ec-bb6f-3f618ba1045a	true	introspection.token.claim
12334289-61b6-40ec-bb6f-3f618ba1045a	true	id.token.claim
12334289-61b6-40ec-bb6f-3f618ba1045a	true	access.token.claim
12334289-61b6-40ec-bb6f-3f618ba1045a	clientAddress	claim.name
12334289-61b6-40ec-bb6f-3f618ba1045a	String	jsonType.label
1d218e57-ac09-4d32-b89c-07ae4ed58cce	clientHost	user.session.note
1d218e57-ac09-4d32-b89c-07ae4ed58cce	true	introspection.token.claim
1d218e57-ac09-4d32-b89c-07ae4ed58cce	true	id.token.claim
1d218e57-ac09-4d32-b89c-07ae4ed58cce	true	access.token.claim
1d218e57-ac09-4d32-b89c-07ae4ed58cce	clientHost	claim.name
1d218e57-ac09-4d32-b89c-07ae4ed58cce	String	jsonType.label
3f4a532c-2a4d-42e8-b2fb-cbfb9422f52e	client_id	user.session.note
3f4a532c-2a4d-42e8-b2fb-cbfb9422f52e	true	introspection.token.claim
3f4a532c-2a4d-42e8-b2fb-cbfb9422f52e	true	id.token.claim
3f4a532c-2a4d-42e8-b2fb-cbfb9422f52e	true	access.token.claim
3f4a532c-2a4d-42e8-b2fb-cbfb9422f52e	client_id	claim.name
3f4a532c-2a4d-42e8-b2fb-cbfb9422f52e	String	jsonType.label
24528f67-6f3a-4275-ae08-79ca4ba58eff	true	introspection.token.claim
24528f67-6f3a-4275-ae08-79ca4ba58eff	true	multivalued
24528f67-6f3a-4275-ae08-79ca4ba58eff	true	id.token.claim
24528f67-6f3a-4275-ae08-79ca4ba58eff	true	access.token.claim
24528f67-6f3a-4275-ae08-79ca4ba58eff	organization	claim.name
24528f67-6f3a-4275-ae08-79ca4ba58eff	String	jsonType.label
438ab2c1-d3b2-4a9a-be41-831e3e54f62f	false	single
438ab2c1-d3b2-4a9a-be41-831e3e54f62f	Basic	attribute.nameformat
438ab2c1-d3b2-4a9a-be41-831e3e54f62f	Role	attribute.name
163c675a-47fb-4070-979a-6ba569140b52	true	introspection.token.claim
163c675a-47fb-4070-979a-6ba569140b52	true	userinfo.token.claim
163c675a-47fb-4070-979a-6ba569140b52	website	user.attribute
163c675a-47fb-4070-979a-6ba569140b52	true	id.token.claim
163c675a-47fb-4070-979a-6ba569140b52	true	access.token.claim
163c675a-47fb-4070-979a-6ba569140b52	website	claim.name
163c675a-47fb-4070-979a-6ba569140b52	String	jsonType.label
1b1e7dc6-4d69-4d2e-af5d-80e42e7cc203	true	introspection.token.claim
1b1e7dc6-4d69-4d2e-af5d-80e42e7cc203	true	userinfo.token.claim
1b1e7dc6-4d69-4d2e-af5d-80e42e7cc203	lastName	user.attribute
1b1e7dc6-4d69-4d2e-af5d-80e42e7cc203	true	id.token.claim
1b1e7dc6-4d69-4d2e-af5d-80e42e7cc203	true	access.token.claim
1b1e7dc6-4d69-4d2e-af5d-80e42e7cc203	family_name	claim.name
1b1e7dc6-4d69-4d2e-af5d-80e42e7cc203	String	jsonType.label
25127411-91c5-465e-8af9-8921ec4c096d	true	introspection.token.claim
25127411-91c5-465e-8af9-8921ec4c096d	true	userinfo.token.claim
25127411-91c5-465e-8af9-8921ec4c096d	profile	user.attribute
25127411-91c5-465e-8af9-8921ec4c096d	true	id.token.claim
25127411-91c5-465e-8af9-8921ec4c096d	true	access.token.claim
25127411-91c5-465e-8af9-8921ec4c096d	profile	claim.name
25127411-91c5-465e-8af9-8921ec4c096d	String	jsonType.label
2c0d5fce-f8c3-4712-80ad-03776f48f0f3	true	introspection.token.claim
2c0d5fce-f8c3-4712-80ad-03776f48f0f3	true	userinfo.token.claim
2c0d5fce-f8c3-4712-80ad-03776f48f0f3	zoneinfo	user.attribute
2c0d5fce-f8c3-4712-80ad-03776f48f0f3	true	id.token.claim
2c0d5fce-f8c3-4712-80ad-03776f48f0f3	true	access.token.claim
2c0d5fce-f8c3-4712-80ad-03776f48f0f3	zoneinfo	claim.name
2c0d5fce-f8c3-4712-80ad-03776f48f0f3	String	jsonType.label
4235c058-f79a-48a9-a6a9-bd5e5d73b15b	true	introspection.token.claim
4235c058-f79a-48a9-a6a9-bd5e5d73b15b	true	userinfo.token.claim
4235c058-f79a-48a9-a6a9-bd5e5d73b15b	picture	user.attribute
4235c058-f79a-48a9-a6a9-bd5e5d73b15b	true	id.token.claim
4235c058-f79a-48a9-a6a9-bd5e5d73b15b	true	access.token.claim
4235c058-f79a-48a9-a6a9-bd5e5d73b15b	picture	claim.name
4235c058-f79a-48a9-a6a9-bd5e5d73b15b	String	jsonType.label
42f3f259-4f32-4248-8000-ad4a8b889930	true	introspection.token.claim
42f3f259-4f32-4248-8000-ad4a8b889930	true	userinfo.token.claim
42f3f259-4f32-4248-8000-ad4a8b889930	birthdate	user.attribute
42f3f259-4f32-4248-8000-ad4a8b889930	true	id.token.claim
42f3f259-4f32-4248-8000-ad4a8b889930	true	access.token.claim
42f3f259-4f32-4248-8000-ad4a8b889930	birthdate	claim.name
42f3f259-4f32-4248-8000-ad4a8b889930	String	jsonType.label
5b030dce-f8eb-4642-8b37-857c68dd2cfe	true	introspection.token.claim
5b030dce-f8eb-4642-8b37-857c68dd2cfe	true	userinfo.token.claim
5b030dce-f8eb-4642-8b37-857c68dd2cfe	middleName	user.attribute
5b030dce-f8eb-4642-8b37-857c68dd2cfe	true	id.token.claim
5b030dce-f8eb-4642-8b37-857c68dd2cfe	true	access.token.claim
5b030dce-f8eb-4642-8b37-857c68dd2cfe	middle_name	claim.name
5b030dce-f8eb-4642-8b37-857c68dd2cfe	String	jsonType.label
67d5a6f7-252f-4275-9ced-36a1acb6d09f	true	introspection.token.claim
67d5a6f7-252f-4275-9ced-36a1acb6d09f	true	userinfo.token.claim
67d5a6f7-252f-4275-9ced-36a1acb6d09f	locale	user.attribute
67d5a6f7-252f-4275-9ced-36a1acb6d09f	true	id.token.claim
67d5a6f7-252f-4275-9ced-36a1acb6d09f	true	access.token.claim
67d5a6f7-252f-4275-9ced-36a1acb6d09f	locale	claim.name
67d5a6f7-252f-4275-9ced-36a1acb6d09f	String	jsonType.label
7edc371e-f17f-43b9-be2b-c7960067b599	true	introspection.token.claim
7edc371e-f17f-43b9-be2b-c7960067b599	true	userinfo.token.claim
7edc371e-f17f-43b9-be2b-c7960067b599	firstName	user.attribute
7edc371e-f17f-43b9-be2b-c7960067b599	true	id.token.claim
7edc371e-f17f-43b9-be2b-c7960067b599	true	access.token.claim
7edc371e-f17f-43b9-be2b-c7960067b599	given_name	claim.name
7edc371e-f17f-43b9-be2b-c7960067b599	String	jsonType.label
849d4441-75f7-42e2-ae34-bc01b0437d9c	true	introspection.token.claim
849d4441-75f7-42e2-ae34-bc01b0437d9c	true	userinfo.token.claim
849d4441-75f7-42e2-ae34-bc01b0437d9c	updatedAt	user.attribute
849d4441-75f7-42e2-ae34-bc01b0437d9c	true	id.token.claim
849d4441-75f7-42e2-ae34-bc01b0437d9c	true	access.token.claim
849d4441-75f7-42e2-ae34-bc01b0437d9c	updated_at	claim.name
849d4441-75f7-42e2-ae34-bc01b0437d9c	long	jsonType.label
96920e73-7b44-45ab-80d0-daf2505d3fc0	true	introspection.token.claim
96920e73-7b44-45ab-80d0-daf2505d3fc0	true	userinfo.token.claim
96920e73-7b44-45ab-80d0-daf2505d3fc0	username	user.attribute
96920e73-7b44-45ab-80d0-daf2505d3fc0	true	id.token.claim
96920e73-7b44-45ab-80d0-daf2505d3fc0	true	access.token.claim
96920e73-7b44-45ab-80d0-daf2505d3fc0	preferred_username	claim.name
96920e73-7b44-45ab-80d0-daf2505d3fc0	String	jsonType.label
9a0261ee-85ef-4ef8-a601-0bc832cfa9e9	true	introspection.token.claim
9a0261ee-85ef-4ef8-a601-0bc832cfa9e9	true	userinfo.token.claim
9a0261ee-85ef-4ef8-a601-0bc832cfa9e9	gender	user.attribute
9a0261ee-85ef-4ef8-a601-0bc832cfa9e9	true	id.token.claim
9a0261ee-85ef-4ef8-a601-0bc832cfa9e9	true	access.token.claim
9a0261ee-85ef-4ef8-a601-0bc832cfa9e9	gender	claim.name
9a0261ee-85ef-4ef8-a601-0bc832cfa9e9	String	jsonType.label
b43203a3-9fb7-4781-9b89-bdcdb6a7c868	true	introspection.token.claim
b43203a3-9fb7-4781-9b89-bdcdb6a7c868	true	userinfo.token.claim
b43203a3-9fb7-4781-9b89-bdcdb6a7c868	true	id.token.claim
b43203a3-9fb7-4781-9b89-bdcdb6a7c868	true	access.token.claim
ecf35e52-5f85-425b-affd-e410d8273f0d	true	introspection.token.claim
ecf35e52-5f85-425b-affd-e410d8273f0d	true	userinfo.token.claim
ecf35e52-5f85-425b-affd-e410d8273f0d	nickname	user.attribute
ecf35e52-5f85-425b-affd-e410d8273f0d	true	id.token.claim
ecf35e52-5f85-425b-affd-e410d8273f0d	true	access.token.claim
ecf35e52-5f85-425b-affd-e410d8273f0d	nickname	claim.name
ecf35e52-5f85-425b-affd-e410d8273f0d	String	jsonType.label
802b6db9-fa31-44be-97ba-ae3d1d6d5cf7	true	introspection.token.claim
802b6db9-fa31-44be-97ba-ae3d1d6d5cf7	true	userinfo.token.claim
802b6db9-fa31-44be-97ba-ae3d1d6d5cf7	email	user.attribute
802b6db9-fa31-44be-97ba-ae3d1d6d5cf7	true	id.token.claim
802b6db9-fa31-44be-97ba-ae3d1d6d5cf7	true	access.token.claim
802b6db9-fa31-44be-97ba-ae3d1d6d5cf7	email	claim.name
802b6db9-fa31-44be-97ba-ae3d1d6d5cf7	String	jsonType.label
f473d6c1-d9c0-41b4-aea8-d7438ff76e28	true	introspection.token.claim
f473d6c1-d9c0-41b4-aea8-d7438ff76e28	true	userinfo.token.claim
f473d6c1-d9c0-41b4-aea8-d7438ff76e28	emailVerified	user.attribute
f473d6c1-d9c0-41b4-aea8-d7438ff76e28	true	id.token.claim
f473d6c1-d9c0-41b4-aea8-d7438ff76e28	true	access.token.claim
f473d6c1-d9c0-41b4-aea8-d7438ff76e28	email_verified	claim.name
f473d6c1-d9c0-41b4-aea8-d7438ff76e28	boolean	jsonType.label
7ab792b5-b72f-4cd5-914a-9bebfa2830c0	formatted	user.attribute.formatted
7ab792b5-b72f-4cd5-914a-9bebfa2830c0	country	user.attribute.country
7ab792b5-b72f-4cd5-914a-9bebfa2830c0	true	introspection.token.claim
7ab792b5-b72f-4cd5-914a-9bebfa2830c0	postal_code	user.attribute.postal_code
7ab792b5-b72f-4cd5-914a-9bebfa2830c0	true	userinfo.token.claim
7ab792b5-b72f-4cd5-914a-9bebfa2830c0	street	user.attribute.street
7ab792b5-b72f-4cd5-914a-9bebfa2830c0	true	id.token.claim
7ab792b5-b72f-4cd5-914a-9bebfa2830c0	region	user.attribute.region
7ab792b5-b72f-4cd5-914a-9bebfa2830c0	true	access.token.claim
7ab792b5-b72f-4cd5-914a-9bebfa2830c0	locality	user.attribute.locality
34ecc71d-5fdb-404f-a167-ae08f02de82e	true	introspection.token.claim
34ecc71d-5fdb-404f-a167-ae08f02de82e	true	userinfo.token.claim
34ecc71d-5fdb-404f-a167-ae08f02de82e	phoneNumber	user.attribute
34ecc71d-5fdb-404f-a167-ae08f02de82e	true	id.token.claim
34ecc71d-5fdb-404f-a167-ae08f02de82e	true	access.token.claim
34ecc71d-5fdb-404f-a167-ae08f02de82e	phone_number	claim.name
34ecc71d-5fdb-404f-a167-ae08f02de82e	String	jsonType.label
6176adb7-add4-49ad-ab31-a485de36a849	true	introspection.token.claim
6176adb7-add4-49ad-ab31-a485de36a849	true	userinfo.token.claim
6176adb7-add4-49ad-ab31-a485de36a849	phoneNumberVerified	user.attribute
6176adb7-add4-49ad-ab31-a485de36a849	true	id.token.claim
6176adb7-add4-49ad-ab31-a485de36a849	true	access.token.claim
6176adb7-add4-49ad-ab31-a485de36a849	phone_number_verified	claim.name
6176adb7-add4-49ad-ab31-a485de36a849	boolean	jsonType.label
1ecc6159-c4fc-48c1-b648-1b1901921728	true	introspection.token.claim
1ecc6159-c4fc-48c1-b648-1b1901921728	true	multivalued
1ecc6159-c4fc-48c1-b648-1b1901921728	foo	user.attribute
1ecc6159-c4fc-48c1-b648-1b1901921728	true	access.token.claim
1ecc6159-c4fc-48c1-b648-1b1901921728	resource_access.${client_id}.roles	claim.name
1ecc6159-c4fc-48c1-b648-1b1901921728	String	jsonType.label
a2e0f7ee-08cf-41c6-a7f9-4cc16209cc6a	true	introspection.token.claim
a2e0f7ee-08cf-41c6-a7f9-4cc16209cc6a	true	multivalued
a2e0f7ee-08cf-41c6-a7f9-4cc16209cc6a	foo	user.attribute
a2e0f7ee-08cf-41c6-a7f9-4cc16209cc6a	true	access.token.claim
a2e0f7ee-08cf-41c6-a7f9-4cc16209cc6a	realm_access.roles	claim.name
a2e0f7ee-08cf-41c6-a7f9-4cc16209cc6a	String	jsonType.label
f9ebadfc-daeb-4f0b-94ea-340ba3d3472d	true	introspection.token.claim
f9ebadfc-daeb-4f0b-94ea-340ba3d3472d	true	access.token.claim
991fbf96-c418-47e2-bb95-2b841766edbd	true	introspection.token.claim
991fbf96-c418-47e2-bb95-2b841766edbd	true	access.token.claim
034d4de4-7968-4161-9748-e0783f75ca5e	true	introspection.token.claim
034d4de4-7968-4161-9748-e0783f75ca5e	true	multivalued
034d4de4-7968-4161-9748-e0783f75ca5e	foo	user.attribute
034d4de4-7968-4161-9748-e0783f75ca5e	true	id.token.claim
034d4de4-7968-4161-9748-e0783f75ca5e	true	access.token.claim
034d4de4-7968-4161-9748-e0783f75ca5e	groups	claim.name
034d4de4-7968-4161-9748-e0783f75ca5e	String	jsonType.label
a03d9fcd-7fef-436a-83ff-6b7be9388c55	true	introspection.token.claim
a03d9fcd-7fef-436a-83ff-6b7be9388c55	true	userinfo.token.claim
a03d9fcd-7fef-436a-83ff-6b7be9388c55	username	user.attribute
a03d9fcd-7fef-436a-83ff-6b7be9388c55	true	id.token.claim
a03d9fcd-7fef-436a-83ff-6b7be9388c55	true	access.token.claim
a03d9fcd-7fef-436a-83ff-6b7be9388c55	upn	claim.name
a03d9fcd-7fef-436a-83ff-6b7be9388c55	String	jsonType.label
4c842d07-f94b-40f0-ac02-9c9f69281e85	true	introspection.token.claim
4c842d07-f94b-40f0-ac02-9c9f69281e85	true	id.token.claim
4c842d07-f94b-40f0-ac02-9c9f69281e85	true	access.token.claim
68b38ca1-37ea-4ddc-a8a7-5373607bdd46	true	introspection.token.claim
68b38ca1-37ea-4ddc-a8a7-5373607bdd46	true	access.token.claim
7a465222-a064-4781-be89-84123b46786d	AUTH_TIME	user.session.note
7a465222-a064-4781-be89-84123b46786d	true	introspection.token.claim
7a465222-a064-4781-be89-84123b46786d	true	id.token.claim
7a465222-a064-4781-be89-84123b46786d	true	access.token.claim
7a465222-a064-4781-be89-84123b46786d	auth_time	claim.name
7a465222-a064-4781-be89-84123b46786d	long	jsonType.label
73d4adbc-b764-421c-b40d-1ea90d21930d	clientHost	user.session.note
73d4adbc-b764-421c-b40d-1ea90d21930d	true	introspection.token.claim
73d4adbc-b764-421c-b40d-1ea90d21930d	true	id.token.claim
73d4adbc-b764-421c-b40d-1ea90d21930d	true	access.token.claim
73d4adbc-b764-421c-b40d-1ea90d21930d	clientHost	claim.name
73d4adbc-b764-421c-b40d-1ea90d21930d	String	jsonType.label
84135c49-bf96-4697-879c-4c9c5c46c197	client_id	user.session.note
84135c49-bf96-4697-879c-4c9c5c46c197	true	introspection.token.claim
84135c49-bf96-4697-879c-4c9c5c46c197	true	id.token.claim
84135c49-bf96-4697-879c-4c9c5c46c197	true	access.token.claim
84135c49-bf96-4697-879c-4c9c5c46c197	client_id	claim.name
84135c49-bf96-4697-879c-4c9c5c46c197	String	jsonType.label
ffa96937-8924-4c89-9fb5-c43612c6adc5	clientAddress	user.session.note
ffa96937-8924-4c89-9fb5-c43612c6adc5	true	introspection.token.claim
ffa96937-8924-4c89-9fb5-c43612c6adc5	true	id.token.claim
ffa96937-8924-4c89-9fb5-c43612c6adc5	true	access.token.claim
ffa96937-8924-4c89-9fb5-c43612c6adc5	clientAddress	claim.name
ffa96937-8924-4c89-9fb5-c43612c6adc5	String	jsonType.label
7f93cc63-2aae-4e66-b2b4-b7b576bdbf2c	true	introspection.token.claim
7f93cc63-2aae-4e66-b2b4-b7b576bdbf2c	true	multivalued
7f93cc63-2aae-4e66-b2b4-b7b576bdbf2c	true	id.token.claim
7f93cc63-2aae-4e66-b2b4-b7b576bdbf2c	true	access.token.claim
7f93cc63-2aae-4e66-b2b4-b7b576bdbf2c	organization	claim.name
7f93cc63-2aae-4e66-b2b4-b7b576bdbf2c	String	jsonType.label
5e4e97a2-ae2e-401a-b2eb-2598f0a2d678	true	introspection.token.claim
5e4e97a2-ae2e-401a-b2eb-2598f0a2d678	true	userinfo.token.claim
5e4e97a2-ae2e-401a-b2eb-2598f0a2d678	locale	user.attribute
5e4e97a2-ae2e-401a-b2eb-2598f0a2d678	true	id.token.claim
5e4e97a2-ae2e-401a-b2eb-2598f0a2d678	true	access.token.claim
5e4e97a2-ae2e-401a-b2eb-2598f0a2d678	locale	claim.name
5e4e97a2-ae2e-401a-b2eb-2598f0a2d678	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
d8293cec-b966-4170-8fed-d0f1f6161baa	60	300	300	\N	\N	\N	t	f	0	\N	taskflow	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	6eebb183-341a-448b-bc3b-9496a36cb863	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	d18ed81e-7306-4eae-83c3-6b234bc26150	6d37a6fb-bd93-4ce3-bfaa-565b7cb64380	4aead574-73aa-4b76-9931-1d6e0346678a	7bb2cfaa-cf10-48f5-9a19-aa7c2568e2c4	015b8349-1f05-4f2b-9929-cf5470ffdc90	2592000	f	900	t	f	53ce3839-521d-451c-8521-daca5b5cc9c5	0	f	0	0	c58a26c8-1395-442b-95b4-3c4801f3a399
7f4bc72e-99dc-4684-8265-a601599a1fb1	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	537c9c47-f74f-4410-a3de-9eb64e1eb981	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	eefee08a-636c-42c7-a4a4-5b87e90cead4	474f4f28-b911-4c57-bde4-757c5fcd8bd4	50fc651b-ea1c-49f7-b056-600b9a1b408e	4f4af586-e775-47e0-9902-f6b4df6a87d4	3b6d78fa-6e9e-44d2-a089-92159d0a8dd4	2592000	f	900	t	f	20462a35-54f3-4544-bb04-63ef804eceac	0	f	0	0	55586ac1-5a47-469d-bfe8-1a5ab889be4d
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	7f4bc72e-99dc-4684-8265-a601599a1fb1	
_browser_header.xContentTypeOptions	7f4bc72e-99dc-4684-8265-a601599a1fb1	nosniff
_browser_header.referrerPolicy	7f4bc72e-99dc-4684-8265-a601599a1fb1	no-referrer
_browser_header.xRobotsTag	7f4bc72e-99dc-4684-8265-a601599a1fb1	none
_browser_header.xFrameOptions	7f4bc72e-99dc-4684-8265-a601599a1fb1	SAMEORIGIN
_browser_header.contentSecurityPolicy	7f4bc72e-99dc-4684-8265-a601599a1fb1	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	7f4bc72e-99dc-4684-8265-a601599a1fb1	max-age=31536000; includeSubDomains
bruteForceProtected	7f4bc72e-99dc-4684-8265-a601599a1fb1	false
permanentLockout	7f4bc72e-99dc-4684-8265-a601599a1fb1	false
maxTemporaryLockouts	7f4bc72e-99dc-4684-8265-a601599a1fb1	0
bruteForceStrategy	7f4bc72e-99dc-4684-8265-a601599a1fb1	MULTIPLE
maxFailureWaitSeconds	7f4bc72e-99dc-4684-8265-a601599a1fb1	900
minimumQuickLoginWaitSeconds	7f4bc72e-99dc-4684-8265-a601599a1fb1	60
waitIncrementSeconds	7f4bc72e-99dc-4684-8265-a601599a1fb1	60
quickLoginCheckMilliSeconds	7f4bc72e-99dc-4684-8265-a601599a1fb1	1000
maxDeltaTimeSeconds	7f4bc72e-99dc-4684-8265-a601599a1fb1	43200
failureFactor	7f4bc72e-99dc-4684-8265-a601599a1fb1	30
realmReusableOtpCode	7f4bc72e-99dc-4684-8265-a601599a1fb1	false
firstBrokerLoginFlowId	7f4bc72e-99dc-4684-8265-a601599a1fb1	dbbdcc56-251a-4b08-b86d-c79390fc75c6
displayName	7f4bc72e-99dc-4684-8265-a601599a1fb1	Keycloak
displayNameHtml	7f4bc72e-99dc-4684-8265-a601599a1fb1	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	7f4bc72e-99dc-4684-8265-a601599a1fb1	RS256
offlineSessionMaxLifespanEnabled	7f4bc72e-99dc-4684-8265-a601599a1fb1	false
offlineSessionMaxLifespan	7f4bc72e-99dc-4684-8265-a601599a1fb1	5184000
_browser_header.contentSecurityPolicyReportOnly	d8293cec-b966-4170-8fed-d0f1f6161baa	
_browser_header.xContentTypeOptions	d8293cec-b966-4170-8fed-d0f1f6161baa	nosniff
_browser_header.referrerPolicy	d8293cec-b966-4170-8fed-d0f1f6161baa	no-referrer
_browser_header.xRobotsTag	d8293cec-b966-4170-8fed-d0f1f6161baa	none
_browser_header.xFrameOptions	d8293cec-b966-4170-8fed-d0f1f6161baa	SAMEORIGIN
_browser_header.contentSecurityPolicy	d8293cec-b966-4170-8fed-d0f1f6161baa	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	d8293cec-b966-4170-8fed-d0f1f6161baa	max-age=31536000; includeSubDomains
bruteForceProtected	d8293cec-b966-4170-8fed-d0f1f6161baa	false
permanentLockout	d8293cec-b966-4170-8fed-d0f1f6161baa	false
maxTemporaryLockouts	d8293cec-b966-4170-8fed-d0f1f6161baa	0
bruteForceStrategy	d8293cec-b966-4170-8fed-d0f1f6161baa	MULTIPLE
maxFailureWaitSeconds	d8293cec-b966-4170-8fed-d0f1f6161baa	900
minimumQuickLoginWaitSeconds	d8293cec-b966-4170-8fed-d0f1f6161baa	60
waitIncrementSeconds	d8293cec-b966-4170-8fed-d0f1f6161baa	60
quickLoginCheckMilliSeconds	d8293cec-b966-4170-8fed-d0f1f6161baa	1000
maxDeltaTimeSeconds	d8293cec-b966-4170-8fed-d0f1f6161baa	43200
failureFactor	d8293cec-b966-4170-8fed-d0f1f6161baa	30
realmReusableOtpCode	d8293cec-b966-4170-8fed-d0f1f6161baa	false
defaultSignatureAlgorithm	d8293cec-b966-4170-8fed-d0f1f6161baa	RS256
offlineSessionMaxLifespanEnabled	d8293cec-b966-4170-8fed-d0f1f6161baa	false
offlineSessionMaxLifespan	d8293cec-b966-4170-8fed-d0f1f6161baa	5184000
actionTokenGeneratedByAdminLifespan	d8293cec-b966-4170-8fed-d0f1f6161baa	43200
actionTokenGeneratedByUserLifespan	d8293cec-b966-4170-8fed-d0f1f6161baa	300
oauth2DeviceCodeLifespan	d8293cec-b966-4170-8fed-d0f1f6161baa	600
oauth2DevicePollingInterval	d8293cec-b966-4170-8fed-d0f1f6161baa	5
webAuthnPolicyRpEntityName	d8293cec-b966-4170-8fed-d0f1f6161baa	keycloak
webAuthnPolicySignatureAlgorithms	d8293cec-b966-4170-8fed-d0f1f6161baa	ES256,RS256
webAuthnPolicyRpId	d8293cec-b966-4170-8fed-d0f1f6161baa	
webAuthnPolicyAttestationConveyancePreference	d8293cec-b966-4170-8fed-d0f1f6161baa	not specified
webAuthnPolicyAuthenticatorAttachment	d8293cec-b966-4170-8fed-d0f1f6161baa	not specified
webAuthnPolicyRequireResidentKey	d8293cec-b966-4170-8fed-d0f1f6161baa	not specified
webAuthnPolicyUserVerificationRequirement	d8293cec-b966-4170-8fed-d0f1f6161baa	not specified
webAuthnPolicyCreateTimeout	d8293cec-b966-4170-8fed-d0f1f6161baa	0
webAuthnPolicyAvoidSameAuthenticatorRegister	d8293cec-b966-4170-8fed-d0f1f6161baa	false
webAuthnPolicyRpEntityNamePasswordless	d8293cec-b966-4170-8fed-d0f1f6161baa	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	d8293cec-b966-4170-8fed-d0f1f6161baa	ES256,RS256
webAuthnPolicyRpIdPasswordless	d8293cec-b966-4170-8fed-d0f1f6161baa	
webAuthnPolicyAttestationConveyancePreferencePasswordless	d8293cec-b966-4170-8fed-d0f1f6161baa	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	d8293cec-b966-4170-8fed-d0f1f6161baa	not specified
webAuthnPolicyRequireResidentKeyPasswordless	d8293cec-b966-4170-8fed-d0f1f6161baa	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	d8293cec-b966-4170-8fed-d0f1f6161baa	not specified
webAuthnPolicyCreateTimeoutPasswordless	d8293cec-b966-4170-8fed-d0f1f6161baa	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	d8293cec-b966-4170-8fed-d0f1f6161baa	false
cibaBackchannelTokenDeliveryMode	d8293cec-b966-4170-8fed-d0f1f6161baa	poll
cibaExpiresIn	d8293cec-b966-4170-8fed-d0f1f6161baa	120
cibaInterval	d8293cec-b966-4170-8fed-d0f1f6161baa	5
cibaAuthRequestedUserHint	d8293cec-b966-4170-8fed-d0f1f6161baa	login_hint
parRequestUriLifespan	d8293cec-b966-4170-8fed-d0f1f6161baa	60
firstBrokerLoginFlowId	d8293cec-b966-4170-8fed-d0f1f6161baa	53c4d65c-0e69-4f93-9814-aa9e8e18c7fd
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
7f4bc72e-99dc-4684-8265-a601599a1fb1	jboss-logging
d8293cec-b966-4170-8fed-d0f1f6161baa	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	7f4bc72e-99dc-4684-8265-a601599a1fb1
password	password	t	t	d8293cec-b966-4170-8fed-d0f1f6161baa
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
92585ea0-fda0-4277-8d52-1824bde1d052	/realms/master/account/*
aa668fed-c3bd-448b-b628-b4ce5270941b	/realms/master/account/*
e3642221-4079-4480-9bf6-9cf40d6d4651	/admin/master/console/*
8e5d9c2b-c962-4c54-9422-b56ca6d347f8	/realms/taskflow/account/*
12867e04-92e1-40a8-85fa-8b396cdd7135	/realms/taskflow/account/*
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	/admin/taskflow/console/*
2c2afe53-e35b-4e11-bc76-816cbf59f621	http://localhost:4200/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
6a4e3f88-2272-4f1a-928d-492e741a13cc	VERIFY_EMAIL	Verify Email	7f4bc72e-99dc-4684-8265-a601599a1fb1	t	f	VERIFY_EMAIL	50
07292d7d-4ddc-4e2f-aa9a-423f205be86f	UPDATE_PROFILE	Update Profile	7f4bc72e-99dc-4684-8265-a601599a1fb1	t	f	UPDATE_PROFILE	40
d123ca06-6c04-4fe6-8824-f81d784e2ea1	CONFIGURE_TOTP	Configure OTP	7f4bc72e-99dc-4684-8265-a601599a1fb1	t	f	CONFIGURE_TOTP	10
07f6122a-4aad-4a0e-b7cd-dd290f3ab93d	UPDATE_PASSWORD	Update Password	7f4bc72e-99dc-4684-8265-a601599a1fb1	t	f	UPDATE_PASSWORD	30
7afa958f-3fe5-4779-b4dc-ad32b3e15d81	TERMS_AND_CONDITIONS	Terms and Conditions	7f4bc72e-99dc-4684-8265-a601599a1fb1	f	f	TERMS_AND_CONDITIONS	20
2f4bde43-de28-4d13-853a-0c188d28c654	delete_account	Delete Account	7f4bc72e-99dc-4684-8265-a601599a1fb1	f	f	delete_account	60
6f6d79f7-1b49-43e3-8484-b0f2e7bbe7e6	delete_credential	Delete Credential	7f4bc72e-99dc-4684-8265-a601599a1fb1	t	f	delete_credential	100
965425d2-0f7c-4a10-8841-852235c07644	update_user_locale	Update User Locale	7f4bc72e-99dc-4684-8265-a601599a1fb1	t	f	update_user_locale	1000
0ebade18-a589-4df3-a990-454505a04aee	webauthn-register	Webauthn Register	7f4bc72e-99dc-4684-8265-a601599a1fb1	t	f	webauthn-register	70
eaae05e3-b4c3-4e2d-9eac-054867e57580	webauthn-register-passwordless	Webauthn Register Passwordless	7f4bc72e-99dc-4684-8265-a601599a1fb1	t	f	webauthn-register-passwordless	80
bb92a4bb-f774-4ba4-a0ca-086b85ef55aa	VERIFY_PROFILE	Verify Profile	7f4bc72e-99dc-4684-8265-a601599a1fb1	t	f	VERIFY_PROFILE	90
7e104351-9ba5-4a6c-a89d-9036147c8f60	VERIFY_EMAIL	Verify Email	d8293cec-b966-4170-8fed-d0f1f6161baa	t	f	VERIFY_EMAIL	50
c2d51de1-d41a-490d-90a7-6d86ad272554	UPDATE_PROFILE	Update Profile	d8293cec-b966-4170-8fed-d0f1f6161baa	t	f	UPDATE_PROFILE	40
374a3dda-390e-4890-9af8-060b3c688cd3	CONFIGURE_TOTP	Configure OTP	d8293cec-b966-4170-8fed-d0f1f6161baa	t	f	CONFIGURE_TOTP	10
7b8fe079-41e6-4875-9d6e-22bee91f354f	UPDATE_PASSWORD	Update Password	d8293cec-b966-4170-8fed-d0f1f6161baa	t	f	UPDATE_PASSWORD	30
31371cde-3eac-4b4b-aae7-19139a36aa93	TERMS_AND_CONDITIONS	Terms and Conditions	d8293cec-b966-4170-8fed-d0f1f6161baa	f	f	TERMS_AND_CONDITIONS	20
c36561de-2710-495e-9142-ec03dcbd7941	delete_account	Delete Account	d8293cec-b966-4170-8fed-d0f1f6161baa	f	f	delete_account	60
3aba4058-15ca-45c4-9ddb-eae70e3413f7	delete_credential	Delete Credential	d8293cec-b966-4170-8fed-d0f1f6161baa	t	f	delete_credential	100
e5cdcd9f-6181-41b9-9a76-c1aaaea53fc6	update_user_locale	Update User Locale	d8293cec-b966-4170-8fed-d0f1f6161baa	t	f	update_user_locale	1000
f6d90881-9cc6-4964-a1ff-5f5027a49387	webauthn-register	Webauthn Register	d8293cec-b966-4170-8fed-d0f1f6161baa	t	f	webauthn-register	70
5962f2c2-d850-41c1-8f37-e581eb813876	webauthn-register-passwordless	Webauthn Register Passwordless	d8293cec-b966-4170-8fed-d0f1f6161baa	t	f	webauthn-register-passwordless	80
509e2e61-f232-43d3-9ee8-ea3cd84246e7	VERIFY_PROFILE	Verify Profile	d8293cec-b966-4170-8fed-d0f1f6161baa	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
aa668fed-c3bd-448b-b628-b4ce5270941b	dff67640-1709-4fdb-b143-cb37ebbe7ea6
aa668fed-c3bd-448b-b628-b4ce5270941b	1ed7c30c-95eb-47ea-9868-1962054b1676
12867e04-92e1-40a8-85fa-8b396cdd7135	3a178f65-5a1b-46c5-862c-c0dcdf4f655e
12867e04-92e1-40a8-85fa-8b396cdd7135	fbb6d25a-1a21-4185-9c85-c93f7c1111d6
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: server_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.server_config (server_config_key, value, version) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	ba0d1f73-b733-4de1-b253-a954a9a7d705	983d1849-9fe5-4756-ba08-f5149c136a03	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
ba0d1f73-b733-4de1-b253-a954a9a7d705	\N	38377bbf-aa07-47d8-85e5-d0e42f4d640f	f	t	\N	\N	\N	7f4bc72e-99dc-4684-8265-a601599a1fb1	admin	1751150046826	\N	0
bb5fee16-2732-4a59-972c-a6db9bd0005a	ardolynk75@gmail.com	ardolynk75@gmail.com	t	t	\N	Michael	Tikhonenko	d8293cec-b966-4170-8fed-d0f1f6161baa	ardolynk75@gmail.com	1751150169354	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
55586ac1-5a47-469d-bfe8-1a5ab889be4d	ba0d1f73-b733-4de1-b253-a954a9a7d705
3032665b-2718-47ec-a299-d5c66bbc5f85	ba0d1f73-b733-4de1-b253-a954a9a7d705
c58a26c8-1395-442b-95b4-3c4801f3a399	bb5fee16-2732-4a59-972c-a6db9bd0005a
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
e3642221-4079-4480-9bf6-9cf40d6d4651	+
a1e33eeb-b6b0-4d4f-b16e-943d773e174f	+
2c2afe53-e35b-4e11-bc76-816cbf59f621	http://localhost:4200
\.


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: server_config SERVER_CONFIG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.server_config
    ADD CONSTRAINT "SERVER_CONFIG_pkey" PRIMARY KEY (server_config_key);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

