create database drone;
create role drone with password 'drone';
alter role drone with login;
grant all on database drone to drone;

create database gogs;
create role gogs with password 'gogs';
alter role gogs with login;
grant all on database gogs to gogs;

\c gogs;

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

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

SET default_with_oids = false;

--
-- Name: access; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.access (
    id bigint NOT NULL,
    user_id bigint,
    repo_id bigint,
    mode integer
);


ALTER TABLE public.access OWNER TO gogs;

--
-- Name: access_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.access_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_id_seq OWNER TO gogs;

--
-- Name: access_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.access_id_seq OWNED BY public.access.id;


--
-- Name: access_token; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.access_token (
    id bigint NOT NULL,
    uid bigint,
    name character varying(255),
    sha1 character varying(40),
    created_unix bigint,
    updated_unix bigint
);


ALTER TABLE public.access_token OWNER TO gogs;

--
-- Name: access_token_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.access_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_token_id_seq OWNER TO gogs;

--
-- Name: access_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.access_token_id_seq OWNED BY public.access_token.id;


--
-- Name: action; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.action (
    id bigint NOT NULL,
    user_id bigint,
    op_type integer,
    act_user_id bigint,
    act_user_name character varying(255),
    repo_id bigint,
    repo_user_name character varying(255),
    repo_name character varying(255),
    ref_name character varying(255),
    is_private boolean DEFAULT false NOT NULL,
    content text,
    created_unix bigint
);


ALTER TABLE public.action OWNER TO gogs;

--
-- Name: action_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.action_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.action_id_seq OWNER TO gogs;

--
-- Name: action_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.action_id_seq OWNED BY public.action.id;


--
-- Name: attachment; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.attachment (
    id bigint NOT NULL,
    uuid uuid,
    issue_id bigint,
    comment_id bigint,
    release_id bigint,
    name character varying(255),
    created_unix bigint
);


ALTER TABLE public.attachment OWNER TO gogs;

--
-- Name: attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.attachment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attachment_id_seq OWNER TO gogs;

--
-- Name: attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.attachment_id_seq OWNED BY public.attachment.id;


--
-- Name: collaboration; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.collaboration (
    id bigint NOT NULL,
    repo_id bigint NOT NULL,
    user_id bigint NOT NULL,
    mode integer DEFAULT 2 NOT NULL
);


ALTER TABLE public.collaboration OWNER TO gogs;

--
-- Name: collaboration_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.collaboration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collaboration_id_seq OWNER TO gogs;

--
-- Name: collaboration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.collaboration_id_seq OWNED BY public.collaboration.id;


--
-- Name: comment; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.comment (
    id bigint NOT NULL,
    type integer,
    poster_id bigint,
    issue_id bigint,
    commit_id bigint,
    line bigint,
    content text,
    created_unix bigint,
    updated_unix bigint,
    commit_sha character varying(40)
);


ALTER TABLE public.comment OWNER TO gogs;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_id_seq OWNER TO gogs;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;


--
-- Name: deploy_key; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.deploy_key (
    id bigint NOT NULL,
    key_id bigint,
    repo_id bigint,
    name character varying(255),
    fingerprint character varying(255),
    created_unix bigint,
    updated_unix bigint
);


ALTER TABLE public.deploy_key OWNER TO gogs;

--
-- Name: deploy_key_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.deploy_key_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deploy_key_id_seq OWNER TO gogs;

--
-- Name: deploy_key_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.deploy_key_id_seq OWNED BY public.deploy_key.id;


--
-- Name: email_address; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.email_address (
    id bigint NOT NULL,
    uid bigint NOT NULL,
    email character varying(255) NOT NULL,
    is_activated boolean
);


ALTER TABLE public.email_address OWNER TO gogs;

--
-- Name: email_address_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.email_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_address_id_seq OWNER TO gogs;

--
-- Name: email_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.email_address_id_seq OWNED BY public.email_address.id;


--
-- Name: follow; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.follow (
    id bigint NOT NULL,
    user_id bigint,
    follow_id bigint
);


ALTER TABLE public.follow OWNER TO gogs;

--
-- Name: follow_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.follow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.follow_id_seq OWNER TO gogs;

--
-- Name: follow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.follow_id_seq OWNED BY public.follow.id;


--
-- Name: hook_task; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.hook_task (
    id bigint NOT NULL,
    repo_id bigint,
    hook_id bigint,
    uuid character varying(255),
    type integer,
    url text,
    signature text,
    payload_content text,
    content_type integer,
    event_type character varying(255),
    is_ssl boolean,
    is_delivered boolean,
    delivered bigint,
    is_succeed boolean,
    request_content text,
    response_content text
);


ALTER TABLE public.hook_task OWNER TO gogs;

--
-- Name: hook_task_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.hook_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hook_task_id_seq OWNER TO gogs;

--
-- Name: hook_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.hook_task_id_seq OWNED BY public.hook_task.id;


--
-- Name: issue; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.issue (
    id bigint NOT NULL,
    repo_id bigint,
    index bigint,
    poster_id bigint,
    name character varying(255),
    content text,
    milestone_id bigint,
    priority integer,
    assignee_id bigint,
    is_closed boolean,
    is_pull boolean,
    num_comments integer,
    deadline_unix bigint,
    created_unix bigint,
    updated_unix bigint
);


ALTER TABLE public.issue OWNER TO gogs;

--
-- Name: issue_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.issue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.issue_id_seq OWNER TO gogs;

--
-- Name: issue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.issue_id_seq OWNED BY public.issue.id;


--
-- Name: issue_label; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.issue_label (
    id bigint NOT NULL,
    issue_id bigint,
    label_id bigint
);


ALTER TABLE public.issue_label OWNER TO gogs;

--
-- Name: issue_label_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.issue_label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.issue_label_id_seq OWNER TO gogs;

--
-- Name: issue_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.issue_label_id_seq OWNED BY public.issue_label.id;


--
-- Name: issue_user; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.issue_user (
    id bigint NOT NULL,
    uid bigint,
    issue_id bigint,
    repo_id bigint,
    milestone_id bigint,
    is_read boolean,
    is_assigned boolean,
    is_mentioned boolean,
    is_poster boolean,
    is_closed boolean
);


ALTER TABLE public.issue_user OWNER TO gogs;

--
-- Name: issue_user_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.issue_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.issue_user_id_seq OWNER TO gogs;

--
-- Name: issue_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.issue_user_id_seq OWNED BY public.issue_user.id;


--
-- Name: label; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.label (
    id bigint NOT NULL,
    repo_id bigint,
    name character varying(255),
    color character varying(7),
    num_issues integer,
    num_closed_issues integer
);


ALTER TABLE public.label OWNER TO gogs;

--
-- Name: label_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.label_id_seq OWNER TO gogs;

--
-- Name: label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.label_id_seq OWNED BY public.label.id;


--
-- Name: login_source; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.login_source (
    id bigint NOT NULL,
    type integer,
    name character varying(255),
    is_actived boolean DEFAULT false NOT NULL,
    is_default boolean DEFAULT false,
    cfg text,
    created_unix bigint,
    updated_unix bigint
);


ALTER TABLE public.login_source OWNER TO gogs;

--
-- Name: login_source_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.login_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.login_source_id_seq OWNER TO gogs;

--
-- Name: login_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.login_source_id_seq OWNED BY public.login_source.id;


--
-- Name: milestone; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.milestone (
    id bigint NOT NULL,
    repo_id bigint,
    name character varying(255),
    content text,
    is_closed boolean,
    num_issues integer,
    num_closed_issues integer,
    completeness integer,
    deadline_unix bigint,
    closed_date_unix bigint
);


ALTER TABLE public.milestone OWNER TO gogs;

--
-- Name: milestone_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.milestone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.milestone_id_seq OWNER TO gogs;

--
-- Name: milestone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.milestone_id_seq OWNED BY public.milestone.id;


--
-- Name: mirror; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.mirror (
    id bigint NOT NULL,
    repo_id bigint,
    "interval" integer,
    enable_prune boolean DEFAULT true NOT NULL,
    updated_unix bigint,
    next_update_unix bigint
);


ALTER TABLE public.mirror OWNER TO gogs;

--
-- Name: mirror_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.mirror_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mirror_id_seq OWNER TO gogs;

