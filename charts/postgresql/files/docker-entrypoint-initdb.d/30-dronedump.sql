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

