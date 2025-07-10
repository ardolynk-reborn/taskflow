--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Debian 16.9-1.pgdg120+1)
-- Dumped by pg_dump version 16.9 (Debian 16.9-1.pgdg120+1)

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
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: taskflow
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO taskflow;

--
-- Name: notes; Type: TABLE; Schema: public; Owner: taskflow
--

CREATE TABLE public.notes (
    id integer NOT NULL,
    task_id bigint,
    user_id bigint,
    note text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.notes OWNER TO taskflow;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: taskflow
--

CREATE SEQUENCE public.notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notes_id_seq OWNER TO taskflow;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taskflow
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: taskflow
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    owner_id bigint,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.projects OWNER TO taskflow;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: taskflow
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_id_seq OWNER TO taskflow;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taskflow
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: taskflow
--

CREATE TABLE public.tasks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    project_id bigint,
    status character varying(255),
    assignee_id bigint,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    status_updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_task_status CHECK (((status)::text = ANY ((ARRAY['TODO'::character varying, 'IN_PROGRESS'::character varying, 'DONE'::character varying])::text[])))
);


ALTER TABLE public.tasks OWNER TO taskflow;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: taskflow
--

CREATE SEQUENCE public.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tasks_id_seq OWNER TO taskflow;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taskflow
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: taskflow
--