--
-- Name: mirror_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.mirror_id_seq OWNED BY public.mirror.id;


--
-- Name: notice; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.notice (
    id bigint NOT NULL,
    type integer,
    description text,
    created_unix bigint
);


ALTER TABLE public.notice OWNER TO gogs;

--
-- Name: notice_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.notice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notice_id_seq OWNER TO gogs;

--
-- Name: notice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.notice_id_seq OWNED BY public.notice.id;


--
-- Name: org_user; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.org_user (
    id bigint NOT NULL,
    uid bigint,
    org_id bigint,
    is_public boolean,
    is_owner boolean,
    num_teams integer
);


ALTER TABLE public.org_user OWNER TO gogs;

--
-- Name: org_user_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.org_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.org_user_id_seq OWNER TO gogs;

--
-- Name: org_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.org_user_id_seq OWNED BY public.org_user.id;


--
-- Name: protect_branch; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.protect_branch (
    id bigint NOT NULL,
    repo_id bigint,
    name character varying(255),
    protected boolean,
    require_pull_request boolean,
    enable_whitelist boolean,
    whitelist_user_i_ds text,
    whitelist_team_i_ds text
);


ALTER TABLE public.protect_branch OWNER TO gogs;

--
-- Name: protect_branch_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.protect_branch_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.protect_branch_id_seq OWNER TO gogs;

--
-- Name: protect_branch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.protect_branch_id_seq OWNED BY public.protect_branch.id;


--
-- Name: protect_branch_whitelist; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.protect_branch_whitelist (
    id bigint NOT NULL,
    protect_branch_id bigint,
    repo_id bigint,
    name character varying(255),
    user_id bigint
);


ALTER TABLE public.protect_branch_whitelist OWNER TO gogs;

--
-- Name: protect_branch_whitelist_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.protect_branch_whitelist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.protect_branch_whitelist_id_seq OWNER TO gogs;

--
-- Name: protect_branch_whitelist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.protect_branch_whitelist_id_seq OWNED BY public.protect_branch_whitelist.id;


--
-- Name: public_key; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.public_key (
    id bigint NOT NULL,
    owner_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    fingerprint character varying(255) NOT NULL,
    content text NOT NULL,
    mode integer DEFAULT 2 NOT NULL,
    type integer DEFAULT 1 NOT NULL,
    created_unix bigint,
    updated_unix bigint
);


ALTER TABLE public.public_key OWNER TO gogs;

--
-- Name: public_key_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.public_key_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.public_key_id_seq OWNER TO gogs;

--
-- Name: public_key_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.public_key_id_seq OWNED BY public.public_key.id;


--
-- Name: pull_request; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.pull_request (
    id bigint NOT NULL,
    type integer,
    status integer,
    issue_id bigint,
    index bigint,
    head_repo_id bigint,
    base_repo_id bigint,
    head_user_name character varying(255),
    head_branch character varying(255),
    base_branch character varying(255),
    merge_base character varying(40),
    has_merged boolean,
    merged_commit_id character varying(40),
    merger_id bigint,
    merged_unix bigint
);


ALTER TABLE public.pull_request OWNER TO gogs;

--
-- Name: pull_request_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.pull_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pull_request_id_seq OWNER TO gogs;

--
-- Name: pull_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.pull_request_id_seq OWNED BY public.pull_request.id;


--
-- Name: release; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.release (
    id bigint NOT NULL,
    repo_id bigint,
    publisher_id bigint,
    tag_name character varying(255),
    lower_tag_name character varying(255),
    target character varying(255),
    title character varying(255),
    sha1 character varying(40),
    num_commits bigint,
    note text,
    is_draft boolean DEFAULT false NOT NULL,
    is_prerelease boolean,
    created_unix bigint
);


ALTER TABLE public.release OWNER TO gogs;

--
-- Name: release_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.release_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.release_id_seq OWNER TO gogs;

--
-- Name: release_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.release_id_seq OWNED BY public.release.id;


--
-- Name: repository; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.repository (
    id bigint NOT NULL,
    owner_id bigint,
    lower_name character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(512),
    website character varying(255),
    default_branch character varying(255),
    size bigint DEFAULT 0 NOT NULL,
    use_custom_avatar boolean,
    num_watches integer,
    num_stars integer,
    num_forks integer,
    num_issues integer,
    num_closed_issues integer,
    num_pulls integer,
    num_closed_pulls integer,
    num_milestones integer DEFAULT 0 NOT NULL,
    num_closed_milestones integer DEFAULT 0 NOT NULL,
    is_private boolean,
    is_bare boolean,
    is_mirror boolean,
    enable_wiki boolean DEFAULT true NOT NULL,
    allow_public_wiki boolean,
    enable_external_wiki boolean,
    external_wiki_url character varying(255),
    enable_issues boolean DEFAULT true NOT NULL,
    allow_public_issues boolean,
    enable_external_tracker boolean,
    external_tracker_url character varying(255),
    external_tracker_format character varying(255),
    external_tracker_style character varying(255),
    enable_pulls boolean DEFAULT true NOT NULL,
    pulls_ignore_whitespace boolean DEFAULT false NOT NULL,
    pulls_allow_rebase boolean DEFAULT false NOT NULL,
    is_fork boolean DEFAULT false NOT NULL,
    fork_id bigint,
    created_unix bigint,
    updated_unix bigint
);


ALTER TABLE public.repository OWNER TO gogs;

--
-- Name: repository_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.repository_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.repository_id_seq OWNER TO gogs;

--
-- Name: repository_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.repository_id_seq OWNED BY public.repository.id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.star (
    id bigint NOT NULL,
    uid bigint,
    repo_id bigint
);


ALTER TABLE public.star OWNER TO gogs;

--
-- Name: star_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.star_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_id_seq OWNER TO gogs;

--
-- Name: star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.star_id_seq OWNED BY public.star.id;


--
-- Name: team; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.team (
    id bigint NOT NULL,
    org_id bigint,
    lower_name character varying(255),
    name character varying(255),
    description character varying(255),
    authorize integer,
    num_repos integer,
    num_members integer
);


ALTER TABLE public.team OWNER TO gogs;

--
-- Name: team_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_id_seq OWNER TO gogs;

--
-- Name: team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.team_id_seq OWNED BY public.team.id;


--
-- Name: team_repo; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.team_repo (
    id bigint NOT NULL,
    org_id bigint,
    team_id bigint,
    repo_id bigint
);


ALTER TABLE public.team_repo OWNER TO gogs;

--
-- Name: team_repo_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.team_repo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_repo_id_seq OWNER TO gogs;

--
-- Name: team_repo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.team_repo_id_seq OWNED BY public.team_repo.id;


--
-- Name: team_user; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.team_user (
    id bigint NOT NULL,
    org_id bigint,
    team_id bigint,
    uid bigint
);


ALTER TABLE public.team_user OWNER TO gogs;

--
-- Name: team_user_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.team_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_user_id_seq OWNER TO gogs;

--
-- Name: team_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.team_user_id_seq OWNED BY public.team_user.id;


--
-- Name: two_factor; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.two_factor (
    id bigint NOT NULL,
    user_id bigint,
    secret character varying(255),
    created_unix bigint
);


ALTER TABLE public.two_factor OWNER TO gogs;

--
-- Name: two_factor_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.two_factor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.two_factor_id_seq OWNER TO gogs;

--
-- Name: two_factor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.two_factor_id_seq OWNED BY public.two_factor.id;


--
-- Name: two_factor_recovery_code; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.two_factor_recovery_code (
    id bigint NOT NULL,
    user_id bigint,
    code character varying(11),
    is_used boolean
);


ALTER TABLE public.two_factor_recovery_code OWNER TO gogs;

--
-- Name: two_factor_recovery_code_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.two_factor_recovery_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.two_factor_recovery_code_id_seq OWNER TO gogs;

--
-- Name: two_factor_recovery_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.two_factor_recovery_code_id_seq OWNED BY public.two_factor_recovery_code.id;


--
-- Name: upload; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.upload (
    id bigint NOT NULL,
    uuid uuid,
    name character varying(255)
);


ALTER TABLE public.upload OWNER TO gogs;

--
-- Name: upload_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.upload_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.upload_id_seq OWNER TO gogs;

--
-- Name: upload_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.upload_id_seq OWNED BY public.upload.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public."user" (
    id bigint NOT NULL,
    lower_name character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    full_name character varying(255),
    email character varying(255) NOT NULL,
    passwd character varying(255) NOT NULL,
    login_type integer,
    login_source bigint DEFAULT 0 NOT NULL,
    login_name character varying(255),
    type integer,
    location character varying(255),
    website character varying(255),
    rands character varying(10),
    salt character varying(10),
    created_unix bigint,
    updated_unix bigint,
    last_repo_visibility boolean,
    max_repo_creation integer DEFAULT '-1'::integer NOT NULL,
    is_active boolean,
    is_admin boolean,
    allow_git_hook boolean,
    allow_import_local boolean,
    prohibit_login boolean,
    avatar character varying(2048) NOT NULL,
    avatar_email character varying(255) NOT NULL,
    use_custom_avatar boolean,
    num_followers integer,
    num_following integer DEFAULT 0 NOT NULL,
    num_stars integer,
    num_repos integer,
    description character varying(255),
    num_teams integer,
    num_members integer
);


ALTER TABLE public."user" OWNER TO gogs;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO gogs;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: version; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.version (
    id bigint NOT NULL,
    version bigint
);


ALTER TABLE public.version OWNER TO gogs;

--
-- Name: version_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.version_id_seq OWNER TO gogs;

--
-- Name: version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.version_id_seq OWNED BY public.version.id;


--
-- Name: watch; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.watch (
    id bigint NOT NULL,
    user_id bigint,
    repo_id bigint
);


ALTER TABLE public.watch OWNER TO gogs;

--
-- Name: watch_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.watch_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.watch_id_seq OWNER TO gogs;

--
-- Name: watch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.watch_id_seq OWNED BY public.watch.id;


--
-- Name: webhook; Type: TABLE; Schema: public; Owner: gogs
--

CREATE TABLE public.webhook (
    id bigint NOT NULL,
    repo_id bigint,
    org_id bigint,
    url text,
    content_type integer,
    secret text,
    events text,
    is_ssl boolean,
    is_active boolean,
    hook_task_type integer,
    meta text,
    last_status integer,
    created_unix bigint,
    updated_unix bigint
);


ALTER TABLE public.webhook OWNER TO gogs;

--
-- Name: webhook_id_seq; Type: SEQUENCE; Schema: public; Owner: gogs
--

CREATE SEQUENCE public.webhook_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.webhook_id_seq OWNER TO gogs;

--
-- Name: webhook_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gogs
--

ALTER SEQUENCE public.webhook_id_seq OWNED BY public.webhook.id;


--
-- Name: access id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.access ALTER COLUMN id SET DEFAULT nextval('public.access_id_seq'::regclass);


--
-- Name: access_token id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.access_token ALTER COLUMN id SET DEFAULT nextval('public.access_token_id_seq'::regclass);


--
-- Name: action id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.action ALTER COLUMN id SET DEFAULT nextval('public.action_id_seq'::regclass);


--
-- Name: attachment id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.attachment ALTER COLUMN id SET DEFAULT nextval('public.attachment_id_seq'::regclass);


--
-- Name: collaboration id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.collaboration ALTER COLUMN id SET DEFAULT nextval('public.collaboration_id_seq'::regclass);


--
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);


--
-- Name: deploy_key id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.deploy_key ALTER COLUMN id SET DEFAULT nextval('public.deploy_key_id_seq'::regclass);


--
-- Name: email_address id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.email_address ALTER COLUMN id SET DEFAULT nextval('public.email_address_id_seq'::regclass);


--
-- Name: follow id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.follow ALTER COLUMN id SET DEFAULT nextval('public.follow_id_seq'::regclass);


--
-- Name: hook_task id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.hook_task ALTER COLUMN id SET DEFAULT nextval('public.hook_task_id_seq'::regclass);


--
-- Name: issue id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.issue ALTER COLUMN id SET DEFAULT nextval('public.issue_id_seq'::regclass);


--
-- Name: issue_label id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.issue_label ALTER COLUMN id SET DEFAULT nextval('public.issue_label_id_seq'::regclass);


--
-- Name: issue_user id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.issue_user ALTER COLUMN id SET DEFAULT nextval('public.issue_user_id_seq'::regclass);


--
-- Name: label id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.label ALTER COLUMN id SET DEFAULT nextval('public.label_id_seq'::regclass);


--
-- Name: login_source id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.login_source ALTER COLUMN id SET DEFAULT nextval('public.login_source_id_seq'::regclass);


--
-- Name: milestone id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.milestone ALTER COLUMN id SET DEFAULT nextval('public.milestone_id_seq'::regclass);


--
-- Name: mirror id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.mirror ALTER COLUMN id SET DEFAULT nextval('public.mirror_id_seq'::regclass);


--
-- Name: notice id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.notice ALTER COLUMN id SET DEFAULT nextval('public.notice_id_seq'::regclass);


--
-- Name: org_user id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.org_user ALTER COLUMN id SET DEFAULT nextval('public.org_user_id_seq'::regclass);


--
-- Name: protect_branch id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.protect_branch ALTER COLUMN id SET DEFAULT nextval('public.protect_branch_id_seq'::regclass);


--
-- Name: protect_branch_whitelist id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.protect_branch_whitelist ALTER COLUMN id SET DEFAULT nextval('public.protect_branch_whitelist_id_seq'::regclass);


--
-- Name: public_key id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.public_key ALTER COLUMN id SET DEFAULT nextval('public.public_key_id_seq'::regclass);


--
-- Name: pull_request id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.pull_request ALTER COLUMN id SET DEFAULT nextval('public.pull_request_id_seq'::regclass);


--
-- Name: release id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.release ALTER COLUMN id SET DEFAULT nextval('public.release_id_seq'::regclass);


--
-- Name: repository id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.repository ALTER COLUMN id SET DEFAULT nextval('public.repository_id_seq'::regclass);


--
-- Name: star id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.star ALTER COLUMN id SET DEFAULT nextval('public.star_id_seq'::regclass);


--
-- Name: team id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.team ALTER COLUMN id SET DEFAULT nextval('public.team_id_seq'::regclass);


--
-- Name: team_repo id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.team_repo ALTER COLUMN id SET DEFAULT nextval('public.team_repo_id_seq'::regclass);


--
-- Name: team_user id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.team_user ALTER COLUMN id SET DEFAULT nextval('public.team_user_id_seq'::regclass);


--
-- Name: two_factor id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.two_factor ALTER COLUMN id SET DEFAULT nextval('public.two_factor_id_seq'::regclass);


--
-- Name: two_factor_recovery_code id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.two_factor_recovery_code ALTER COLUMN id SET DEFAULT nextval('public.two_factor_recovery_code_id_seq'::regclass);