CREATE TABLE public.users (
    id integer NOT NULL,
    keycloak_id character varying(255) NOT NULL,
    username character varying(255),
    email character varying(255),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO taskflow;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: taskflow
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO taskflow;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taskflow
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: taskflow
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	001	basic structure	SQL	V001__basic_structure.sql	1823195088	taskflow	2025-07-02 11:30:04.409746	90	t
2	002	task status	SQL	V002__task_status.sql	1947908098	taskflow	2025-07-02 11:30:04.625008	44	t
3	003	task status constraint	SQL	V003__task_status_constraint.sql	1003859280	taskflow	2025-07-02 11:30:04.717147	14	t
4	004	task title to name	SQL	V004__task_title_to_name.sql	-1179309720	taskflow	2025-07-03 09:09:09.196117	43	t
5	005	timestamps	SQL	V005__timestamps.sql	604144080	taskflow	2025-07-06 12:26:46.503974	115	t
6	006	status update timestamp	SQL	V006__status_update_timestamp.sql	-2031233980	taskflow	2025-07-09 11:18:42.121462	31	t
7	007	task notes	SQL	V007__task_notes.sql	301720085	taskflow	2025-07-09 14:33:08.63213	37	t
8	008	task notes timestamps	SQL	V008__task_notes_timestamps.sql	-2104572540	taskflow	2025-07-09 18:15:18.76075	31	t
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: taskflow
--

COPY public.notes (id, task_id, user_id, note, created_at, updated_at) FROM stdin;
39	60	5	Does anyone have their on suggestions? It would be good to discuss.	2025-07-10 16:42:06.173877	2025-07-10 16:42:06.1739
40	60	10	You'd better ask Natalia, she might have relevant experience	2025-07-10 16:44:31.022808	2025-07-10 16:44:51.192661
41	60	7	That's true. Michael, I just mailed you some useful documents.	2025-07-10 16:46:31.295763	2025-07-10 16:46:31.295773
42	60	5	Thanks Natalia, I've just done with this.	2025-07-10 16:48:22.488503	2025-07-10 16:48:22.488525
44	40	6	I have some Idea about security rules, Just would like to ask Brian if the supervisor should have priveledges to purge archive data.	2025-07-10 16:53:11.105834	2025-07-10 16:53:11.10617
45	40	11	No way! Only me and Annecorinne as administrators should be able to do this.	2025-07-10 16:56:23.416476	2025-07-10 16:56:23.416506
46	40	9	Yes, I confirm	2025-07-10 16:57:33.076712	2025-07-10 16:57:33.076726
47	40	6	Thank you guys, totally agree. Probably will finish with it tomorrow.	2025-07-10 16:58:50.382934	2025-07-10 16:58:50.382947
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: taskflow
--

COPY public.projects (id, name, description, owner_id, created_at, updated_at) FROM stdin;
30	Admin Dashboard	System dashboard for admin monitoring	5	2025-07-10 15:21:31.563483	2025-07-10 15:21:31.563508
31	Pinterest Analytics Tool	Tooling to analyze pin engagement and user behavior	6	2025-07-10 15:56:44.947517	2025-07-10 15:56:44.947588
32	Ad Campaign Manager	Platform to manage Pinterest ad campaigns	6	2025-07-10 15:57:23.045974	2025-07-10 15:57:23.04606
33	Economist Subscriber Insights	Tools to analyze subscriber behavior and retention metrics	7	2025-07-10 16:14:08.174352	2025-07-10 16:14:08.17437
34	Paywall Optimization	System to test and deploy paywall variations	7	2025-07-10 16:14:44.665923	2025-07-10 16:14:44.665954
35	DOT Infrastructure Tracker	Platform to track progress on national infrastructure projects	8	2025-07-10 16:19:39.53096	2025-07-10 16:19:39.530974
36	Transportation Safety Dashboard	Dashboard visualizing national transportation safety data	8	2025-07-10 16:20:21.95236	2025-07-10 16:20:21.952372
37	Email Campaign Manager	Tool to create, schedule, and track email marketing campaigns	9	2025-07-10 16:30:13.721345	2025-07-10 16:30:13.721357
38	Subscriber Analytics	Platform to analyze subscriber engagement and list growth	9	2025-07-10 16:30:30.836167	2025-07-10 16:30:30.83618
39	Search Relevance Tuning	System to experiment with search ranking algorithms and signals	10	2025-07-10 16:34:17.669441	2025-07-10 16:34:17.669468
40	BigQuery Cost Optimizer	Tool to analyze and reduce BigQuery query costs	10	2025-07-10 16:34:41.306124	2025-07-10 16:34:41.306135
41	Community Moderation Tools	Tools to help moderators manage subreddit content and enforce rules	11	2025-07-10 16:38:05.704929	2025-07-10 16:38:05.704955
42	Content Recommendation Engine	System to recommend posts to users based on interests and engagement	11	2025-07-10 16:38:26.093298	2025-07-10 16:38:26.093309
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: taskflow
--

COPY public.tasks (id, name, description, project_id, status, assignee_id, created_at, updated_at, status_updated_at) FROM stdin;
51	Build data ingestion pipeline	Ingest accident reports and safety metrics	36	TODO	8	2025-07-10 16:22:02.170959	2025-07-10 16:22:02.170994	2025-07-10 16:22:02.166705
52	Create dashboard UI	Implement visualizations for safety trends	36	TODO	10	2025-07-10 16:22:58.182735	2025-07-10 16:22:58.182785	2025-07-10 16:22:58.173883
53	Design template editor UI	Create an interface for users to build email templates	37	TODO	9	2025-07-10 16:30:57.220033	2025-07-10 16:30:57.220039	2025-07-10 16:30:57.216271
54	Implement scheduling engine	Allow scheduling of email campaigns to different time zones	37	TODO	10	2025-07-10 16:31:36.586303	2025-07-10 16:31:36.58631	2025-07-10 16:31:36.582957
55	Integrate email open tracking	Record opens and clicks for reporting	38	TODO	9	2025-07-10 16:32:02.82196	2025-07-10 16:32:02.821968	2025-07-10 16:32:02.818063
39	Design dashboard UI	Initial UI layout for admin dashboard	30	TODO	5	2025-07-10 15:26:13.895397	2025-07-10 15:26:13.895422	2025-07-10 15:26:13.888718
40	Setup security rules	Define RBAC for admin endpoints	30	IN_PROGRESS	6	2025-07-10 15:26:55.567312	2025-07-10 15:55:14.622623	2025-07-10 15:55:14.619226
41	Design database schema	Plan tables for analytics events and aggregations	31	TODO	6	2025-07-10 16:05:21.942806	2025-07-10 16:05:21.94284	2025-07-10 16:05:21.93252
42	Implement event ingestion	Code service to ingest pin events	31	TODO	7	2025-07-10 16:06:08.942262	2025-07-10 16:06:08.942275	2025-07-10 16:06:08.938511
43	Create campaign UI	Develop React components for creating ad campaigns	32	TODO	6	2025-07-10 16:06:47.496176	2025-07-10 16:06:47.496186	2025-07-10 16:06:47.492632
44	Integrate billing API	Connect to billing system for campaign costs	32	TODO	8	2025-07-10 16:08:26.944288	2025-07-10 16:08:26.944301	2025-07-10 16:08:26.938758
45	Design event tracking model	Design how user interactions will be tracked	33	TODO	7	2025-07-10 16:15:43.165261	2025-07-10 16:15:43.165281	2025-07-10 16:15:43.158817
46	Implement reporting dashboard	Build dashboards showing subscriber activity	33	TODO	8	2025-07-10 16:16:32.154497	2025-07-10 16:16:32.154521	2025-07-10 16:16:32.151333
47	Develop A/B testing engine	Build the engine to split traffic for experiments	34	TODO	7	2025-07-10 16:17:13.44407	2025-07-10 16:17:13.444084	2025-07-10 16:17:13.440172
48	Integrate experiment results into analytics	Feed experiment outcomes into BI tools	34	TODO	9	2025-07-10 16:17:45.27711	2025-07-10 16:17:45.277136	2025-07-10 16:17:45.273267
49	Design database schema	Create tables for tracking projects, budgets, and timelines	35	TODO	8	2025-07-10 16:20:51.212667	2025-07-10 16:20:51.212712	2025-07-10 16:20:51.208755
50	Develop REST API	Expose endpoints for infrastructure project data	35	TODO	9	2025-07-10 16:21:15.858712	2025-07-10 16:21:15.858735	2025-07-10 16:21:15.853608
56	Build analytics dashboard	Visualize subscriber trends and engagement metrics	38	TODO	11	2025-07-10 16:33:02.218773	2025-07-10 16:33:02.218796	2025-07-10 16:33:02.214858
57	Design ranking experiment framework	Create framework for A/B testing ranking models	39	TODO	10	2025-07-10 16:35:04.358536	2025-07-10 16:35:04.358548	2025-07-10 16:35:04.352552
59	Analyze costly queries	Build analysis to detect expensive queries	40	TODO	10	2025-07-10 16:35:41.071929	2025-07-10 16:35:41.071961	2025-07-10 16:35:41.068284
58	Implement feature logging	Log search features used during queries	39	TODO	11	2025-07-10 16:35:20.030289	2025-07-10 16:36:20.710784	2025-07-10 16:35:20.027126
61	Build report handling UI	Create UI for moderators to review user reports	41	TODO	11	2025-07-10 16:38:57.866822	2025-07-10 16:38:57.866831	2025-07-10 16:38:57.863997
62	Implement rule engine	Develop logic for auto-flagging rule violations	41	TODO	5	2025-07-10 16:39:18.1085	2025-07-10 16:39:18.108522	2025-07-10 16:39:18.104862
63	Design recommendation model	Plan machine learning model for ranking posts	42	TODO	11	2025-07-10 16:39:41.650826	2025-07-10 16:39:41.650836	2025-07-10 16:39:41.647067
64	Develop tracking pipeline	Capture user engagement signals for recommendations	42	TODO	6	2025-07-10 16:40:04.294163	2025-07-10 16:40:04.294176	2025-07-10 16:40:04.286
60	Suggest cost-saving rewrites	Recommend query rewrites to reduce cost	40	DONE	5	2025-07-10 16:36:09.648302	2025-07-10 16:47:25.007886	2025-07-10 16:47:25.00424
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: taskflow
--

COPY public.users (id, keycloak_id, username, email, created_at, updated_at) FROM stdin;
5	bb5fee16-2732-4a59-972c-a6db9bd0005a	Michael Tikhonenko	ardolynk75@gmail.com	2025-07-06 12:26:46.655452	2025-07-06 12:26:46.655452
6	545412bd-c075-48a6-b1a2-221e1a576990	Charley Shurrocks	cshurrocks0@pinterest.com	2025-07-06 12:26:46.655452	2025-07-06 12:26:46.655452
7	d5bf4bbd-1678-42cf-85d8-24e4f696ffe8	Natalya Chang	nchang0@sciencedirect.com	2025-07-06 12:26:46.655452	2025-07-06 12:26:46.655452
8	fd537df7-7ca2-4c23-ae85-b8d56c7207cc	Jolee Josowitz	jjosowitz1@cpanel.net	2025-07-06 12:26:46.655452	2025-07-06 12:26:46.655452
9	29f526c0-4c2b-4570-90c7-149c4ac7a3cc	Annecorinne Ricardot	aricardot2@example.com	2025-07-06 12:26:46.655452	2025-07-06 12:26:46.655452
10	88e98426-0be2-4f5e-8e59-7d116a549c4e	Mikkel Scarce	mscarce3@china.com.cn	2025-07-06 12:26:46.655452	2025-07-06 12:26:46.655452
11	931c34a1-6202-4229-8b0c-9a819063d259	Brian Raper	braper4@1688.com	2025-07-06 12:26:46.655452	2025-07-06 12:26:46.655452
\.


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taskflow
--

SELECT pg_catalog.setval('public.notes_id_seq', 47, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taskflow
--

SELECT pg_catalog.setval('public.projects_id_seq', 42, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taskflow
--

SELECT pg_catalog.setval('public.tasks_id_seq', 64, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taskflow
--

SELECT pg_catalog.setval('public.users_id_seq', 11, true);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users users_keycloak_id_key; Type: CONSTRAINT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_keycloak_id_key UNIQUE (keycloak_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: taskflow
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: idx_notes_created_at; Type: INDEX; Schema: public; Owner: taskflow
--

CREATE INDEX idx_notes_created_at ON public.users USING btree (created_at);


--
-- Name: idx_notes_updated_at; Type: INDEX; Schema: public; Owner: taskflow
--

CREATE INDEX idx_notes_updated_at ON public.users USING btree (updated_at);


--
-- Name: idx_projects_created_at; Type: INDEX; Schema: public; Owner: taskflow
--

CREATE INDEX idx_projects_created_at ON public.projects USING btree (created_at);


--
-- Name: idx_projects_updated_at; Type: INDEX; Schema: public; Owner: taskflow
--

CREATE INDEX idx_projects_updated_at ON public.projects USING btree (updated_at);


--
-- Name: idx_tasks_created_at; Type: INDEX; Schema: public; Owner: taskflow
--

CREATE INDEX idx_tasks_created_at ON public.tasks USING btree (created_at);


--
-- Name: idx_tasks_status_updated_at; Type: INDEX; Schema: public; Owner: taskflow
--

CREATE INDEX idx_tasks_status_updated_at ON public.tasks USING btree (status_updated_at);


--
-- Name: idx_tasks_updated_at; Type: INDEX; Schema: public; Owner: taskflow
--

CREATE INDEX idx_tasks_updated_at ON public.tasks USING btree (updated_at);


--
-- Name: idx_users_created_at; Type: INDEX; Schema: public; Owner: taskflow
--

CREATE INDEX idx_users_created_at ON public.users USING btree (created_at);


--
-- Name: idx_users_updated_at; Type: INDEX; Schema: public; Owner: taskflow
--

CREATE INDEX idx_users_updated_at ON public.users USING btree (updated_at);


--
-- Name: notes notes_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: notes notes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: projects projects_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.users(id);


--
-- Name: tasks tasks_assignee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_assignee_id_fkey FOREIGN KEY (assignee_id) REFERENCES public.users(id);


--
-- Name: tasks tasks_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: taskflow
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- PostgreSQL database dump complete
--