--
-- Name: upload id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.upload ALTER COLUMN id SET DEFAULT nextval('public.upload_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: version id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.version ALTER COLUMN id SET DEFAULT nextval('public.version_id_seq'::regclass);


--
-- Name: watch id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.watch ALTER COLUMN id SET DEFAULT nextval('public.watch_id_seq'::regclass);


--
-- Name: webhook id; Type: DEFAULT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.webhook ALTER COLUMN id SET DEFAULT nextval('public.webhook_id_seq'::regclass);


--
-- Data for Name: access; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.access (id, user_id, repo_id, mode) FROM stdin;
\.


--
-- Data for Name: access_token; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.access_token (id, uid, name, sha1, created_unix, updated_unix) FROM stdin;
1	2	drone	33279f7d138c3ba63730c7f7f23c4f8aec7edfb8	1576410881	1576410884
\.


--
-- Data for Name: action; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.action (id, user_id, op_type, act_user_id, act_user_name, repo_id, repo_user_name, repo_name, ref_name, is_private, content, created_unix) FROM stdin;
1	2	1	2	developer	1	developer	example-golang-app		f		1576410870
\.


--
-- Data for Name: attachment; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.attachment (id, uuid, issue_id, comment_id, release_id, name, created_unix) FROM stdin;
\.


--
-- Data for Name: collaboration; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.collaboration (id, repo_id, user_id, mode) FROM stdin;
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.comment (id, type, poster_id, issue_id, commit_id, line, content, created_unix, updated_unix, commit_sha) FROM stdin;
\.


--
-- Data for Name: deploy_key; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.deploy_key (id, key_id, repo_id, name, fingerprint, created_unix, updated_unix) FROM stdin;
\.


--
-- Data for Name: email_address; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.email_address (id, uid, email, is_activated) FROM stdin;
\.


--
-- Data for Name: follow; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.follow (id, user_id, follow_id) FROM stdin;
\.


--
-- Data for Name: hook_task; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.hook_task (id, repo_id, hook_id, uuid, type, url, signature, payload_content, content_type, event_type, is_ssl, is_delivered, delivered, is_succeed, request_content, response_content) FROM stdin;
\.


--
-- Data for Name: issue; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.issue (id, repo_id, index, poster_id, name, content, milestone_id, priority, assignee_id, is_closed, is_pull, num_comments, deadline_unix, created_unix, updated_unix) FROM stdin;
\.


--
-- Data for Name: issue_label; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.issue_label (id, issue_id, label_id) FROM stdin;
\.


--
-- Data for Name: issue_user; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.issue_user (id, uid, issue_id, repo_id, milestone_id, is_read, is_assigned, is_mentioned, is_poster, is_closed) FROM stdin;
\.


--
-- Data for Name: label; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.label (id, repo_id, name, color, num_issues, num_closed_issues) FROM stdin;
\.


--
-- Data for Name: login_source; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.login_source (id, type, name, is_actived, is_default, cfg, created_unix, updated_unix) FROM stdin;
1	2	ldap	t	t	{"Host":"ldap-svc","Port":389,"SecurityProtocol":0,"SkipVerify":false,"BindDN":"cn=readonly,dc=mykube,dc=awesome","BindPassword":"readonly","UserBase":"dc=mykube,dc=awesome","UserDN":"","AttributeUsername":"uid","AttributeName":"","AttributeSurname":"","AttributeMail":"mail","AttributesInBind":false,"Filter":"(uid=%s)","AdminFilter":"(\\u0026(uid=%s)(memberOf=cn=gitadmins,ou=gitadmins,ou=people,dc=mykube,dc=awesome))","GroupEnabled":false,"GroupDN":"ou=group,dc=mykube,dc=awesome","GroupFilter":"(\\u0026(objectClass=posixGroup)(cn=developers)(memberUid=%s))","GroupMemberUID":"memberUid","UserUID":"memberUid"}	1576410826	1576410832
\.


--
-- Data for Name: milestone; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.milestone (id, repo_id, name, content, is_closed, num_issues, num_closed_issues, completeness, deadline_unix, closed_date_unix) FROM stdin;
\.


--
-- Data for Name: mirror; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.mirror (id, repo_id, "interval", enable_prune, updated_unix, next_update_unix) FROM stdin;
\.


--
-- Data for Name: notice; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.notice (id, type, description, created_unix) FROM stdin;
\.


--
-- Data for Name: org_user; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.org_user (id, uid, org_id, is_public, is_owner, num_teams) FROM stdin;
\.


--
-- Data for Name: protect_branch; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.protect_branch (id, repo_id, name, protected, require_pull_request, enable_whitelist, whitelist_user_i_ds, whitelist_team_i_ds) FROM stdin;
\.


--
-- Data for Name: protect_branch_whitelist; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.protect_branch_whitelist (id, protect_branch_id, repo_id, name, user_id) FROM stdin;
\.


--
-- Data for Name: public_key; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.public_key (id, owner_id, name, fingerprint, content, mode, type, created_unix, updated_unix) FROM stdin;
\.


--
-- Data for Name: pull_request; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.pull_request (id, type, status, issue_id, index, head_repo_id, base_repo_id, head_user_name, head_branch, base_branch, merge_base, has_merged, merged_commit_id, merger_id, merged_unix) FROM stdin;
\.


--
-- Data for Name: release; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.release (id, repo_id, publisher_id, tag_name, lower_tag_name, target, title, sha1, num_commits, note, is_draft, is_prerelease, created_unix) FROM stdin;
\.


--
-- Data for Name: repository; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.repository (id, owner_id, lower_name, name, description, website, default_branch, size, use_custom_avatar, num_watches, num_stars, num_forks, num_issues, num_closed_issues, num_pulls, num_closed_pulls, num_milestones, num_closed_milestones, is_private, is_bare, is_mirror, enable_wiki, allow_public_wiki, enable_external_wiki, external_wiki_url, enable_issues, allow_public_issues, enable_external_tracker, external_tracker_url, external_tracker_format, external_tracker_style, enable_pulls, pulls_ignore_whitespace, pulls_allow_rebase, is_fork, fork_id, created_unix, updated_unix) FROM stdin;
1	2	example-golang-app	example-golang-app			master	0	f	1	0	0	0	0	0	0	0	0	f	t	f	t	f	f		t	f	f			numeric	t	f	f	f	0	1576410870	1576410870
\.


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.star (id, uid, repo_id) FROM stdin;
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.team (id, org_id, lower_name, name, description, authorize, num_repos, num_members) FROM stdin;
\.


--
-- Data for Name: team_repo; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.team_repo (id, org_id, team_id, repo_id) FROM stdin;
\.


--
-- Data for Name: team_user; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.team_user (id, org_id, team_id, uid) FROM stdin;
\.


--
-- Data for Name: two_factor; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.two_factor (id, user_id, secret, created_unix) FROM stdin;
\.


--
-- Data for Name: two_factor_recovery_code; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.two_factor_recovery_code (id, user_id, code, is_used) FROM stdin;
\.


--
-- Data for Name: upload; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.upload (id, uuid, name) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public."user" (id, lower_name, name, full_name, email, passwd, login_type, login_source, login_name, type, location, website, rands, salt, created_unix, updated_unix, last_repo_visibility, max_repo_creation, is_active, is_admin, allow_git_hook, allow_import_local, prohibit_login, avatar, avatar_email, use_custom_avatar, num_followers, num_following, num_stars, num_repos, description, num_teams, num_members) FROM stdin;
1	gitadmin	gitadmin		gitadmin@mykube.awesome	066b2192c97a640d214f57ddeee196d1015bd34e3f2d020a31b2d274e307abc8c94f16028b78e9edf9eefb2adc5332c904ea	0	0		0			S3MFW6MCLX	dq0lidBFha	1576410685	1576410685	f	-1	t	t	f	f	f	d85ff99563c19170227453c8e4436cf4	gitadmin@mykube.awesome	f	0	0	0	0		0	0
2	developer	developer	developer	developer@mykube.awesome	2cb1c5170590fdacd3d42c6852f8eebe12232e1aadd73246b81263a8d0484e176f511adfa20b73cd2adc02c3efe71b1c3887	2	1	developer	0			XA9yIWqUBI	4US6I9MflL	1576410847	1576410870	f	-1	t	f	f	f	f	a603259584aa3ac4fd4ab8c903462384	developer@mykube.awesome	f	0	0	0	1		0	0
\.


--
-- Data for Name: version; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.version (id, version) FROM stdin;
1	19
\.


--
-- Data for Name: watch; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.watch (id, user_id, repo_id) FROM stdin;
1	2	1
\.


--
-- Data for Name: webhook; Type: TABLE DATA; Schema: public; Owner: gogs
--

COPY public.webhook (id, repo_id, org_id, url, content_type, secret, events, is_ssl, is_active, hook_task_type, meta, last_status, created_unix, updated_unix) FROM stdin;
1	1	0	http://drone-svc/hook?access_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZXh0IjoiZGV2ZWxvcGVyL2V4YW1wbGUtZ29sYW5nLWFwcCIsInR5cGUiOiJob29rIn0.LJfkUHu7kJ6dLvUvkMZo0TDf_l_lt3h9rftQ2XlToSg	1	DWNBQT5ASWILDXNQKZYGVMUCWKPAJREYJYCMT4H2EOVPMNWEXFPQ====	{"push_only":false,"send_everything":false,"choose_events":true,"events":{"create":true,"delete":false,"fork":false,"push":true,"issues":false,"pull_request":true,"issue_comment":false,"release":false}}	f	t	1		0	1576410884	1576410897
\.


--
-- Name: access_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.access_id_seq', 1, false);


--
-- Name: access_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.access_token_id_seq', 1, true);


--
-- Name: action_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.action_id_seq', 1, true);


--
-- Name: attachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.attachment_id_seq', 1, false);


--
-- Name: collaboration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.collaboration_id_seq', 1, false);


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.comment_id_seq', 1, false);


--
-- Name: deploy_key_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.deploy_key_id_seq', 1, false);


--
-- Name: email_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.email_address_id_seq', 1, false);


--
-- Name: follow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.follow_id_seq', 1, false);


--
-- Name: hook_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.hook_task_id_seq', 1, false);


--
-- Name: issue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.issue_id_seq', 1, false);


--
-- Name: issue_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.issue_label_id_seq', 1, false);


--
-- Name: issue_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.issue_user_id_seq', 1, false);


--
-- Name: label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.label_id_seq', 1, false);


--
-- Name: login_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.login_source_id_seq', 1, true);


--
-- Name: milestone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.milestone_id_seq', 1, false);


--
-- Name: mirror_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.mirror_id_seq', 1, false);


--
-- Name: notice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.notice_id_seq', 1, false);


--
-- Name: org_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.org_user_id_seq', 1, false);


--
-- Name: protect_branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.protect_branch_id_seq', 1, false);


--
-- Name: protect_branch_whitelist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.protect_branch_whitelist_id_seq', 1, false);


--
-- Name: public_key_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.public_key_id_seq', 1, false);


--
-- Name: pull_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.pull_request_id_seq', 1, false);


--
-- Name: release_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.release_id_seq', 1, false);


--
-- Name: repository_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.repository_id_seq', 1, true);


--
-- Name: star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.star_id_seq', 1, false);


--
-- Name: team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.team_id_seq', 1, false);


--
-- Name: team_repo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.team_repo_id_seq', 1, false);


--
-- Name: team_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.team_user_id_seq', 1, false);


--
-- Name: two_factor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.two_factor_id_seq', 1, false);


--
-- Name: two_factor_recovery_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.two_factor_recovery_code_id_seq', 1, false);


--
-- Name: upload_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.upload_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.user_id_seq', 2, true);


--
-- Name: version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.version_id_seq', 1, true);


--
-- Name: watch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.watch_id_seq', 1, true);


--
-- Name: webhook_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gogs
--

SELECT pg_catalog.setval('public.webhook_id_seq', 1, true);


--
-- Name: access access_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.access
    ADD CONSTRAINT access_pkey PRIMARY KEY (id);


--
-- Name: access_token access_token_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.access_token
    ADD CONSTRAINT access_token_pkey PRIMARY KEY (id);


--
-- Name: action action_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.action
    ADD CONSTRAINT action_pkey PRIMARY KEY (id);


--
-- Name: attachment attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.attachment
    ADD CONSTRAINT attachment_pkey PRIMARY KEY (id);


--
-- Name: collaboration collaboration_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.collaboration
    ADD CONSTRAINT collaboration_pkey PRIMARY KEY (id);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: deploy_key deploy_key_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.deploy_key
    ADD CONSTRAINT deploy_key_pkey PRIMARY KEY (id);


--
-- Name: email_address email_address_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.email_address
    ADD CONSTRAINT email_address_pkey PRIMARY KEY (id);


--
-- Name: follow follow_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follow_pkey PRIMARY KEY (id);


--
-- Name: hook_task hook_task_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.hook_task
    ADD CONSTRAINT hook_task_pkey PRIMARY KEY (id);


--
-- Name: issue_label issue_label_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.issue_label
    ADD CONSTRAINT issue_label_pkey PRIMARY KEY (id);


--
-- Name: issue issue_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.issue
    ADD CONSTRAINT issue_pkey PRIMARY KEY (id);


--
-- Name: issue_user issue_user_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.issue_user
    ADD CONSTRAINT issue_user_pkey PRIMARY KEY (id);


--
-- Name: label label_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.label
    ADD CONSTRAINT label_pkey PRIMARY KEY (id);


--
-- Name: login_source login_source_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.login_source
    ADD CONSTRAINT login_source_pkey PRIMARY KEY (id);


--
-- Name: milestone milestone_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.milestone
    ADD CONSTRAINT milestone_pkey PRIMARY KEY (id);


--
-- Name: mirror mirror_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.mirror
    ADD CONSTRAINT mirror_pkey PRIMARY KEY (id);


--
-- Name: notice notice_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.notice
    ADD CONSTRAINT notice_pkey PRIMARY KEY (id);


--
-- Name: org_user org_user_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.org_user
    ADD CONSTRAINT org_user_pkey PRIMARY KEY (id);


--
-- Name: protect_branch protect_branch_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.protect_branch
    ADD CONSTRAINT protect_branch_pkey PRIMARY KEY (id);


--
-- Name: protect_branch_whitelist protect_branch_whitelist_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.protect_branch_whitelist
    ADD CONSTRAINT protect_branch_whitelist_pkey PRIMARY KEY (id);


--
-- Name: public_key public_key_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.public_key
    ADD CONSTRAINT public_key_pkey PRIMARY KEY (id);


--
-- Name: pull_request pull_request_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.pull_request
    ADD CONSTRAINT pull_request_pkey PRIMARY KEY (id);


--
-- Name: release release_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.release
    ADD CONSTRAINT release_pkey PRIMARY KEY (id);


--
-- Name: repository repository_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.repository
    ADD CONSTRAINT repository_pkey PRIMARY KEY (id);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (id);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id);


--
-- Name: team_repo team_repo_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.team_repo
    ADD CONSTRAINT team_repo_pkey PRIMARY KEY (id);


--
-- Name: team_user team_user_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.team_user
    ADD CONSTRAINT team_user_pkey PRIMARY KEY (id);


--
-- Name: two_factor two_factor_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.two_factor
    ADD CONSTRAINT two_factor_pkey PRIMARY KEY (id);


--
-- Name: two_factor_recovery_code two_factor_recovery_code_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.two_factor_recovery_code
    ADD CONSTRAINT two_factor_recovery_code_pkey PRIMARY KEY (id);


--
-- Name: upload upload_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.upload
    ADD CONSTRAINT upload_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: version version_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT version_pkey PRIMARY KEY (id);


--
-- Name: watch watch_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.watch
    ADD CONSTRAINT watch_pkey PRIMARY KEY (id);


--
-- Name: webhook webhook_pkey; Type: CONSTRAINT; Schema: public; Owner: gogs
--

ALTER TABLE ONLY public.webhook
    ADD CONSTRAINT webhook_pkey PRIMARY KEY (id);


--
-- Name: IDX_access_token_uid; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_access_token_uid" ON public.access_token USING btree (uid);


--
-- Name: IDX_action_repo_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_action_repo_id" ON public.action USING btree (repo_id);


--
-- Name: IDX_attachment_issue_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_attachment_issue_id" ON public.attachment USING btree (issue_id);


--
-- Name: IDX_attachment_release_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_attachment_release_id" ON public.attachment USING btree (release_id);


--
-- Name: IDX_collaboration_repo_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_collaboration_repo_id" ON public.collaboration USING btree (repo_id);


--
-- Name: IDX_collaboration_user_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_collaboration_user_id" ON public.collaboration USING btree (user_id);


--
-- Name: IDX_comment_issue_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_comment_issue_id" ON public.comment USING btree (issue_id);


--
-- Name: IDX_deploy_key_key_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_deploy_key_key_id" ON public.deploy_key USING btree (key_id);


--
-- Name: IDX_deploy_key_repo_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_deploy_key_repo_id" ON public.deploy_key USING btree (repo_id);


--
-- Name: IDX_email_address_uid; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_email_address_uid" ON public.email_address USING btree (uid);


--
-- Name: IDX_hook_task_repo_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_hook_task_repo_id" ON public.hook_task USING btree (repo_id);


--
-- Name: IDX_issue_repo_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_issue_repo_id" ON public.issue USING btree (repo_id);


--
-- Name: IDX_issue_user_repo_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_issue_user_repo_id" ON public.issue_user USING btree (repo_id);


--
-- Name: IDX_issue_user_uid; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_issue_user_uid" ON public.issue_user USING btree (uid);


--
-- Name: IDX_label_repo_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_label_repo_id" ON public.label USING btree (repo_id);


--
-- Name: IDX_milestone_repo_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_milestone_repo_id" ON public.milestone USING btree (repo_id);


--
-- Name: IDX_org_user_org_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_org_user_org_id" ON public.org_user USING btree (org_id);


--
-- Name: IDX_org_user_uid; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_org_user_uid" ON public.org_user USING btree (uid);


--
-- Name: IDX_public_key_owner_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_public_key_owner_id" ON public.public_key USING btree (owner_id);


--
-- Name: IDX_pull_request_issue_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_pull_request_issue_id" ON public.pull_request USING btree (issue_id);


--
-- Name: IDX_repository_lower_name; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_repository_lower_name" ON public.repository USING btree (lower_name);


--
-- Name: IDX_repository_name; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_repository_name" ON public.repository USING btree (name);


--
-- Name: IDX_team_org_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_team_org_id" ON public.team USING btree (org_id);


--
-- Name: IDX_team_repo_org_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_team_repo_org_id" ON public.team_repo USING btree (org_id);


--
-- Name: IDX_team_user_org_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE INDEX "IDX_team_user_org_id" ON public.team_user USING btree (org_id);


--
-- Name: UQE_access_s; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_access_s" ON public.access USING btree (user_id, repo_id);


--
-- Name: UQE_access_token_sha1; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_access_token_sha1" ON public.access_token USING btree (sha1);


--
-- Name: UQE_attachment_uuid; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_attachment_uuid" ON public.attachment USING btree (uuid);


--
-- Name: UQE_collaboration_s; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_collaboration_s" ON public.collaboration USING btree (repo_id, user_id);


--
-- Name: UQE_deploy_key_s; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_deploy_key_s" ON public.deploy_key USING btree (key_id, repo_id);


--
-- Name: UQE_email_address_email; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_email_address_email" ON public.email_address USING btree (email);


--
-- Name: UQE_follow_follow; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_follow_follow" ON public.follow USING btree (user_id, follow_id);


--
-- Name: UQE_issue_label_s; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_issue_label_s" ON public.issue_label USING btree (issue_id, label_id);


--
-- Name: UQE_issue_repo_index; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_issue_repo_index" ON public.issue USING btree (repo_id, index);


--
-- Name: UQE_login_source_name; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_login_source_name" ON public.login_source USING btree (name);


--
-- Name: UQE_org_user_s; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_org_user_s" ON public.org_user USING btree (uid, org_id);


--
-- Name: UQE_protect_branch_protect_branch; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_protect_branch_protect_branch" ON public.protect_branch USING btree (repo_id, name);


--
-- Name: UQE_protect_branch_whitelist_protect_branch_whitelist; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_protect_branch_whitelist_protect_branch_whitelist" ON public.protect_branch_whitelist USING btree (repo_id, name, user_id);


--
-- Name: UQE_repository_s; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_repository_s" ON public.repository USING btree (owner_id, lower_name);


--
-- Name: UQE_star_s; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_star_s" ON public.star USING btree (uid, repo_id);


--
-- Name: UQE_team_repo_s; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_team_repo_s" ON public.team_repo USING btree (team_id, repo_id);


--
-- Name: UQE_team_user_s; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_team_user_s" ON public.team_user USING btree (team_id, uid);


--
-- Name: UQE_two_factor_user_id; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_two_factor_user_id" ON public.two_factor USING btree (user_id);


--
-- Name: UQE_upload_uuid; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_upload_uuid" ON public.upload USING btree (uuid);


--
-- Name: UQE_user_lower_name; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_user_lower_name" ON public."user" USING btree (lower_name);


--
-- Name: UQE_user_name; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_user_name" ON public."user" USING btree (name);


--
-- Name: UQE_watch_watch; Type: INDEX; Schema: public; Owner: gogs
--

CREATE UNIQUE INDEX "UQE_watch_watch" ON public.watch USING btree (user_id, repo_id);


--
-- PostgreSQL database dump complete
--

\c drone;

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

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

SET default_with_oids = false;

--
-- Name: agents; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.agents (
    agent_id integer NOT NULL,
    agent_addr character varying(250),
    agent_platform character varying(500),
    agent_capacity integer,
    agent_created integer,
    agent_updated integer
);


ALTER TABLE public.agents OWNER TO drone;

--
-- Name: agents_agent_id_seq; Type: SEQUENCE; Schema: public; Owner: drone
--

CREATE SEQUENCE public.agents_agent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agents_agent_id_seq OWNER TO drone;

--
-- Name: agents_agent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drone
--

ALTER SEQUENCE public.agents_agent_id_seq OWNED BY public.agents.agent_id;


--
-- Name: builds; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.builds (
    build_id integer NOT NULL,
    build_repo_id integer,
    build_number integer,
    build_event character varying(500),
    build_status character varying(500),
    build_enqueued integer,
    build_created integer,
    build_started integer,
    build_finished integer,
    build_commit character varying(500),
    build_branch character varying(500),
    build_ref character varying(500),
    build_refspec character varying(1000),
    build_remote character varying(500),
    build_title character varying(1000),
    build_message character varying(2000),
    build_timestamp integer,
    build_author character varying(500),
    build_avatar character varying(1000),
    build_email character varying(500),
    build_link character varying(1000),
    build_deploy character varying(500),
    build_signed boolean,
    build_verified boolean,
    build_parent integer,
    build_error character varying(500),
    build_reviewer character varying(250),
    build_reviewed integer,
    build_sender character varying(250),
    build_config_id integer
);


ALTER TABLE public.builds OWNER TO drone;

--
-- Name: builds_build_id_seq; Type: SEQUENCE; Schema: public; Owner: drone
--

CREATE SEQUENCE public.builds_build_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.builds_build_id_seq OWNER TO drone;

--
-- Name: builds_build_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drone
--

ALTER SEQUENCE public.builds_build_id_seq OWNED BY public.builds.build_id;


--
-- Name: config; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.config (
    config_id integer NOT NULL,
    config_repo_id integer,
    config_hash character varying(250),
    config_data bytea
);


ALTER TABLE public.config OWNER TO drone;

--
-- Name: config_config_id_seq; Type: SEQUENCE; Schema: public; Owner: drone
--

CREATE SEQUENCE public.config_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.config_config_id_seq OWNER TO drone;

--
-- Name: config_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drone
--

ALTER SEQUENCE public.config_config_id_seq OWNED BY public.config.config_id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.files (
    file_id integer NOT NULL,
    file_build_id integer,
    file_proc_id integer,
    file_name character varying(250),
    file_mime character varying(250),
    file_size integer,
    file_time integer,
    file_data bytea,
    file_pid integer,
    file_meta_passed integer,
    file_meta_failed integer,
    file_meta_skipped integer
);


ALTER TABLE public.files OWNER TO drone;

--
-- Name: files_file_id_seq; Type: SEQUENCE; Schema: public; Owner: drone
--

CREATE SEQUENCE public.files_file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_file_id_seq OWNER TO drone;

--
-- Name: files_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drone
--

ALTER SEQUENCE public.files_file_id_seq OWNED BY public.files.file_id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.logs (
    log_id integer NOT NULL,
    log_job_id integer,
    log_data bytea
);


ALTER TABLE public.logs OWNER TO drone;

--
-- Name: logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: drone
--

CREATE SEQUENCE public.logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logs_log_id_seq OWNER TO drone;

--
-- Name: logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drone
--

ALTER SEQUENCE public.logs_log_id_seq OWNED BY public.logs.log_id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.migrations (
    name character varying(255)
);


ALTER TABLE public.migrations OWNER TO drone;

--
-- Name: perms; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.perms (
    perm_user_id integer NOT NULL,
    perm_repo_id integer NOT NULL,
    perm_pull boolean,
    perm_push boolean,
    perm_admin boolean,
    perm_synced integer
);


ALTER TABLE public.perms OWNER TO drone;

--
-- Name: procs; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.procs (
    proc_id integer NOT NULL,
    proc_build_id integer,
    proc_pid integer,
    proc_ppid integer,
    proc_pgid integer,
    proc_name character varying(250),
    proc_state character varying(250),
    proc_error character varying(500),
    proc_exit_code integer,
    proc_started integer,
    proc_stopped integer,
    proc_machine character varying(250),
    proc_platform character varying(250),
    proc_environ character varying(2000)
);


ALTER TABLE public.procs OWNER TO drone;

--
-- Name: procs_proc_id_seq; Type: SEQUENCE; Schema: public; Owner: drone
--

CREATE SEQUENCE public.procs_proc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.procs_proc_id_seq OWNER TO drone;

--
-- Name: procs_proc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drone
--

ALTER SEQUENCE public.procs_proc_id_seq OWNED BY public.procs.proc_id;


--
-- Name: registry; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.registry (
    registry_id integer NOT NULL,
    registry_repo_id integer,
    registry_addr character varying(250),
    registry_email character varying(500),
    registry_username character varying(2000),
    registry_password character varying(8000),
    registry_token character varying(2000)
);


ALTER TABLE public.registry OWNER TO drone;

--
-- Name: registry_registry_id_seq; Type: SEQUENCE; Schema: public; Owner: drone
--

CREATE SEQUENCE public.registry_registry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.registry_registry_id_seq OWNER TO drone;

--
-- Name: registry_registry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drone
--

ALTER SEQUENCE public.registry_registry_id_seq OWNED BY public.registry.registry_id;


--
-- Name: repos; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.repos (
    repo_id integer NOT NULL,
    repo_user_id integer,
    repo_owner character varying(250),
    repo_name character varying(250),
    repo_full_name character varying(250),
    repo_avatar character varying(500),
    repo_link character varying(1000),
    repo_clone character varying(1000),
    repo_branch character varying(500),
    repo_timeout integer,
    repo_private boolean,
    repo_trusted boolean,
    repo_allow_pr boolean,
    repo_allow_push boolean,
    repo_allow_deploys boolean,
    repo_allow_tags boolean,
    repo_hash character varying(500),
    repo_scm character varying(50),
    repo_config_path character varying(500),
    repo_gated boolean,
    repo_visibility character varying(50),
    repo_counter integer,
    repo_active boolean
);


ALTER TABLE public.repos OWNER TO drone;

--
-- Name: repos_repo_id_seq; Type: SEQUENCE; Schema: public; Owner: drone
--

CREATE SEQUENCE public.repos_repo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.repos_repo_id_seq OWNER TO drone;

--
-- Name: repos_repo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drone
--

ALTER SEQUENCE public.repos_repo_id_seq OWNED BY public.repos.repo_id;


--
-- Name: secrets; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.secrets (
    secret_id integer NOT NULL,
    secret_repo_id integer,
    secret_name character varying(250),
    secret_value bytea,
    secret_images character varying(2000),
    secret_events character varying(2000),
    secret_skip_verify boolean,
    secret_conceal boolean
);


ALTER TABLE public.secrets OWNER TO drone;

--
-- Name: secrets_secret_id_seq; Type: SEQUENCE; Schema: public; Owner: drone
--

CREATE SEQUENCE public.secrets_secret_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secrets_secret_id_seq OWNER TO drone;

--
-- Name: secrets_secret_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drone
--

ALTER SEQUENCE public.secrets_secret_id_seq OWNED BY public.secrets.secret_id;


--
-- Name: senders; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.senders (
    sender_id integer NOT NULL,
    sender_repo_id integer,
    sender_login character varying(250),
    sender_allow boolean,
    sender_block boolean
);


ALTER TABLE public.senders OWNER TO drone;

--
-- Name: senders_sender_id_seq; Type: SEQUENCE; Schema: public; Owner: drone
--

CREATE SEQUENCE public.senders_sender_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.senders_sender_id_seq OWNER TO drone;

--
-- Name: senders_sender_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drone
--

ALTER SEQUENCE public.senders_sender_id_seq OWNED BY public.senders.sender_id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.tasks (
    task_id character varying(250) NOT NULL,
    task_data bytea,
    task_labels bytea
);


ALTER TABLE public.tasks OWNER TO drone;

--
-- Name: users; Type: TABLE; Schema: public; Owner: drone
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_login character varying(250),
    user_token character varying(500),
    user_secret character varying(500),
    user_expiry integer,
    user_email character varying(500),
    user_avatar character varying(500),
    user_active boolean,
    user_admin boolean,
    user_hash character varying(500),
    user_synced integer
);


ALTER TABLE public.users OWNER TO drone;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: drone
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO drone;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drone
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: agents agent_id; Type: DEFAULT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.agents ALTER COLUMN agent_id SET DEFAULT nextval('public.agents_agent_id_seq'::regclass);


--
-- Name: builds build_id; Type: DEFAULT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.builds ALTER COLUMN build_id SET DEFAULT nextval('public.builds_build_id_seq'::regclass);


--
-- Name: config config_id; Type: DEFAULT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.config ALTER COLUMN config_id SET DEFAULT nextval('public.config_config_id_seq'::regclass);


--
-- Name: files file_id; Type: DEFAULT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.files ALTER COLUMN file_id SET DEFAULT nextval('public.files_file_id_seq'::regclass);


--
-- Name: logs log_id; Type: DEFAULT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.logs ALTER COLUMN log_id SET DEFAULT nextval('public.logs_log_id_seq'::regclass);


--
-- Name: procs proc_id; Type: DEFAULT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.procs ALTER COLUMN proc_id SET DEFAULT nextval('public.procs_proc_id_seq'::regclass);


--
-- Name: registry registry_id; Type: DEFAULT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.registry ALTER COLUMN registry_id SET DEFAULT nextval('public.registry_registry_id_seq'::regclass);


--
-- Name: repos repo_id; Type: DEFAULT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.repos ALTER COLUMN repo_id SET DEFAULT nextval('public.repos_repo_id_seq'::regclass);


--
-- Name: secrets secret_id; Type: DEFAULT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.secrets ALTER COLUMN secret_id SET DEFAULT nextval('public.secrets_secret_id_seq'::regclass);


--
-- Name: senders sender_id; Type: DEFAULT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.senders ALTER COLUMN sender_id SET DEFAULT nextval('public.senders_sender_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: agents; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.agents (agent_id, agent_addr, agent_platform, agent_capacity, agent_created, agent_updated) FROM stdin;
\.


--
-- Data for Name: builds; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.builds (build_id, build_repo_id, build_number, build_event, build_status, build_enqueued, build_created, build_started, build_finished, build_commit, build_branch, build_ref, build_refspec, build_remote, build_title, build_message, build_timestamp, build_author, build_avatar, build_email, build_link, build_deploy, build_signed, build_verified, build_parent, build_error, build_reviewer, build_reviewed, build_sender, build_config_id) FROM stdin;
\.


--
-- Data for Name: config; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.config (config_id, config_repo_id, config_hash, config_data) FROM stdin;
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.files (file_id, file_build_id, file_proc_id, file_name, file_mime, file_size, file_time, file_data, file_pid, file_meta_passed, file_meta_failed, file_meta_skipped) FROM stdin;
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.logs (log_id, log_job_id, log_data) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.migrations (name) FROM stdin;
create-table-users
create-table-repos
create-table-builds
create-index-builds-repo
create-index-builds-author
create-table-procs
create-index-procs-build
create-table-logs
create-table-files
create-index-files-builds
create-index-files-procs
create-table-secrets
create-index-secrets-repo
create-table-registry
create-index-registry-repo
create-table-config
create-table-tasks
create-table-agents
create-table-senders
create-index-sender-repos
alter-table-add-repo-visibility
update-table-set-repo-visibility
alter-table-add-repo-seq
update-table-set-repo-seq
update-table-set-repo-seq-default
alter-table-add-repo-active
update-table-set-repo-active
alter-table-add-user-synced
update-table-set-user-synced
create-table-perms
create-index-perms-repo
create-index-perms-user
alter-table-add-file-pid
alter-table-add-file-meta-passed
alter-table-add-file-meta-failed
alter-table-add-file-meta-skipped
alter-table-update-file-meta
\.


--
-- Data for Name: perms; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.perms (perm_user_id, perm_repo_id, perm_pull, perm_push, perm_admin, perm_synced) FROM stdin;
1	1	t	t	t	1576410883
\.


--
-- Data for Name: procs; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.procs (proc_id, proc_build_id, proc_pid, proc_ppid, proc_pgid, proc_name, proc_state, proc_error, proc_exit_code, proc_started, proc_stopped, proc_machine, proc_platform, proc_environ) FROM stdin;
\.


--
-- Data for Name: registry; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.registry (registry_id, registry_repo_id, registry_addr, registry_email, registry_username, registry_password, registry_token) FROM stdin;
\.


--
-- Data for Name: repos; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.repos (repo_id, repo_user_id, repo_owner, repo_name, repo_full_name, repo_avatar, repo_link, repo_clone, repo_branch, repo_timeout, repo_private, repo_trusted, repo_allow_pr, repo_allow_push, repo_allow_deploys, repo_allow_tags, repo_hash, repo_scm, repo_config_path, repo_gated, repo_visibility, repo_counter, repo_active) FROM stdin;
1	1	developer	example-golang-app	developer/example-golang-app	https://secure.gravatar.com/avatar/a603259584aa3ac4fd4ab8c903462384?d=identicon	http://gogs-svc/developer/example-golang-app	http://gogs-svc/developer/example-golang-app.git	master	60	f	f	t	t	f	f	DWNBQT5ASWILDXNQKZYGVMUCWKPAJREYJYCMT4H2EOVPMNWEXFPQ====	git	.drone.yml	f	public	0	t
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.secrets (secret_id, secret_repo_id, secret_name, secret_value, secret_images, secret_events, secret_skip_verify, secret_conceal) FROM stdin;
1	1	kubeconfig_url	\\x687474703a2f2f6d696e696f2d7376633a393030302f736563726574732f6b756265636f6e666967	null\n	["push","tag","deployment"]\n	f	f
\.


--
-- Data for Name: senders; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.senders (sender_id, sender_repo_id, sender_login, sender_allow, sender_block) FROM stdin;
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.tasks (task_id, task_data, task_labels) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: drone
--

COPY public.users (user_id, user_login, user_token, user_secret, user_expiry, user_email, user_avatar, user_active, user_admin, user_hash, user_synced) FROM stdin;
1	developer	33279f7d138c3ba63730c7f7f23c4f8aec7edfb8		0	developer@mykube.awesome	https://secure.gravatar.com/avatar/a603259584aa3ac4fd4ab8c903462384?d=identicon	f	f	D4TE7UTUTDVOT7IQCPDP7XMEVH6VMXUASI25WH7PDFMNXUIH23NA====	1576410882
\.


--
-- Name: agents_agent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: drone
--

SELECT pg_catalog.setval('public.agents_agent_id_seq', 1, false);


--
-- Name: builds_build_id_seq; Type: SEQUENCE SET; Schema: public; Owner: drone
--

SELECT pg_catalog.setval('public.builds_build_id_seq', 1, false);


--
-- Name: config_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: drone
--

SELECT pg_catalog.setval('public.config_config_id_seq', 1, false);


--
-- Name: files_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: drone
--

SELECT pg_catalog.setval('public.files_file_id_seq', 1, false);


--
-- Name: logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: drone
--

SELECT pg_catalog.setval('public.logs_log_id_seq', 1, false);


--
-- Name: procs_proc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: drone
--

SELECT pg_catalog.setval('public.procs_proc_id_seq', 1, false);


--
-- Name: registry_registry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: drone
--

SELECT pg_catalog.setval('public.registry_registry_id_seq', 1, false);


--
-- Name: repos_repo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: drone
--

SELECT pg_catalog.setval('public.repos_repo_id_seq', 1, true);


--
-- Name: secrets_secret_id_seq; Type: SEQUENCE SET; Schema: public; Owner: drone
--

SELECT pg_catalog.setval('public.secrets_secret_id_seq', 1, true);


--
-- Name: senders_sender_id_seq; Type: SEQUENCE SET; Schema: public; Owner: drone
--

SELECT pg_catalog.setval('public.senders_sender_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: drone
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, true);


--
-- Name: agents agents_agent_addr_key; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_agent_addr_key UNIQUE (agent_addr);


--
-- Name: agents agents_pkey; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_pkey PRIMARY KEY (agent_id);


--
-- Name: builds builds_build_number_build_repo_id_key; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.builds
    ADD CONSTRAINT builds_build_number_build_repo_id_key UNIQUE (build_number, build_repo_id);


--
-- Name: builds builds_pkey; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.builds
    ADD CONSTRAINT builds_pkey PRIMARY KEY (build_id);


--
-- Name: config config_config_hash_config_repo_id_key; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.config
    ADD CONSTRAINT config_config_hash_config_repo_id_key UNIQUE (config_hash, config_repo_id);


--
-- Name: config config_pkey; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.config
    ADD CONSTRAINT config_pkey PRIMARY KEY (config_id);


--
-- Name: files files_file_proc_id_file_name_key; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_file_proc_id_file_name_key UNIQUE (file_proc_id, file_name);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (file_id);


--
-- Name: logs logs_log_job_id_key; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_log_job_id_key UNIQUE (log_job_id);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (log_id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: perms perms_perm_user_id_perm_repo_id_key; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.perms
    ADD CONSTRAINT perms_perm_user_id_perm_repo_id_key UNIQUE (perm_user_id, perm_repo_id);


--
-- Name: procs procs_pkey; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.procs
    ADD CONSTRAINT procs_pkey PRIMARY KEY (proc_id);


--
-- Name: procs procs_proc_build_id_proc_pid_key; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.procs
    ADD CONSTRAINT procs_proc_build_id_proc_pid_key UNIQUE (proc_build_id, proc_pid);


--
-- Name: registry registry_pkey; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.registry
    ADD CONSTRAINT registry_pkey PRIMARY KEY (registry_id);


--
-- Name: registry registry_registry_addr_registry_repo_id_key; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.registry
    ADD CONSTRAINT registry_registry_addr_registry_repo_id_key UNIQUE (registry_addr, registry_repo_id);


--
-- Name: repos repos_pkey; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.repos
    ADD CONSTRAINT repos_pkey PRIMARY KEY (repo_id);


--
-- Name: repos repos_repo_full_name_key; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.repos
    ADD CONSTRAINT repos_repo_full_name_key UNIQUE (repo_full_name);


--
-- Name: secrets secrets_pkey; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.secrets
    ADD CONSTRAINT secrets_pkey PRIMARY KEY (secret_id);


--
-- Name: secrets secrets_secret_name_secret_repo_id_key; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.secrets
    ADD CONSTRAINT secrets_secret_name_secret_repo_id_key UNIQUE (secret_name, secret_repo_id);


--
-- Name: senders senders_pkey; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.senders
    ADD CONSTRAINT senders_pkey PRIMARY KEY (sender_id);


--
-- Name: senders senders_sender_repo_id_sender_login_key; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.senders
    ADD CONSTRAINT senders_sender_repo_id_sender_login_key UNIQUE (sender_repo_id, sender_login);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (task_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_user_login_key; Type: CONSTRAINT; Schema: public; Owner: drone
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_login_key UNIQUE (user_login);


--
-- Name: file_build_ix; Type: INDEX; Schema: public; Owner: drone
--

CREATE INDEX file_build_ix ON public.files USING btree (file_build_id);


--
-- Name: file_proc_ix; Type: INDEX; Schema: public; Owner: drone
--

CREATE INDEX file_proc_ix ON public.files USING btree (file_proc_id);


--
-- Name: ix_build_author; Type: INDEX; Schema: public; Owner: drone
--

CREATE INDEX ix_build_author ON public.builds USING btree (build_author);


--
-- Name: ix_build_repo; Type: INDEX; Schema: public; Owner: drone
--

CREATE INDEX ix_build_repo ON public.builds USING btree (build_repo_id);


--
-- Name: ix_perms_repo; Type: INDEX; Schema: public; Owner: drone
--

CREATE INDEX ix_perms_repo ON public.perms USING btree (perm_repo_id);


--
-- Name: ix_perms_user; Type: INDEX; Schema: public; Owner: drone
--

CREATE INDEX ix_perms_user ON public.perms USING btree (perm_user_id);


--
-- Name: ix_registry_repo; Type: INDEX; Schema: public; Owner: drone
--

CREATE INDEX ix_registry_repo ON public.registry USING btree (registry_repo_id);


--
-- Name: ix_secrets_repo; Type: INDEX; Schema: public; Owner: drone
--

CREATE INDEX ix_secrets_repo ON public.secrets USING btree (secret_repo_id);


--
-- Name: proc_build_ix; Type: INDEX; Schema: public; Owner: drone
--

CREATE INDEX proc_build_ix ON public.procs USING btree (proc_build_id);


--
-- Name: sender_repo_ix; Type: INDEX; Schema: public; Owner: drone
--

CREATE INDEX sender_repo_ix ON public.senders USING btree (sender_repo_id);


--
-- PostgreSQL database dump complete
--

