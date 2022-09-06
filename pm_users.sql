--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Debian 12.5-1.pgdg100+1)
-- Dumped by pg_dump version 12.5 (Debian 12.5-1.pgdg100+1)

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
-- Name: active_clients; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.active_clients (
    id bigint NOT NULL,
    user_id bigint,
    company_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.active_clients OWNER TO postgres;

--
-- Name: active_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.active_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_clients_id_seq OWNER TO postgres;

--
-- Name: active_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.active_clients_id_seq OWNED BY public.active_clients.id;


--
-- Name: assist_contracts; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.assist_contracts (
    id bigint NOT NULL,
    title character varying(255),
    date_start date,
    date_end date,
    company_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.assist_contracts OWNER TO postgres;

--
-- Name: assist_contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.assist_contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assist_contracts_id_seq OWNER TO postgres;

--
-- Name: assist_contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.assist_contracts_id_seq OWNED BY public.assist_contracts.id;


--
-- Name: rights; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.rights (
    id bigint NOT NULL,
    title character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.rights OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(255),
    profile_picture character varying(255),
    email character varying(255),
    password character varying(255),
    right_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: auth; Type: VIEW; Schema: public; Owner: odoo
--

CREATE VIEW public.auth AS
 SELECT users.id,
    users.username,
    users.profile_picture,
    users.email,
    users.right_id,
    rights.title
   FROM (public.users
     JOIN public.rights ON ((users.right_id = rights.id)));


ALTER TABLE public.auth OWNER TO postgres;

--
-- Name: base_cache_signaling; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_cache_signaling
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_cache_signaling OWNER TO postgres;

--
-- Name: base_registry_signaling; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_registry_signaling
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_registry_signaling OWNER TO postgres;

--
-- Name: boards; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.boards (
    id bigint NOT NULL,
    name character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.boards OWNER TO postgres;

--
-- Name: boards_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.boards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.boards_id_seq OWNER TO postgres;

--
-- Name: boards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.boards_id_seq OWNED BY public.boards.id;


--
-- Name: cards; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.cards (
    id bigint NOT NULL,
    name character varying(255),
    stage_id bigint NOT NULL,
    "position" integer NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    task_id bigint
);


ALTER TABLE public.cards OWNER TO postgres;

--
-- Name: cards_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cards_id_seq OWNER TO postgres;

--
-- Name: cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.cards_id_seq OWNED BY public.cards.id;


--
-- Name: clients_requests; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.clients_requests (
    id bigint NOT NULL,
    content character varying(255),
    date_post timestamp(0) without time zone,
    active_client_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    title character varying(255),
    seen boolean,
    ongoing boolean,
    done boolean,
    file_urls character varying(255)[] DEFAULT ARRAY[]::character varying[] NOT NULL
);


ALTER TABLE public.clients_requests OWNER TO postgres;

--
-- Name: clients_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.clients_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clients_requests_id_seq OWNER TO postgres;

--
-- Name: clients_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.clients_requests_id_seq OWNED BY public.clients_requests.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    content character varying(255),
    task_id bigint,
    poster_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    file_urls character varying(255)[] DEFAULT ARRAY[]::character varying[] NOT NULL
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.companies (
    id bigint NOT NULL,
    name character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    logo character varying(255)
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_id_seq OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: editors; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.editors (
    id bigint NOT NULL,
    title character varying(255),
    company_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.editors OWNER TO postgres;

--
-- Name: editors_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.editors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.editors_id_seq OWNER TO postgres;

--
-- Name: editors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.editors_id_seq OWNED BY public.editors.id;


--
-- Name: licenses; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.licenses (
    id bigint NOT NULL,
    title character varying(255),
    date_start date,
    date_end date,
    company_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.licenses OWNER TO postgres;

--
-- Name: licenses_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.licenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.licenses_id_seq OWNER TO postgres;

--
-- Name: licenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.licenses_id_seq OWNED BY public.licenses.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    content character varying(255),
    seen boolean DEFAULT false NOT NULL,
    sender_id bigint,
    receiver_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: planified; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.planified (
    id bigint NOT NULL,
    description character varying(255),
    dt_start timestamp(0) without time zone,
    period integer,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    attributor_id integer,
    contributor_id integer,
    project_id integer,
    estimated_duration integer,
    without_control boolean DEFAULT false
);


ALTER TABLE public.planified OWNER TO postgres;

--
-- Name: planified_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.planified_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planified_id_seq OWNER TO postgres;

--
-- Name: planified_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.planified_id_seq OWNED BY public.planified.id;


--
-- Name: priorities; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.priorities (
    id bigint NOT NULL,
    title character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.priorities OWNER TO postgres;

--
-- Name: priorities_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.priorities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.priorities_id_seq OWNER TO postgres;

--
-- Name: priorities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.priorities_id_seq OWNED BY public.priorities.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.projects (
    id bigint NOT NULL,
    title character varying(255),
    description character varying(255),
    progression integer,
    date_start date,
    date_end date,
    estimated_duration integer,
    performed_duration integer,
    deadline date,
    active_client_id bigint,
    status_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    board_id bigint
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: rights_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.rights_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rights_id_seq OWNER TO postgres;

--
-- Name: rights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.rights_id_seq OWNED BY public.rights.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: softwares; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.softwares (
    id bigint NOT NULL,
    title character varying(255),
    company_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.softwares OWNER TO postgres;

--
-- Name: softwares_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.softwares_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.softwares_id_seq OWNER TO postgres;

--
-- Name: softwares_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.softwares_id_seq OWNED BY public.softwares.id;


--
-- Name: stages; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.stages (
    id bigint NOT NULL,
    name character varying(255),
    board_id bigint NOT NULL,
    status_id bigint,
    "position" integer NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.stages OWNER TO postgres;

--
-- Name: stages_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.stages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stages_id_seq OWNER TO postgres;

--
-- Name: stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.stages_id_seq OWNED BY public.stages.id;


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.statuses (
    id bigint NOT NULL,
    title character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.statuses OWNER TO postgres;

--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.statuses_id_seq OWNER TO postgres;

--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.statuses_id_seq OWNED BY public.statuses.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    title character varying(255),
    progression integer,
    date_start date,
    date_end date,
    estimated_duration integer,
    performed_duration integer,
    deadline date,
    parent_id bigint,
    project_id bigint,
    contributor_id bigint,
    status_id bigint,
    priority_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    attributor_id bigint,
    achieved_at timestamp(0) without time zone,
    hidden boolean DEFAULT false,
    without_control boolean DEFAULT false
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_id_seq OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: active_clients id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.active_clients ALTER COLUMN id SET DEFAULT nextval('public.active_clients_id_seq'::regclass);


--
-- Name: assist_contracts id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.assist_contracts ALTER COLUMN id SET DEFAULT nextval('public.assist_contracts_id_seq'::regclass);


--
-- Name: boards id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.boards ALTER COLUMN id SET DEFAULT nextval('public.boards_id_seq'::regclass);


--
-- Name: cards id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.cards ALTER COLUMN id SET DEFAULT nextval('public.cards_id_seq'::regclass);


--
-- Name: clients_requests id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.clients_requests ALTER COLUMN id SET DEFAULT nextval('public.clients_requests_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: editors id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.editors ALTER COLUMN id SET DEFAULT nextval('public.editors_id_seq'::regclass);


--
-- Name: licenses id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.licenses ALTER COLUMN id SET DEFAULT nextval('public.licenses_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: planified id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.planified ALTER COLUMN id SET DEFAULT nextval('public.planified_id_seq'::regclass);


--
-- Name: priorities id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.priorities ALTER COLUMN id SET DEFAULT nextval('public.priorities_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: rights id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.rights ALTER COLUMN id SET DEFAULT nextval('public.rights_id_seq'::regclass);


--
-- Name: softwares id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.softwares ALTER COLUMN id SET DEFAULT nextval('public.softwares_id_seq'::regclass);


--
-- Name: stages id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.stages ALTER COLUMN id SET DEFAULT nextval('public.stages_id_seq'::regclass);


--
-- Name: statuses id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.statuses ALTER COLUMN id SET DEFAULT nextval('public.statuses_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: active_clients; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.active_clients (id, user_id, company_id, inserted_at, updated_at) FROM stdin;
1	33	1	2021-04-27 20:13:41	2021-04-27 20:13:41
9	63	1	2021-08-24 14:15:16	2021-08-24 14:15:16
10	64	1	2021-08-24 14:26:14	2021-08-24 14:26:14
11	65	1	2021-08-24 14:34:55	2021-08-24 14:34:55
12	66	1	2021-08-24 14:37:57	2021-08-24 14:37:57
13	67	2	2021-08-24 14:41:14	2021-08-24 14:41:14
14	68	1	2021-08-27 07:01:04	2021-08-27 07:01:04
15	58	1	2022-01-28 13:46:59	2022-01-28 13:46:59
16	69	1	2022-01-28 17:45:54	2022-01-28 17:45:54
17	83	2	2022-02-03 07:19:04	2022-02-03 07:19:04
18	84	1	2022-02-08 14:10:28	2022-02-08 14:10:28
19	87	1	2022-02-14 22:55:15	2022-02-14 22:55:15
20	88	1	2022-02-24 07:13:03	2022-02-24 07:13:03
21	89	1	2022-02-24 07:30:15	2022-02-24 07:30:15
22	90	1	2022-02-28 09:51:30	2022-02-28 09:51:30
23	93	1	2022-03-01 09:05:44	2022-03-01 09:05:44
\.


--
-- Data for Name: assist_contracts; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.assist_contracts (id, title, date_start, date_end, company_id, inserted_at, updated_at) FROM stdin;
1	CONT/SOC/001	2021-06-09	2021-06-12	1	2021-06-01 22:03:42	2021-06-01 22:03:42
\.


--
-- Data for Name: boards; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.boards (id, name, inserted_at, updated_at) FROM stdin;
35	SIGM - Application inter Amadeus et Odoo	2022-02-03 07:47:06	2022-02-03 07:47:06
36	Site web QLM	2022-02-03 09:43:17	2022-02-03 09:43:17
37	Site web QLM	2022-02-03 09:43:30	2022-02-03 09:43:30
38	Sauvegarde FTP des clients 	2022-02-03 09:49:57	2022-02-03 09:49:57
39	Sauvegarde FTP des clients 	2022-02-03 09:50:50	2022-02-03 09:50:50
40	Intervention / Accompagnement 2202	2022-02-04 12:08:55	2022-02-04 12:08:55
41	Intervention / Accompagnement 2022	2022-02-04 12:10:05	2022-02-04 12:10:05
42	Intervention / Accompagnement 2022	2022-02-04 12:12:42	2022-02-04 12:12:42
43	SIGM - Gestion  Agence de Voyage sur Odoo 15	2022-02-07 09:15:56	2022-02-07 09:15:56
44	Correction/Amélioration de l'application Project Monitoring MGBI	2022-02-08 13:09:38	2022-02-08 13:09:38
45	Correction/Amélioration de l'application Project Monitoring MGBI	2022-02-08 13:11:06	2022-02-08 13:11:06
46	Synchro du site Computek	2022-02-08 14:11:40	2022-02-08 14:11:40
47	COMPUTEK - Intervention / Accompagnement 2022	2022-02-14 11:31:40	2022-02-14 11:31:40
48	COMPUTEK - Intervention / Accompagnement 2022	2022-02-14 11:32:14	2022-02-14 11:32:14
49	M-TEC - Mise en place d'un nouveau dossier	2022-02-14 22:56:37	2022-02-14 22:56:37
50	EDR - Application Web Réappro	2022-02-24 07:13:56	2022-02-24 07:13:56
51	CDC - Intervention Site web	2022-02-24 07:30:39	2022-02-24 07:30:39
52	CDC - Intervention Site web	2022-02-24 07:31:14	2022-02-24 07:31:14
53	NAJMI - Mise en place	2022-02-28 09:52:54	2022-02-28 09:52:54
54	NAJMI - Mise en place	2022-02-28 09:53:10	2022-02-28 09:53:10
55	MADAPLAST - Intervention / Accompagnement 2022	2022-03-01 09:07:34	2022-03-01 09:07:34
\.


--
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.cards (id, name, stage_id, "position", inserted_at, updated_at, task_id) FROM stdin;
543	Ajustement de stock, demande de Mme Jeanne par Whatsapp	205	54	2022-03-17 14:58:07	2022-03-17 14:58:20	565
369	Renommer "Montant TVA" en "Montant TVA sur fees" dans le document travel order	209	12	2022-02-21 06:55:58	2022-02-21 09:31:27	391
283	Renommer "Sous-total" dans document facture en "Sous-total HT" et exclue tout taxe de sa valeur	207	5	2022-02-08 13:15:53	2022-02-10 09:16:41	305
299	Ajouter un label pour le champs autre infos dans travel order	209	8	2022-02-10 09:22:28	2022-02-10 09:22:38	321
446	Baser toutes les politiques de facturations sur les quantités commandées	206	41	2022-02-25 07:27:36	2022-02-25 07:27:36	468
229	Correspondance des articles et familles sur le site	178	3	2022-02-04 12:05:33	2022-02-04 12:05:42	234
228	Import photos des articles publié sur le site 	178	2	2022-02-04 12:03:00	2022-02-04 12:05:46	233
226	Programme de transfert des backup clients sur FTP	190	4	2022-02-04 08:22:24	2022-02-22 11:38:54	229
439	Déplacer la colonne fournisseur avant la colonne articles	208	4	2022-02-25 07:16:51	2022-02-25 07:17:18	461
510	Création Tableau pour les articles Bien	266	1	2022-03-07 06:27:10	2022-03-07 06:27:10	532
462	Adapter les fichiers de configurations Import/Export avec le nouveau sftp Incadea	208	1	2022-02-28 09:42:13	2022-02-28 12:39:03	484
227	Installation du nouveau programme sauvegarde sur les serveurs clients	190	0	2022-02-04 11:59:31	2022-02-22 11:39:23	232
422	Mise à jour Code-barre articles Pointes	205	29	2022-02-24 08:00:31	2022-02-24 08:01:05	444
455	Déblocage d'un problème de création d'un BL	235	17	2022-02-28 07:51:09	2022-02-28 07:51:24	477
415	Intégration de stock du PO26335 et PO26713	205	20	2022-02-22 11:37:35	2022-02-22 12:36:25	437
518	TEST2	236	0	2022-03-07 13:46:15	2022-03-07 13:46:27	540
372	Renommer "Remboursement partiel" en "Avoir partiel" dans document facture > ajouter un avoir	206	17	2022-02-21 06:58:23	2022-02-21 06:58:23	394
297	Mise en place des articles sans emplacement Odoo	205	6	2022-02-10 09:02:39	2022-02-10 19:03:45	319
364	Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable	205	3	2022-02-18 08:42:10	2022-02-22 11:18:42	386
411	Intégration de stock du PO24141 et PO26463	205	21	2022-02-22 10:50:32	2022-02-22 13:10:10	433
342	Création compte utilisateur EBP COMPTA, FRANK	234	11	2022-02-16 10:22:21	2022-02-16 10:22:27	364
344	Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro 	225	2	2022-02-17 06:56:59	2022-02-21 09:11:49	366
308	Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site	225	6	2022-02-14 09:18:12	2022-02-21 06:49:48	330
310	Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on	225	3	2022-02-14 09:20:37	2022-02-22 08:45:47	332
354	Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA	235	0	2022-02-17 07:05:09	2022-02-21 06:01:01	376
352	Paramétrage model d'impression	234	8	2022-02-17 07:03:30	2022-02-21 06:52:59	374
461	Ajustement de stock via Mme Jeanne (image whatsapp)	205	34	2022-02-28 08:50:35	2022-02-28 12:40:35	483
368	Rapprochement bancaire mai-juin BMOI Chainmalt	210	44	2022-02-21 06:07:07	2022-02-22 10:29:04	390
410	Rapprochement bancaire juiller-aôut BMOI Chainmalt	209	0	2022-02-22 10:30:16	2022-02-22 12:34:40	432
458	Liste des articles sans code barre	235	36	2022-02-28 07:54:11	2022-03-08 04:47:59	480
393	Préparation un fichier d'inventaire COMPUTEK	235	4	2022-02-21 09:21:15	2022-02-22 12:37:27	415
248	Numérotation facture 1er Avril 2021 - 31 Mars : exercice 2021, exercice cfao	206	2	2022-02-07 10:42:49	2022-02-07 10:42:49	270
315	Demander la liste de tous les clients Incadea à mettre en place sur le dossier de test	210	7	2022-02-14 13:18:07	2022-02-14 13:18:14	337
466	Mise à jour emplacement dépôt 2 du 23/02/2022	205	36	2022-02-28 13:33:44	2022-02-28 13:33:50	488
243	Amélioration de l'application	170	1	2022-02-07 08:53:36	2022-02-21 09:31:53	265
460	Finalisation de la requête Granit	206	0	2022-02-28 08:00:44	2022-02-28 08:00:53	482
222	Lecture des données XML	170	3	2022-02-03 07:47:56	2022-02-04 10:58:05	219
467	Ne pas afficher le champs "type de client" dans la fiche fournisseur	206	44	2022-03-01 06:56:48	2022-03-01 06:56:48	489
400	Correction des conflits entre la version WP all import et Wordpress	225	0	2022-02-22 07:42:10	2022-02-22 11:23:49	422
286	Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande	210	2	2022-02-08 13:24:47	2022-02-28 09:00:19	308
476	Définir la valeur de la colonne posting group dans l'export d'écriture comptable avec posting group des clients ou fournisseurs corrspondants	206	48	2022-03-01 09:14:19	2022-03-01 09:14:19	498
428	Listes des articles déjà bloqués	235	16	2022-02-24 12:51:34	2022-02-25 13:28:58	450
293	Pouvoir attribuer une tâche à un attributteur	216	4	2022-02-08 14:18:14	2022-02-08 14:18:14	315
291	•\tNombre de tâches dans Kanban view devrait être selon utilisateur connecté (ne voir que le nombre de tâches de l’utilisateur connecté)	216	2	2022-02-08 14:14:34	2022-02-08 14:14:34	313
341	Assistance pour les articles stock négatif	235	8	2022-02-16 08:28:53	2022-02-22 12:38:20	363
292	•\tAjouter un champ description dans une tâche	216	3	2022-02-08 14:15:34	2022-02-08 14:15:34	314
532	Mise en place Stock du PO26731 fichier INGCO 18H	205	53	2022-03-16 06:29:32	2022-03-16 06:29:40	554
472	Tâche 1	261	0	2022-03-01 09:03:49	2022-03-01 10:06:41	494
416	Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé	235	9	2022-02-23 05:50:20	2022-02-23 05:50:51	438
322	Création d'un champ "publier sur le web"  sur les catégories	180	2	2022-02-15 07:11:45	2022-02-21 09:30:27	344
484	Vérifier si modificaiton de rapport devis amadeus a impacté celui de to	206	49	2022-03-02 08:12:56	2022-03-02 08:12:56	506
382	Dans fiche facture > Ecriture comptable, mettre une ligne par billet	206	26	2022-02-21 07:06:48	2022-02-21 07:06:48	404
300	Cacher le bouton confirmer dans travel order si l'utilisateur n'a pas le droit de confirmer	209	13	2022-02-10 09:24:40	2022-02-18 13:19:27	322
508	Intégration inventaire RFI du 03/03/2022	205	47	2022-03-04 10:31:31	2022-03-04 11:32:08	530
511	Inventaire sur une période	266	2	2022-03-07 06:28:29	2022-03-07 06:28:29	533
514	Mise en place des procédures	261	2	2022-03-07 07:02:26	2022-03-07 07:02:26	536
544	Intégration stock dépôt 3, demande de Mme Jeanne (Chein/INT/03214)	205	55	2022-03-17 15:01:15	2022-03-17 15:01:24	566
278	module de notification odoo	178	0	2022-02-07 13:38:13	2022-02-23 08:33:12	300
519	Modification droit des utilisateurs, Seul ZOHAR et KOULSOUM peuvent supprimer un BL	235	31	2022-03-07 13:46:55	2022-03-07 13:47:14	541
520	Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil	235	37	2022-03-07 13:48:04	2022-03-08 05:05:26	542
447	Créer un champas pour la référence fournisseur dans doc facture et afficher sa valeur dans l'impression	207	4	2022-02-25 07:32:31	2022-02-27 15:42:35	469
306	Extraction Image EBP	190	1	2022-02-14 09:16:47	2022-02-28 10:23:13	328
388	Automatiser la création d'un avoir fournisseur lors de la création d'un avoir client ou vice versa	206	32	2022-02-21 07:12:16	2022-02-21 07:12:16	410
389	Ajouter la compagnie/fournisseur dans l'avoir client	206	33	2022-02-21 07:13:03	2022-02-21 07:13:03	411
440	Filtrer les articles selon le fournisseur selectionné	206	38	2022-02-25 07:19:56	2022-02-25 07:19:56	462
445	Relier la colonne référence fournisseur avec le champ référence fournisseur dans doc achat	210	51	2022-02-25 07:25:48	2022-02-27 15:45:16	467
453	Enlever le champs numéro de dossier et considérer le numéro de document à sa place	210	54	2022-02-27 15:46:59	2022-02-27 15:50:20	475
436	Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci	210	48	2022-02-25 07:13:42	2022-02-25 09:19:01	458
491	Droit d'utilisateur	235	24	2022-03-02 11:20:30	2022-03-02 11:21:39	513
289	•\tPouvoir mettre une virgule dans Tâche > Durée estimée	216	0	2022-02-08 14:07:42	2022-03-14 12:00:12	311
423	Mise en place E-mail "cheinmaltcompta2@groupe-qlm.com"	205	30	2022-02-24 08:50:40	2022-02-24 08:50:55	445
418	Intégration inventaire Showroom Cheinmalt	205	28	2022-02-23 14:38:33	2022-02-23 14:38:46	440
465	Créer un champs dans res.partner pour y stocker GenBusPostingGroup_G	206	43	2022-02-28 12:51:25	2022-02-28 12:51:25	487
464	Mise à jour emplacement Dépôt 2 du 25/02/2022	205	35	2022-02-28 12:39:27	2022-02-28 13:19:54	486
376	Mettre le montant en lettre dans l'impression de facture	210	46	2022-02-21 07:01:40	2022-02-24 10:34:54	398
316	Demander l'accès au serveur sftp à Mr Andy	210	4	2022-02-14 13:18:42	2022-02-14 13:18:48	338
271	Ajouter les champs active product et active supplier pour filtrer les articles et les fournisseurs	210	28	2022-02-07 13:02:41	2022-02-08 09:24:33	293
261	Copie de certains champs lors d'une duplication de document travel order	210	27	2022-02-07 12:50:50	2022-02-08 14:28:18	283
262	Ajouter le numéro pnr dans la commande (nouveau champs)	210	14	2022-02-07 12:52:06	2022-02-08 14:28:28	284
263	Mettre une bande duplicata après une première impression de la facture	210	13	2022-02-07 12:53:26	2022-02-08 14:31:25	285
265	Ajouter un bouton d'impression de la facture et enlever le menu d'impression	210	30	2022-02-07 12:54:50	2022-02-08 14:31:25	287
266	Ajouter un champs pour savoir si la facture a déjà été imprimée ou pas	210	31	2022-02-07 12:55:40	2022-02-08 14:31:25	288
260	Ajouter un champs autre info dans travel order	210	9	2022-02-07 12:49:59	2022-02-10 07:06:00	282
314	Envoyer le fichier export de l’écriture comptable sous format LOCPRO à Mr Andy pour un test d’import sur Incadea 	210	8	2022-02-14 13:17:28	2022-02-14 13:17:38	336
236	Validation BL	205	9	2022-02-04 12:45:25	2022-02-04 12:45:57	242
348	Afficher TVA en bas de la fiche commande même si c'est à 0	210	34	2022-02-17 07:01:11	2022-02-18 13:24:40	370
232	Salaire QLM, Codigaz, Codimat janvier 2022	205	14	2022-02-04 12:17:55	2022-02-04 12:39:23	237
365	Création STC de deux salariés	205	25	2022-02-18 09:24:00	2022-02-22 13:11:45	387
473	Tâche 1	266	0	2022-03-01 09:08:00	2022-03-01 09:08:00	495
398	Ajustement des stocks de hhs6301	205	26	2022-02-21 14:23:34	2022-02-22 13:11:59	420
240	Impression 40 factures - ENAC	205	19	2022-02-04 12:50:51	2022-02-04 12:51:00	246
335	Extraction Image EBP	225	10	2022-02-16 07:08:56	2022-02-21 06:49:26	357
305	Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site	225	7	2022-02-14 09:15:47	2022-02-21 06:50:17	327
304	Mise en place du site et intégration de 'wp all import'	225	4	2022-02-11 12:57:37	2022-02-21 09:15:45	326
392	Adaptation/Vérification du programme Import Devis sur EBP	225	1	2022-02-21 09:21:02	2022-02-28 10:28:31	414
477	Ajustement de stock pour validation BL CHM/BL/21311	205	38	2022-03-01 09:15:06	2022-03-01 09:15:14	499
237	Notification mail d'une commande passée sur le site	180	9	2022-02-04 12:47:10	2022-02-04 12:47:17	243
238	Création banner d'accueil sur le site	180	6	2022-02-04 12:49:51	2022-02-04 12:49:53	244
245	Description technique des familles 	180	5	2022-02-07 09:12:21	2022-02-15 07:19:11	267
408	Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina	235	19	2022-02-22 09:41:36	2022-02-28 12:38:43	430
482	Bébloquage d'utilisateur dans CRM	235	21	2022-03-01 13:44:28	2022-03-01 13:45:25	504
468	Gestion de paie mois de février 2022 - Cheinmalt	205	40	2022-03-01 07:11:15	2022-03-02 08:23:31	490
381	Dans fiche facture > Ecriture comptable, les libellés doivent avoir la même valeur sur toutes les lignes	206	25	2022-02-21 07:06:17	2022-02-21 07:06:17	403
509	Validation BL CHM/BL/16176, CHM/BL/15175, CHM/BL/21054, CHM/BL/21065	205	48	2022-03-04 14:08:40	2022-03-04 14:09:09	531
512	Création champ perso pour OF d'origine	266	3	2022-03-07 06:31:08	2022-03-07 06:31:08	534
449	Relier Travel Order et Account Move par des ids	206	42	2022-02-25 09:24:20	2022-02-25 09:24:20	471
268	Définir le libellé des lignes 401 fournisseurs et 411 clients de l'écriture comptables (valeur: libellé global de la commande)	207	2	2022-02-07 12:58:27	2022-02-09 10:03:25	290
424	Déblocage d'un problème de connexion à la base	235	10	2022-02-24 12:42:50	2022-02-24 12:43:19	446
430	Déblocage d'un problème de création d'un BL	235	12	2022-02-24 12:53:05	2022-02-24 12:53:33	452
285	Ajouter une référence du document achat dans le document de commande	209	6	2022-02-08 13:23:48	2022-02-10 09:16:55	307
489	Bébloquage utilisateur dans CRM	235	22	2022-03-02 11:18:07	2022-03-02 11:18:25	511
521	Contre-inventaire Computek TANA, 	235	32	2022-03-07 13:49:10	2022-03-07 13:49:42	543
526	STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)	205	51	2022-03-08 10:16:30	2022-03-08 13:33:57	548
441	Renommer "Quantité" en "Nombre de chambres/personnes"	207	3	2022-02-25 07:20:53	2022-02-27 15:20:02	463
267	Changement de libellé: Usager => Passager, Partenaire => Client	210	0	2022-02-07 12:56:38	2022-02-08 14:32:35	289
429	Paramétrage sur les fiches Clients	235	35	2022-02-24 12:52:21	2022-03-08 04:43:39	451
328	IMPRESSION DES TICKETS DE CAISSE A MOB+	232	0	2022-02-15 07:42:10	2022-02-15 07:42:48	350
522	Modification droit de validation Inventaire	235	38	2022-03-07 13:50:36	2022-03-08 13:41:38	544
478	Ajouter un champs gen_bus_pg dans res.partner	210	61	2022-03-01 09:47:20	2022-03-01 09:59:24	500
223	Rédirection port 80 vers 8069 sur 54 	180	7	2022-02-03 09:44:54	2022-02-04 12:00:48	221
239	Amélioration du design de l'interface d'accueil 	180	4	2022-02-04 12:50:34	2022-02-04 12:50:37	245
224	Description des familles publié sur le site	180	8	2022-02-03 09:48:08	2022-02-04 12:00:59	222
356	droit d'autorisation pour SABIR	235	1	2022-02-17 07:06:24	2022-02-21 06:01:09	378
340	Création nouvel utilisateur Odoo	205	23	2022-02-16 08:19:35	2022-02-22 13:11:04	362
370	Renommer "TVA" en "TVA sur fees" dans la facture	210	40	2022-02-21 06:56:36	2022-02-21 11:55:21	392
444	Ajouter une colonne pour la référence facture fournisseur à côté de la colonne fournisseur	210	52	2022-02-25 07:24:32	2022-02-27 15:45:26	466
367	Enlever les boutons créer une facture, envoyer la commande par courriel, annuler, bloquer dans le document d'achat	210	38	2022-02-18 14:23:35	2022-02-18 14:23:42	389
272	Ajouter numéro de dossier dans la commande	210	23	2022-02-07 13:05:03	2022-02-08 09:24:22	294
276	Type du chams libellé global: Char => Text	210	26	2022-02-07 13:09:21	2022-02-08 09:23:37	298
270	Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné	210	22	2022-02-07 13:01:28	2022-02-08 09:24:33	292
409	Intégration de stock du PO26496 dépôt 3	205	27	2022-02-22 09:49:42	2022-02-22 13:12:09	431
339	Création champ description technique des articles	205	4	2022-02-16 08:07:34	2022-02-21 11:52:26	361
241	Paramétrage paie - création structure solde de congé, min irsa sur 3000	205	17	2022-02-04 12:53:30	2022-02-04 12:53:49	247
282	Photos INGCO	205	12	2022-02-08 10:42:12	2022-02-10 19:02:14	304
296	Intégration stock P025886	205	11	2022-02-09 12:33:06	2022-02-10 19:03:16	318
294	Mise à jours totes les photos INGCO	205	10	2022-02-09 09:04:07	2022-02-10 19:03:27	316
330	Modification de la catégories d'articles 	205	8	2022-02-15 10:07:05	2022-02-15 10:07:14	352
332	Récupération de la tva sur Odoo de l'article pour le site	205	7	2022-02-15 10:54:22	2022-02-21 09:41:53	354
433	Intégration d'inventaire pour Computek Tamatave	235	13	2022-02-25 06:05:24	2022-02-25 12:30:31	455
244	Modification de la page d'accueil	180	3	2022-02-07 09:12:20	2022-02-15 07:19:13	266
327	Restriction sur la modifcation des catégories	205	5	2022-02-15 07:41:21	2022-02-21 10:15:17	349
399	Tester un module pour mettre les avances sur Odoo 	205	2	2022-02-21 14:26:18	2022-02-28 10:26:09	421
485	Gestion de paie fév 2022 - QLM/Codigaz/Codimat	205	45	2022-03-02 08:24:12	2022-03-03 10:16:53	507
334	Droit des utilisateurS COMPUTEK TANA	234	9	2022-02-15 11:17:34	2022-02-21 06:54:02	356
413	Correction erreurs sur le module Fabrication	205	0	2022-02-22 11:19:33	2022-02-28 10:28:00	435
290	Restauration du site sur le serveur de test	225	9	2022-02-08 14:12:35	2022-02-14 09:18:44	312
336	Transfert Image To FTP	225	8	2022-02-16 07:09:37	2022-02-21 06:49:30	358
307	Intégration des requêtes et adaptation des programmes synchro	225	5	2022-02-14 09:17:21	2022-02-21 06:50:39	329
497	Insertion d'ARTICLE qui ne sont pas dans la nouvelle base	235	27	2022-03-03 06:20:49	2022-03-03 12:39:26	519
312	Mise à jour tarifs	234	0	2022-02-14 11:35:50	2022-03-09 12:13:22	334
281	Gestion des threads	170	4	2022-02-08 10:05:08	2022-02-21 09:31:53	303
303	Mise à jour export vers Odoo	170	2	2022-02-11 07:43:24	2022-02-21 09:32:00	325
338	Envoi des anomalies d'enregistrement des PNRs sur email	170	0	2022-02-16 07:32:30	2022-02-21 09:33:20	360
288	L'application se récharge automatiquement après quelque moment	216	1	2022-02-08 13:44:53	2022-02-08 13:44:53	310
504	Creation d'un Bon de sortie pour régulariser un AVOIR	235	29	2022-03-04 06:34:38	2022-03-04 10:14:49	526
384	Dans impression facture, mettre les fournisseurs au niveau de la ligne	210	58	2022-02-21 07:08:43	2022-02-28 09:43:06	406
420	Installation des paquets 	244	0	2022-02-24 07:15:16	2022-03-01 20:29:32	442
301	Intégration inventaire QLM	202	0	2022-02-11 07:15:01	2022-02-25 13:19:13	323
425	Intégration d'inventaire pour MOB+	235	11	2022-02-24 12:44:43	2022-02-24 12:44:48	447
385	Dans la fiche facture > Ajouter un avoir, l'option date d'extourne doit être la date du jour et non la date de la pièce comptable	206	29	2022-02-21 07:10:24	2022-02-21 07:10:24	407
386	Dans la fiche facture > Ajouter un avoir, le motif doit être obligatoire	206	30	2022-02-21 07:10:57	2022-02-21 07:10:57	408
527	Ajustement de stock pour validation BL demande de Mme Jeanne	205	50	2022-03-08 13:33:44	2022-03-08 13:33:49	549
513	Gestion des emplacements 	261	1	2022-03-07 07:01:12	2022-03-07 07:01:12	535
437	Synchronisation des clients odoo avec ceux dans Incadea	206	37	2022-02-25 07:15:13	2022-02-25 07:15:13	459
379	Dans la fiche facture, masquer le bouton "Remettre en brouillon"	210	43	2022-02-21 07:04:41	2022-02-21 14:26:11	401
405	Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement.	235	2	2022-02-22 09:35:06	2022-02-22 12:37:15	427
350	Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT	235	7	2022-02-17 07:02:29	2022-02-22 12:38:01	372
498	Béblocage des utilisateurs bloqué du CRM	235	26	2022-03-03 06:21:51	2022-03-03 12:14:08	520
249	Ajout de colonne comptes auxiliaires dans les écritures comptables	210	20	2022-02-07 10:47:37	2022-02-08 12:07:25	271
345	Rendre le champs Numéro PNR dans le document de commande obligatoire	210	32	2022-02-17 06:58:35	2022-02-18 13:19:56	367
353	Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous	210	3	2022-02-17 07:04:15	2022-02-28 08:38:07	375
486	Validation BL Cheinmalt CHM/BL/21868, CHM/BL/21828, CHM/BL/20587	205	41	2022-03-02 08:25:21	2022-03-02 08:25:27	508
359	Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet)	209	10	2022-02-17 07:09:34	2022-02-21 09:23:37	381
287	Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit	209	14	2022-02-08 13:29:51	2022-02-18 13:04:18	309
470	Ajouter un champs posting group dans res.partner	210	59	2022-03-01 08:34:18	2022-03-01 09:12:46	492
329	RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR	232	1	2022-02-15 07:43:40	2022-02-21 07:17:25	351
451	Préparation fichier d'import avoirs MOURTAZA VALIBHAY	205	33	2022-02-25 13:20:55	2022-02-28 08:45:09	473
414	Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM	205	22	2022-02-22 11:32:55	2022-02-22 13:10:20	436
490	Déblocage compte bloqué par ADM et MGBI2	235	23	2022-03-02 11:19:35	2022-03-02 11:19:54	512
479	Importer les GenBusPostingGroup des clients et fournisseurs	210	62	2022-03-01 09:48:30	2022-03-01 10:00:52	501
459	Bébloquage erreur de réconciliation de donnée GESCOM et CRM	235	20	2022-02-28 07:55:42	2022-03-01 13:44:43	481
362	Ajuster la taille des colonnes	206	14	2022-02-17 07:13:24	2022-02-17 07:13:24	384
317	Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation	206	5	2022-02-14 13:21:59	2022-02-14 13:21:59	339
343	Validation BL Cheinmalt	205	24	2022-02-16 12:45:55	2022-02-22 13:11:29	365
432	Intégration des Stocks dépôt 2 PO24141 et autres articles (carreaux)	205	31	2022-02-24 14:00:50	2022-02-24 14:00:56	454
450	Intégration stock dépôt 2 du 24/02/2022	205	32	2022-02-25 13:18:52	2022-02-25 13:19:06	472
231	Solde de congé 2021	205	16	2022-02-04 12:16:55	2022-02-04 12:39:32	236
235	Intégration stock PO26294 - Francelec	205	15	2022-02-04 12:42:51	2022-02-04 12:44:14	241
234	Intégration stock PO25899 - Ingco	205	13	2022-02-04 12:42:07	2022-02-04 12:44:23	240
230	Salaire Cheinmalt janvier 2022	205	18	2022-02-04 12:15:24	2022-02-04 12:39:40	235
492	Contre inventaire pour COMPUTEK TANA	235	25	2022-03-02 11:22:04	2022-03-02 11:22:52	514
395	Rajouter sur l'historique quand il y a un ajustement de stock	205	1	2022-02-21 09:25:44	2022-02-22 12:13:23	417
325	Modification compte article	234	12	2022-02-15 07:38:33	2022-02-15 07:39:03	347
324	Création utilisateur EBP	234	13	2022-02-15 07:36:23	2022-02-21 06:52:25	346
311	Mise à jour des familles	234	1	2022-02-14 11:34:35	2022-03-09 12:13:12	333
396	Rajout catalogue FOSKA sur le site	203	10	2022-02-21 09:29:30	2022-02-21 09:29:42	418
427	Suppression des Clients n'ayant pas d'échéance, ni de téléphone et d'adresse,commence par (mr,mm) 	235	15	2022-02-24 12:49:28	2022-02-25 13:28:36	449
320	Envoyer de la liste des articles pour indiquer ceux qui sont à publier ou non sur le site	231	1	2022-02-14 13:25:36	2022-02-14 13:25:36	342
321	Analyser la problématique d'envoi automatique des messages whatsapp et mails	231	2	2022-02-14 13:26:23	2022-02-14 13:26:23	343
431	Suppression des bases SQL EBP	231	0	2022-02-24 12:55:09	2022-03-16 07:58:09	453
337	Envoyer fichier dans l'FTP du Site COMPUTEK	223	2	2022-02-16 07:11:44	2022-02-16 07:12:11	359
383	Afficher les autres taxes dans l'impression facture	210	57	2022-02-21 07:08:07	2022-02-28 09:35:57	405
452	Import avoirs MOURTAZA VALIBHAY	204	2	2022-02-25 13:28:39	2022-02-28 08:46:16	474
481	Ajustement de stock Chein/Stock pour validation BL	205	39	2022-03-01 11:52:25	2022-03-02 08:23:26	503
487	Vérification stock des articles et validation des livraisons VCHD21123	205	42	2022-03-02 08:26:24	2022-03-02 08:26:42	509
357	Ajouter les champs obligatoires dans les lignes de commandes, les afficher sur la facture: N° du vol, la clase de réservation (à afficher dans la facture), status (liste déroulante: issued, reissued, refund)	209	11	2022-02-17 07:07:09	2022-02-24 09:36:09	379
380	Mettre la même présentation dans la facture (lignes) que dans le document de commande	206	24	2022-02-21 07:05:21	2022-02-21 07:05:21	402
351	Départ et Arrivée: des listes déroulantes (quand on a la liste)	207	1	2022-02-17 07:02:49	2022-02-22 06:33:49	373
421	Modification du banner sur l'accueil	255	0	2022-02-24 07:31:39	2022-02-24 09:24:43	443
387	Erreur lors de la confirmation d'un avoir	206	31	2022-02-21 07:11:28	2022-02-21 07:11:28	409
454	Paramétrage sur les fiches CLIENTS	235	30	2022-02-28 07:49:18	2022-03-04 11:21:27	476
373	Renommer "Remboursement intégral" en "Avoir intégral" dans document facture > ajouter un avoir	206	18	2022-02-21 06:58:48	2022-02-21 06:58:48	395
406	Modèle d'impression BON DE TRANSFERT	235	3	2022-02-22 09:36:04	2022-02-22 12:37:21	428
346	Enlever User 01, User 02, User 03 de la liste des clients dans document de commande	210	1	2022-02-17 06:59:48	2022-02-28 09:00:09	368
502	Ajustement de stock ATG0601 et PEG60*18 pour validation BL	205	44	2022-03-03 08:21:27	2022-03-03 10:16:14	524
407	Préparation fichier d'inventaire	235	5	2022-02-22 09:38:25	2022-02-22 12:37:34	429
391	Vérification des articles avec doublons	235	6	2022-02-21 09:17:41	2022-02-22 12:37:38	413
371	Renommer "Nombre d'achat" en "Achat" dans le document travel order	210	39	2022-02-21 06:57:25	2022-02-21 09:37:33	393
377	Renommer "Émis" en "émis" dans impression facture	210	42	2022-02-21 07:03:06	2022-02-21 14:26:00	399
419	Repertorier les ecritures non rapprochées - BMOI Chainmalt	210	47	2022-02-24 06:34:50	2022-02-25 07:53:43	441
250	Afficher les autres taxes dans les documents factures et achats	210	19	2022-02-07 10:51:20	2022-02-08 12:35:06	272
251	Document travel order doit être non modifiable à partir de 'accepté'	210	18	2022-02-07 10:52:35	2022-02-08 12:36:17	273
252	Afficher les fournisseurs dans la facture client	210	17	2022-02-07 10:54:06	2022-02-08 13:16:16	274
246	Rajouter un statut Accepté pour les devis	210	24	2022-02-07 09:17:00	2022-02-07 10:34:49	268
390	Créer l'avoir fournisseur quand on confirme l'avoir client	206	34	2022-02-21 07:13:52	2022-02-21 07:13:52	412
378	Dans la ficher client, enlever tout dans les conditions de paiement et ne laisser que Paiement immédiat et 30 jours	206	22	2022-02-21 07:03:58	2022-02-21 07:03:58	400
279	Suppression backup ancienne	190	3	2022-02-08 09:05:09	2022-02-28 10:23:17	301
280	Normalisation l'heure d'envoie backup	190	2	2022-02-08 09:07:00	2022-02-28 10:23:21	302
434	Créer un manuel d'utilisation pour l'application	206	35	2022-02-25 07:11:20	2022-02-25 07:11:20	456
457	Inventaire TANA et TAMATAVE	235	18	2022-02-28 07:53:14	2022-02-28 07:53:25	479
471	Importer les postings group des clients et dans odoo	210	60	2022-03-01 08:35:11	2022-03-01 09:13:00	493
255	Création d'un champs selection (client en compte, client de passage (default))	206	4	2022-02-07 10:58:48	2022-02-07 10:58:48	277
529	Inventaire Computek TANA, date date du document 28/02/2022	235	39	2022-03-09 12:21:15	2022-03-09 12:22:03	551
426	Suppression des doublons des clients	235	14	2022-02-24 12:45:41	2022-02-25 13:28:36	448
412	Mettre à jour import article depuis hfsql	206	16	2022-02-22 10:58:05	2022-02-27 15:50:53	434
233	Alert audio quand chèque arrivé à échéance	201	2	2022-02-04 12:23:41	2022-02-04 12:23:41	238
360	Mettre total Billet en dessous des lignes de commande	206	12	2022-02-17 07:10:57	2022-02-17 07:10:57	382
361	Mettre la total des Fees, la total des taxes (autres taxes) en dessous de s lignes de commande	206	13	2022-02-17 07:12:12	2022-02-17 07:12:12	383
326	Récupération de la tva sur Odoo de l'article pour le site	201	4	2022-02-15 07:40:39	2022-02-15 07:40:39	348
323	Module pour bloquer le mouvement de stock quand on valide un BL daté avant l'inventaire	201	3	2022-02-15 07:35:19	2022-02-15 07:35:19	345
463	Module de gestion d'avance salariale Odoo	203	4	2022-02-28 12:15:36	2022-02-28 12:15:45	485
397	Mise à jour compte de dépense pour le PO PO26496 sur CHEINMALT	203	11	2022-02-21 12:42:42	2022-02-21 12:42:49	419
533	Préparation fichier d'import famille articles Cheinmalt	203	0	2022-03-16 06:31:23	2022-03-16 06:31:36	555
499	Accès dans OLAP pour les MANAGERS	233	11	2022-03-03 06:22:30	2022-03-03 06:22:36	521
402	Adaptation/vérification du programme import client	223	0	2022-02-22 08:55:03	2022-02-22 08:55:12	424
401	Création modèle d'Import Client et Devis sur EBP. 	223	1	2022-02-22 08:52:55	2022-02-22 09:09:10	423
523	Listes des BL non facturés	235	33	2022-03-07 13:50:56	2022-03-07 13:51:31	545
515	Ajustement de stock pour validation BL avec Mme Jeanne	205	49	2022-03-07 09:34:41	2022-03-07 14:54:11	537
488	Mise en place d'une methode de validation pour sauvegarder les ecritures rapprochés	209	1	2022-03-02 10:54:47	2022-03-02 10:55:01	510
474	Ajustement des stocks pour reglement Avoir [TPN2]	205	37	2022-03-01 09:11:46	2022-03-01 09:11:52	496
495	Envoie des fiches de salaire Cheinmalt, QLM, Codimat et Codigaz	205	43	2022-03-02 13:15:51	2022-03-02 13:16:00	517
503	Validation des BL CHM/BL/21377, CHM/BL/21326,CHM/BL/19980,CHM/BL/21179,CHM/BL/19542,CHM/BL/16176 (démande de Mme Jeanne)	205	46	2022-03-03 13:10:42	2022-03-03 13:11:02	525
500	Listes des articles qui n'on pas de mouvement du 3 derniers mois	235	28	2022-03-03 06:23:19	2022-03-04 06:32:20	522
318	Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation	233	23	2022-02-14 13:24:18	2022-02-14 13:24:38	340
534	Création utilisateur HAJA de l'équipe de TANA	235	40	2022-03-16 07:56:36	2022-03-16 09:00:23	556
525	configuration de la base de données SQL Server EDR	244	1	2022-03-08 08:37:06	2022-03-16 10:42:03	547
516	Optimisation de la base de données pour améliorer la navigation sur le site	255	1	2022-03-07 11:35:06	2022-03-07 13:40:10	538
358	Ordre des colonnes des lignes de commandes: Type d'article (billet, fees, supplément/voucher), Article,... (Fournisseur  et numéro de billet côte à côte)	210	37	2022-02-17 07:08:41	2022-02-18 13:25:46	380
374	Renommer "Agence de voyage" en "Agences de voyage"	210	41	2022-02-21 06:59:20	2022-02-21 14:25:47	396
443	Prendre en compte "Nombre" dans le calcul du prix total et du total HT	210	55	2022-02-25 07:23:38	2022-02-28 08:16:09	465
442	Renommer "Nombre" en "Nombre de nuitées"	210	50	2022-02-25 07:21:52	2022-02-27 15:19:43	464
435	Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert	210	53	2022-02-25 07:12:35	2022-02-27 15:50:20	457
347	Mettre la liste de prix en mode lecture seule et/ou la masquer	210	33	2022-02-17 07:00:30	2022-02-18 13:24:18	369
349	Ajouter INF dans civilité dans la ligne de commande	210	35	2022-02-17 07:01:47	2022-02-18 13:24:47	371
355	Renommer "Date d'arrivé" en "Date d'arrivée"	210	36	2022-02-17 07:05:09	2022-02-18 13:25:09	377
438	Enlever le champs référence dans doc de type to	210	49	2022-02-25 07:16:04	2022-02-25 10:06:42	460
298	Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer	210	5	2022-02-10 09:21:35	2022-02-28 08:37:56	320
483	Débogage au niveau des filtres du tableau principale	242	0	2022-03-01 20:30:59	2022-03-16 12:14:00	505
536	Mise en place de WP All Export(commandes et utilisateurs) sur le site computek 	224	0	2022-03-16 13:16:43	2022-03-16 13:16:55	558
469	Ajout autres détails d'un PNR: Affichage + Traitement	169	4	2022-03-01 07:17:29	2022-03-03 06:21:32	491
404	Affichage des autres informations significatives d'un billet	169	2	2022-02-22 08:57:11	2022-03-04 08:18:39	426
506	Affichage des segments de vols d'un billet	169	1	2022-03-04 07:47:07	2022-03-04 09:31:36	528
333	Calcul automatique du montant du service fees	169	5	2022-02-15 11:14:04	2022-02-18 14:09:20	355
403	Affichage des 'PNR AirSegments' dans la liste des vols effectués	169	3	2022-02-22 08:56:16	2022-03-01 07:20:56	425
295	Ajout historique d'un billet	169	0	2022-02-09 09:52:22	2022-03-08 07:55:33	317
475	Tâche 1	206	47	2022-03-01 09:12:19	2022-03-01 09:12:19	497
331	Récupération de la tva sur Odoo de l'article pour le site	180	1	2022-02-15 10:09:11	2022-02-22 11:45:37	353
363	synchronisation des categories odoo et site web	180	0	2022-02-18 08:25:18	2022-03-01 11:53:36	385
366	Rendre la référence de travel order obligatoire	209	9	2022-02-18 14:17:15	2022-02-18 14:18:50	388
313	Prise en compte des données Tour (en cas de modification du circuit)	209	2	2022-02-14 11:43:00	2022-02-21 06:05:27	335
275	Ne pas afficher les détails des lignes dans l'impression (facture, devis, commande, pro forma)	209	7	2022-02-07 13:08:38	2022-02-08 09:02:02	297
284	Désactiver certaines colonne dans travel order selon l'article selectionné	209	5	2022-02-08 13:16:43	2022-02-10 07:17:10	306
254	Gestion des clients en compte et client de passage	209	4	2022-02-07 10:56:48	2022-02-08 08:57:56	276
501	Paramétrage des vues dans GESCOM, accès au filtrage d'une date	235	34	2022-03-03 06:24:32	2022-03-07 13:52:16	523
507	Affichage des historiques d'un billet	168	0	2022-03-04 08:19:32	2022-03-04 08:19:42	529
531	Validation BL, demande par Mme Jeanne du 14/03/22	205	52	2022-03-16 06:28:24	2022-03-16 06:28:32	553
309	création d'import produit et catégories, et correspondance des champs d'import sur le site	224	4	2022-02-14 09:19:58	2022-02-24 04:49:21	331
394	Mise en place WPAllExport des clients et commandes 	224	3	2022-02-21 09:23:08	2022-02-24 05:41:09	416
494	Backup Site web/base de données et mise  en place WPAllimport	224	2	2022-03-02 13:03:07	2022-03-09 13:31:55	516
530	Mise en page des catégories sur le menu gauche du site	224	1	2022-03-09 13:35:41	2022-03-16 13:18:20	552
535	Modèle d'impression FACTURE D'ACOMPTE	235	41	2022-03-16 07:57:31	2022-03-16 13:45:43	557
253	Gestion des droits de validations de devis	210	16	2022-02-07 10:55:05	2022-02-08 14:17:22	275
256	statut accepté => génération de doc achat	210	15	2022-02-07 12:44:44	2022-02-08 14:25:05	278
264	Création de la bande duplicata	210	29	2022-02-07 12:53:56	2022-02-08 14:31:25	286
257	statut confirmé => génération de factures clients et fournisseurs	210	12	2022-02-07 12:45:57	2022-02-08 14:26:20	279
269	Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande	210	11	2022-02-07 12:59:55	2022-02-08 14:33:21	291
258	statu annulé => suppression du document achat	210	10	2022-02-07 12:47:28	2022-02-10 07:05:57	280
274	Ajouter un champs pour le numéro de jour	210	6	2022-02-07 13:06:59	2022-02-10 07:06:05	296
375	Ajouter dans le document d'achat le numéro du vol et les dates (dates de départ et d'arrivée)	210	56	2022-02-21 07:00:22	2022-02-28 08:16:34	397
319	Finir le rapprochement bancaire pour une banque	210	45	2022-02-14 13:25:13	2022-02-22 10:29:18	341
273	Ajouter un champs nombre (nombre x quantité joue le rôle de quantité)	210	25	2022-02-07 13:06:33	2022-02-08 09:24:14	295
259	Cacher le champs émission, sa valeur est toujour la même	210	21	2022-02-07 12:49:12	2022-02-08 09:42:30	281
541	Sauvegarde des backups vers 37 puis vers sync.com	189	0	2022-03-17 14:01:15	2022-03-17 14:06:40	563
538	Sauvegarde des backups vers 37 puis vers sync.com	189	4	2022-03-17 13:57:56	2022-03-17 13:59:43	560
456	Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows	189	17	2022-02-28 07:52:30	2022-03-01 11:43:44	478
505	Sauvegarde manuelle vers Syn.com	189	11	2022-03-04 07:00:30	2022-03-07 11:36:12	527
540	Sauvegarde des backups vers 37 puis vers sync.com	189	3	2022-03-17 14:00:29	2022-03-17 14:01:04	562
528	Sauvegarde manuelle depuis 37 vers sync.com	189	6	2022-03-09 09:00:40	2022-03-17 13:51:37	550
302	Résolution des problèmes d'envoie des fichiers backup dans l'FTP	189	14	2022-02-11 07:33:42	2022-03-02 12:33:33	324
448	Mise en place server FTP	189	12	2022-02-25 07:54:25	2022-03-02 12:33:13	470
493	Sauvegarde manuel backup EBP	189	10	2022-03-02 12:34:07	2022-03-03 04:56:43	515
225	Programme pour rapport mails des sauvegarde réussie du jours 	189	18	2022-02-03 09:52:01	2022-02-03 12:00:04	223
417	Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes.	189	16	2022-02-23 07:12:59	2022-02-25 07:52:48	439
242	Vérification des sauvegardes sur les serveurs clients 	189	13	2022-02-07 08:52:08	2022-03-02 12:33:47	264
496	Sauvegarde manuel backup ebp	189	7	2022-03-03 04:57:12	2022-03-04 06:59:29	518
517	Sauvegarde manuelle vers Syn.com	189	9	2022-03-07 11:37:19	2022-03-08 06:03:47	539
524	Sauvegarde manuelle backup EBP vers Sync.com	189	8	2022-03-08 06:09:30	2022-03-09 09:00:04	546
537	Sauvegarde des backups vers 37 puis vers sync.com	189	5	2022-03-17 13:55:46	2022-03-17 13:57:15	559
539	Sauvegarde des backups vers 37 puis vers sync.com	189	2	2022-03-17 13:58:16	2022-03-17 13:59:46	561
480	Sauvegarde Manuel des backups	189	15	2022-03-01 11:43:39	2022-03-02 12:32:59	502
542	Sauvegarde des backups vers 37 puis vers sync.com	189	1	2022-03-17 14:07:02	2022-03-17 14:07:22	564
\.


--
-- Data for Name: clients_requests; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.clients_requests (id, content, date_post, active_client_id, inserted_at, updated_at, title, seen, ongoing, done, file_urls) FROM stdin;
14	3eme requête	2021-06-05 18:14:45	1	2021-06-05 15:14:45	2021-06-05 15:14:45	Requête 3	f	f	f	{}
26	ceci est une collection de fonds d'écran	2021-06-08 11:04:07	1	2021-06-08 08:04:07	2021-06-12 09:48:22	Fond d'écran	f	f	f	{/uploads/1361846e69b9740-e234-494e-ae88-6383904579d0.jpg,/uploads/SBKjnxm4e3aa22e-f0b5-4229-8cb4-5192c6325dd3.jpg}
13	deuxième requête 	2021-06-05 18:13:24	1	2021-06-05 15:13:24	2021-06-05 18:56:19	Requête 2	f	f	f	{}
15	ceci est une requête flash	2021-06-05 21:01:44	1	2021-06-05 18:01:44	2021-06-12 09:47:28	Requête flash	f	f	f	{}
12	Voici la première requête	2021-06-05 17:39:41	1	2021-06-05 14:39:41	2021-06-07 14:41:16	Requête 1	t	f	f	{}
21	samurai pictures	2021-06-07 20:44:26	1	2021-06-07 17:44:26	2021-06-12 09:47:32	Samuraï	f	f	f	{/uploads/136201116337dd3-836b-44e6-a5fa-cf2cd07416b8.jpg,/uploads/winter_samuraiea311a63-ef6c-4184-8329-32dd542f488e.jpg}
27	test	2021-06-16 16:27:58	1	2021-06-16 13:27:58	2021-07-04 17:38:14	Test	f	f	f	{/uploads/nihon799a0b89-ef08-4597-b35d-91e8fe2c78d7.jpg}
28	eci est un test 	2021-07-05 11:57:39	1	2021-07-05 08:57:39	2021-07-05 08:57:39	Test requête	f	f	f	{/uploads/musk4thc2409339-a808-46ca-8881-5ac55143900b.png}
22	des fichiers	2021-06-07 20:59:51	1	2021-06-07 17:59:51	2021-06-12 09:47:47	Fichiers	f	f	f	{/uploads/cert-21413040-107362b713fa-34ee-4193-80f3-af48536efc2d.pdf,"/uploads/cert-21413040-1024 (copy)qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq7e55d38a-a14a-43ce-adeb-7153f5d79c2a.pdf"}
29	Ceci est une requête de démonstration,\r\nPouvez-vous la recevoir?	2021-08-11 16:09:18	1	2021-08-11 13:09:18	2021-08-11 13:09:18	Ma requête	f	f	f	{/uploads/db_conceptb1978b84-b341-4d0a-848d-edfd441c428d.png}
25	Êtes-vous notifié de cette requête?	2021-06-07 23:43:47	1	2021-06-07 20:43:47	2021-06-12 09:40:05	Notification?	t	f	f	{}
23	ceci est un fichier texte	2021-06-07 21:16:55	1	2021-06-07 18:16:55	2021-06-12 09:47:56	Fichier texte	f	f	f	{/uploads/test1703fef2-905a-4e5f-9396-067124e1eaaa.txt}
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.comments (id, content, task_id, poster_id, inserted_at, updated_at, file_urls) FROM stdin;
96	Test	315	71	2022-02-08 17:18:31	2022-02-08 14:18:31	{}
97	test	315	71	2022-02-08 17:18:44	2022-02-08 14:18:44	{}
98	Cette tâche a besoin d'un modèle de facture des PNRs specimens	317	73	2022-02-09 12:53:37	2022-02-09 09:53:37	{}
99	Arrêt de toutes les activités en arrière-plan après la fermeture de l'application	303	73	2022-02-10 15:50:35	2022-02-10 12:50:35	{}
100	ajout droit de création un ORDRE DE TRANFERT,	378	76	2022-02-21 09:02:20	2022-02-21 06:02:20	{}
101	voir le prix de revient et l'achat sur la fiche article	378	76	2022-02-21 09:02:49	2022-02-21 06:02:49	{}
102	VUE pour le compte de notre Direction Générale svp (Mr Zohar et Mme Koulsoum), ajout champs "NOTES,Utilisateur de création et modification" sur les documents OT, BE, BS	372	76	2022-02-21 10:15:41	2022-02-21 07:15:41	{}
103	- Nom d'utilisateur = JOSE - Type d'accès = seulement ''CONSULTATION'' de fiches article	346	76	2022-02-21 10:18:24	2022-02-21 07:18:24	{}
104	Suite aux besoins réels de notre Webmaster, nous vous prions d'activer son compte d'utilisateur dans EBP, sur tous les 4 entités.	346	76	2022-02-21 10:19:11	2022-02-21 07:19:11	{}
105	changer tous les compte de variation de stock 6037 et compte d'encours de stock 371	347	76	2022-02-21 10:21:36	2022-02-21 07:21:36	{}
106	il y a quelque articles qui en a le compte: 6037CANON,,,	347	76	2022-02-21 10:21:52	2022-02-21 07:21:52	{}
107	Ajout champs notes, En fait, c'est dans l'onglet NOTES qu'on écrit tous les motifs et remarques relatifs à l'ordre de transfert.	374	76	2022-02-21 10:25:22	2022-02-21 07:25:22	{}
108	l'article devient stock négatif	363	76	2022-02-21 10:27:51	2022-02-21 07:27:51	{}
110	Acces Transfert Commande Interne en Bon de livraison pour les 03 Commerciaux: TOLOTRA-JODIE-MATIO.	356	76	2022-02-21 10:33:41	2022-02-21 07:33:41	{}
111	Blocage  de  Transfert en Commande interne pour les articles générique et les articles non mouvementé.	356	76	2022-02-21 10:33:55	2022-02-21 07:33:55	{}
112	Acces au saisie mode de règlemente et fiche client	356	76	2022-02-21 10:34:07	2022-02-21 07:34:07	{}
113	Patrick accès pour les BON de COMMANDE interne client	356	76	2022-02-21 10:34:20	2022-02-21 07:34:20	{}
114	 Mouvements de stock des articles pour Patrick-Dominique-Jodie	356	76	2022-02-21 10:34:33	2022-02-21 07:34:33	{}
115	Déjà envoyé au COMPUTEK un fichier pour les familles à changer	333	76	2022-02-21 10:35:35	2022-02-21 07:35:35	{}
116	en attente d'une retour du COMPUTEK	333	76	2022-02-21 10:35:58	2022-02-21 07:35:58	{}
117	Sont seuls autorisés à saisir une facture fournisseur : - THEODORA pour Computek Tanà - ROLAND et LILIA pour Computek Tamatave - HASINA et SARIAKA pour MOB+ - SABIR pour SMB	351	76	2022-02-21 10:39:14	2022-02-21 07:39:14	{}
118	MAIS sont seuls autorisés à valider la facture : - Mr Zohar - Mme Koulsoum	351	76	2022-02-21 10:39:38	2022-02-21 07:39:38	{}
119	supprimer (ou bloquer) automatiquement tous les doublons d'articles DONT le stock est = 0 	413	76	2022-02-21 12:18:22	2022-02-21 09:18:22	{}
120	Traduction Français du nom à rajouter 	361	70	2022-02-21 12:39:32	2022-02-21 09:39:32	{}
121	TEST	350	85	2022-02-21 12:43:25	2022-02-21 09:43:25	{}
122	TEST	350	85	2022-02-21 12:43:44	2022-02-21 09:43:44	{}
123	TEST1	350	85	2022-02-21 12:44:04	2022-02-21 09:44:04	{}
124	 à modifier comme  l'ordre de transfert, ajout champs "notes" , L'en tête de page du BON D'ENTREE à rectifier,  changer la modèle du BON DE SORTIE soit identique au BON D'ENTREE	428	76	2022-02-22 12:37:30	2022-02-22 09:37:30	{}
125	 Pourriez-vous nous préparer un fichier excel d'inventaire avec lequel on va pointer les articles avec les douchettes à codes-barres ?	429	76	2022-02-22 12:39:06	2022-02-22 09:39:06	{}
126	Base de donnée verouillé par ADM	446	76	2022-02-24 15:43:11	2022-02-24 12:43:11	{}
127	Mettre le champs NOM, PRENOM, TELEPHONE, MAIL obligatoire durant la création d'un nouveau Client	451	76	2022-02-24 15:52:42	2022-02-24 12:52:42	{}
128	L'article CRAY0008 du stock TANA ne peut pas se ajouter dans BL	452	76	2022-02-24 15:53:19	2022-02-24 12:53:19	{}
129	Le champs "Référence fournisseur" dans doc achat est récupéré dans le champs "Référence de paiement" dans la facture, faut-il créé encore un autre champs pour le récupérer?	305	78	2022-02-27 18:44:29	2022-02-27 15:44:29	{}
130	Un exemple d'un PNR avec les détails plus visibles	317	73	2022-03-01 10:19:20	2022-03-01 07:19:20	{}
131	Droit pour modification fiche article pour SARIAKA02	513	76	2022-03-02 14:21:31	2022-03-02 11:21:31	{}
132	INVENTAIRE COMPUTEK TANA du 03/03/2022	519	76	2022-03-03 11:01:17	2022-03-03 08:01:17	{}
133	Mettre le champs NOM, PRENOM, TELEPHONE, MAIL obligatoire durant la création d'un nouveau Client	476	76	2022-03-04 13:21:30	2022-03-04 10:21:30	{}
134	Cause de ces iventaires:Articles insérer avant inventaires non exporte-déclaration quantité en paquets et unitaire	543	76	2022-03-07 16:49:34	2022-03-07 13:49:34	{}
135	Suppression des BL doublon dans l'ancienne base et de la nouvelle base.	545	76	2022-03-07 16:51:17	2022-03-07 13:51:17	{}
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.companies (id, name, inserted_at, updated_at, logo) FROM stdin;
2	COMP	2021-05-03 07:27:29	2021-05-03 07:27:29	images/company_logos/company_default_logo.png
6	SOCIETAM	2021-05-14 13:08:49	2021-05-14 13:08:49	images/company_logos/company_default_logo.png
1	MGBI	2021-04-13 13:35:40	2021-06-08 16:39:58	images/company_logos/company_default_logo.png
\.


--
-- Data for Name: editors; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.editors (id, title, company_id, inserted_at, updated_at) FROM stdin;
1	SOC-EDITOR1	1	2021-06-02 15:10:15	2021-06-02 15:10:15
13	EBP	1	2022-02-18 09:32:46	2022-02-18 09:32:46
\.


--
-- Data for Name: licenses; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.licenses (id, title, date_start, date_end, company_id, inserted_at, updated_at) FROM stdin;
1	LIC--SOC1	2021-06-10	2021-06-12	1	2021-06-02 20:27:41	2021-06-02 20:27:41
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.notifications (id, content, seen, sender_id, receiver_id, inserted_at, updated_at) FROM stdin;
3940	Un projet du nom de SIGM - Application inter Amadeus et Odoo a été crée par Mihaja	f	70	53	2022-02-03 07:47:06	2022-02-03 07:47:06
3941	Un projet du nom de SIGM - Application inter Amadeus et Odoo a été crée par Mihaja	f	70	57	2022-02-03 07:47:06	2022-02-03 07:47:06
3942	Un projet du nom de SIGM - Application inter Amadeus et Odoo a été crée par Mihaja	f	70	71	2022-02-03 07:47:06	2022-02-03 07:47:06
3947	Un projet du nom de Site web QLM a été crée par Mihaja	f	70	53	2022-02-03 09:43:30	2022-02-03 09:43:30
3948	Un projet du nom de Site web QLM a été crée par Mihaja	f	70	57	2022-02-03 09:43:30	2022-02-03 09:43:30
3949	Un projet du nom de Site web QLM a été crée par Mihaja	f	70	71	2022-02-03 09:43:30	2022-02-03 09:43:30
3962	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	53	2022-02-03 09:47:27	2022-02-03 09:47:27
3963	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	57	2022-02-03 09:47:27	2022-02-03 09:47:27
3964	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	70	2022-02-03 09:47:27	2022-02-03 09:47:27
3965	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	71	2022-02-03 09:47:27	2022-02-03 09:47:27
3993	Tâche "Programme pour rapport mails des sauvegarde réussie du jours "\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-02-03 12:00:04	2022-02-03 12:00:04
3994	Tâche "Programme pour rapport mails des sauvegarde réussie du jours "\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-02-03 12:00:04	2022-02-03 12:00:04
3995	Tâche "Programme pour rapport mails des sauvegarde réussie du jours "\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-02-03 12:00:04	2022-02-03 12:00:04
3996	Tâche "Programme pour rapport mails des sauvegarde réussie du jours "\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-02-03 12:00:04	2022-02-03 12:00:04
3997	Tâche nouvellement créee du nom de Programme de transfert des backup clients sur FTP par Mihaja dans le projet Sauvegarde FTP des clients .	f	70	53	2022-02-04 08:22:24	2022-02-04 08:22:24
3998	Tâche nouvellement créee du nom de Programme de transfert des backup clients sur FTP par Mihaja dans le projet Sauvegarde FTP des clients .	f	70	57	2022-02-04 08:22:24	2022-02-04 08:22:24
3999	Tâche nouvellement créee du nom de Programme de transfert des backup clients sur FTP par Mihaja dans le projet Sauvegarde FTP des clients .	f	70	71	2022-02-04 08:22:24	2022-02-04 08:22:24
4005	Tâche nouvellement créee du nom de Installation du nouveau programme sauvegarde sur les serveurs clients par Mihaja dans le projet Sauvegarde FTP des clients .	f	70	53	2022-02-04 11:59:31	2022-02-04 11:59:31
4006	Tâche nouvellement créee du nom de Installation du nouveau programme sauvegarde sur les serveurs clients par Mihaja dans le projet Sauvegarde FTP des clients .	f	70	57	2022-02-04 11:59:31	2022-02-04 11:59:31
4007	Tâche nouvellement créee du nom de Installation du nouveau programme sauvegarde sur les serveurs clients par Mihaja dans le projet Sauvegarde FTP des clients .	f	70	71	2022-02-04 11:59:31	2022-02-04 11:59:31
4008	Mihaja vous a assigné à la tâche Installation du nouveau programme sauvegarde sur les serveurs clients dans le projet Sauvegarde FTP des clients .	f	70	74	2022-02-04 11:59:31	2022-02-04 11:59:31
4012	Tâche "Installation du nouveau programme sauvegarde sur les serveurs clients"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Mihaja	f	70	53	2022-02-04 12:00:02	2022-02-04 12:00:02
4013	Tâche "Installation du nouveau programme sauvegarde sur les serveurs clients"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Mihaja	f	70	57	2022-02-04 12:00:02	2022-02-04 12:00:02
4014	Tâche "Installation du nouveau programme sauvegarde sur les serveurs clients"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Mihaja	f	70	71	2022-02-04 12:00:02	2022-02-04 12:00:02
4027	Tâche "Correspondance des articles et familles sur le site"\n          du projet Site web QLM mise dans " En cours " par Mihaja	f	70	53	2022-02-04 12:05:42	2022-02-04 12:05:42
4028	Tâche "Correspondance des articles et familles sur le site"\n          du projet Site web QLM mise dans " En cours " par Mihaja	f	70	57	2022-02-04 12:05:42	2022-02-04 12:05:42
4029	Tâche "Correspondance des articles et familles sur le site"\n          du projet Site web QLM mise dans " En cours " par Mihaja	f	70	71	2022-02-04 12:05:42	2022-02-04 12:05:42
4030	Tâche "Import photos des articles publié sur le site "\n          du projet Site web QLM mise dans " En cours " par Mihaja	f	70	53	2022-02-04 12:05:46	2022-02-04 12:05:46
4031	Tâche "Import photos des articles publié sur le site "\n          du projet Site web QLM mise dans " En cours " par Mihaja	f	70	57	2022-02-04 12:05:46	2022-02-04 12:05:46
4032	Tâche "Import photos des articles publié sur le site "\n          du projet Site web QLM mise dans " En cours " par Mihaja	f	70	71	2022-02-04 12:05:46	2022-02-04 12:05:46
4040	Tâche nouvellement créee du nom de Solde de congé 2021 par Michel dans le projet Intervention / Accompagnement 2022.	f	71	53	2022-02-04 12:16:55	2022-02-04 12:16:55
4041	Tâche nouvellement créee du nom de Solde de congé 2021 par Michel dans le projet Intervention / Accompagnement 2022.	f	71	57	2022-02-04 12:16:55	2022-02-04 12:16:55
4042	Tâche nouvellement créee du nom de Solde de congé 2021 par Michel dans le projet Intervention / Accompagnement 2022.	f	71	70	2022-02-04 12:16:55	2022-02-04 12:16:55
4043	Michel vous a assigné à la tâche Solde de congé 2021 dans le projet Intervention / Accompagnement 2022.	t	71	77	2022-02-04 12:16:55	2022-02-04 12:16:55
4151	Tâche nouvellement créee du nom de Vérification des sauvegardes sur les serveurs clients  par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-02-07 08:52:08	2022-02-07 08:52:08
4152	Tâche nouvellement créee du nom de Vérification des sauvegardes sur les serveurs clients  par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-02-07 08:52:08	2022-02-07 08:52:08
4154	Tâche nouvellement créee du nom de Vérification des sauvegardes sur les serveurs clients  par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-02-07 08:52:08	2022-02-07 08:52:08
4243	Tâche nouvellement créee du nom de statut accepté => génération de doc achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 12:44:44	2022-02-07 12:44:44
6718	La tâche Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci a été achevée.	f	78	71	2022-02-25 09:19:01	2022-02-25 09:19:01
6719	La tâche Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci a été achevée.	f	78	85	2022-02-25 09:19:01	2022-02-25 09:19:01
3943	Tâche nouvellement créee du nom de Lecture des données XML par Mihaja dans le projet SIGM - Application inter Amadeus et Odoo.	f	70	53	2022-02-03 07:47:56	2022-02-03 07:47:56
3944	Tâche nouvellement créee du nom de Lecture des données XML par Mihaja dans le projet SIGM - Application inter Amadeus et Odoo.	f	70	57	2022-02-03 07:47:56	2022-02-03 07:47:56
3945	Tâche nouvellement créee du nom de Lecture des données XML par Mihaja dans le projet SIGM - Application inter Amadeus et Odoo.	f	70	71	2022-02-03 07:47:56	2022-02-03 07:47:56
3966	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	53	2022-02-03 09:47:34	2022-02-03 09:47:34
3967	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	57	2022-02-03 09:47:34	2022-02-03 09:47:34
3968	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	70	2022-02-03 09:47:34	2022-02-03 09:47:34
3969	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	71	2022-02-03 09:47:34	2022-02-03 09:47:34
3974	Tâche "Description des familles publié sur le site"\n          du projet Site web QLM mise dans " En cours " par Fanantenana	f	75	53	2022-02-03 09:50:39	2022-02-03 09:50:39
3975	Tâche "Description des familles publié sur le site"\n          du projet Site web QLM mise dans " En cours " par Fanantenana	f	75	57	2022-02-03 09:50:39	2022-02-03 09:50:39
3976	Tâche "Description des familles publié sur le site"\n          du projet Site web QLM mise dans " En cours " par Fanantenana	f	75	70	2022-02-03 09:50:39	2022-02-03 09:50:39
3977	Tâche "Description des familles publié sur le site"\n          du projet Site web QLM mise dans " En cours " par Fanantenana	f	75	71	2022-02-03 09:50:39	2022-02-03 09:50:39
3978	Un projet du nom de Sauvegarde FTP des clients  a été crée par Mihaja	f	70	53	2022-02-03 09:50:50	2022-02-03 09:50:50
3979	Un projet du nom de Sauvegarde FTP des clients  a été crée par Mihaja	f	70	57	2022-02-03 09:50:50	2022-02-03 09:50:50
3980	Un projet du nom de Sauvegarde FTP des clients  a été crée par Mihaja	f	70	71	2022-02-03 09:50:50	2022-02-03 09:50:50
3981	Tâche nouvellement créee du nom de Programme pour rapport mails des sauvegarde réussie du jours  par Mihaja dans le projet Sauvegarde FTP des clients .	f	70	53	2022-02-03 09:52:01	2022-02-03 09:52:01
3982	Tâche nouvellement créee du nom de Programme pour rapport mails des sauvegarde réussie du jours  par Mihaja dans le projet Sauvegarde FTP des clients .	f	70	57	2022-02-03 09:52:01	2022-02-03 09:52:01
3983	Tâche nouvellement créee du nom de Programme pour rapport mails des sauvegarde réussie du jours  par Mihaja dans le projet Sauvegarde FTP des clients .	f	70	71	2022-02-03 09:52:01	2022-02-03 09:52:01
3985	Tâche "Programme pour rapport mails des sauvegarde réussie du jours "\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	53	2022-02-03 09:53:32	2022-02-03 09:53:32
3986	Tâche "Programme pour rapport mails des sauvegarde réussie du jours "\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	57	2022-02-03 09:53:32	2022-02-03 09:53:32
3987	Tâche "Programme pour rapport mails des sauvegarde réussie du jours "\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	70	2022-02-03 09:53:32	2022-02-03 09:53:32
3988	Tâche "Programme pour rapport mails des sauvegarde réussie du jours "\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	71	2022-02-03 09:53:32	2022-02-03 09:53:32
4000	Mihaja vous a assigné à la tâche Programme de transfert des backup clients sur FTP dans le projet Sauvegarde FTP des clients .	f	70	74	2022-02-04 08:22:24	2022-02-04 08:22:24
4009	Tâche "Programme de transfert des backup clients sur FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Mihaja	f	70	53	2022-02-04 11:59:45	2022-02-04 11:59:45
4010	Tâche "Programme de transfert des backup clients sur FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Mihaja	f	70	57	2022-02-04 11:59:45	2022-02-04 11:59:45
4011	Tâche "Programme de transfert des backup clients sur FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Mihaja	f	70	71	2022-02-04 11:59:45	2022-02-04 11:59:45
4036	Tâche nouvellement créee du nom de Salaire Cheinmalt janvier 2022 par Michel dans le projet Intervention / Accompagnement 2022.	f	71	53	2022-02-04 12:15:24	2022-02-04 12:15:24
4037	Tâche nouvellement créee du nom de Salaire Cheinmalt janvier 2022 par Michel dans le projet Intervention / Accompagnement 2022.	f	71	57	2022-02-04 12:15:24	2022-02-04 12:15:24
4038	Tâche nouvellement créee du nom de Salaire Cheinmalt janvier 2022 par Michel dans le projet Intervention / Accompagnement 2022.	f	71	70	2022-02-04 12:15:24	2022-02-04 12:15:24
4039	Michel vous a assigné à la tâche Salaire Cheinmalt janvier 2022 dans le projet Intervention / Accompagnement 2022.	t	71	77	2022-02-04 12:15:24	2022-02-04 12:15:24
4044	Tâche nouvellement créee du nom de Salaire QLM, Codigaz, Codimat janvier 2022 par Michel dans le projet Intervention / Accompagnement 2022.	f	71	53	2022-02-04 12:17:55	2022-02-04 12:17:55
4045	Tâche nouvellement créee du nom de Salaire QLM, Codigaz, Codimat janvier 2022 par Michel dans le projet Intervention / Accompagnement 2022.	f	71	57	2022-02-04 12:17:55	2022-02-04 12:17:55
4046	Tâche nouvellement créee du nom de Salaire QLM, Codigaz, Codimat janvier 2022 par Michel dans le projet Intervention / Accompagnement 2022.	f	71	70	2022-02-04 12:17:55	2022-02-04 12:17:55
4244	Tâche nouvellement créee du nom de statut accepté => génération de doc achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 12:44:44	2022-02-07 12:44:44
4246	Tâche nouvellement créee du nom de statut accepté => génération de doc achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 12:44:44	2022-02-07 12:44:44
4247	Rémi vous a assigné à la tâche statut accepté => génération de doc achat dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 12:44:45	2022-02-07 12:44:45
4155	Osé vous a assigné à la tâche Vérification des sauvegardes sur les serveurs clients  dans le projet Sauvegarde FTP des clients .	t	74	74	2022-02-07 08:52:08	2022-02-07 08:52:08
3953	Mihaja vous a assigné à la tâche Rédirection port 80 vers 8069 sur 54  dans le projet Site web QLM.	t	70	72	2022-02-03 09:44:54	2022-02-03 09:44:54
3946	Mihaja vous a assigné à la tâche Lecture des données XML dans le projet SIGM - Application inter Amadeus et Odoo.	t	70	73	2022-02-03 07:47:56	2022-02-03 07:47:56
3950	Tâche nouvellement créee du nom de Rédirection port 80 vers 8069 sur 54  par Mihaja dans le projet Site web QLM.	f	70	53	2022-02-03 09:44:54	2022-02-03 09:44:54
3951	Tâche nouvellement créee du nom de Rédirection port 80 vers 8069 sur 54  par Mihaja dans le projet Site web QLM.	f	70	57	2022-02-03 09:44:54	2022-02-03 09:44:54
3952	Tâche nouvellement créee du nom de Rédirection port 80 vers 8069 sur 54  par Mihaja dans le projet Site web QLM.	f	70	71	2022-02-03 09:44:54	2022-02-03 09:44:54
3954	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " En blocage " par Nasolo	f	72	53	2022-02-03 09:45:55	2022-02-03 09:45:55
3955	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " En blocage " par Nasolo	f	72	57	2022-02-03 09:45:55	2022-02-03 09:45:55
3956	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " En blocage " par Nasolo	f	72	70	2022-02-03 09:45:55	2022-02-03 09:45:55
3957	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " En blocage " par Nasolo	f	72	71	2022-02-03 09:45:55	2022-02-03 09:45:55
3958	Tâche "Lecture des données XML"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	53	2022-02-03 09:47:23	2022-02-03 09:47:23
3959	Tâche "Lecture des données XML"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	57	2022-02-03 09:47:23	2022-02-03 09:47:23
3960	Tâche "Lecture des données XML"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	70	2022-02-03 09:47:23	2022-02-03 09:47:23
3961	Tâche "Lecture des données XML"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	71	2022-02-03 09:47:23	2022-02-03 09:47:23
3970	Tâche nouvellement créee du nom de Description des familles publié sur le site par Mihaja dans le projet Site web QLM.	f	70	53	2022-02-03 09:48:08	2022-02-03 09:48:08
3971	Tâche nouvellement créee du nom de Description des familles publié sur le site par Mihaja dans le projet Site web QLM.	f	70	57	2022-02-03 09:48:08	2022-02-03 09:48:08
3972	Tâche nouvellement créee du nom de Description des familles publié sur le site par Mihaja dans le projet Site web QLM.	f	70	71	2022-02-03 09:48:08	2022-02-03 09:48:08
3989	Tâche "Programme pour rapport mails des sauvegarde réussie du jours "\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-02-03 09:53:43	2022-02-03 09:53:43
3990	Tâche "Programme pour rapport mails des sauvegarde réussie du jours "\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-02-03 09:53:43	2022-02-03 09:53:43
3991	Tâche "Programme pour rapport mails des sauvegarde réussie du jours "\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	70	2022-02-03 09:53:43	2022-02-03 09:53:43
3992	Tâche "Programme pour rapport mails des sauvegarde réussie du jours "\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-02-03 09:53:43	2022-02-03 09:53:43
4001	La tâche Lecture des données XML a été achevée.	f	73	53	2022-02-04 10:58:05	2022-02-04 10:58:05
4002	La tâche Lecture des données XML a été achevée.	f	73	57	2022-02-04 10:58:05	2022-02-04 10:58:05
4003	La tâche Lecture des données XML a été achevée.	f	73	70	2022-02-04 10:58:05	2022-02-04 10:58:05
4004	La tâche Lecture des données XML a été achevée.	f	73	71	2022-02-04 10:58:05	2022-02-04 10:58:05
4015	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-04 12:00:48	2022-02-04 12:00:48
4016	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-04 12:00:48	2022-02-04 12:00:48
4017	Tâche "Rédirection port 80 vers 8069 sur 54 "\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-04 12:00:48	2022-02-04 12:00:48
4156	Tâche "Vérification des sauvegardes sur les serveurs clients "\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-02-07 08:52:26	2022-02-07 08:52:26
4157	Tâche "Vérification des sauvegardes sur les serveurs clients "\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-02-07 08:52:26	2022-02-07 08:52:26
4159	Tâche "Vérification des sauvegardes sur les serveurs clients "\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-02-07 08:52:26	2022-02-07 08:52:26
4248	Tâche nouvellement créee du nom de statut confirmé => génération de factures clients et fournisseurs par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 12:45:57	2022-02-07 12:45:57
4249	Tâche nouvellement créee du nom de statut confirmé => génération de factures clients et fournisseurs par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 12:45:57	2022-02-07 12:45:57
4251	Tâche nouvellement créee du nom de statut confirmé => génération de factures clients et fournisseurs par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 12:45:57	2022-02-07 12:45:57
4252	Rémi vous a assigné à la tâche statut confirmé => génération de factures clients et fournisseurs dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 12:45:57	2022-02-07 12:45:57
4268	Tâche nouvellement créee du nom de Copie de certains champs lors d'une duplication de document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 12:50:50	2022-02-07 12:50:50
4269	Tâche nouvellement créee du nom de Copie de certains champs lors d'une duplication de document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 12:50:50	2022-02-07 12:50:50
4158	Tâche "Vérification des sauvegardes sur les serveurs clients "\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	t	74	70	2022-02-07 08:52:26	2022-02-07 08:52:26
4018	Tâche "Description des familles publié sur le site"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-04 12:00:59	2022-02-04 12:00:59
4019	Tâche "Description des familles publié sur le site"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-04 12:00:59	2022-02-04 12:00:59
4020	Tâche "Description des familles publié sur le site"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-04 12:00:59	2022-02-04 12:00:59
4021	Tâche nouvellement créee du nom de Import photos des articles publié sur le site  par Mihaja dans le projet Site web QLM.	f	70	53	2022-02-04 12:03:00	2022-02-04 12:03:00
4022	Tâche nouvellement créee du nom de Import photos des articles publié sur le site  par Mihaja dans le projet Site web QLM.	f	70	57	2022-02-04 12:03:00	2022-02-04 12:03:00
4023	Tâche nouvellement créee du nom de Import photos des articles publié sur le site  par Mihaja dans le projet Site web QLM.	f	70	71	2022-02-04 12:03:00	2022-02-04 12:03:00
4033	Un projet du nom de Intervention / Accompagnement 2022 a été crée par Michel	f	71	53	2022-02-04 12:12:42	2022-02-04 12:12:42
4034	Un projet du nom de Intervention / Accompagnement 2022 a été crée par Michel	f	71	57	2022-02-04 12:12:42	2022-02-04 12:12:42
4035	Un projet du nom de Intervention / Accompagnement 2022 a été crée par Michel	f	71	70	2022-02-04 12:12:42	2022-02-04 12:12:42
3973	Mihaja vous a assigné à la tâche Description des familles publié sur le site dans le projet Site web QLM.	t	70	75	2022-02-03 09:48:08	2022-02-03 09:48:08
4160	Tâche nouvellement créee du nom de Amélioration de l'application par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	53	2022-02-07 08:53:36	2022-02-07 08:53:36
4161	Tâche nouvellement créee du nom de Amélioration de l'application par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	57	2022-02-07 08:53:36	2022-02-07 08:53:36
4163	Tâche nouvellement créee du nom de Amélioration de l'application par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	71	2022-02-07 08:53:36	2022-02-07 08:53:36
4253	Tâche nouvellement créee du nom de statu annulé => suppression du document achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 12:47:28	2022-02-07 12:47:28
4254	Tâche nouvellement créee du nom de statu annulé => suppression du document achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 12:47:28	2022-02-07 12:47:28
4256	Tâche nouvellement créee du nom de statu annulé => suppression du document achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 12:47:28	2022-02-07 12:47:28
4273	Tâche nouvellement créee du nom de Ajouter le numéro pnr dans la commande (nouveau champs) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 12:52:06	2022-02-07 12:52:06
4274	Tâche nouvellement créee du nom de Ajouter le numéro pnr dans la commande (nouveau champs) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 12:52:06	2022-02-07 12:52:06
4276	Tâche nouvellement créee du nom de Ajouter le numéro pnr dans la commande (nouveau champs) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 12:52:06	2022-02-07 12:52:06
4277	Rémi vous a assigné à la tâche Ajouter le numéro pnr dans la commande (nouveau champs) dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 12:52:06	2022-02-07 12:52:06
4283	Vous avez été assigné à la sous-tâche Création de la bande duplicata du projet SIGM - Gestion  Agence de Voyage sur Odoo 15	f	78	78	2022-02-07 12:53:56	2022-02-07 12:53:56
4284	Vous avez été assigné à la sous-tâche Ajouter un bouton d'impression de la facture et enlever le menu d'impression du projet SIGM - Gestion  Agence de Voyage sur Odoo 15	t	78	78	2022-02-07 12:54:50	2022-02-07 12:54:50
4162	Tâche nouvellement créee du nom de Amélioration de l'application par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	t	73	70	2022-02-07 08:53:36	2022-02-07 08:53:36
4255	Tâche nouvellement créee du nom de statu annulé => suppression du document achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 12:47:28	2022-02-07 12:47:28
4275	Tâche nouvellement créee du nom de Ajouter le numéro pnr dans la commande (nouveau champs) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 12:52:06	2022-02-07 12:52:06
5783	Vous avez été assigné à la sous-tâche Ajouter la compagnie/fournisseur dans l'avoir client du projet SIGM - Gestion  Agence de Voyage sur Odoo 15	f	78	78	2022-02-21 07:13:03	2022-02-21 07:13:03
6159	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-22 10:50:56	2022-02-22 10:50:56
6160	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-22 10:50:56	2022-02-22 10:50:56
6162	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-22 10:50:56	2022-02-22 10:50:56
6163	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-22 10:50:56	2022-02-22 10:50:56
6164	Tâche nouvellement créee du nom de Mettre à jour import article depuis hfsql par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-22 10:58:05	2022-02-22 10:58:05
6165	Tâche nouvellement créee du nom de Mettre à jour import article depuis hfsql par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-22 10:58:05	2022-02-22 10:58:05
6167	Tâche nouvellement créee du nom de Mettre à jour import article depuis hfsql par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-22 10:58:05	2022-02-22 10:58:05
6168	Tâche nouvellement créee du nom de Mettre à jour import article depuis hfsql par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-22 10:58:05	2022-02-22 10:58:05
6161	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-22 10:50:56	2022-02-22 10:50:56
6183	Tâche "Correction des conflits entre la version WP all import et Wordpress"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-22 11:23:49	2022-02-22 11:23:49
6184	Tâche "Correction des conflits entre la version WP all import et Wordpress"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-22 11:23:49	2022-02-22 11:23:49
3984	Mihaja vous a assigné à la tâche Programme pour rapport mails des sauvegarde réussie du jours  dans le projet Sauvegarde FTP des clients .	f	70	74	2022-02-03 09:52:01	2022-02-03 09:52:01
4024	Tâche nouvellement créee du nom de Correspondance des articles et familles sur le site par Mihaja dans le projet Site web QLM.	f	70	53	2022-02-04 12:05:33	2022-02-04 12:05:33
4025	Tâche nouvellement créee du nom de Correspondance des articles et familles sur le site par Mihaja dans le projet Site web QLM.	f	70	57	2022-02-04 12:05:33	2022-02-04 12:05:33
4026	Tâche nouvellement créee du nom de Correspondance des articles et familles sur le site par Mihaja dans le projet Site web QLM.	f	70	71	2022-02-04 12:05:33	2022-02-04 12:05:33
4164	Famenontsoa vous a assigné à la tâche Amélioration de l'application dans le projet SIGM - Application inter Amadeus et Odoo.	t	73	73	2022-02-07 08:53:36	2022-02-07 08:53:36
4257	Rémi vous a assigné à la tâche statu annulé => suppression du document achat dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 12:47:28	2022-02-07 12:47:28
4267	Rémi vous a assigné à la tâche Ajouter un champs autre info dans travel order dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 12:49:59	2022-02-07 12:49:59
4272	Rémi vous a assigné à la tâche Copie de certains champs lors d'une duplication de document travel order dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 12:50:50	2022-02-07 12:50:50
4312	Tâche nouvellement créee du nom de Ajouter un champs nombre (nombre x quantité joue le rôle de quantité) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 13:06:33	2022-02-07 13:06:33
4313	Tâche nouvellement créee du nom de Ajouter un champs nombre (nombre x quantité joue le rôle de quantité) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 13:06:33	2022-02-07 13:06:33
4315	Tâche nouvellement créee du nom de Ajouter un champs nombre (nombre x quantité joue le rôle de quantité) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 13:06:33	2022-02-07 13:06:33
4314	Tâche nouvellement créee du nom de Ajouter un champs nombre (nombre x quantité joue le rôle de quantité) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 13:06:33	2022-02-07 13:06:33
5784	Vous avez été assigné à la sous-tâche Créer l'avoir fournisseur quand on confirme l'avoir client du projet SIGM - Gestion  Agence de Voyage sur Odoo 15	f	78	78	2022-02-21 07:13:52	2022-02-21 07:13:52
6198	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-22 11:36:12	2022-02-22 11:36:12
6199	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-22 11:36:12	2022-02-22 11:36:12
6201	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-22 11:36:12	2022-02-22 11:36:12
6202	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-22 11:36:12	2022-02-22 11:36:12
6200	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-22 11:36:12	2022-02-22 11:36:12
6235	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	53	2022-02-22 12:02:40	2022-02-22 12:02:40
6236	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	57	2022-02-22 12:02:40	2022-02-22 12:02:40
6237	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	70	2022-02-22 12:02:40	2022-02-22 12:02:40
6238	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	71	2022-02-22 12:02:40	2022-02-22 12:02:40
6239	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	85	2022-02-22 12:02:40	2022-02-22 12:02:40
5857	Mihaja vous a assigné à la tâche Rajouter sur l'historique quand il y a un ajustement de stock dans le projet QLM Intervention / Accompagnement 2022.	t	70	81	2022-02-21 09:25:44	2022-02-21 09:25:44
6178	Mihaja vous a assigné à la tâche Correction erreurs sur le module Fabrication dans le projet QLM Intervention / Accompagnement 2022.	t	70	81	2022-02-22 11:19:33	2022-02-22 11:19:33
6545	Tâche nouvellement créee du nom de Déblocage d'un problème de création d'un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-24 12:53:05	2022-02-24 12:53:05
6614	Rémi vous a assigné à la tâche Enlever le champs référence dans doc de type to dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:16:04	2022-02-25 07:16:04
6615	Tâche nouvellement créee du nom de Déplacer la colonne fournisseur avant la colonne articles par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:16:51	2022-02-25 07:16:51
6616	Tâche nouvellement créee du nom de Déplacer la colonne fournisseur avant la colonne articles par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:16:51	2022-02-25 07:16:51
6618	Tâche nouvellement créee du nom de Déplacer la colonne fournisseur avant la colonne articles par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:16:51	2022-02-25 07:16:51
6617	Tâche nouvellement créee du nom de Déplacer la colonne fournisseur avant la colonne articles par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:16:51	2022-02-25 07:16:51
4047	Tâche "Salaire QLM, Codigaz, Codimat janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	f	71	53	2022-02-04 12:23:38	2022-02-04 12:23:38
4048	Tâche "Salaire QLM, Codigaz, Codimat janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	f	71	57	2022-02-04 12:23:38	2022-02-04 12:23:38
4049	Tâche "Salaire QLM, Codigaz, Codimat janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	f	71	70	2022-02-04 12:23:38	2022-02-04 12:23:38
4088	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-04 12:39:40	2022-02-04 12:39:40
4089	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-04 12:39:40	2022-02-04 12:39:40
4091	Tâche nouvellement créee du nom de Intégration stock PO25899 - Ingco par Michel dans le projet Intervention / Accompagnement 2022.	f	71	53	2022-02-04 12:42:07	2022-02-04 12:42:07
4092	Tâche nouvellement créee du nom de Intégration stock PO25899 - Ingco par Michel dans le projet Intervention / Accompagnement 2022.	f	71	57	2022-02-04 12:42:07	2022-02-04 12:42:07
4165	Tâche "Amélioration de l'application"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	53	2022-02-07 08:56:49	2022-02-07 08:56:49
4166	Tâche "Amélioration de l'application"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	57	2022-02-07 08:56:49	2022-02-07 08:56:49
4168	Tâche "Amélioration de l'application"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	71	2022-02-07 08:56:49	2022-02-07 08:56:49
4258	Tâche nouvellement créee du nom de Cacher le champs émission, sa valeur est toujour la même par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 12:49:12	2022-02-07 12:49:12
4259	Tâche nouvellement créee du nom de Cacher le champs émission, sa valeur est toujour la même par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 12:49:12	2022-02-07 12:49:12
4261	Tâche nouvellement créee du nom de Cacher le champs émission, sa valeur est toujour la même par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 12:49:12	2022-02-07 12:49:12
4278	Tâche nouvellement créee du nom de Mettre une bande duplicata après une première impression de la facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 12:53:26	2022-02-07 12:53:26
4279	Tâche nouvellement créee du nom de Mettre une bande duplicata après une première impression de la facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 12:53:26	2022-02-07 12:53:26
4281	Tâche nouvellement créee du nom de Mettre une bande duplicata après une première impression de la facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 12:53:26	2022-02-07 12:53:26
4307	Tâche nouvellement créee du nom de Ajouter numéro de dossier dans la commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 13:05:03	2022-02-07 13:05:03
4308	Tâche nouvellement créee du nom de Ajouter numéro de dossier dans la commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 13:05:03	2022-02-07 13:05:03
4310	Tâche nouvellement créee du nom de Ajouter numéro de dossier dans la commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 13:05:03	2022-02-07 13:05:03
4090	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-04 12:39:40	2022-02-04 12:39:40
4093	Tâche nouvellement créee du nom de Intégration stock PO25899 - Ingco par Michel dans le projet Intervention / Accompagnement 2022.	t	71	70	2022-02-04 12:42:07	2022-02-04 12:42:07
4167	Tâche "Amélioration de l'application"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	t	73	70	2022-02-07 08:56:49	2022-02-07 08:56:49
4260	Tâche nouvellement créee du nom de Cacher le champs émission, sa valeur est toujour la même par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 12:49:12	2022-02-07 12:49:12
4280	Tâche nouvellement créee du nom de Mettre une bande duplicata après une première impression de la facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 12:53:26	2022-02-07 12:53:26
4309	Tâche nouvellement créee du nom de Ajouter numéro de dossier dans la commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 13:05:03	2022-02-07 13:05:03
5785	Tâche "RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	53	2022-02-21 07:17:25	2022-02-21 07:17:25
5786	Tâche "RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	57	2022-02-21 07:17:25	2022-02-21 07:17:25
5788	Tâche "RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	71	2022-02-21 07:17:25	2022-02-21 07:17:25
5787	Tâche "RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	t	76	70	2022-02-21 07:17:25	2022-02-21 07:17:25
4050	Tâche nouvellement créee du nom de Alert audio quand chèque arrivé à échéance par Mihaja dans le projet Intervention / Accompagnement 2022.	f	70	53	2022-02-04 12:23:41	2022-02-04 12:23:41
4051	Tâche nouvellement créee du nom de Alert audio quand chèque arrivé à échéance par Mihaja dans le projet Intervention / Accompagnement 2022.	f	70	57	2022-02-04 12:23:41	2022-02-04 12:23:41
4052	Tâche nouvellement créee du nom de Alert audio quand chèque arrivé à échéance par Mihaja dans le projet Intervention / Accompagnement 2022.	f	70	71	2022-02-04 12:23:41	2022-02-04 12:23:41
4169	Tâche nouvellement créee du nom de Modification de la page d'accueil par Fanantenana dans le projet Site web QLM.	f	75	53	2022-02-07 09:12:21	2022-02-07 09:12:21
4170	Tâche nouvellement créee du nom de Modification de la page d'accueil par Fanantenana dans le projet Site web QLM.	f	75	57	2022-02-07 09:12:21	2022-02-07 09:12:21
4172	Tâche nouvellement créee du nom de Modification de la page d'accueil par Fanantenana dans le projet Site web QLM.	f	75	71	2022-02-07 09:12:21	2022-02-07 09:12:21
4271	Tâche nouvellement créee du nom de Copie de certains champs lors d'une duplication de document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 12:50:50	2022-02-07 12:50:50
4171	Tâche nouvellement créee du nom de Modification de la page d'accueil par Fanantenana dans le projet Site web QLM.	t	75	70	2022-02-07 09:12:21	2022-02-07 09:12:21
5789	Tâche "RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	85	2022-02-21 07:17:25	2022-02-21 07:17:25
6185	Tâche "Correction des conflits entre la version WP all import et Wordpress"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-22 11:23:49	2022-02-22 11:23:49
6186	Tâche "Correction des conflits entre la version WP all import et Wordpress"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-22 11:23:49	2022-02-22 11:23:49
6244	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	53	2022-02-22 12:19:59	2022-02-22 12:19:59
6245	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	57	2022-02-22 12:19:59	2022-02-22 12:19:59
6246	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	70	2022-02-22 12:19:59	2022-02-22 12:19:59
6247	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	71	2022-02-22 12:19:59	2022-02-22 12:19:59
6248	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	85	2022-02-22 12:19:59	2022-02-22 12:19:59
6208	Elie vous a assigné à la tâche Intégration de stock du PO26335 et PO26713 dans le projet QLM Intervention / Accompagnement 2022.	t	77	77	2022-02-22 11:37:35	2022-02-22 11:37:35
6551	La tâche Déblocage d'un problème de création d'un BL a été achevée.	f	76	85	2022-02-24 12:53:33	2022-02-24 12:53:33
6603	Tâche nouvellement créee du nom de Synchronisation des clients odoo avec ceux dans Incadea par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:15:13	2022-02-25 07:15:13
6604	Tâche nouvellement créee du nom de Synchronisation des clients odoo avec ceux dans Incadea par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:15:13	2022-02-25 07:15:13
6606	Tâche nouvellement créee du nom de Synchronisation des clients odoo avec ceux dans Incadea par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:15:13	2022-02-25 07:15:13
6607	Tâche nouvellement créee du nom de Synchronisation des clients odoo avec ceux dans Incadea par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:15:13	2022-02-25 07:15:13
6620	Rémi vous a assigné à la tâche Déplacer la colonne fournisseur avant la colonne articles dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:16:51	2022-02-25 07:16:51
6621	Tâche "Enlever le champs référence dans doc de type to"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	53	2022-02-25 07:16:58	2022-02-25 07:16:58
6622	Tâche "Enlever le champs référence dans doc de type to"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	57	2022-02-25 07:16:58	2022-02-25 07:16:58
6624	Tâche "Enlever le champs référence dans doc de type to"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	71	2022-02-25 07:16:58	2022-02-25 07:16:58
6625	Tâche "Enlever le champs référence dans doc de type to"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	85	2022-02-25 07:16:58	2022-02-25 07:16:58
6636	Rémi vous a assigné à la tâche Filtrer les articles selon le fournisseur selectionné dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:19:56	2022-02-25 07:19:56
6640	Tâche nouvellement créee du nom de Renommer "Quantité" en "Nombre de chambres/personnes" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:20:53	2022-02-25 07:20:53
6641	Tâche nouvellement créee du nom de Renommer "Quantité" en "Nombre de chambres/personnes" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:20:53	2022-02-25 07:20:53
6642	Rémi vous a assigné à la tâche Renommer "Quantité" en "Nombre de chambres/personnes" dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:20:53	2022-02-25 07:20:53
6663	Tâche nouvellement créee du nom de Prendre en compte "Nombre" dans le calcul du prix total et du total HT par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:23:38	2022-02-25 07:23:38
6664	Rémi vous a assigné à la tâche Prendre en compte "Nombre" dans le calcul du prix total et du total HT dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:23:38	2022-02-25 07:23:38
4053	Mihaja vous a assigné à la tâche Alert audio quand chèque arrivé à échéance dans le projet Intervention / Accompagnement 2022.	f	70	78	2022-02-04 12:23:41	2022-02-04 12:23:41
4054	Tâche "Salaire QLM, Codigaz, Codimat janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " A faire " par Michel	f	71	53	2022-02-04 12:23:41	2022-02-04 12:23:41
4055	Tâche "Salaire QLM, Codigaz, Codimat janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " A faire " par Michel	f	71	57	2022-02-04 12:23:41	2022-02-04 12:23:41
4056	Tâche "Salaire QLM, Codigaz, Codimat janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " A faire " par Michel	f	71	70	2022-02-04 12:23:41	2022-02-04 12:23:41
4085	Tâche "Solde de congé 2021"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-04 12:39:32	2022-02-04 12:39:32
4086	Tâche "Solde de congé 2021"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-04 12:39:32	2022-02-04 12:39:32
4098	Tâche "Intégration stock PO26294 - Francelec"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-04 12:43:08	2022-02-04 12:43:08
4099	Tâche "Intégration stock PO26294 - Francelec"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-04 12:43:08	2022-02-04 12:43:08
4101	Tâche "Intégration stock PO26294 - Francelec"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-04 12:43:08	2022-02-04 12:43:08
4106	Tâche "Intégration stock PO25899 - Ingco"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-04 12:44:23	2022-02-04 12:44:23
4107	Tâche "Intégration stock PO25899 - Ingco"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-04 12:44:23	2022-02-04 12:44:23
4100	Tâche "Intégration stock PO26294 - Francelec"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-04 12:43:08	2022-02-04 12:43:08
4108	Tâche "Intégration stock PO25899 - Ingco"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-04 12:44:23	2022-02-04 12:44:23
4174	Tâche nouvellement créee du nom de Description technique des familles  par Nasolo dans le projet Site web QLM.	f	72	53	2022-02-07 09:12:21	2022-02-07 09:12:21
4175	Tâche nouvellement créee du nom de Description technique des familles  par Nasolo dans le projet Site web QLM.	f	72	57	2022-02-07 09:12:21	2022-02-07 09:12:21
4177	Tâche nouvellement créee du nom de Description technique des familles  par Nasolo dans le projet Site web QLM.	f	72	71	2022-02-07 09:12:21	2022-02-07 09:12:21
4282	Rémi vous a assigné à la tâche Mettre une bande duplicata après une première impression de la facture dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 12:53:26	2022-02-07 12:53:26
4291	Tâche nouvellement créee du nom de Définir le libellé des lignes 401 fournisseurs et 411 clients de l'écriture comptables (valeur: libellé global de la commande) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 12:58:27	2022-02-07 12:58:27
4292	Tâche nouvellement créee du nom de Définir le libellé des lignes 401 fournisseurs et 411 clients de l'écriture comptables (valeur: libellé global de la commande) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 12:58:27	2022-02-07 12:58:27
4294	Tâche nouvellement créee du nom de Définir le libellé des lignes 401 fournisseurs et 411 clients de l'écriture comptables (valeur: libellé global de la commande) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 12:58:27	2022-02-07 12:58:27
4305	Rémi vous a assigné à la tâche Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	78	2022-02-07 13:01:28	2022-02-07 13:01:28
4173	Fanantenana vous a assigné à la tâche Modification de la page d'accueil dans le projet Site web QLM.	t	75	75	2022-02-07 09:12:21	2022-02-07 09:12:21
4087	Tâche "Solde de congé 2021"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-04 12:39:32	2022-02-04 12:39:32
4176	Tâche nouvellement créee du nom de Description technique des familles  par Nasolo dans le projet Site web QLM.	t	72	70	2022-02-07 09:12:21	2022-02-07 09:12:21
4293	Tâche nouvellement créee du nom de Définir le libellé des lignes 401 fournisseurs et 411 clients de l'écriture comptables (valeur: libellé global de la commande) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 12:58:27	2022-02-07 12:58:27
5795	Tâche "Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	53	2022-02-21 08:39:12	2022-02-21 08:39:12
5796	Tâche "Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	57	2022-02-21 08:39:12	2022-02-21 08:39:12
5797	Tâche "Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	t	78	70	2022-02-21 08:39:12	2022-02-21 08:39:12
4057	Tâche "Solde de congé 2021"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-04 12:24:13	2022-02-04 12:24:13
4058	Tâche "Solde de congé 2021"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-04 12:24:13	2022-02-04 12:24:13
4059	Tâche "Solde de congé 2021"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	70	2022-02-04 12:24:13	2022-02-04 12:24:13
4060	Tâche "Solde de congé 2021"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-04 12:24:13	2022-02-04 12:24:13
4178	Nasolo vous a assigné à la tâche Description technique des familles  dans le projet Site web QLM.	t	72	72	2022-02-07 09:12:21	2022-02-07 09:12:21
4286	Tâche nouvellement créee du nom de Changement de libellé: Usager => Passager, Partenaire => Client par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 12:56:38	2022-02-07 12:56:38
4287	Tâche nouvellement créee du nom de Changement de libellé: Usager => Passager, Partenaire => Client par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 12:56:38	2022-02-07 12:56:38
4289	Tâche nouvellement créee du nom de Changement de libellé: Usager => Passager, Partenaire => Client par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 12:56:38	2022-02-07 12:56:38
4301	Tâche nouvellement créee du nom de Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 13:01:28	2022-02-07 13:01:28
4302	Tâche nouvellement créee du nom de Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 13:01:28	2022-02-07 13:01:28
4304	Tâche nouvellement créee du nom de Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 13:01:28	2022-02-07 13:01:28
4316	Rémi vous a assigné à la tâche Ajouter un champs nombre (nombre x quantité joue le rôle de quantité) dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	78	2022-02-07 13:06:33	2022-02-07 13:06:33
4288	Tâche nouvellement créee du nom de Changement de libellé: Usager => Passager, Partenaire => Client par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 12:56:38	2022-02-07 12:56:38
4303	Tâche nouvellement créee du nom de Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 13:01:28	2022-02-07 13:01:28
5798	Tâche "Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	71	2022-02-21 08:39:12	2022-02-21 08:39:12
5799	Tâche "Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	85	2022-02-21 08:39:12	2022-02-21 08:39:12
6240	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-22 12:13:24	2022-02-22 12:13:24
6241	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-22 12:13:24	2022-02-22 12:13:24
6242	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-22 12:13:24	2022-02-22 12:13:24
6243	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-22 12:13:24	2022-02-22 12:13:24
6254	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	53	2022-02-22 12:33:03	2022-02-22 12:33:03
6255	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	57	2022-02-22 12:33:03	2022-02-22 12:33:03
6256	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	70	2022-02-22 12:33:03	2022-02-22 12:33:03
6257	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	71	2022-02-22 12:33:03	2022-02-22 12:33:03
6258	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	85	2022-02-22 12:33:03	2022-02-22 12:33:03
6274	La tâche Modèle d'impression BON DE TRANSFERT a été achevée.	f	76	53	2022-02-22 12:37:21	2022-02-22 12:37:21
6275	La tâche Modèle d'impression BON DE TRANSFERT a été achevée.	f	76	57	2022-02-22 12:37:21	2022-02-22 12:37:21
6276	La tâche Modèle d'impression BON DE TRANSFERT a été achevée.	f	76	70	2022-02-22 12:37:21	2022-02-22 12:37:21
6277	La tâche Modèle d'impression BON DE TRANSFERT a été achevée.	f	76	71	2022-02-22 12:37:21	2022-02-22 12:37:21
6278	La tâche Modèle d'impression BON DE TRANSFERT a été achevée.	f	76	85	2022-02-22 12:37:21	2022-02-22 12:37:21
6294	La tâche Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT a été achevée.	f	76	53	2022-02-22 12:38:01	2022-02-22 12:38:01
6295	La tâche Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT a été achevée.	f	76	57	2022-02-22 12:38:01	2022-02-22 12:38:01
6296	La tâche Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT a été achevée.	f	76	70	2022-02-22 12:38:01	2022-02-22 12:38:01
6297	La tâche Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT a été achevée.	f	76	71	2022-02-22 12:38:01	2022-02-22 12:38:01
6298	La tâche Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT a été achevée.	f	76	85	2022-02-22 12:38:01	2022-02-22 12:38:01
6314	La tâche Création nouvel utilisateur Odoo a été achevée.	f	77	53	2022-02-22 13:11:04	2022-02-22 13:11:04
6315	La tâche Création nouvel utilisateur Odoo a été achevée.	f	77	57	2022-02-22 13:11:04	2022-02-22 13:11:04
6316	La tâche Création nouvel utilisateur Odoo a été achevée.	f	77	70	2022-02-22 13:11:04	2022-02-22 13:11:04
4061	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-04 12:24:24	2022-02-04 12:24:24
4062	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-04 12:24:24	2022-02-04 12:24:24
4063	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	70	2022-02-04 12:24:24	2022-02-04 12:24:24
4064	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-04 12:24:24	2022-02-04 12:24:24
4065	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-04 12:26:05	2022-02-04 12:26:05
4066	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-04 12:26:05	2022-02-04 12:26:05
4067	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	70	2022-02-04 12:26:05	2022-02-04 12:26:05
4068	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-04 12:26:05	2022-02-04 12:26:05
4078	Tâche "Salaire QLM, Codigaz, Codimat janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-04 12:26:23	2022-02-04 12:26:23
4079	Tâche "Salaire QLM, Codigaz, Codimat janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-04 12:26:23	2022-02-04 12:26:23
4081	Tâche "Salaire QLM, Codigaz, Codimat janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-04 12:26:23	2022-02-04 12:26:23
4073	Michel vous a assigné à la tâche Salaire QLM, Codigaz, Codimat janvier 2022.	t	71	77	2022-02-04 12:26:11	2022-02-04 12:26:11
4179	Tâche "Modification de la page d'accueil"\n          du projet Site web QLM mise dans " En cours " par Fanantenana	f	75	53	2022-02-07 09:13:21	2022-02-07 09:13:21
4180	Tâche "Modification de la page d'accueil"\n          du projet Site web QLM mise dans " En cours " par Fanantenana	f	75	57	2022-02-07 09:13:21	2022-02-07 09:13:21
4182	Tâche "Modification de la page d'accueil"\n          du projet Site web QLM mise dans " En cours " par Fanantenana	f	75	71	2022-02-07 09:13:21	2022-02-07 09:13:21
4198	Tâche nouvellement créee du nom de module de notification windows lors d'un nouveau message odoo par Nasolo dans le projet Site web QLM.	f	72	53	2022-02-07 10:36:49	2022-02-07 10:36:49
4199	Tâche nouvellement créee du nom de module de notification windows lors d'un nouveau message odoo par Nasolo dans le projet Site web QLM.	f	72	57	2022-02-07 10:36:49	2022-02-07 10:36:49
4201	Tâche nouvellement créee du nom de module de notification windows lors d'un nouveau message odoo par Nasolo dans le projet Site web QLM.	f	72	71	2022-02-07 10:36:49	2022-02-07 10:36:49
4222	Tâche nouvellement créee du nom de Document travel order doit être non modifiable à partir de 'accepté' par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 10:52:35	2022-02-07 10:52:35
4223	Tâche nouvellement créee du nom de Document travel order doit être non modifiable à partir de 'accepté' par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 10:52:35	2022-02-07 10:52:35
4225	Tâche nouvellement créee du nom de Document travel order doit être non modifiable à partir de 'accepté' par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 10:52:35	2022-02-07 10:52:35
4237	Tâche nouvellement créee du nom de Gestion des clients en compte et client de passage par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 10:56:48	2022-02-07 10:56:48
4238	Tâche nouvellement créee du nom de Gestion des clients en compte et client de passage par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 10:56:48	2022-02-07 10:56:48
4240	Tâche nouvellement créee du nom de Gestion des clients en compte et client de passage par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 10:56:48	2022-02-07 10:56:48
4241	Rémi vous a assigné à la tâche Gestion des clients en compte et client de passage dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 10:56:48	2022-02-07 10:56:48
4317	Tâche nouvellement créee du nom de Ajouter un champs pour le numéro de jour par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 13:06:59	2022-02-07 13:06:59
4318	Tâche nouvellement créee du nom de Ajouter un champs pour le numéro de jour par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 13:06:59	2022-02-07 13:06:59
4320	Tâche nouvellement créee du nom de Ajouter un champs pour le numéro de jour par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 13:06:59	2022-02-07 13:06:59
4080	Tâche "Salaire QLM, Codigaz, Codimat janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-04 12:26:23	2022-02-04 12:26:23
4181	Tâche "Modification de la page d'accueil"\n          du projet Site web QLM mise dans " En cours " par Fanantenana	t	75	70	2022-02-07 09:13:21	2022-02-07 09:13:21
4200	Tâche nouvellement créee du nom de module de notification windows lors d'un nouveau message odoo par Nasolo dans le projet Site web QLM.	t	72	70	2022-02-07 10:36:49	2022-02-07 10:36:49
5800	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 09:11:49	2022-02-21 09:11:49
5801	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 09:11:49	2022-02-21 09:11:49
5802	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 09:11:49	2022-02-21 09:11:49
5803	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 09:11:49	2022-02-21 09:11:49
6252	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	71	2022-02-22 12:32:59	2022-02-22 12:32:59
6694	La tâche Repertorier les ecritures non rapprochées - BMOI Chainmalt a été achevée.	f	79	53	2022-02-25 07:53:44	2022-02-25 07:53:44
4069	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " A faire " par Elie	f	77	53	2022-02-04 12:26:05	2022-02-04 12:26:05
4070	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " A faire " par Elie	f	77	57	2022-02-04 12:26:05	2022-02-04 12:26:05
4071	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " A faire " par Elie	f	77	70	2022-02-04 12:26:05	2022-02-04 12:26:05
4072	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " A faire " par Elie	f	77	71	2022-02-04 12:26:05	2022-02-04 12:26:05
4074	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-04 12:26:18	2022-02-04 12:26:18
4075	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-04 12:26:18	2022-02-04 12:26:18
4076	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	70	2022-02-04 12:26:18	2022-02-04 12:26:18
4077	Tâche "Salaire Cheinmalt janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-04 12:26:18	2022-02-04 12:26:18
4082	Tâche "Salaire QLM, Codigaz, Codimat janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-04 12:39:23	2022-02-04 12:39:23
4083	Tâche "Salaire QLM, Codigaz, Codimat janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-04 12:39:23	2022-02-04 12:39:23
4183	Tâche "Description technique des familles "\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	53	2022-02-07 09:14:18	2022-02-07 09:14:18
4184	Tâche "Description technique des familles "\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	57	2022-02-07 09:14:18	2022-02-07 09:14:18
4186	Tâche "Description technique des familles "\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	71	2022-02-07 09:14:18	2022-02-07 09:14:18
4190	Tâche nouvellement créee du nom de Rajouter un statut Accepté pour les devis par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	53	2022-02-07 09:17:00	2022-02-07 09:17:00
4191	Tâche nouvellement créee du nom de Rajouter un statut Accepté pour les devis par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	57	2022-02-07 09:17:00	2022-02-07 09:17:00
4192	Tâche nouvellement créee du nom de Rajouter un statut Accepté pour les devis par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	71	2022-02-07 09:17:00	2022-02-07 09:17:00
4212	Tâche nouvellement créee du nom de Ajout de colonne comptes auxiliaires dans les écritures comptables par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 10:47:37	2022-02-07 10:47:37
4213	Tâche nouvellement créee du nom de Ajout de colonne comptes auxiliaires dans les écritures comptables par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 10:47:37	2022-02-07 10:47:37
4215	Tâche nouvellement créee du nom de Ajout de colonne comptes auxiliaires dans les écritures comptables par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 10:47:37	2022-02-07 10:47:37
4217	Tâche nouvellement créee du nom de Afficher les autres taxes dans les documents factures et achats par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 10:51:20	2022-02-07 10:51:20
4218	Tâche nouvellement créee du nom de Afficher les autres taxes dans les documents factures et achats par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 10:51:20	2022-02-07 10:51:20
4220	Tâche nouvellement créee du nom de Afficher les autres taxes dans les documents factures et achats par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 10:51:20	2022-02-07 10:51:20
4306	Vous avez été assigné à la sous-tâche Ajouter les champs active product et active supplier pour filtrer les articles et les fournisseurs du projet SIGM - Gestion  Agence de Voyage sur Odoo 15	t	78	78	2022-02-07 13:02:41	2022-02-07 13:02:41
4362	Tâche "Gestion des droits de validations de devis"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 08:57:46	2022-02-08 08:57:46
4363	Tâche "Gestion des droits de validations de devis"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 08:57:46	2022-02-08 08:57:46
4365	Tâche "Gestion des droits de validations de devis"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 08:57:46	2022-02-08 08:57:46
4402	Tâche "Changement de libellé: Usager => Passager, Partenaire => Client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 09:00:56	2022-02-08 09:00:56
4403	Tâche "Changement de libellé: Usager => Passager, Partenaire => Client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 09:00:56	2022-02-08 09:00:56
4084	Tâche "Salaire QLM, Codigaz, Codimat janvier 2022"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-04 12:39:23	2022-02-04 12:39:23
4185	Tâche "Description technique des familles "\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	t	72	70	2022-02-07 09:14:18	2022-02-07 09:14:18
5804	Tâche Envoyer fichier dans l'FTP du Site COMPUTEK archivée par Mihaja.	f	70	53	2022-02-21 09:12:52	2022-02-21 09:12:52
5805	Tâche Envoyer fichier dans l'FTP du Site COMPUTEK archivée par Mihaja.	f	70	57	2022-02-21 09:12:52	2022-02-21 09:12:52
5806	Tâche Envoyer fichier dans l'FTP du Site COMPUTEK archivée par Mihaja.	f	70	71	2022-02-21 09:12:52	2022-02-21 09:12:52
5807	Tâche Envoyer fichier dans l'FTP du Site COMPUTEK archivée par Mihaja.	f	70	85	2022-02-21 09:12:52	2022-02-21 09:12:52
6695	La tâche Repertorier les ecritures non rapprochées - BMOI Chainmalt a été achevée.	f	79	57	2022-02-25 07:53:44	2022-02-25 07:53:44
6697	La tâche Repertorier les ecritures non rapprochées - BMOI Chainmalt a été achevée.	f	79	71	2022-02-25 07:53:44	2022-02-25 07:53:44
6698	La tâche Repertorier les ecritures non rapprochées - BMOI Chainmalt a été achevée.	f	79	85	2022-02-25 07:53:44	2022-02-25 07:53:44
6747	La tâche Intégration stock dépôt 2 du 24/02/2022 a été achevée.	f	77	53	2022-02-25 13:19:06	2022-02-25 13:19:06
4094	Tâche nouvellement créee du nom de Intégration stock PO26294 - Francelec par Michel dans le projet Intervention / Accompagnement 2022.	f	71	53	2022-02-04 12:42:51	2022-02-04 12:42:51
4095	Tâche nouvellement créee du nom de Intégration stock PO26294 - Francelec par Michel dans le projet Intervention / Accompagnement 2022.	f	71	57	2022-02-04 12:42:51	2022-02-04 12:42:51
4102	Michel vous a assigné à la tâche Intégration stock PO25899 - Ingco.	t	71	77	2022-02-04 12:43:10	2022-02-04 12:43:10
4187	Un projet du nom de SIGM - Gestion  Agence de Voyage sur Odoo 15 a été crée par Mihaja	f	70	53	2022-02-07 09:15:56	2022-02-07 09:15:56
4188	Un projet du nom de SIGM - Gestion  Agence de Voyage sur Odoo 15 a été crée par Mihaja	f	70	57	2022-02-07 09:15:56	2022-02-07 09:15:56
4189	Un projet du nom de SIGM - Gestion  Agence de Voyage sur Odoo 15 a été crée par Mihaja	f	70	71	2022-02-07 09:15:56	2022-02-07 09:15:56
4231	Rémi vous a assigné à la tâche Afficher les fournisseurs dans la facture client dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 10:54:06	2022-02-07 10:54:06
4311	Rémi vous a assigné à la tâche Ajouter numéro de dossier dans la commande dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	78	2022-02-07 13:05:03	2022-02-07 13:05:03
4321	Rémi vous a assigné à la tâche Ajouter un champs pour le numéro de jour dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	78	2022-02-07 13:06:59	2022-02-07 13:06:59
4366	Tâche "Gestion des clients en compte et client de passage"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 08:57:56	2022-02-08 08:57:56
4367	Tâche "Gestion des clients en compte et client de passage"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 08:57:56	2022-02-08 08:57:56
4369	Tâche "Gestion des clients en compte et client de passage"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 08:57:56	2022-02-08 08:57:56
4405	Tâche "Changement de libellé: Usager => Passager, Partenaire => Client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 09:00:56	2022-02-08 09:00:56
4422	Tâche "Ajouter un champs pour le numéro de jour"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 09:01:47	2022-02-08 09:01:47
4423	Tâche "Ajouter un champs pour le numéro de jour"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 09:01:47	2022-02-08 09:01:47
4425	Tâche "Ajouter un champs pour le numéro de jour"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 09:01:47	2022-02-08 09:01:47
4472	Tâche "Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 09:24:33	2022-02-08 09:24:33
4473	Tâche "Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 09:24:33	2022-02-08 09:24:33
4474	Tâche "Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 09:24:33	2022-02-08 09:24:33
4096	Tâche nouvellement créee du nom de Intégration stock PO26294 - Francelec par Michel dans le projet Intervention / Accompagnement 2022.	t	71	70	2022-02-04 12:42:51	2022-02-04 12:42:51
4368	Tâche "Gestion des clients en compte et client de passage"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 08:57:56	2022-02-08 08:57:56
4424	Tâche "Ajouter un champs pour le numéro de jour"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 09:01:47	2022-02-08 09:01:47
5809	Tâche "Mise en place du site et intégration de 'wp all import'"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 09:15:46	2022-02-21 09:15:46
5810	Tâche "Mise en place du site et intégration de 'wp all import'"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 09:15:46	2022-02-21 09:15:46
5811	Tâche "Mise en place du site et intégration de 'wp all import'"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 09:15:46	2022-02-21 09:15:46
5812	Tâche "Mise en place du site et intégration de 'wp all import'"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 09:15:46	2022-02-21 09:15:46
5808	Mihaja vous a assigné à la tâche création d'import produit et catégories, et correspondance des champs d'import sur le site.	t	70	75	2022-02-21 09:14:58	2022-02-21 09:14:58
6253	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	85	2022-02-22 12:32:59	2022-02-22 12:32:59
6289	La tâche Vérification des articles avec doublons a été achevée.	f	76	53	2022-02-22 12:37:38	2022-02-22 12:37:38
6290	La tâche Vérification des articles avec doublons a été achevée.	f	76	57	2022-02-22 12:37:38	2022-02-22 12:37:38
6291	La tâche Vérification des articles avec doublons a été achevée.	f	76	70	2022-02-22 12:37:38	2022-02-22 12:37:38
6292	La tâche Vérification des articles avec doublons a été achevée.	f	76	71	2022-02-22 12:37:38	2022-02-22 12:37:38
6293	La tâche Vérification des articles avec doublons a été achevée.	f	76	85	2022-02-22 12:37:38	2022-02-22 12:37:38
6334	La tâche Intégration de stock du PO26496 dépôt 3 a été achevée.	f	77	53	2022-02-22 13:12:09	2022-02-22 13:12:09
6335	La tâche Intégration de stock du PO26496 dépôt 3 a été achevée.	f	77	57	2022-02-22 13:12:09	2022-02-22 13:12:09
6336	La tâche Intégration de stock du PO26496 dépôt 3 a été achevée.	f	77	70	2022-02-22 13:12:09	2022-02-22 13:12:09
6337	La tâche Intégration de stock du PO26496 dépôt 3 a été achevée.	f	77	71	2022-02-22 13:12:09	2022-02-22 13:12:09
6338	La tâche Intégration de stock du PO26496 dépôt 3 a été achevée.	f	77	85	2022-02-22 13:12:09	2022-02-22 13:12:09
6552	Tâche nouvellement créee du nom de Suppression des bases SQL EBP par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-24 12:55:09	2022-02-24 12:55:09
6553	Tâche nouvellement créee du nom de Suppression des bases SQL EBP par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-24 12:55:09	2022-02-24 12:55:09
4097	Michel vous a assigné à la tâche Intégration stock PO26294 - Francelec dans le projet Intervention / Accompagnement 2022.	t	71	77	2022-02-04 12:42:51	2022-02-04 12:42:51
4193	Mihaja vous a assigné à la tâche Rajouter un statut Accepté pour les devis dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	78	2022-02-07 09:17:00	2022-02-07 09:17:00
4322	Tâche nouvellement créee du nom de Ne pas afficher les détails des lignes dans l'impression (facture, devis, commande, pro forma) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 13:08:38	2022-02-07 13:08:38
4323	Tâche nouvellement créee du nom de Ne pas afficher les détails des lignes dans l'impression (facture, devis, commande, pro forma) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 13:08:38	2022-02-07 13:08:38
4325	Tâche nouvellement créee du nom de Ne pas afficher les détails des lignes dans l'impression (facture, devis, commande, pro forma) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 13:08:38	2022-02-07 13:08:38
4370	Tâche "statut confirmé => génération de factures clients et fournisseurs"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 08:58:04	2022-02-08 08:58:04
4371	Tâche "statut confirmé => génération de factures clients et fournisseurs"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 08:58:04	2022-02-08 08:58:04
4373	Tâche "statut confirmé => génération de factures clients et fournisseurs"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 08:58:04	2022-02-08 08:58:04
4378	Tâche "statu annulé => suppression du document achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 08:58:18	2022-02-08 08:58:18
4379	Tâche "statu annulé => suppression du document achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 08:58:18	2022-02-08 08:58:18
4381	Tâche "statu annulé => suppression du document achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 08:58:18	2022-02-08 08:58:18
4386	Tâche "Ajouter un champs autre info dans travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 08:58:45	2022-02-08 08:58:45
4387	Tâche "Ajouter un champs autre info dans travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 08:58:45	2022-02-08 08:58:45
4389	Tâche "Ajouter un champs autre info dans travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 08:58:45	2022-02-08 08:58:45
4406	Tâche "Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 09:01:16	2022-02-08 09:01:16
4407	Tâche "Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 09:01:16	2022-02-08 09:01:16
4409	Tâche "Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 09:01:16	2022-02-08 09:01:16
4430	Tâche "Type du chams libellé global: Char => Text"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 09:02:15	2022-02-08 09:02:15
4431	Tâche "Type du chams libellé global: Char => Text"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 09:02:15	2022-02-08 09:02:15
4433	Tâche "Type du chams libellé global: Char => Text"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 09:02:15	2022-02-08 09:02:15
4490	Vous avez été assigné à la sous-tâche Gestion des threads du projet SIGM - Application inter Amadeus et Odoo	t	73	73	2022-02-08 10:05:08	2022-02-08 10:05:08
4495	Elie vous a assigné à la tâche Photos INGCO dans le projet Intervention / Accompagnement 2022.	t	77	77	2022-02-08 10:42:12	2022-02-08 10:42:12
4324	Tâche nouvellement créee du nom de Ne pas afficher les détails des lignes dans l'impression (facture, devis, commande, pro forma) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 13:08:38	2022-02-07 13:08:38
4372	Tâche "statut confirmé => génération de factures clients et fournisseurs"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 08:58:04	2022-02-08 08:58:04
4380	Tâche "statu annulé => suppression du document achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 08:58:18	2022-02-08 08:58:18
4388	Tâche "Ajouter un champs autre info dans travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 08:58:45	2022-02-08 08:58:45
5813	Tâche nouvellement créee du nom de Vérification des articles avec doublons par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-21 09:17:41	2022-02-21 09:17:41
5814	Tâche nouvellement créee du nom de Vérification des articles avec doublons par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-21 09:17:41	2022-02-21 09:17:41
5816	Tâche nouvellement créee du nom de Vérification des articles avec doublons par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-21 09:17:41	2022-02-21 09:17:41
5817	Tâche nouvellement créee du nom de Vérification des articles avec doublons par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-21 09:17:41	2022-02-21 09:17:41
5896	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	53	2022-02-21 09:39:01	2022-02-21 09:39:01
5897	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	57	2022-02-21 09:39:01	2022-02-21 09:39:01
7821	La tâche Contre-inventaire Computek TANA,  a été achevée.	f	76	57	2022-03-07 13:49:43	2022-03-07 13:49:43
7822	La tâche Contre-inventaire Computek TANA,  a été achevée.	f	76	70	2022-03-07 13:49:43	2022-03-07 13:49:43
4103	Tâche "Intégration stock PO26294 - Francelec"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-04 12:44:14	2022-02-04 12:44:14
4104	Tâche "Intégration stock PO26294 - Francelec"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-04 12:44:14	2022-02-04 12:44:14
4105	Tâche "Intégration stock PO26294 - Francelec"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-04 12:44:14	2022-02-04 12:44:14
4194	La tâche Rajouter un statut Accepté pour les devis a été achevée.	f	78	53	2022-02-07 10:34:49	2022-02-07 10:34:49
4195	La tâche Rajouter un statut Accepté pour les devis a été achevée.	f	78	57	2022-02-07 10:34:49	2022-02-07 10:34:49
4197	La tâche Rajouter un statut Accepté pour les devis a été achevée.	f	78	71	2022-02-07 10:34:49	2022-02-07 10:34:49
4326	Rémi vous a assigné à la tâche Ne pas afficher les détails des lignes dans l'impression (facture, devis, commande, pro forma) dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	78	2022-02-07 13:08:38	2022-02-07 13:08:38
4332	Tâche "Ajout de colonne comptes auxiliaires dans les écritures comptables"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-07 13:22:24	2022-02-07 13:22:24
4333	Tâche "Ajout de colonne comptes auxiliaires dans les écritures comptables"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-07 13:22:24	2022-02-07 13:22:24
4335	Tâche "Ajout de colonne comptes auxiliaires dans les écritures comptables"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-07 13:22:24	2022-02-07 13:22:24
4348	Tâche nouvellement créee du nom de module notification odoo par Nasolo dans le projet Site web QLM.	f	72	53	2022-02-07 13:35:15	2022-02-07 13:35:15
4349	Tâche nouvellement créee du nom de module notification odoo par Nasolo dans le projet Site web QLM.	f	72	57	2022-02-07 13:35:15	2022-02-07 13:35:15
4351	Tâche nouvellement créee du nom de module notification odoo par Nasolo dans le projet Site web QLM.	f	72	71	2022-02-07 13:35:15	2022-02-07 13:35:15
4353	Tâche nouvellement créee du nom de module de notification odoo par Nasolo dans le projet Site web QLM.	f	72	53	2022-02-07 13:38:13	2022-02-07 13:38:13
4354	Tâche nouvellement créee du nom de module de notification odoo par Nasolo dans le projet Site web QLM.	f	72	57	2022-02-07 13:38:13	2022-02-07 13:38:13
4356	Tâche nouvellement créee du nom de module de notification odoo par Nasolo dans le projet Site web QLM.	f	72	71	2022-02-07 13:38:13	2022-02-07 13:38:13
4374	Tâche "statut accepté => génération de doc achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 08:58:12	2022-02-08 08:58:12
4375	Tâche "statut accepté => génération de doc achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 08:58:12	2022-02-08 08:58:12
4377	Tâche "statut accepté => génération de doc achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 08:58:12	2022-02-08 08:58:12
4410	Tâche "Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 09:01:25	2022-02-08 09:01:25
4411	Tâche "Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 09:01:25	2022-02-08 09:01:25
4413	Tâche "Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 09:01:25	2022-02-08 09:01:25
4434	Tâche nouvellement créee du nom de Suppression backup ancienne par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-02-08 09:05:09	2022-02-08 09:05:09
4435	Tâche nouvellement créee du nom de Suppression backup ancienne par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-02-08 09:05:09	2022-02-08 09:05:09
4437	Tâche nouvellement créee du nom de Suppression backup ancienne par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-02-08 09:05:09	2022-02-08 09:05:09
4448	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-02-08 09:08:42	2022-02-08 09:08:42
4449	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-02-08 09:08:42	2022-02-08 09:08:42
4451	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-02-08 09:08:42	2022-02-08 09:08:42
4196	La tâche Rajouter un statut Accepté pour les devis a été achevée.	t	78	70	2022-02-07 10:34:49	2022-02-07 10:34:49
4334	Tâche "Ajout de colonne comptes auxiliaires dans les écritures comptables"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-07 13:22:24	2022-02-07 13:22:24
4350	Tâche nouvellement créee du nom de module notification odoo par Nasolo dans le projet Site web QLM.	t	72	70	2022-02-07 13:35:15	2022-02-07 13:35:15
5818	Miandrisoa vous a assigné à la tâche Vérification des articles avec doublons dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-21 09:17:41	2022-02-21 09:17:41
5887	Tâche "Envoi des anomalies d'enregistrement des PNRs sur email"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 09:33:20	2022-02-21 09:33:20
5888	Tâche "Envoi des anomalies d'enregistrement des PNRs sur email"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 09:33:20	2022-02-21 09:33:20
5889	Tâche "Envoi des anomalies d'enregistrement des PNRs sur email"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 09:33:20	2022-02-21 09:33:20
5890	Tâche "Envoi des anomalies d'enregistrement des PNRs sur email"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 09:33:20	2022-02-21 09:33:20
6280	La tâche Préparation un fichier d'inventaire COMPUTEK a été achevée.	f	76	57	2022-02-22 12:37:27	2022-02-22 12:37:27
6281	La tâche Préparation un fichier d'inventaire COMPUTEK a été achevée.	f	76	70	2022-02-22 12:37:27	2022-02-22 12:37:27
4109	Tâche nouvellement créee du nom de Validation BL par Michel dans le projet Intervention / Accompagnement 2022.	f	71	53	2022-02-04 12:45:25	2022-02-04 12:45:25
4110	Tâche nouvellement créee du nom de Validation BL par Michel dans le projet Intervention / Accompagnement 2022.	f	71	57	2022-02-04 12:45:25	2022-02-04 12:45:25
4111	Tâche nouvellement créee du nom de Validation BL par Michel dans le projet Intervention / Accompagnement 2022.	t	71	70	2022-02-04 12:45:25	2022-02-04 12:45:25
4140	Michel vous a assigné à la tâche Impression 40 factures - ENAC dans le projet Intervention / Accompagnement 2022.	t	71	77	2022-02-04 12:50:51	2022-02-04 12:50:51
4221	Rémi vous a assigné à la tâche Afficher les autres taxes dans les documents factures et achats dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 10:51:20	2022-02-07 10:51:20
4202	Nasolo vous a assigné à la tâche module de notification windows lors d'un nouveau message odoo.	t	72	72	2022-02-07 10:42:28	2022-02-07 10:42:28
4327	Tâche nouvellement créee du nom de Type du chams libellé global: Char => Text par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 13:09:21	2022-02-07 13:09:21
4328	Tâche nouvellement créee du nom de Type du chams libellé global: Char => Text par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 13:09:21	2022-02-07 13:09:21
4330	Tâche nouvellement créee du nom de Type du chams libellé global: Char => Text par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 13:09:21	2022-02-07 13:09:21
4382	Tâche "Cacher le champs émission, sa valeur est toujour la même"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 08:58:36	2022-02-08 08:58:36
4383	Tâche "Cacher le champs émission, sa valeur est toujour la même"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 08:58:36	2022-02-08 08:58:36
4385	Tâche "Cacher le champs émission, sa valeur est toujour la même"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 08:58:36	2022-02-08 08:58:36
4414	Tâche "Ajouter numéro de dossier dans la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 09:01:32	2022-02-08 09:01:32
4415	Tâche "Ajouter numéro de dossier dans la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 09:01:32	2022-02-08 09:01:32
4417	Tâche "Ajouter numéro de dossier dans la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 09:01:32	2022-02-08 09:01:32
4460	Tâche "Type du chams libellé global: Char => Text"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 09:23:37	2022-02-08 09:23:37
4461	Tâche "Type du chams libellé global: Char => Text"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 09:23:37	2022-02-08 09:23:37
4462	Tâche "Type du chams libellé global: Char => Text"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 09:23:37	2022-02-08 09:23:37
4463	Tâche "Ajouter un champs nombre (nombre x quantité joue le rôle de quantité)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 09:24:14	2022-02-08 09:24:14
4464	Tâche "Ajouter un champs nombre (nombre x quantité joue le rôle de quantité)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 09:24:14	2022-02-08 09:24:14
4465	Tâche "Ajouter un champs nombre (nombre x quantité joue le rôle de quantité)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 09:24:14	2022-02-08 09:24:14
4496	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-08 10:42:44	2022-02-08 10:42:44
4497	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-08 10:42:44	2022-02-08 10:42:44
4499	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-08 10:42:44	2022-02-08 10:42:44
4498	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-08 10:42:44	2022-02-08 10:42:44
4329	Tâche nouvellement créee du nom de Type du chams libellé global: Char => Text par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 13:09:21	2022-02-07 13:09:21
4384	Tâche "Cacher le champs émission, sa valeur est toujour la même"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 08:58:36	2022-02-08 08:58:36
4416	Tâche "Ajouter numéro de dossier dans la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 09:01:32	2022-02-08 09:01:32
5819	Tâche "Vérification des articles avec doublons"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-02-21 09:17:52	2022-02-21 09:17:52
5820	Tâche "Vérification des articles avec doublons"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-02-21 09:17:52	2022-02-21 09:17:52
5822	Tâche "Vérification des articles avec doublons"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-02-21 09:17:52	2022-02-21 09:17:52
5823	Tâche "Vérification des articles avec doublons"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-02-21 09:17:52	2022-02-21 09:17:52
5834	Miandrisoa vous a assigné à la tâche Préparation un fichier d'inventaire COMPUTEK dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-21 09:21:15	2022-02-21 09:21:15
5853	Tâche nouvellement créee du nom de Rajouter sur l'historique quand il y a un ajustement de stock par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	53	2022-02-21 09:25:44	2022-02-21 09:25:44
5854	Tâche nouvellement créee du nom de Rajouter sur l'historique quand il y a un ajustement de stock par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	57	2022-02-21 09:25:44	2022-02-21 09:25:44
4113	Tâche "Validation BL"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-04 12:45:57	2022-02-04 12:45:57
4114	Tâche "Validation BL"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-04 12:45:57	2022-02-04 12:45:57
4112	Michel vous a assigné à la tâche Validation BL.	t	71	77	2022-02-04 12:45:52	2022-02-04 12:45:52
4144	Tâche nouvellement créee du nom de Paramétrage paie - création structure solde de congé, min irsa sur 3000 par Michel dans le projet Intervention / Accompagnement 2022.	f	71	53	2022-02-04 12:53:30	2022-02-04 12:53:30
4145	Tâche nouvellement créee du nom de Paramétrage paie - création structure solde de congé, min irsa sur 3000 par Michel dans le projet Intervention / Accompagnement 2022.	f	71	57	2022-02-04 12:53:30	2022-02-04 12:53:30
4147	Michel vous a assigné à la tâche Paramétrage paie - création structure solde de congé, min irsa sur 3000 dans le projet Intervention / Accompagnement 2022.	t	71	77	2022-02-04 12:53:30	2022-02-04 12:53:30
4203	Tâche nouvellement créee du nom de Numérotation facture 1er Avril 2021 - 31 Mars : exercice 2021, exercice cfao par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 10:42:49	2022-02-07 10:42:49
4204	Tâche nouvellement créee du nom de Numérotation facture 1er Avril 2021 - 31 Mars : exercice 2021, exercice cfao par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 10:42:49	2022-02-07 10:42:49
4206	Tâche nouvellement créee du nom de Numérotation facture 1er Avril 2021 - 31 Mars : exercice 2021, exercice cfao par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 10:42:49	2022-02-07 10:42:49
4331	Rémi vous a assigné à la tâche Type du chams libellé global: Char => Text dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	78	2022-02-07 13:09:21	2022-02-07 13:09:21
4390	Tâche "Copie de certains champs lors d'une duplication de document travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 08:58:53	2022-02-08 08:58:53
4391	Tâche "Copie de certains champs lors d'une duplication de document travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 08:58:53	2022-02-08 08:58:53
4393	Tâche "Copie de certains champs lors d'une duplication de document travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 08:58:53	2022-02-08 08:58:53
4418	Tâche "Ajouter un champs nombre (nombre x quantité joue le rôle de quantité)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 09:01:40	2022-02-08 09:01:40
4419	Tâche "Ajouter un champs nombre (nombre x quantité joue le rôle de quantité)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 09:01:40	2022-02-08 09:01:40
4421	Tâche "Ajouter un champs nombre (nombre x quantité joue le rôle de quantité)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 09:01:40	2022-02-08 09:01:40
4469	La tâche Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné a été achevée avec toutes ses tâches filles.	f	70	53	2022-02-08 09:24:33	2022-02-08 09:24:33
4470	La tâche Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné a été achevée avec toutes ses tâches filles.	f	70	57	2022-02-08 09:24:33	2022-02-08 09:24:33
4471	La tâche Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné a été achevée avec toutes ses tâches filles.	f	70	71	2022-02-08 09:24:33	2022-02-08 09:24:33
4438	Osé vous a assigné à la tâche Suppression backup ancienne dans le projet Sauvegarde FTP des clients .	t	74	74	2022-02-08 09:05:09	2022-02-08 09:05:09
4115	Tâche "Validation BL"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-04 12:45:57	2022-02-04 12:45:57
4146	Tâche nouvellement créee du nom de Paramétrage paie - création structure solde de congé, min irsa sur 3000 par Michel dans le projet Intervention / Accompagnement 2022.	t	71	70	2022-02-04 12:53:30	2022-02-04 12:53:30
4205	Tâche nouvellement créee du nom de Numérotation facture 1er Avril 2021 - 31 Mars : exercice 2021, exercice cfao par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 10:42:49	2022-02-07 10:42:49
4392	Tâche "Copie de certains champs lors d'une duplication de document travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 08:58:53	2022-02-08 08:58:53
4420	Tâche "Ajouter un champs nombre (nombre x quantité joue le rôle de quantité)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 09:01:40	2022-02-08 09:01:40
5824	Tâche nouvellement créee du nom de Adaptation/Vérification du programme Import Devis sur EBP par Mihaja dans le projet Synchro du site Computek.	f	70	53	2022-02-21 09:21:02	2022-02-21 09:21:02
5825	Tâche nouvellement créee du nom de Adaptation/Vérification du programme Import Devis sur EBP par Mihaja dans le projet Synchro du site Computek.	f	70	57	2022-02-21 09:21:02	2022-02-21 09:21:02
5826	Tâche nouvellement créee du nom de Adaptation/Vérification du programme Import Devis sur EBP par Mihaja dans le projet Synchro du site Computek.	f	70	71	2022-02-21 09:21:02	2022-02-21 09:21:02
5827	Tâche nouvellement créee du nom de Adaptation/Vérification du programme Import Devis sur EBP par Mihaja dans le projet Synchro du site Computek.	f	70	85	2022-02-21 09:21:02	2022-02-21 09:21:02
5866	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 09:30:27	2022-02-21 09:30:27
5867	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 09:30:27	2022-02-21 09:30:27
5868	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 09:30:27	2022-02-21 09:30:27
5869	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 09:30:27	2022-02-21 09:30:27
5875	La tâche Amélioration de l'application a été achevée avec toutes ses tâches filles.	f	70	53	2022-02-21 09:31:53	2022-02-21 09:31:53
4116	Tâche nouvellement créee du nom de Notification mail d'une commande passée sur le site par Mihaja dans le projet Site web QLM.	f	70	53	2022-02-04 12:47:10	2022-02-04 12:47:10
4117	Tâche nouvellement créee du nom de Notification mail d'une commande passée sur le site par Mihaja dans le projet Site web QLM.	f	70	57	2022-02-04 12:47:10	2022-02-04 12:47:10
4118	Tâche nouvellement créee du nom de Notification mail d'une commande passée sur le site par Mihaja dans le projet Site web QLM.	f	70	71	2022-02-04 12:47:10	2022-02-04 12:47:10
4134	Tâche "Amélioration du design de l'interface d'accueil "\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-04 12:50:37	2022-02-04 12:50:37
4135	Tâche "Amélioration du design de l'interface d'accueil "\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-04 12:50:37	2022-02-04 12:50:37
4136	Tâche "Amélioration du design de l'interface d'accueil "\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-04 12:50:37	2022-02-04 12:50:37
4207	Rémi vous a assigné à la tâche Numérotation facture 1er Avril 2021 - 31 Mars : exercice 2021, exercice cfao dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 10:42:49	2022-02-07 10:42:49
4208	Tâche "module de notification windows lors d'un nouveau message odoo"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	53	2022-02-07 10:45:51	2022-02-07 10:45:51
4209	Tâche "module de notification windows lors d'un nouveau message odoo"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	57	2022-02-07 10:45:51	2022-02-07 10:45:51
4211	Tâche "module de notification windows lors d'un nouveau message odoo"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	71	2022-02-07 10:45:51	2022-02-07 10:45:51
4226	Rémi vous a assigné à la tâche Document travel order doit être non modifiable à partir de 'accepté' dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 10:52:35	2022-02-07 10:52:35
4236	Rémi vous a assigné à la tâche Gestion des droits de validations de devis dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 10:55:05	2022-02-07 10:55:05
4285	Vous avez été assigné à la sous-tâche Ajouter un champs pour savoir si la facture a déjà été imprimée ou pas du projet SIGM - Gestion  Agence de Voyage sur Odoo 15	t	78	78	2022-02-07 12:55:40	2022-02-07 12:55:40
4295	Rémi vous a assigné à la tâche Définir le libellé des lignes 401 fournisseurs et 411 clients de l'écriture comptables (valeur: libellé global de la commande) dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	78	2022-02-07 12:58:27	2022-02-07 12:58:27
4300	Rémi vous a assigné à la tâche Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	78	2022-02-07 12:59:55	2022-02-07 12:59:55
4340	Tâche "Document travel order doit être non modifiable à partir de 'accepté'"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-07 13:23:33	2022-02-07 13:23:33
4341	Tâche "Document travel order doit être non modifiable à partir de 'accepté'"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-07 13:23:33	2022-02-07 13:23:33
4343	Tâche "Document travel order doit être non modifiable à partir de 'accepté'"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-07 13:23:33	2022-02-07 13:23:33
4394	Tâche "Ajouter le numéro pnr dans la commande (nouveau champs)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 08:59:11	2022-02-08 08:59:11
4395	Tâche "Ajouter le numéro pnr dans la commande (nouveau champs)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 08:59:11	2022-02-08 08:59:11
4397	Tâche "Ajouter le numéro pnr dans la commande (nouveau champs)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 08:59:11	2022-02-08 08:59:11
4426	Tâche "Ne pas afficher les détails des lignes dans l'impression (facture, devis, commande, pro forma)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 09:02:02	2022-02-08 09:02:02
4427	Tâche "Ne pas afficher les détails des lignes dans l'impression (facture, devis, commande, pro forma)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 09:02:02	2022-02-08 09:02:02
4429	Tâche "Ne pas afficher les détails des lignes dans l'impression (facture, devis, commande, pro forma)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 09:02:02	2022-02-08 09:02:02
4439	Tâche nouvellement créee du nom de Normalisation l'heure d'envoie backup par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-02-08 09:07:00	2022-02-08 09:07:00
4440	Tâche nouvellement créee du nom de Normalisation l'heure d'envoie backup par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-02-08 09:07:00	2022-02-08 09:07:00
4442	Tâche nouvellement créee du nom de Normalisation l'heure d'envoie backup par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-02-08 09:07:00	2022-02-08 09:07:00
4444	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-02-08 09:08:02	2022-02-08 09:08:02
4352	Nasolo vous a assigné à la tâche module notification odoo dans le projet Site web QLM.	t	72	72	2022-02-07 13:35:15	2022-02-07 13:35:15
6282	La tâche Préparation un fichier d'inventaire COMPUTEK a été achevée.	f	76	71	2022-02-22 12:37:27	2022-02-22 12:37:27
6283	La tâche Préparation un fichier d'inventaire COMPUTEK a été achevée.	f	76	85	2022-02-22 12:37:27	2022-02-22 12:37:27
6319	La tâche Validation BL Cheinmalt a été achevée.	f	77	53	2022-02-22 13:11:29	2022-02-22 13:11:29
6320	La tâche Validation BL Cheinmalt a été achevée.	f	77	57	2022-02-22 13:11:29	2022-02-22 13:11:29
6321	La tâche Validation BL Cheinmalt a été achevée.	f	77	70	2022-02-22 13:11:29	2022-02-22 13:11:29
6322	La tâche Validation BL Cheinmalt a été achevée.	f	77	71	2022-02-22 13:11:29	2022-02-22 13:11:29
6323	La tâche Validation BL Cheinmalt a été achevée.	f	77	85	2022-02-22 13:11:29	2022-02-22 13:11:29
6324	La tâche Création STC de deux salariés a été achevée.	f	77	53	2022-02-22 13:11:45	2022-02-22 13:11:45
6325	La tâche Création STC de deux salariés a été achevée.	f	77	57	2022-02-22 13:11:45	2022-02-22 13:11:45
6326	La tâche Création STC de deux salariés a été achevée.	f	77	70	2022-02-22 13:11:45	2022-02-22 13:11:45
4126	Mihaja vous a assigné à la tâche Création banner d'accueil sur le site dans le projet Site web QLM.	t	70	75	2022-02-04 12:49:51	2022-02-04 12:49:51
4216	Rémi vous a assigné à la tâche Ajout de colonne comptes auxiliaires dans les écritures comptables dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 10:47:37	2022-02-07 10:47:37
4227	Tâche nouvellement créee du nom de Afficher les fournisseurs dans la facture client par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 10:54:06	2022-02-07 10:54:06
4228	Tâche nouvellement créee du nom de Afficher les fournisseurs dans la facture client par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 10:54:06	2022-02-07 10:54:06
4230	Tâche nouvellement créee du nom de Afficher les fournisseurs dans la facture client par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 10:54:06	2022-02-07 10:54:06
4232	Tâche nouvellement créee du nom de Gestion des droits de validations de devis par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 10:55:05	2022-02-07 10:55:05
4233	Tâche nouvellement créee du nom de Gestion des droits de validations de devis par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 10:55:05	2022-02-07 10:55:05
4235	Tâche nouvellement créee du nom de Gestion des droits de validations de devis par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 10:55:05	2022-02-07 10:55:05
4336	Tâche "Afficher les autres taxes dans les documents factures et achats"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-07 13:23:13	2022-02-07 13:23:13
4337	Tâche "Afficher les autres taxes dans les documents factures et achats"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-07 13:23:13	2022-02-07 13:23:13
4339	Tâche "Afficher les autres taxes dans les documents factures et achats"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-07 13:23:13	2022-02-07 13:23:13
4398	Tâche "Mettre une bande duplicata après une première impression de la facture"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-08 08:59:22	2022-02-08 08:59:22
4399	Tâche "Mettre une bande duplicata après une première impression de la facture"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-08 08:59:22	2022-02-08 08:59:22
4401	Tâche "Mettre une bande duplicata après une première impression de la facture"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-08 08:59:22	2022-02-08 08:59:22
4478	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-02-08 10:04:24	2022-02-08 10:04:24
4479	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-02-08 10:04:24	2022-02-08 10:04:24
4481	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-02-08 10:04:24	2022-02-08 10:04:24
4482	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-02-08 10:04:26	2022-02-08 10:04:26
4483	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-02-08 10:04:26	2022-02-08 10:04:26
4485	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-02-08 10:04:26	2022-02-08 10:04:26
4443	Osé vous a assigné à la tâche Normalisation l'heure d'envoie backup dans le projet Sauvegarde FTP des clients .	t	74	74	2022-02-08 09:07:00	2022-02-08 09:07:00
4229	Tâche nouvellement créee du nom de Afficher les fournisseurs dans la facture client par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 10:54:06	2022-02-07 10:54:06
4234	Tâche nouvellement créee du nom de Gestion des droits de validations de devis par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 10:55:05	2022-02-07 10:55:05
4338	Tâche "Afficher les autres taxes dans les documents factures et achats"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-07 13:23:13	2022-02-07 13:23:13
4400	Tâche "Mettre une bande duplicata après une première impression de la facture"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 08:59:22	2022-02-08 08:59:22
4480	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	t	74	70	2022-02-08 10:04:24	2022-02-08 10:04:24
4484	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	t	74	70	2022-02-08 10:04:26	2022-02-08 10:04:26
4119	Mihaja vous a assigné à la tâche Notification mail d'une commande passée sur le site dans le projet Site web QLM.	t	70	81	2022-02-04 12:47:10	2022-02-04 12:47:10
5904	Tâche "Restriction sur la modifcation des catégories"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 10:15:17	2022-02-21 10:15:17
5905	Tâche "Restriction sur la modifcation des catégories"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 10:15:17	2022-02-21 10:15:17
5906	Tâche "Restriction sur la modifcation des catégories"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 10:15:17	2022-02-21 10:15:17
5907	Tâche "Restriction sur la modifcation des catégories"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 10:15:17	2022-02-21 10:15:17
5941	La tâche Renommer "Agence de voyage" en "Agences de voyage" a été achevée.	f	78	53	2022-02-21 14:25:48	2022-02-21 14:25:48
5942	La tâche Renommer "Agence de voyage" en "Agences de voyage" a été achevée.	f	78	57	2022-02-21 14:25:48	2022-02-21 14:25:48
5944	La tâche Renommer "Agence de voyage" en "Agences de voyage" a été achevée.	f	78	71	2022-02-21 14:25:48	2022-02-21 14:25:48
5943	La tâche Renommer "Agence de voyage" en "Agences de voyage" a été achevée.	t	78	70	2022-02-21 14:25:48	2022-02-21 14:25:48
4120	Tâche "Notification mail d'une commande passée sur le site"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-04 12:47:17	2022-02-04 12:47:17
4121	Tâche "Notification mail d'une commande passée sur le site"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-04 12:47:17	2022-02-04 12:47:17
4122	Tâche "Notification mail d'une commande passée sur le site"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-04 12:47:17	2022-02-04 12:47:17
4123	Tâche nouvellement créee du nom de Création banner d'accueil sur le site par Mihaja dans le projet Site web QLM.	f	70	53	2022-02-04 12:49:51	2022-02-04 12:49:51
4124	Tâche nouvellement créee du nom de Création banner d'accueil sur le site par Mihaja dans le projet Site web QLM.	f	70	57	2022-02-04 12:49:51	2022-02-04 12:49:51
4125	Tâche nouvellement créee du nom de Création banner d'accueil sur le site par Mihaja dans le projet Site web QLM.	f	70	71	2022-02-04 12:49:51	2022-02-04 12:49:51
4137	Tâche nouvellement créee du nom de Impression 40 factures - ENAC par Michel dans le projet Intervention / Accompagnement 2022.	f	71	53	2022-02-04 12:50:51	2022-02-04 12:50:51
4138	Tâche nouvellement créee du nom de Impression 40 factures - ENAC par Michel dans le projet Intervention / Accompagnement 2022.	f	71	57	2022-02-04 12:50:51	2022-02-04 12:50:51
4242	Vous avez été assigné à la sous-tâche Création d'un champs selection (client en compte, client de passage (default)) du projet SIGM - Gestion  Agence de Voyage sur Odoo 15	f	78	78	2022-02-07 10:58:48	2022-02-07 10:58:48
4262	Rémi vous a assigné à la tâche Cacher le champs émission, sa valeur est toujour la même dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-07 12:49:12	2022-02-07 12:49:12
4263	Tâche nouvellement créee du nom de Ajouter un champs autre info dans travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 12:49:59	2022-02-07 12:49:59
4264	Tâche nouvellement créee du nom de Ajouter un champs autre info dans travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 12:49:59	2022-02-07 12:49:59
4266	Tâche nouvellement créee du nom de Ajouter un champs autre info dans travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 12:49:59	2022-02-07 12:49:59
4296	Tâche nouvellement créee du nom de Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-07 12:59:55	2022-02-07 12:59:55
4297	Tâche nouvellement créee du nom de Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-07 12:59:55	2022-02-07 12:59:55
4299	Tâche nouvellement créee du nom de Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-07 12:59:55	2022-02-07 12:59:55
4290	Rémi vous a assigné à la tâche Changement de libellé: Usager => Passager, Partenaire => Client dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	78	2022-02-07 12:56:38	2022-02-07 12:56:38
4344	Tâche "Afficher les fournisseurs dans la facture client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-07 13:23:44	2022-02-07 13:23:44
4345	Tâche "Afficher les fournisseurs dans la facture client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-07 13:23:44	2022-02-07 13:23:44
4347	Tâche "Afficher les fournisseurs dans la facture client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-07 13:23:44	2022-02-07 13:23:44
4445	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-02-08 09:08:02	2022-02-08 09:08:02
4447	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-02-08 09:08:02	2022-02-08 09:08:02
4452	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	53	2022-02-08 09:08:48	2022-02-08 09:08:48
4453	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	57	2022-02-08 09:08:48	2022-02-08 09:08:48
4455	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	71	2022-02-08 09:08:48	2022-02-08 09:08:48
4491	Tâche nouvellement créee du nom de Photos INGCO par Elie dans le projet Intervention / Accompagnement 2022.	f	77	53	2022-02-08 10:42:12	2022-02-08 10:42:12
4492	Tâche nouvellement créee du nom de Photos INGCO par Elie dans le projet Intervention / Accompagnement 2022.	f	77	57	2022-02-08 10:42:12	2022-02-08 10:42:12
4494	Tâche nouvellement créee du nom de Photos INGCO par Elie dans le projet Intervention / Accompagnement 2022.	f	77	71	2022-02-08 10:42:12	2022-02-08 10:42:12
4139	Tâche nouvellement créee du nom de Impression 40 factures - ENAC par Michel dans le projet Intervention / Accompagnement 2022.	t	71	70	2022-02-04 12:50:51	2022-02-04 12:50:51
4265	Tâche nouvellement créee du nom de Ajouter un champs autre info dans travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 12:49:59	2022-02-07 12:49:59
5829	Tâche nouvellement créee du nom de Préparation un fichier d'inventaire COMPUTEK par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-21 09:21:15	2022-02-21 09:21:15
5830	Tâche nouvellement créee du nom de Préparation un fichier d'inventaire COMPUTEK par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-21 09:21:15	2022-02-21 09:21:15
5832	Tâche nouvellement créee du nom de Préparation un fichier d'inventaire COMPUTEK par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-21 09:21:15	2022-02-21 09:21:15
5833	Tâche nouvellement créee du nom de Préparation un fichier d'inventaire COMPUTEK par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-21 09:21:15	2022-02-21 09:21:15
5844	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	53	2022-02-21 09:23:22	2022-02-21 09:23:22
6317	La tâche Création nouvel utilisateur Odoo a été achevée.	f	77	71	2022-02-22 13:11:04	2022-02-22 13:11:04
6318	La tâche Création nouvel utilisateur Odoo a été achevée.	f	77	85	2022-02-22 13:11:04	2022-02-22 13:11:04
7823	La tâche Contre-inventaire Computek TANA,  a été achevée.	f	76	71	2022-03-07 13:49:43	2022-03-07 13:49:43
4127	Tâche "Création banner d'accueil sur le site"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-04 12:49:53	2022-02-04 12:49:53
4128	Tâche "Création banner d'accueil sur le site"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-04 12:49:53	2022-02-04 12:49:53
4129	Tâche "Création banner d'accueil sur le site"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-04 12:49:53	2022-02-04 12:49:53
4148	Tâche "Paramétrage paie - création structure solde de congé, min irsa sur 3000"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-04 12:53:49	2022-02-04 12:53:49
4149	Tâche "Paramétrage paie - création structure solde de congé, min irsa sur 3000"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-04 12:53:49	2022-02-04 12:53:49
4456	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	53	2022-02-08 09:08:49	2022-02-08 09:08:49
4457	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	57	2022-02-08 09:08:49	2022-02-08 09:08:49
4459	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	71	2022-02-08 09:08:49	2022-02-08 09:08:49
4466	Tâche "Ajouter numéro de dossier dans la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 09:24:22	2022-02-08 09:24:22
4467	Tâche "Ajouter numéro de dossier dans la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 09:24:22	2022-02-08 09:24:22
4468	Tâche "Ajouter numéro de dossier dans la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 09:24:22	2022-02-08 09:24:22
4475	Tâche "Cacher le champs émission, sa valeur est toujour la même"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 09:42:30	2022-02-08 09:42:30
4476	Tâche "Cacher le champs émission, sa valeur est toujour la même"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 09:42:30	2022-02-08 09:42:30
4477	Tâche "Cacher le champs émission, sa valeur est toujour la même"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 09:42:30	2022-02-08 09:42:30
4486	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	53	2022-02-08 10:04:34	2022-02-08 10:04:34
4487	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	57	2022-02-08 10:04:34	2022-02-08 10:04:34
4489	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	71	2022-02-08 10:04:34	2022-02-08 10:04:34
4500	Tâche "Ajout de colonne comptes auxiliaires dans les écritures comptables"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 12:07:26	2022-02-08 12:07:26
4501	Tâche "Ajout de colonne comptes auxiliaires dans les écritures comptables"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 12:07:26	2022-02-08 12:07:26
4502	Tâche "Ajout de colonne comptes auxiliaires dans les écritures comptables"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 12:07:26	2022-02-08 12:07:26
4513	Un projet du nom de Correction/Amélioration de l'application Project Monitoring MGBI a été crée par Mihaja	f	70	53	2022-02-08 13:11:06	2022-02-08 13:11:06
4514	Un projet du nom de Correction/Amélioration de l'application Project Monitoring MGBI a été crée par Mihaja	f	70	57	2022-02-08 13:11:06	2022-02-08 13:11:06
4515	Un projet du nom de Correction/Amélioration de l'application Project Monitoring MGBI a été crée par Mihaja	f	70	71	2022-02-08 13:11:06	2022-02-08 13:11:06
4552	Tâche nouvellement créee du nom de L'application se récharge automatiquement après quelque moment par Mihaja dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	f	70	53	2022-02-08 13:44:53	2022-02-08 13:44:53
4553	Tâche nouvellement créee du nom de L'application se récharge automatiquement après quelque moment par Mihaja dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	f	70	57	2022-02-08 13:44:53	2022-02-08 13:44:53
4554	Tâche nouvellement créee du nom de L'application se récharge automatiquement après quelque moment par Mihaja dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	f	70	71	2022-02-08 13:44:53	2022-02-08 13:44:53
4582	Tâche "statut accepté => génération de doc achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 14:25:05	2022-02-08 14:25:05
4583	Tâche "statut accepté => génération de doc achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 14:25:05	2022-02-08 14:25:05
4584	Tâche "statut accepté => génération de doc achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 14:25:05	2022-02-08 14:25:05
4585	Tâche "statut accepté => génération de doc achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-08 14:25:05	2022-02-08 14:25:05
4566	Mihaja vous a assigné à la tâche Restauration du site sur le serveur de test dans le projet Synchro du site Computek.	t	70	75	2022-02-08 14:12:36	2022-02-08 14:12:36
4357	Nasolo vous a assigné à la tâche module de notification odoo dans le projet Site web QLM.	t	72	72	2022-02-07 13:38:13	2022-02-07 13:38:13
6327	La tâche Création STC de deux salariés a été achevée.	f	77	71	2022-02-22 13:11:45	2022-02-22 13:11:45
6328	La tâche Création STC de deux salariés a été achevée.	f	77	85	2022-02-22 13:11:45	2022-02-22 13:11:45
6329	La tâche Ajustement des stocks de hhs6301 a été achevée.	f	77	53	2022-02-22 13:11:59	2022-02-22 13:11:59
6330	La tâche Ajustement des stocks de hhs6301 a été achevée.	f	77	57	2022-02-22 13:11:59	2022-02-22 13:11:59
6331	La tâche Ajustement des stocks de hhs6301 a été achevée.	f	77	70	2022-02-22 13:11:59	2022-02-22 13:11:59
6332	La tâche Ajustement des stocks de hhs6301 a été achevée.	f	77	71	2022-02-22 13:11:59	2022-02-22 13:11:59
6333	La tâche Ajustement des stocks de hhs6301 a été achevée.	f	77	85	2022-02-22 13:11:59	2022-02-22 13:11:59
6705	Tâche "Mise en place server FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-02-25 07:54:36	2022-02-25 07:54:36
4130	Tâche nouvellement créee du nom de Amélioration du design de l'interface d'accueil  par Mihaja dans le projet Site web QLM.	f	70	53	2022-02-04 12:50:34	2022-02-04 12:50:34
4131	Tâche nouvellement créee du nom de Amélioration du design de l'interface d'accueil  par Mihaja dans le projet Site web QLM.	f	70	57	2022-02-04 12:50:34	2022-02-04 12:50:34
4132	Tâche nouvellement créee du nom de Amélioration du design de l'interface d'accueil  par Mihaja dans le projet Site web QLM.	f	70	71	2022-02-04 12:50:34	2022-02-04 12:50:34
4141	Tâche "Impression 40 factures - ENAC"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-04 12:51:01	2022-02-04 12:51:01
4142	Tâche "Impression 40 factures - ENAC"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-04 12:51:01	2022-02-04 12:51:01
4358	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	53	2022-02-07 14:03:40	2022-02-07 14:03:40
4359	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	57	2022-02-07 14:03:40	2022-02-07 14:03:40
4361	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	71	2022-02-07 14:03:40	2022-02-07 14:03:40
4503	Tâche "Modification de la page d'accueil"\n          du projet Site web QLM mise dans " En contrôle " par Fanantenana	f	75	53	2022-02-08 12:21:11	2022-02-08 12:21:11
4504	Tâche "Modification de la page d'accueil"\n          du projet Site web QLM mise dans " En contrôle " par Fanantenana	f	75	57	2022-02-08 12:21:11	2022-02-08 12:21:11
4506	Tâche "Modification de la page d'accueil"\n          du projet Site web QLM mise dans " En contrôle " par Fanantenana	f	75	71	2022-02-08 12:21:11	2022-02-08 12:21:11
4505	Tâche "Modification de la page d'accueil"\n          du projet Site web QLM mise dans " En contrôle " par Fanantenana	t	75	70	2022-02-08 12:21:11	2022-02-08 12:21:11
4529	Tâche nouvellement créee du nom de Ajouter une référence du document achat dans le document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-08 13:23:48	2022-02-08 13:23:48
4530	Tâche nouvellement créee du nom de Ajouter une référence du document achat dans le document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-08 13:23:48	2022-02-08 13:23:48
4532	Tâche nouvellement créee du nom de Ajouter une référence du document achat dans le document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-08 13:23:48	2022-02-08 13:23:48
4560	Un projet du nom de Synchro du site Computek a été crée par Mihaja	f	70	53	2022-02-08 14:11:41	2022-02-08 14:11:41
4561	Un projet du nom de Synchro du site Computek a été crée par Mihaja	f	70	57	2022-02-08 14:11:41	2022-02-08 14:11:41
4562	Un projet du nom de Synchro du site Computek a été crée par Mihaja	f	70	71	2022-02-08 14:11:41	2022-02-08 14:11:41
4563	Tâche nouvellement créee du nom de Restauration du site sur le serveur de test par Mihaja dans le projet Synchro du site Computek.	f	70	53	2022-02-08 14:12:36	2022-02-08 14:12:36
4564	Tâche nouvellement créee du nom de Restauration du site sur le serveur de test par Mihaja dans le projet Synchro du site Computek.	f	70	57	2022-02-08 14:12:36	2022-02-08 14:12:36
4565	Tâche nouvellement créee du nom de Restauration du site sur le serveur de test par Mihaja dans le projet Synchro du site Computek.	f	70	71	2022-02-08 14:12:36	2022-02-08 14:12:36
4598	La tâche Mettre une bande duplicata après une première impression de la facture a été achevée avec toutes ses tâches filles.	f	70	53	2022-02-08 14:31:25	2022-02-08 14:31:25
4599	La tâche Mettre une bande duplicata après une première impression de la facture a été achevée avec toutes ses tâches filles.	f	70	57	2022-02-08 14:31:25	2022-02-08 14:31:25
4600	La tâche Mettre une bande duplicata après une première impression de la facture a été achevée avec toutes ses tâches filles.	f	70	71	2022-02-08 14:31:25	2022-02-08 14:31:25
4601	La tâche Mettre une bande duplicata après une première impression de la facture a été achevée avec toutes ses tâches filles.	f	70	85	2022-02-08 14:31:25	2022-02-08 14:31:25
4602	Tâche "Mettre une bande duplicata après une première impression de la facture"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 14:31:25	2022-02-08 14:31:25
4603	Tâche "Mettre une bande duplicata après une première impression de la facture"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 14:31:25	2022-02-08 14:31:25
4604	Tâche "Mettre une bande duplicata après une première impression de la facture"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 14:31:25	2022-02-08 14:31:25
4605	Tâche "Mettre une bande duplicata après une première impression de la facture"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-08 14:31:25	2022-02-08 14:31:25
4143	Tâche "Impression 40 factures - ENAC"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-04 12:51:01	2022-02-04 12:51:01
4360	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En cours " par Nasolo	t	72	70	2022-02-07 14:03:40	2022-02-07 14:03:40
4531	Tâche nouvellement créee du nom de Ajouter une référence du document achat dans le document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-08 13:23:48	2022-02-08 13:23:48
5835	Tâche nouvellement créee du nom de Mise en place WPAllExport des clients et commandes  par Mihaja dans le projet Synchro du site Computek.	f	70	53	2022-02-21 09:23:08	2022-02-21 09:23:08
5836	Tâche nouvellement créee du nom de Mise en place WPAllExport des clients et commandes  par Mihaja dans le projet Synchro du site Computek.	f	70	57	2022-02-21 09:23:08	2022-02-21 09:23:08
5837	Tâche nouvellement créee du nom de Mise en place WPAllExport des clients et commandes  par Mihaja dans le projet Synchro du site Computek.	f	70	71	2022-02-21 09:23:08	2022-02-21 09:23:08
5838	Tâche nouvellement créee du nom de Mise en place WPAllExport des clients et commandes  par Mihaja dans le projet Synchro du site Computek.	f	70	85	2022-02-21 09:23:08	2022-02-21 09:23:08
5858	Tâche nouvellement créee du nom de Rajout catalogue FOSKA sur le site par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	53	2022-02-21 09:29:30	2022-02-21 09:29:30
5859	Tâche nouvellement créee du nom de Rajout catalogue FOSKA sur le site par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	57	2022-02-21 09:29:30	2022-02-21 09:29:30
4133	Mihaja vous a assigné à la tâche Amélioration du design de l'interface d'accueil  dans le projet Site web QLM.	t	70	75	2022-02-04 12:50:34	2022-02-04 12:50:34
4507	Tâche "Afficher les autres taxes dans les documents factures et achats"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 12:35:06	2022-02-08 12:35:06
4508	Tâche "Afficher les autres taxes dans les documents factures et achats"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 12:35:06	2022-02-08 12:35:06
4509	Tâche "Afficher les autres taxes dans les documents factures et achats"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 12:35:06	2022-02-08 12:35:06
4510	Tâche "Document travel order doit être non modifiable à partir de 'accepté'"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 12:36:17	2022-02-08 12:36:17
4511	Tâche "Document travel order doit être non modifiable à partir de 'accepté'"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 12:36:17	2022-02-08 12:36:17
4512	Tâche "Document travel order doit être non modifiable à partir de 'accepté'"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 12:36:17	2022-02-08 12:36:17
4520	Rémi vous a assigné à la tâche Renommer "Sous-total" dans document facture en "Sous-total HT" et exclue tout taxe de sa valeur dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-08 13:15:53	2022-02-08 13:15:53
4521	Tâche "Afficher les fournisseurs dans la facture client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 13:16:16	2022-02-08 13:16:16
4522	Tâche "Afficher les fournisseurs dans la facture client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 13:16:16	2022-02-08 13:16:16
4523	Tâche "Afficher les fournisseurs dans la facture client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 13:16:16	2022-02-08 13:16:16
4556	Tâche nouvellement créee du nom de •\tPouvoir mettre une virgule dans Tâche > Durée estimée par Michel dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	f	71	53	2022-02-08 14:07:42	2022-02-08 14:07:42
4557	Tâche nouvellement créee du nom de •\tPouvoir mettre une virgule dans Tâche > Durée estimée par Michel dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	f	71	57	2022-02-08 14:07:42	2022-02-08 14:07:42
4567	Tâche nouvellement créee du nom de •\tAjouter un champ description dans une tâche par Michel dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	f	71	53	2022-02-08 14:15:34	2022-02-08 14:15:34
4568	Tâche nouvellement créee du nom de •\tAjouter un champ description dans une tâche par Michel dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	f	71	57	2022-02-08 14:15:34	2022-02-08 14:15:34
4570	Tâche nouvellement créee du nom de •\tAjouter un champ description dans une tâche par Michel dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	f	71	85	2022-02-08 14:15:34	2022-02-08 14:15:34
4606	Tâche "Changement de libellé: Usager => Passager, Partenaire => Client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 14:32:35	2022-02-08 14:32:35
4607	Tâche "Changement de libellé: Usager => Passager, Partenaire => Client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 14:32:35	2022-02-08 14:32:35
4608	Tâche "Changement de libellé: Usager => Passager, Partenaire => Client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 14:32:35	2022-02-08 14:32:35
4609	Tâche "Changement de libellé: Usager => Passager, Partenaire => Client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-08 14:32:35	2022-02-08 14:32:35
4639	Tâche nouvellement créee du nom de Mise à jours totes les photos INGCO par Elie dans le projet Intervention / Accompagnement 2022.	f	77	53	2022-02-09 09:04:07	2022-02-09 09:04:07
4640	Tâche nouvellement créee du nom de Mise à jours totes les photos INGCO par Elie dans le projet Intervention / Accompagnement 2022.	f	77	57	2022-02-09 09:04:07	2022-02-09 09:04:07
4642	Tâche nouvellement créee du nom de Mise à jours totes les photos INGCO par Elie dans le projet Intervention / Accompagnement 2022.	f	77	71	2022-02-09 09:04:07	2022-02-09 09:04:07
4643	Tâche nouvellement créee du nom de Mise à jours totes les photos INGCO par Elie dans le projet Intervention / Accompagnement 2022.	f	77	85	2022-02-09 09:04:07	2022-02-09 09:04:07
4682	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-09 13:56:33	2022-02-09 13:56:33
4683	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-09 13:56:33	2022-02-09 13:56:33
4685	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-09 13:56:33	2022-02-09 13:56:33
4686	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-09 13:56:33	2022-02-09 13:56:33
4684	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-09 13:56:33	2022-02-09 13:56:33
4558	Tâche nouvellement créee du nom de •\tPouvoir mettre une virgule dans Tâche > Durée estimée par Michel dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	t	71	70	2022-02-08 14:07:42	2022-02-08 14:07:42
4569	Tâche nouvellement créee du nom de •\tAjouter un champ description dans une tâche par Michel dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	t	71	70	2022-02-08 14:15:34	2022-02-08 14:15:34
5840	Tâche "Mise en place WPAllExport des clients et commandes "\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	53	2022-02-21 09:23:11	2022-02-21 09:23:11
5841	Tâche "Mise en place WPAllExport des clients et commandes "\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	57	2022-02-21 09:23:11	2022-02-21 09:23:11
5842	Tâche "Mise en place WPAllExport des clients et commandes "\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	71	2022-02-21 09:23:11	2022-02-21 09:23:11
7824	La tâche Contre-inventaire Computek TANA,  a été achevée.	f	76	85	2022-03-07 13:49:43	2022-03-07 13:49:43
4516	Tâche nouvellement créee du nom de Renommer "Sous-total" dans document facture en "Sous-total HT" et exclue tout taxe de sa valeur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-08 13:15:53	2022-02-08 13:15:53
4517	Tâche nouvellement créee du nom de Renommer "Sous-total" dans document facture en "Sous-total HT" et exclue tout taxe de sa valeur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-08 13:15:53	2022-02-08 13:15:53
4519	Tâche nouvellement créee du nom de Renommer "Sous-total" dans document facture en "Sous-total HT" et exclue tout taxe de sa valeur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-08 13:15:53	2022-02-08 13:15:53
4518	Tâche nouvellement créee du nom de Renommer "Sous-total" dans document facture en "Sous-total HT" et exclue tout taxe de sa valeur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-08 13:15:53	2022-02-08 13:15:53
4538	Rémi vous a assigné à la tâche Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-08 13:24:47	2022-02-08 13:24:47
4610	Tâche "Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 14:33:21	2022-02-08 14:33:21
4611	Tâche "Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 14:33:21	2022-02-08 14:33:21
4612	Tâche "Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 14:33:21	2022-02-08 14:33:21
4613	Tâche "Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-08 14:33:21	2022-02-08 14:33:21
4629	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-09 08:35:13	2022-02-09 08:35:13
4630	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-09 08:35:13	2022-02-09 08:35:13
4632	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-09 08:35:13	2022-02-09 08:35:13
4633	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-09 08:35:13	2022-02-09 08:35:13
4704	Tâche "Désactiver certaines colonne dans travel order selon l'article selectionné"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-10 07:17:10	2022-02-10 07:17:10
4705	Tâche "Désactiver certaines colonne dans travel order selon l'article selectionné"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-10 07:17:10	2022-02-10 07:17:10
4707	Tâche "Désactiver certaines colonne dans travel order selon l'article selectionné"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-10 07:17:10	2022-02-10 07:17:10
4708	Tâche "Désactiver certaines colonne dans travel order selon l'article selectionné"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	85	2022-02-10 07:17:10	2022-02-10 07:17:10
4631	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-09 08:35:13	2022-02-09 08:35:13
4706	Tâche "Désactiver certaines colonne dans travel order selon l'article selectionné"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-10 07:17:10	2022-02-10 07:17:10
5843	Tâche "Mise en place WPAllExport des clients et commandes "\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	85	2022-02-21 09:23:11	2022-02-21 09:23:11
5848	Tâche "Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-21 09:23:37	2022-02-21 09:23:37
5849	Tâche "Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-21 09:23:37	2022-02-21 09:23:37
5851	Tâche "Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-21 09:23:37	2022-02-21 09:23:37
5852	Tâche "Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	85	2022-02-21 09:23:37	2022-02-21 09:23:37
5297	Elie vous a assigné à la tâche Validation BL Cheinmalt dans le projet QLM Intervention / Accompagnement 2022.	t	77	77	2022-02-16 12:45:56	2022-02-16 12:45:56
5850	Tâche "Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-21 09:23:37	2022-02-21 09:23:37
6346	Tâche nouvellement créee du nom de Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-02-23 05:50:20	2022-02-23 05:50:20
6347	Tâche nouvellement créee du nom de Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-23 05:50:20	2022-02-23 05:50:20
6348	Tâche nouvellement créee du nom de Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-23 05:50:20	2022-02-23 05:50:20
6555	Tâche nouvellement créee du nom de Suppression des bases SQL EBP par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-24 12:55:09	2022-02-24 12:55:09
6556	Tâche nouvellement créee du nom de Suppression des bases SQL EBP par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-24 12:55:09	2022-02-24 12:55:09
4524	Tâche nouvellement créee du nom de Désactiver certaines colonne dans travel order selon l'article selectionné par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-08 13:16:43	2022-02-08 13:16:43
4525	Tâche nouvellement créee du nom de Désactiver certaines colonne dans travel order selon l'article selectionné par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-08 13:16:43	2022-02-08 13:16:43
4527	Tâche nouvellement créee du nom de Désactiver certaines colonne dans travel order selon l'article selectionné par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-08 13:16:43	2022-02-08 13:16:43
4526	Tâche nouvellement créee du nom de Désactiver certaines colonne dans travel order selon l'article selectionné par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-08 13:16:43	2022-02-08 13:16:43
4573	Tâche "Gestion des droits de validations de devis"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 14:17:22	2022-02-08 14:17:22
4574	Tâche "Gestion des droits de validations de devis"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 14:17:22	2022-02-08 14:17:22
4575	Tâche "Gestion des droits de validations de devis"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 14:17:22	2022-02-08 14:17:22
4576	Tâche "Gestion des droits de validations de devis"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-08 14:17:22	2022-02-08 14:17:22
4614	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-09 08:34:42	2022-02-09 08:34:42
4615	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-09 08:34:42	2022-02-09 08:34:42
4617	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-09 08:34:42	2022-02-09 08:34:42
4618	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-09 08:34:42	2022-02-09 08:34:42
4624	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-09 08:35:07	2022-02-09 08:35:07
4625	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-09 08:35:07	2022-02-09 08:35:07
4627	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-09 08:35:07	2022-02-09 08:35:07
4628	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-09 08:35:07	2022-02-09 08:35:07
4660	Famenontsoa vous a assigné à la tâche Ajout historique d'un billet dans le projet SIGM - Application inter Amadeus et Odoo.	t	73	73	2022-02-09 09:52:22	2022-02-09 09:52:22
4666	Tâche "Définir le libellé des lignes 401 fournisseurs et 411 clients de l'écriture comptables (valeur: libellé global de la commande)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	53	2022-02-09 10:03:25	2022-02-09 10:03:25
4667	Tâche "Définir le libellé des lignes 401 fournisseurs et 411 clients de l'écriture comptables (valeur: libellé global de la commande)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	57	2022-02-09 10:03:25	2022-02-09 10:03:25
4669	Tâche "Définir le libellé des lignes 401 fournisseurs et 411 clients de l'écriture comptables (valeur: libellé global de la commande)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	71	2022-02-09 10:03:25	2022-02-09 10:03:25
4670	Tâche "Définir le libellé des lignes 401 fournisseurs et 411 clients de l'écriture comptables (valeur: libellé global de la commande)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	85	2022-02-09 10:03:25	2022-02-09 10:03:25
4677	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-09 12:33:29	2022-02-09 12:33:29
4678	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-09 12:33:29	2022-02-09 12:33:29
4680	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-09 12:33:29	2022-02-09 12:33:29
4681	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-09 12:33:29	2022-02-09 12:33:29
4676	Elie vous a assigné à la tâche Intégration stock P025886 dans le projet Intervention / Accompagnement 2022.	t	77	77	2022-02-09 12:33:06	2022-02-09 12:33:06
4679	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-09 12:33:29	2022-02-09 12:33:29
4700	Tâche "Ajouter un champs pour le numéro de jour"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-10 07:06:05	2022-02-10 07:06:05
4701	Tâche "Ajouter un champs pour le numéro de jour"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-10 07:06:05	2022-02-10 07:06:05
4702	Tâche "Ajouter un champs pour le numéro de jour"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-10 07:06:05	2022-02-10 07:06:05
6748	La tâche Intégration stock dépôt 2 du 24/02/2022 a été achevée.	f	77	57	2022-02-25 13:19:06	2022-02-25 13:19:06
6750	La tâche Intégration stock dépôt 2 du 24/02/2022 a été achevée.	f	77	71	2022-02-25 13:19:06	2022-02-25 13:19:06
6751	La tâche Intégration stock dépôt 2 du 24/02/2022 a été achevée.	f	77	85	2022-02-25 13:19:06	2022-02-25 13:19:06
6752	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	53	2022-02-25 13:19:13	2022-02-25 13:19:13
6753	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	57	2022-02-25 13:19:13	2022-02-25 13:19:13
6749	La tâche Intégration stock dépôt 2 du 24/02/2022 a été achevée.	t	77	70	2022-02-25 13:19:06	2022-02-25 13:19:06
7071	La tâche Mise à jour emplacement dépôt 2 du 23/02/2022 a été achevée.	f	77	53	2022-02-28 13:33:50	2022-02-28 13:33:50
7072	La tâche Mise à jour emplacement dépôt 2 du 23/02/2022 a été achevée.	f	77	57	2022-02-28 13:33:50	2022-02-28 13:33:50
4528	Rémi vous a assigné à la tâche Désactiver certaines colonne dans travel order selon l'article selectionné dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-08 13:16:43	2022-02-08 13:16:43
4594	Tâche "Ajouter le numéro pnr dans la commande (nouveau champs)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 14:28:28	2022-02-08 14:28:28
4595	Tâche "Ajouter le numéro pnr dans la commande (nouveau champs)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 14:28:28	2022-02-08 14:28:28
4596	Tâche "Ajouter le numéro pnr dans la commande (nouveau champs)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 14:28:28	2022-02-08 14:28:28
4597	Tâche "Ajouter le numéro pnr dans la commande (nouveau champs)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-08 14:28:28	2022-02-08 14:28:28
4619	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-09 08:35:05	2022-02-09 08:35:05
4620	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-09 08:35:05	2022-02-09 08:35:05
4622	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-09 08:35:05	2022-02-09 08:35:05
4623	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-09 08:35:05	2022-02-09 08:35:05
4645	Tâche "Mise à jours totes les photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-09 09:04:17	2022-02-09 09:04:17
4646	Tâche "Mise à jours totes les photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-09 09:04:17	2022-02-09 09:04:17
4648	Tâche "Mise à jours totes les photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-09 09:04:17	2022-02-09 09:04:17
4649	Tâche "Mise à jours totes les photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-09 09:04:17	2022-02-09 09:04:17
4655	Tâche nouvellement créee du nom de Ajout historique d'un billet par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	53	2022-02-09 09:52:22	2022-02-09 09:52:22
4656	Tâche nouvellement créee du nom de Ajout historique d'un billet par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	57	2022-02-09 09:52:22	2022-02-09 09:52:22
4658	Tâche nouvellement créee du nom de Ajout historique d'un billet par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	71	2022-02-09 09:52:22	2022-02-09 09:52:22
4659	Tâche nouvellement créee du nom de Ajout historique d'un billet par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	85	2022-02-09 09:52:22	2022-02-09 09:52:22
4703	Tâche "Ajouter un champs pour le numéro de jour"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-10 07:06:05	2022-02-10 07:06:05
4621	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-09 08:35:05	2022-02-09 08:35:05
4647	Tâche "Mise à jours totes les photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-09 09:04:17	2022-02-09 09:04:17
4657	Tâche nouvellement créee du nom de Ajout historique d'un billet par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	t	73	70	2022-02-09 09:52:22	2022-02-09 09:52:22
4555	Mihaja vous a assigné à la tâche L'application se récharge automatiquement après quelque moment dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	t	70	81	2022-02-08 13:44:53	2022-02-08 13:44:53
5845	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	57	2022-02-21 09:23:22	2022-02-21 09:23:22
5846	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	71	2022-02-21 09:23:22	2022-02-21 09:23:22
5847	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	85	2022-02-21 09:23:22	2022-02-21 09:23:22
5870	Tâche "Renommer "Montant TVA" en "Montant TVA sur fees" dans le document travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-21 09:31:27	2022-02-21 09:31:27
5871	Tâche "Renommer "Montant TVA" en "Montant TVA sur fees" dans le document travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-21 09:31:27	2022-02-21 09:31:27
5873	Tâche "Renommer "Montant TVA" en "Montant TVA sur fees" dans le document travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-21 09:31:27	2022-02-21 09:31:27
5874	Tâche "Renommer "Montant TVA" en "Montant TVA sur fees" dans le document travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	85	2022-02-21 09:31:27	2022-02-21 09:31:27
5908	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 11:52:26	2022-02-21 11:52:26
5909	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 11:52:26	2022-02-21 11:52:26
5910	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 11:52:26	2022-02-21 11:52:26
5911	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 11:52:26	2022-02-21 11:52:26
5946	La tâche Renommer "Émis" en "émis" dans impression facture a été achevée.	f	78	53	2022-02-21 14:26:00	2022-02-21 14:26:00
5947	La tâche Renommer "Émis" en "émis" dans impression facture a été achevée.	f	78	57	2022-02-21 14:26:00	2022-02-21 14:26:00
7847	La tâche Listes des BL non facturés a été achevée.	f	76	53	2022-03-07 13:51:31	2022-03-07 13:51:31
7848	La tâche Listes des BL non facturés a été achevée.	f	76	57	2022-03-07 13:51:31	2022-03-07 13:51:31
7849	La tâche Listes des BL non facturés a été achevée.	f	76	70	2022-03-07 13:51:31	2022-03-07 13:51:31
4533	Rémi vous a assigné à la tâche Ajouter une référence du document achat dans le document de commande dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-08 13:23:48	2022-02-08 13:23:48
4548	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " A faire " par Rémi	f	78	53	2022-02-08 13:32:16	2022-02-08 13:32:16
4549	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " A faire " par Rémi	f	78	57	2022-02-08 13:32:16	2022-02-08 13:32:16
4551	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " A faire " par Rémi	f	78	71	2022-02-08 13:32:16	2022-02-08 13:32:16
4634	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-09 09:03:15	2022-02-09 09:03:15
4635	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-09 09:03:15	2022-02-09 09:03:15
4637	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-09 09:03:15	2022-02-09 09:03:15
4638	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-09 09:03:15	2022-02-09 09:03:15
4650	Tâche "Amélioration de l'application"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	53	2022-02-09 09:39:27	2022-02-09 09:39:27
4651	Tâche "Amélioration de l'application"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	57	2022-02-09 09:39:27	2022-02-09 09:39:27
4653	Tâche "Amélioration de l'application"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	71	2022-02-09 09:39:27	2022-02-09 09:39:27
4654	Tâche "Amélioration de l'application"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	85	2022-02-09 09:39:27	2022-02-09 09:39:27
4692	Tâche "statu annulé => suppression du document achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-10 07:05:57	2022-02-10 07:05:57
4693	Tâche "statu annulé => suppression du document achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-10 07:05:57	2022-02-10 07:05:57
4694	Tâche "statu annulé => suppression du document achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-10 07:05:57	2022-02-10 07:05:57
4695	Tâche "statu annulé => suppression du document achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-10 07:05:57	2022-02-10 07:05:57
4709	Tâche nouvellement créee du nom de Mise en place des articles sans emplacement Odoo par Elie dans le projet Intervention / Accompagnement 2022.	f	77	53	2022-02-10 09:02:39	2022-02-10 09:02:39
4710	Tâche nouvellement créee du nom de Mise en place des articles sans emplacement Odoo par Elie dans le projet Intervention / Accompagnement 2022.	f	77	57	2022-02-10 09:02:39	2022-02-10 09:02:39
4712	Tâche nouvellement créee du nom de Mise en place des articles sans emplacement Odoo par Elie dans le projet Intervention / Accompagnement 2022.	f	77	71	2022-02-10 09:02:39	2022-02-10 09:02:39
4713	Tâche nouvellement créee du nom de Mise en place des articles sans emplacement Odoo par Elie dans le projet Intervention / Accompagnement 2022.	f	77	85	2022-02-10 09:02:39	2022-02-10 09:02:39
4720	Tâche "Renommer "Sous-total" dans document facture en "Sous-total HT" et exclue tout taxe de sa valeur"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	53	2022-02-10 09:16:42	2022-02-10 09:16:42
4721	Tâche "Renommer "Sous-total" dans document facture en "Sous-total HT" et exclue tout taxe de sa valeur"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	57	2022-02-10 09:16:42	2022-02-10 09:16:42
4723	Tâche "Renommer "Sous-total" dans document facture en "Sous-total HT" et exclue tout taxe de sa valeur"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	71	2022-02-10 09:16:42	2022-02-10 09:16:42
4724	Tâche "Renommer "Sous-total" dans document facture en "Sous-total HT" et exclue tout taxe de sa valeur"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	85	2022-02-10 09:16:42	2022-02-10 09:16:42
4550	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " A faire " par Rémi	t	78	70	2022-02-08 13:32:16	2022-02-08 13:32:16
4636	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-09 09:03:15	2022-02-09 09:03:15
4652	Tâche "Amélioration de l'application"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	t	73	70	2022-02-09 09:39:27	2022-02-09 09:39:27
4711	Tâche nouvellement créee du nom de Mise en place des articles sans emplacement Odoo par Elie dans le projet Intervention / Accompagnement 2022.	t	77	70	2022-02-10 09:02:39	2022-02-10 09:02:39
4722	Tâche "Renommer "Sous-total" dans document facture en "Sous-total HT" et exclue tout taxe de sa valeur"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	t	78	70	2022-02-10 09:16:42	2022-02-10 09:16:42
5855	Tâche nouvellement créee du nom de Rajouter sur l'historique quand il y a un ajustement de stock par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	71	2022-02-21 09:25:44	2022-02-21 09:25:44
5856	Tâche nouvellement créee du nom de Rajouter sur l'historique quand il y a un ajustement de stock par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	85	2022-02-21 09:25:44	2022-02-21 09:25:44
5879	Tâche "Amélioration de l'application"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 09:31:53	2022-02-21 09:31:53
5880	Tâche "Amélioration de l'application"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 09:31:53	2022-02-21 09:31:53
5881	Tâche "Amélioration de l'application"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 09:31:53	2022-02-21 09:31:53
7073	La tâche Mise à jour emplacement dépôt 2 du 23/02/2022 a été achevée.	f	77	70	2022-02-28 13:33:50	2022-02-28 13:33:50
4534	Tâche nouvellement créee du nom de Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-08 13:24:47	2022-02-08 13:24:47
4535	Tâche nouvellement créee du nom de Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-08 13:24:47	2022-02-08 13:24:47
4537	Tâche nouvellement créee du nom de Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-08 13:24:47	2022-02-08 13:24:47
4539	Tâche nouvellement créee du nom de Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-08 13:29:51	2022-02-08 13:29:51
4540	Tâche nouvellement créee du nom de Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-08 13:29:51	2022-02-08 13:29:51
4542	Tâche nouvellement créee du nom de Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-08 13:29:51	2022-02-08 13:29:51
4543	Rémi vous a assigné à la tâche Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-08 13:29:51	2022-02-08 13:29:51
4586	Tâche "statut confirmé => génération de factures clients et fournisseurs"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 14:26:20	2022-02-08 14:26:20
4587	Tâche "statut confirmé => génération de factures clients et fournisseurs"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 14:26:20	2022-02-08 14:26:20
4588	Tâche "statut confirmé => génération de factures clients et fournisseurs"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 14:26:20	2022-02-08 14:26:20
4589	Tâche "statut confirmé => génération de factures clients et fournisseurs"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-08 14:26:20	2022-02-08 14:26:20
4644	Elie vous a assigné à la tâche Mise à jours totes les photos INGCO dans le projet Intervention / Accompagnement 2022.	t	77	77	2022-02-09 09:04:07	2022-02-09 09:04:07
4687	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	53	2022-02-10 05:42:02	2022-02-10 05:42:02
4688	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	57	2022-02-10 05:42:02	2022-02-10 05:42:02
4690	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	71	2022-02-10 05:42:02	2022-02-10 05:42:02
4691	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	85	2022-02-10 05:42:02	2022-02-10 05:42:02
4689	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	t	73	70	2022-02-10 05:42:02	2022-02-10 05:42:02
4725	Tâche "Ajouter une référence du document achat dans le document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-10 09:16:56	2022-02-10 09:16:56
4726	Tâche "Ajouter une référence du document achat dans le document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-10 09:16:56	2022-02-10 09:16:56
4728	Tâche "Ajouter une référence du document achat dans le document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-10 09:16:56	2022-02-10 09:16:56
4729	Tâche "Ajouter une référence du document achat dans le document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	85	2022-02-10 09:16:56	2022-02-10 09:16:56
4740	Rémi vous a assigné à la tâche Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-10 09:21:35	2022-02-10 09:21:35
4741	Tâche "Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-10 09:21:55	2022-02-10 09:21:55
4742	Tâche "Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-10 09:21:55	2022-02-10 09:21:55
4714	Elie vous a assigné à la tâche Mise en place des articles sans emplacement Odoo dans le projet Intervention / Accompagnement 2022.	t	77	77	2022-02-10 09:02:39	2022-02-10 09:02:39
4536	Tâche nouvellement créee du nom de Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-08 13:24:47	2022-02-08 13:24:47
4559	Michel vous a assigné à la tâche •\tPouvoir mettre une virgule dans Tâche > Durée estimée dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	t	71	81	2022-02-08 14:07:42	2022-02-08 14:07:42
7850	La tâche Listes des BL non facturés a été achevée.	f	76	71	2022-03-07 13:51:31	2022-03-07 13:51:31
7851	La tâche Listes des BL non facturés a été achevée.	f	76	85	2022-03-07 13:51:31	2022-03-07 13:51:31
7852	La tâche Paramétrage des vues dans GESCOM, accès au filtrage d'une date a été achevée.	f	76	53	2022-03-07 13:52:16	2022-03-07 13:52:16
7853	La tâche Paramétrage des vues dans GESCOM, accès au filtrage d'une date a été achevée.	f	76	57	2022-03-07 13:52:16	2022-03-07 13:52:16
7854	La tâche Paramétrage des vues dans GESCOM, accès au filtrage d'une date a été achevée.	f	76	70	2022-03-07 13:52:16	2022-03-07 13:52:16
7855	La tâche Paramétrage des vues dans GESCOM, accès au filtrage d'une date a été achevée.	f	76	71	2022-03-07 13:52:16	2022-03-07 13:52:16
7856	La tâche Paramétrage des vues dans GESCOM, accès au filtrage d'une date a été achevée.	f	76	85	2022-03-07 13:52:16	2022-03-07 13:52:16
7898	Tâche nouvellement créee du nom de configuration de la base de données SQL Server EDR par Nasolo dans le projet EDR - Application Web Réappro.	f	72	53	2022-03-08 08:37:06	2022-03-08 08:37:06
4544	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	53	2022-02-08 13:30:29	2022-02-08 13:30:29
4545	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	57	2022-02-08 13:30:29	2022-02-08 13:30:29
4547	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	71	2022-02-08 13:30:29	2022-02-08 13:30:29
4577	Tâche nouvellement créee du nom de Pouvoir attribuer une tâche à un attributteur par Michel dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	f	71	53	2022-02-08 14:18:14	2022-02-08 14:18:14
4578	Tâche nouvellement créee du nom de Pouvoir attribuer une tâche à un attributteur par Michel dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	f	71	57	2022-02-08 14:18:14	2022-02-08 14:18:14
4580	Tâche nouvellement créee du nom de Pouvoir attribuer une tâche à un attributteur par Michel dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	f	71	85	2022-02-08 14:18:14	2022-02-08 14:18:14
4590	Tâche "Copie de certains champs lors d'une duplication de document travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-08 14:28:18	2022-02-08 14:28:18
4591	Tâche "Copie de certains champs lors d'une duplication de document travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-08 14:28:18	2022-02-08 14:28:18
4592	Tâche "Copie de certains champs lors d'une duplication de document travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-08 14:28:18	2022-02-08 14:28:18
4593	Tâche "Copie de certains champs lors d'une duplication de document travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-08 14:28:18	2022-02-08 14:28:18
4661	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En blocage " par Famenontsoa	f	73	53	2022-02-09 09:54:08	2022-02-09 09:54:08
4662	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En blocage " par Famenontsoa	f	73	57	2022-02-09 09:54:08	2022-02-09 09:54:08
4664	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En blocage " par Famenontsoa	f	73	71	2022-02-09 09:54:08	2022-02-09 09:54:08
4665	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En blocage " par Famenontsoa	f	73	85	2022-02-09 09:54:08	2022-02-09 09:54:08
4671	Tâche nouvellement créee du nom de Intégration stock P025886 par Elie dans le projet Intervention / Accompagnement 2022.	f	77	53	2022-02-09 12:33:06	2022-02-09 12:33:06
4672	Tâche nouvellement créee du nom de Intégration stock P025886 par Elie dans le projet Intervention / Accompagnement 2022.	f	77	57	2022-02-09 12:33:06	2022-02-09 12:33:06
4674	Tâche nouvellement créee du nom de Intégration stock P025886 par Elie dans le projet Intervention / Accompagnement 2022.	f	77	71	2022-02-09 12:33:06	2022-02-09 12:33:06
4675	Tâche nouvellement créee du nom de Intégration stock P025886 par Elie dans le projet Intervention / Accompagnement 2022.	f	77	85	2022-02-09 12:33:06	2022-02-09 12:33:06
4673	Tâche nouvellement créee du nom de Intégration stock P025886 par Elie dans le projet Intervention / Accompagnement 2022.	t	77	70	2022-02-09 12:33:06	2022-02-09 12:33:06
4696	Tâche "Ajouter un champs autre info dans travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-10 07:06:00	2022-02-10 07:06:00
4697	Tâche "Ajouter un champs autre info dans travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-10 07:06:00	2022-02-10 07:06:00
4698	Tâche "Ajouter un champs autre info dans travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-10 07:06:00	2022-02-10 07:06:00
4699	Tâche "Ajouter un champs autre info dans travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-10 07:06:00	2022-02-10 07:06:00
4715	Tâche "Mise en place des articles sans emplacement Odoo"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-10 09:02:48	2022-02-10 09:02:48
4716	Tâche "Mise en place des articles sans emplacement Odoo"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-10 09:02:48	2022-02-10 09:02:48
4718	Tâche "Mise en place des articles sans emplacement Odoo"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-10 09:02:48	2022-02-10 09:02:48
4719	Tâche "Mise en place des articles sans emplacement Odoo"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-10 09:02:48	2022-02-10 09:02:48
4730	Tâche "Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-10 09:17:10	2022-02-10 09:17:10
4731	Tâche "Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-10 09:17:10	2022-02-10 09:17:10
4733	Tâche "Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-10 09:17:10	2022-02-10 09:17:10
4734	Tâche "Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	85	2022-02-10 09:17:10	2022-02-10 09:17:10
4746	Tâche nouvellement créee du nom de Ajouter un label pour le champs autre infos dans travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-10 09:22:28	2022-02-10 09:22:28
4747	Tâche nouvellement créee du nom de Ajouter un label pour le champs autre infos dans travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-10 09:22:28	2022-02-10 09:22:28
4749	Tâche nouvellement créee du nom de Ajouter un label pour le champs autre infos dans travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-10 09:22:28	2022-02-10 09:22:28
4750	Tâche nouvellement créee du nom de Ajouter un label pour le champs autre infos dans travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-10 09:22:28	2022-02-10 09:22:28
4776	Tâche "Mise à jours totes les photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-10 19:03:27	2022-02-10 19:03:27
4777	Tâche "Mise à jours totes les photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-10 19:03:27	2022-02-10 19:03:27
4779	Tâche "Mise à jours totes les photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	85	2022-02-10 19:03:27	2022-02-10 19:03:27
4784	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En blocage " par Nasolo	f	72	53	2022-02-11 05:06:56	2022-02-11 05:06:56
4785	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En blocage " par Nasolo	f	72	57	2022-02-11 05:06:56	2022-02-11 05:06:56
4787	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En blocage " par Nasolo	f	72	71	2022-02-11 05:06:56	2022-02-11 05:06:56
4788	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En blocage " par Nasolo	f	72	85	2022-02-11 05:06:56	2022-02-11 05:06:56
4748	Tâche nouvellement créee du nom de Ajouter un label pour le champs autre infos dans travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-10 09:22:28	2022-02-10 09:22:28
4778	Tâche "Mise à jours totes les photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-10 19:03:27	2022-02-10 19:03:27
4786	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En blocage " par Nasolo	t	72	70	2022-02-11 05:06:56	2022-02-11 05:06:56
5860	Tâche nouvellement créee du nom de Rajout catalogue FOSKA sur le site par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	71	2022-02-21 09:29:30	2022-02-21 09:29:30
5861	Tâche nouvellement créee du nom de Rajout catalogue FOSKA sur le site par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	85	2022-02-21 09:29:30	2022-02-21 09:29:30
5900	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 09:41:54	2022-02-21 09:41:54
5901	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 09:41:54	2022-02-21 09:41:54
5902	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 09:41:54	2022-02-21 09:41:54
5903	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 09:41:54	2022-02-21 09:41:54
6349	Miandrisoa vous a assigné à la tâche Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-23 05:50:20	2022-02-23 05:50:20
6557	Miandrisoa vous a assigné à la tâche Suppression des bases SQL EBP dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-24 12:55:09	2022-02-24 12:55:09
6580	Tâche nouvellement créee du nom de Créer un manuel d'utilisation pour l'application par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:11:20	2022-02-25 07:11:20
6581	Tâche nouvellement créee du nom de Créer un manuel d'utilisation pour l'application par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:11:20	2022-02-25 07:11:20
6583	Tâche nouvellement créee du nom de Créer un manuel d'utilisation pour l'application par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:11:20	2022-02-25 07:11:20
6584	Tâche nouvellement créee du nom de Créer un manuel d'utilisation pour l'application par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:11:20	2022-02-25 07:11:20
6586	Tâche nouvellement créee du nom de Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:12:35	2022-02-25 07:12:35
6587	Tâche nouvellement créee du nom de Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:12:35	2022-02-25 07:12:35
6653	Rémi vous a assigné à la tâche Renommer "Nombre" en "Nombre de nuitées" dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:21:52	2022-02-25 07:21:52
6654	Tâche "Renommer "Nombre" en "Nombre de nuitées""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	53	2022-02-25 07:22:03	2022-02-25 07:22:03
6655	Tâche "Renommer "Nombre" en "Nombre de nuitées""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	57	2022-02-25 07:22:03	2022-02-25 07:22:03
6706	Tâche "Mise en place server FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-02-25 07:54:36	2022-02-25 07:54:36
4735	Tâche nouvellement créee du nom de Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-10 09:21:35	2022-02-10 09:21:35
4736	Tâche nouvellement créee du nom de Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-10 09:21:35	2022-02-10 09:21:35
4738	Tâche nouvellement créee du nom de Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-10 09:21:35	2022-02-10 09:21:35
4739	Tâche nouvellement créee du nom de Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-10 09:21:35	2022-02-10 09:21:35
4757	Tâche nouvellement créee du nom de Cacher le bouton confirmer dans travel order si l'utilisateur n'a pas le droit de confirmer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-10 09:24:40	2022-02-10 09:24:40
4758	Tâche nouvellement créee du nom de Cacher le bouton confirmer dans travel order si l'utilisateur n'a pas le droit de confirmer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-10 09:24:40	2022-02-10 09:24:40
4760	Tâche nouvellement créee du nom de Cacher le bouton confirmer dans travel order si l'utilisateur n'a pas le droit de confirmer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-10 09:24:40	2022-02-10 09:24:40
4761	Tâche nouvellement créee du nom de Cacher le bouton confirmer dans travel order si l'utilisateur n'a pas le droit de confirmer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-10 09:24:40	2022-02-10 09:24:40
4763	Tâche "Gestion des threads"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	53	2022-02-10 11:06:15	2022-02-10 11:06:15
4764	Tâche "Gestion des threads"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	57	2022-02-10 11:06:15	2022-02-10 11:06:15
4766	Tâche "Gestion des threads"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	71	2022-02-10 11:06:15	2022-02-10 11:06:15
4767	Tâche "Gestion des threads"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	85	2022-02-10 11:06:15	2022-02-10 11:06:15
4780	Tâche "Mise en place des articles sans emplacement Odoo"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-10 19:03:45	2022-02-10 19:03:45
4781	Tâche "Mise en place des articles sans emplacement Odoo"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-10 19:03:45	2022-02-10 19:03:45
4783	Tâche "Mise en place des articles sans emplacement Odoo"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	85	2022-02-10 19:03:45	2022-02-10 19:03:45
4737	Tâche nouvellement créee du nom de Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-10 09:21:35	2022-02-10 09:21:35
4759	Tâche nouvellement créee du nom de Cacher le bouton confirmer dans travel order si l'utilisateur n'a pas le droit de confirmer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-10 09:24:40	2022-02-10 09:24:40
4765	Tâche "Gestion des threads"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	t	73	70	2022-02-10 11:06:15	2022-02-10 11:06:15
4782	Tâche "Mise en place des articles sans emplacement Odoo"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-10 19:03:45	2022-02-10 19:03:45
5862	Tâche "Rajout catalogue FOSKA sur le site"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	53	2022-02-21 09:29:42	2022-02-21 09:29:42
5863	Tâche "Rajout catalogue FOSKA sur le site"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	57	2022-02-21 09:29:42	2022-02-21 09:29:42
5864	Tâche "Rajout catalogue FOSKA sur le site"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	71	2022-02-21 09:29:42	2022-02-21 09:29:42
5865	Tâche "Rajout catalogue FOSKA sur le site"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	85	2022-02-21 09:29:42	2022-02-21 09:29:42
5883	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 09:32:00	2022-02-21 09:32:00
5884	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 09:32:00	2022-02-21 09:32:00
5885	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 09:32:00	2022-02-21 09:32:00
5886	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 09:32:00	2022-02-21 09:32:00
5839	Mihaja vous a assigné à la tâche Mise en place WPAllExport des clients et commandes  dans le projet Synchro du site Computek.	t	70	75	2022-02-21 09:23:08	2022-02-21 09:23:08
5980	Tâche "Mettre le montant en lettre dans l'impression de facture"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	53	2022-02-22 06:33:35	2022-02-22 06:33:35
5981	Tâche "Mettre le montant en lettre dans l'impression de facture"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	57	2022-02-22 06:33:35	2022-02-22 06:33:35
5983	Tâche "Mettre le montant en lettre dans l'impression de facture"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	71	2022-02-22 06:33:35	2022-02-22 06:33:35
5984	Tâche "Mettre le montant en lettre dans l'impression de facture"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	85	2022-02-22 06:33:35	2022-02-22 06:33:35
5985	Tâche "Départ et Arrivée: des listes déroulantes (quand on a la liste)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	53	2022-02-22 06:33:50	2022-02-22 06:33:50
4744	Tâche "Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-10 09:21:55	2022-02-10 09:21:55
4745	Tâche "Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	85	2022-02-10 09:21:55	2022-02-10 09:21:55
4762	Rémi vous a assigné à la tâche Cacher le bouton confirmer dans travel order si l'utilisateur n'a pas le droit de confirmer dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-10 09:24:40	2022-02-10 09:24:40
5876	La tâche Amélioration de l'application a été achevée avec toutes ses tâches filles.	f	70	57	2022-02-21 09:31:53	2022-02-21 09:31:53
5877	La tâche Amélioration de l'application a été achevée avec toutes ses tâches filles.	f	70	71	2022-02-21 09:31:53	2022-02-21 09:31:53
5878	La tâche Amélioration de l'application a été achevée avec toutes ses tâches filles.	f	70	85	2022-02-21 09:31:53	2022-02-21 09:31:53
5917	Tâche nouvellement créee du nom de Mise à jour compte de dépense pour le PO PO26496 sur CHEINMALT par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	53	2022-02-21 12:42:42	2022-02-21 12:42:42
5918	Tâche nouvellement créee du nom de Mise à jour compte de dépense pour le PO PO26496 sur CHEINMALT par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	57	2022-02-21 12:42:42	2022-02-21 12:42:42
5919	Tâche nouvellement créee du nom de Mise à jour compte de dépense pour le PO PO26496 sur CHEINMALT par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	71	2022-02-21 12:42:42	2022-02-21 12:42:42
5920	Tâche nouvellement créee du nom de Mise à jour compte de dépense pour le PO PO26496 sur CHEINMALT par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	85	2022-02-21 12:42:42	2022-02-21 12:42:42
5921	Tâche "Mise à jour compte de dépense pour le PO PO26496 sur CHEINMALT"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	53	2022-02-21 12:42:49	2022-02-21 12:42:49
5922	Tâche "Mise à jour compte de dépense pour le PO PO26496 sur CHEINMALT"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	57	2022-02-21 12:42:49	2022-02-21 12:42:49
5923	Tâche "Mise à jour compte de dépense pour le PO PO26496 sur CHEINMALT"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	71	2022-02-21 12:42:49	2022-02-21 12:42:49
5924	Tâche "Mise à jour compte de dépense pour le PO PO26496 sur CHEINMALT"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	85	2022-02-21 12:42:49	2022-02-21 12:42:49
5925	Tâche nouvellement créee du nom de Ajustement des stocks de hhs6301 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-21 14:23:34	2022-02-21 14:23:34
5926	Tâche nouvellement créee du nom de Ajustement des stocks de hhs6301 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-21 14:23:34	2022-02-21 14:23:34
5928	Tâche nouvellement créee du nom de Ajustement des stocks de hhs6301 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-21 14:23:34	2022-02-21 14:23:34
5929	Tâche nouvellement créee du nom de Ajustement des stocks de hhs6301 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-21 14:23:34	2022-02-21 14:23:34
5930	Elie vous a assigné à la tâche Ajustement des stocks de hhs6301 dans le projet QLM Intervention / Accompagnement 2022.	t	77	77	2022-02-21 14:23:35	2022-02-21 14:23:35
5975	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	f	74	53	2022-02-22 05:43:07	2022-02-22 05:43:07
5976	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	f	74	57	2022-02-22 05:43:07	2022-02-22 05:43:07
5978	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	f	74	71	2022-02-22 05:43:07	2022-02-22 05:43:07
5979	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	f	74	85	2022-02-22 05:43:07	2022-02-22 05:43:07
5990	Tâche nouvellement créee du nom de Correction des conflits entre la version WP all import et Wordpress par Fanantenana dans le projet Synchro du site Computek.	f	75	53	2022-02-22 07:42:10	2022-02-22 07:42:10
5991	Tâche nouvellement créee du nom de Correction des conflits entre la version WP all import et Wordpress par Fanantenana dans le projet Synchro du site Computek.	f	75	57	2022-02-22 07:42:10	2022-02-22 07:42:10
5993	Tâche nouvellement créee du nom de Correction des conflits entre la version WP all import et Wordpress par Fanantenana dans le projet Synchro du site Computek.	f	75	71	2022-02-22 07:42:10	2022-02-22 07:42:10
5994	Tâche nouvellement créee du nom de Correction des conflits entre la version WP all import et Wordpress par Fanantenana dans le projet Synchro du site Computek.	f	75	85	2022-02-22 07:42:10	2022-02-22 07:42:10
5995	Fanantenana vous a assigné à la tâche Correction des conflits entre la version WP all import et Wordpress dans le projet Synchro du site Computek.	f	75	75	2022-02-22 07:42:10	2022-02-22 07:42:10
5927	Tâche nouvellement créee du nom de Ajustement des stocks de hhs6301 par Elie dans le projet QLM Intervention / Accompagnement 2022.	t	77	70	2022-02-21 14:23:34	2022-02-21 14:23:34
5977	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	t	74	70	2022-02-22 05:43:07	2022-02-22 05:43:07
5992	Tâche nouvellement créee du nom de Correction des conflits entre la version WP all import et Wordpress par Fanantenana dans le projet Synchro du site Computek.	t	75	70	2022-02-22 07:42:10	2022-02-22 07:42:10
6352	Tâche "Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	70	2022-02-23 05:50:38	2022-02-23 05:50:38
6353	Tâche "Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	71	2022-02-23 05:50:38	2022-02-23 05:50:38
6354	Tâche "Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	85	2022-02-23 05:50:38	2022-02-23 05:50:38
6360	La tâche Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé a été achevée.	f	76	53	2022-02-23 05:50:51	2022-02-23 05:50:51
4751	Rémi vous a assigné à la tâche Ajouter un label pour le champs autre infos dans travel order dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-10 09:22:28	2022-02-10 09:22:28
4768	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-10 19:02:14	2022-02-10 19:02:14
4769	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-10 19:02:14	2022-02-10 19:02:14
4771	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	85	2022-02-10 19:02:14	2022-02-10 19:02:14
4789	Tâche nouvellement créee du nom de Intégration inventaire QLM par Elie dans le projet Intervention / Accompagnement 2022.	f	77	53	2022-02-11 07:15:01	2022-02-11 07:15:01
4790	Tâche nouvellement créee du nom de Intégration inventaire QLM par Elie dans le projet Intervention / Accompagnement 2022.	f	77	57	2022-02-11 07:15:01	2022-02-11 07:15:01
4792	Tâche nouvellement créee du nom de Intégration inventaire QLM par Elie dans le projet Intervention / Accompagnement 2022.	f	77	71	2022-02-11 07:15:01	2022-02-11 07:15:01
4793	Tâche nouvellement créee du nom de Intégration inventaire QLM par Elie dans le projet Intervention / Accompagnement 2022.	f	77	85	2022-02-11 07:15:01	2022-02-11 07:15:01
4816	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-02-11 07:33:56	2022-02-11 07:33:56
4817	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-02-11 07:33:56	2022-02-11 07:33:56
4819	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-02-11 07:33:56	2022-02-11 07:33:56
4820	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	85	2022-02-11 07:33:56	2022-02-11 07:33:56
4821	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	53	2022-02-11 07:34:11	2022-02-11 07:34:11
4822	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	57	2022-02-11 07:34:11	2022-02-11 07:34:11
4824	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	71	2022-02-11 07:34:11	2022-02-11 07:34:11
4825	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	85	2022-02-11 07:34:11	2022-02-11 07:34:11
4842	Tâche "Restauration du site sur le serveur de test"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	53	2022-02-11 12:53:36	2022-02-11 12:53:36
4843	Tâche "Restauration du site sur le serveur de test"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	57	2022-02-11 12:53:36	2022-02-11 12:53:36
4845	Tâche "Restauration du site sur le serveur de test"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	71	2022-02-11 12:53:36	2022-02-11 12:53:36
4846	Tâche "Restauration du site sur le serveur de test"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	85	2022-02-11 12:53:36	2022-02-11 12:53:36
4858	Tâche nouvellement créee du nom de Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site par Mihaja dans le projet Synchro du site Computek.	f	70	53	2022-02-14 09:15:47	2022-02-14 09:15:47
4859	Tâche nouvellement créee du nom de Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site par Mihaja dans le projet Synchro du site Computek.	f	70	57	2022-02-14 09:15:47	2022-02-14 09:15:47
4860	Tâche nouvellement créee du nom de Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site par Mihaja dans le projet Synchro du site Computek.	f	70	71	2022-02-14 09:15:47	2022-02-14 09:15:47
4861	Tâche nouvellement créee du nom de Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site par Mihaja dans le projet Synchro du site Computek.	f	70	85	2022-02-14 09:15:47	2022-02-14 09:15:47
4891	Tâche nouvellement créee du nom de Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site par Mihaja dans le projet Synchro du site Computek.	f	70	53	2022-02-14 09:18:12	2022-02-14 09:18:12
4892	Tâche nouvellement créee du nom de Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site par Mihaja dans le projet Synchro du site Computek.	f	70	57	2022-02-14 09:18:12	2022-02-14 09:18:12
4893	Tâche nouvellement créee du nom de Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site par Mihaja dans le projet Synchro du site Computek.	f	70	71	2022-02-14 09:18:12	2022-02-14 09:18:12
4894	Tâche nouvellement créee du nom de Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site par Mihaja dans le projet Synchro du site Computek.	f	70	85	2022-02-14 09:18:12	2022-02-14 09:18:12
4951	Tâche "Demander la liste de tous les clients Incadea à mettre en place sur le dossier de test"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-14 13:18:14	2022-02-14 13:18:14
4752	Tâche "Ajouter un label pour le champs autre infos dans travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-10 09:22:38	2022-02-10 09:22:38
4753	Tâche "Ajouter un label pour le champs autre infos dans travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-10 09:22:38	2022-02-10 09:22:38
4755	Tâche "Ajouter un label pour le champs autre infos dans travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-10 09:22:38	2022-02-10 09:22:38
4756	Tâche "Ajouter un label pour le champs autre infos dans travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	85	2022-02-10 09:22:38	2022-02-10 09:22:38
4772	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-10 19:03:16	2022-02-10 19:03:16
4773	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-10 19:03:16	2022-02-10 19:03:16
4775	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	85	2022-02-10 19:03:16	2022-02-10 19:03:16
4794	Elie vous a assigné à la tâche Intégration inventaire QLM dans le projet Intervention / Accompagnement 2022.	t	77	77	2022-02-11 07:15:01	2022-02-11 07:15:01
4805	Tâche nouvellement créee du nom de Résolution des problèmes d'envoie des fichiers backup dans l'FTP par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-02-11 07:33:42	2022-02-11 07:33:42
4806	Tâche nouvellement créee du nom de Résolution des problèmes d'envoie des fichiers backup dans l'FTP par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-02-11 07:33:42	2022-02-11 07:33:42
4808	Tâche nouvellement créee du nom de Résolution des problèmes d'envoie des fichiers backup dans l'FTP par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-02-11 07:33:42	2022-02-11 07:33:42
4809	Tâche nouvellement créee du nom de Résolution des problèmes d'envoie des fichiers backup dans l'FTP par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-02-11 07:33:42	2022-02-11 07:33:42
4837	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	53	2022-02-11 07:43:32	2022-02-11 07:43:32
4838	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	57	2022-02-11 07:43:32	2022-02-11 07:43:32
4840	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	71	2022-02-11 07:43:32	2022-02-11 07:43:32
4841	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	85	2022-02-11 07:43:32	2022-02-11 07:43:32
4847	Tâche nouvellement créee du nom de Mise en place du site et intégration de 'wp all import' par Fanantenana dans le projet Synchro du site Computek.	f	75	53	2022-02-11 12:57:37	2022-02-11 12:57:37
4848	Tâche nouvellement créee du nom de Mise en place du site et intégration de 'wp all import' par Fanantenana dans le projet Synchro du site Computek.	f	75	57	2022-02-11 12:57:37	2022-02-11 12:57:37
4850	Tâche nouvellement créee du nom de Mise en place du site et intégration de 'wp all import' par Fanantenana dans le projet Synchro du site Computek.	f	75	71	2022-02-11 12:57:37	2022-02-11 12:57:37
4851	Tâche nouvellement créee du nom de Mise en place du site et intégration de 'wp all import' par Fanantenana dans le projet Synchro du site Computek.	f	75	85	2022-02-11 12:57:37	2022-02-11 12:57:37
4853	Tâche "Mise en place du site et intégration de 'wp all import'"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	53	2022-02-11 12:57:45	2022-02-11 12:57:45
4854	Tâche "Mise en place du site et intégration de 'wp all import'"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	57	2022-02-11 12:57:45	2022-02-11 12:57:45
4856	Tâche "Mise en place du site et intégration de 'wp all import'"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	71	2022-02-11 12:57:45	2022-02-11 12:57:45
4857	Tâche "Mise en place du site et intégration de 'wp all import'"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	85	2022-02-11 12:57:45	2022-02-11 12:57:45
4862	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-02-14 09:15:49	2022-02-14 09:15:49
4863	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-02-14 09:15:49	2022-02-14 09:15:49
4865	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-02-14 09:15:49	2022-02-14 09:15:49
4754	Tâche "Ajouter un label pour le champs autre infos dans travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-10 09:22:38	2022-02-10 09:22:38
6361	La tâche Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé a été achevée.	f	76	57	2022-02-23 05:50:51	2022-02-23 05:50:51
6362	La tâche Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé a été achevée.	f	76	70	2022-02-23 05:50:51	2022-02-23 05:50:51
6363	La tâche Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé a été achevée.	f	76	71	2022-02-23 05:50:51	2022-02-23 05:50:51
6364	La tâche Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé a été achevée.	f	76	85	2022-02-23 05:50:51	2022-02-23 05:50:51
6708	Tâche "Mise en place server FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-02-25 07:54:36	2022-02-25 07:54:36
6709	Tâche "Mise en place server FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	85	2022-02-25 07:54:36	2022-02-25 07:54:36
6774	La tâche Suppression des doublons des clients a été achevée avec toutes ses tâches filles.	f	76	57	2022-02-25 13:28:36	2022-02-25 13:28:36
4795	Tâche "Intégration inventaire QLM"\n          du projet Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	53	2022-02-11 07:15:10	2022-02-11 07:15:10
4796	Tâche "Intégration inventaire QLM"\n          du projet Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	57	2022-02-11 07:15:10	2022-02-11 07:15:10
4798	Tâche "Intégration inventaire QLM"\n          du projet Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	71	2022-02-11 07:15:10	2022-02-11 07:15:10
4799	Tâche "Intégration inventaire QLM"\n          du projet Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	85	2022-02-11 07:15:10	2022-02-11 07:15:10
4831	Tâche nouvellement créee du nom de Mise à jour export vers Odoo par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	53	2022-02-11 07:43:24	2022-02-11 07:43:24
4832	Tâche nouvellement créee du nom de Mise à jour export vers Odoo par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	57	2022-02-11 07:43:24	2022-02-11 07:43:24
4834	Tâche nouvellement créee du nom de Mise à jour export vers Odoo par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	71	2022-02-11 07:43:24	2022-02-11 07:43:24
4835	Tâche nouvellement créee du nom de Mise à jour export vers Odoo par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	85	2022-02-11 07:43:24	2022-02-11 07:43:24
4836	Famenontsoa vous a assigné à la tâche Mise à jour export vers Odoo dans le projet SIGM - Application inter Amadeus et Odoo.	t	73	73	2022-02-11 07:43:24	2022-02-11 07:43:24
4866	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	85	2022-02-14 09:15:49	2022-02-14 09:15:49
4947	Tâche nouvellement créee du nom de Demander la liste de tous les clients Incadea à mettre en place sur le dossier de test par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	53	2022-02-14 13:18:08	2022-02-14 13:18:08
4948	Tâche nouvellement créee du nom de Demander la liste de tous les clients Incadea à mettre en place sur le dossier de test par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	57	2022-02-14 13:18:08	2022-02-14 13:18:08
4949	Tâche nouvellement créee du nom de Demander la liste de tous les clients Incadea à mettre en place sur le dossier de test par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	71	2022-02-14 13:18:08	2022-02-14 13:18:08
4950	Tâche nouvellement créee du nom de Demander la liste de tous les clients Incadea à mettre en place sur le dossier de test par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	85	2022-02-14 13:18:08	2022-02-14 13:18:08
4975	Tâche "Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	53	2022-02-14 13:24:38	2022-02-14 13:24:38
4976	Tâche "Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	57	2022-02-14 13:24:38	2022-02-14 13:24:38
4977	Tâche "Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	71	2022-02-14 13:24:38	2022-02-14 13:24:38
4978	Tâche "Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	85	2022-02-14 13:24:38	2022-02-14 13:24:38
4797	Tâche "Intégration inventaire QLM"\n          du projet Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	t	77	70	2022-02-11 07:15:10	2022-02-11 07:15:10
4833	Tâche nouvellement créee du nom de Mise à jour export vers Odoo par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	t	73	70	2022-02-11 07:43:24	2022-02-11 07:43:24
5882	Tâche "Amélioration de l'application"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 09:31:53	2022-02-21 09:31:53
5891	La tâche Renommer "Nombre d'achat" en "Achat" dans le document travel order a été achevée.	f	78	53	2022-02-21 09:37:34	2022-02-21 09:37:34
5892	La tâche Renommer "Nombre d'achat" en "Achat" dans le document travel order a été achevée.	f	78	57	2022-02-21 09:37:34	2022-02-21 09:37:34
5894	La tâche Renommer "Nombre d'achat" en "Achat" dans le document travel order a été achevée.	f	78	71	2022-02-21 09:37:34	2022-02-21 09:37:34
5895	La tâche Renommer "Nombre d'achat" en "Achat" dans le document travel order a été achevée.	f	78	85	2022-02-21 09:37:34	2022-02-21 09:37:34
4852	Fanantenana vous a assigné à la tâche Mise en place du site et intégration de 'wp all import' dans le projet Synchro du site Computek.	t	75	75	2022-02-11 12:57:37	2022-02-11 12:57:37
5893	La tâche Renommer "Nombre d'achat" en "Achat" dans le document travel order a été achevée.	t	78	70	2022-02-21 09:37:34	2022-02-21 09:37:34
6365	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-02-23 07:02:38	2022-02-23 07:02:38
6366	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-02-23 07:02:38	2022-02-23 07:02:38
6367	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	70	2022-02-23 07:02:38	2022-02-23 07:02:38
6368	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-02-23 07:02:38	2022-02-23 07:02:38
6369	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	85	2022-02-23 07:02:38	2022-02-23 07:02:38
6148	Elie vous a assigné à la tâche Intégration de stock du PO24141 et PO26463 dans le projet QLM Intervention / Accompagnement 2022.	t	77	77	2022-02-22 10:50:32	2022-02-22 10:50:32
6396	Elie vous a assigné à la tâche Intégration inventaire Showroom Cheinmalt dans le projet QLM Intervention / Accompagnement 2022.	t	77	77	2022-02-23 14:38:33	2022-02-23 14:38:33
6412	Tâche "Mise en place WPAllExport des clients et commandes "\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	53	2022-02-24 04:48:13	2022-02-24 04:48:13
6413	Tâche "Mise en place WPAllExport des clients et commandes "\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	57	2022-02-24 04:48:13	2022-02-24 04:48:13
6776	La tâche Suppression des doublons des clients a été achevée avec toutes ses tâches filles.	f	76	71	2022-02-25 13:28:36	2022-02-25 13:28:36
4800	Tâche "Intégration inventaire QLM"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-11 07:15:12	2022-02-11 07:15:12
4801	Tâche "Intégration inventaire QLM"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-11 07:15:12	2022-02-11 07:15:12
4803	Tâche "Intégration inventaire QLM"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-11 07:15:12	2022-02-11 07:15:12
4804	Tâche "Intégration inventaire QLM"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-11 07:15:12	2022-02-11 07:15:12
4811	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-02-11 07:33:54	2022-02-11 07:33:54
4812	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-02-11 07:33:54	2022-02-11 07:33:54
4814	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-02-11 07:33:54	2022-02-11 07:33:54
4815	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	85	2022-02-11 07:33:54	2022-02-11 07:33:54
4826	Tâche "Installation du nouveau programme sauvegarde sur les serveurs clients"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-02-11 07:34:30	2022-02-11 07:34:30
4827	Tâche "Installation du nouveau programme sauvegarde sur les serveurs clients"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-02-11 07:34:30	2022-02-11 07:34:30
4829	Tâche "Installation du nouveau programme sauvegarde sur les serveurs clients"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-02-11 07:34:30	2022-02-11 07:34:30
4830	Tâche "Installation du nouveau programme sauvegarde sur les serveurs clients"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-02-11 07:34:30	2022-02-11 07:34:30
4867	Tâche nouvellement créee du nom de Extraction Image EBP par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-02-14 09:16:47	2022-02-14 09:16:47
4868	Tâche nouvellement créee du nom de Extraction Image EBP par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-02-14 09:16:47	2022-02-14 09:16:47
4870	Tâche nouvellement créee du nom de Extraction Image EBP par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-02-14 09:16:47	2022-02-14 09:16:47
4871	Tâche nouvellement créee du nom de Extraction Image EBP par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-02-14 09:16:47	2022-02-14 09:16:47
4883	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	53	2022-02-14 09:17:31	2022-02-14 09:17:31
4884	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	57	2022-02-14 09:17:31	2022-02-14 09:17:31
4885	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	71	2022-02-14 09:17:31	2022-02-14 09:17:31
4886	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	85	2022-02-14 09:17:31	2022-02-14 09:17:31
4896	Tâche "Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	53	2022-02-14 09:18:17	2022-02-14 09:18:17
4897	Tâche "Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	57	2022-02-14 09:18:17	2022-02-14 09:18:17
4898	Tâche "Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	71	2022-02-14 09:18:17	2022-02-14 09:18:17
4899	Tâche "Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	85	2022-02-14 09:18:17	2022-02-14 09:18:17
4916	Tâche "Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	53	2022-02-14 09:20:42	2022-02-14 09:20:42
4917	Tâche "Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	57	2022-02-14 09:20:42	2022-02-14 09:20:42
4918	Tâche "Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	71	2022-02-14 09:20:42	2022-02-14 09:20:42
4919	Tâche "Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	85	2022-02-14 09:20:42	2022-02-14 09:20:42
4933	Michel vous a assigné à la tâche Mise à jour tarifs dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	71	76	2022-02-14 11:35:50	2022-02-14 11:35:50
4934	Tâche nouvellement créee du nom de Prise en compte des données Tour (en cas de modification du circuit) par Michel dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	71	53	2022-02-14 11:43:00	2022-02-14 11:43:00
4935	Tâche nouvellement créee du nom de Prise en compte des données Tour (en cas de modification du circuit) par Michel dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	71	57	2022-02-14 11:43:00	2022-02-14 11:43:00
4810	Osé vous a assigné à la tâche Résolution des problèmes d'envoie des fichiers backup dans l'FTP dans le projet Sauvegarde FTP des clients .	t	74	74	2022-02-11 07:33:42	2022-02-11 07:33:42
4872	Osé vous a assigné à la tâche Extraction Image EBP dans le projet Sauvegarde FTP des clients .	f	74	74	2022-02-14 09:16:47	2022-02-14 09:16:47
4878	Tâche nouvellement créee du nom de Intégration des requêtes et adaptation des programmes synchro par Mihaja dans le projet Synchro du site Computek.	f	70	53	2022-02-14 09:17:21	2022-02-14 09:17:21
4879	Tâche nouvellement créee du nom de Intégration des requêtes et adaptation des programmes synchro par Mihaja dans le projet Synchro du site Computek.	f	70	57	2022-02-14 09:17:21	2022-02-14 09:17:21
4880	Tâche nouvellement créee du nom de Intégration des requêtes et adaptation des programmes synchro par Mihaja dans le projet Synchro du site Computek.	f	70	71	2022-02-14 09:17:21	2022-02-14 09:17:21
4881	Tâche nouvellement créee du nom de Intégration des requêtes et adaptation des programmes synchro par Mihaja dans le projet Synchro du site Computek.	f	70	85	2022-02-14 09:17:21	2022-02-14 09:17:21
4900	Tâche "Restauration du site sur le serveur de test"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-14 09:18:44	2022-02-14 09:18:44
4901	Tâche "Restauration du site sur le serveur de test"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-14 09:18:44	2022-02-14 09:18:44
4902	Tâche "Restauration du site sur le serveur de test"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-14 09:18:44	2022-02-14 09:18:44
4903	Tâche "Restauration du site sur le serveur de test"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-14 09:18:44	2022-02-14 09:18:44
4928	Michel vous a assigné à la tâche Mise à jour des familles dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	71	76	2022-02-14 11:34:35	2022-02-14 11:34:35
4937	Tâche nouvellement créee du nom de Prise en compte des données Tour (en cas de modification du circuit) par Michel dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	71	85	2022-02-14 11:43:00	2022-02-14 11:43:00
4943	Tâche "Envoyer le fichier export de l’écriture comptable sous format LOCPRO à Mr Andy pour un test d’import sur Incadea "\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-14 13:17:38	2022-02-14 13:17:38
4944	Tâche "Envoyer le fichier export de l’écriture comptable sous format LOCPRO à Mr Andy pour un test d’import sur Incadea "\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-14 13:17:38	2022-02-14 13:17:38
4945	Tâche "Envoyer le fichier export de l’écriture comptable sous format LOCPRO à Mr Andy pour un test d’import sur Incadea "\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-14 13:17:38	2022-02-14 13:17:38
4946	Tâche "Envoyer le fichier export de l’écriture comptable sous format LOCPRO à Mr Andy pour un test d’import sur Incadea "\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-14 13:17:38	2022-02-14 13:17:38
4959	Tâche "Demander l'accès au serveur sftp à Mr Andy"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-14 13:18:48	2022-02-14 13:18:48
4960	Tâche "Demander l'accès au serveur sftp à Mr Andy"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-14 13:18:48	2022-02-14 13:18:48
4961	Tâche "Demander l'accès au serveur sftp à Mr Andy"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-14 13:18:48	2022-02-14 13:18:48
4962	Tâche "Demander l'accès au serveur sftp à Mr Andy"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-14 13:18:48	2022-02-14 13:18:48
4963	Tâche nouvellement créee du nom de Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	53	2022-02-14 13:21:59	2022-02-14 13:21:59
4964	Tâche nouvellement créee du nom de Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	57	2022-02-14 13:21:59	2022-02-14 13:21:59
4965	Tâche nouvellement créee du nom de Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	71	2022-02-14 13:21:59	2022-02-14 13:21:59
4966	Tâche nouvellement créee du nom de Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	85	2022-02-14 13:21:59	2022-02-14 13:21:59
4967	Tâche Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation archivée par Mihaja.	f	70	53	2022-02-14 13:22:11	2022-02-14 13:22:11
4968	Tâche Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation archivée par Mihaja.	f	70	57	2022-02-14 13:22:11	2022-02-14 13:22:11
4969	Tâche Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation archivée par Mihaja.	f	70	71	2022-02-14 13:22:11	2022-02-14 13:22:11
4970	Tâche Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation archivée par Mihaja.	f	70	85	2022-02-14 13:22:11	2022-02-14 13:22:11
4984	Haro vous a assigné à la tâche Finir le rapprochement bancaire pour une banque dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	79	79	2022-02-14 13:25:13	2022-02-14 13:25:13
5898	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	71	2022-02-21 09:39:01	2022-02-21 09:39:01
5899	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	85	2022-02-21 09:39:01	2022-02-21 09:39:01
5912	La tâche Renommer "TVA" en "TVA sur fees" dans la facture a été achevée.	f	78	53	2022-02-21 11:55:21	2022-02-21 11:55:21
5913	La tâche Renommer "TVA" en "TVA sur fees" dans la facture a été achevée.	f	78	57	2022-02-21 11:55:21	2022-02-21 11:55:21
5915	La tâche Renommer "TVA" en "TVA sur fees" dans la facture a été achevée.	f	78	71	2022-02-21 11:55:21	2022-02-21 11:55:21
5916	La tâche Renommer "TVA" en "TVA sur fees" dans la facture a été achevée.	f	78	85	2022-02-21 11:55:21	2022-02-21 11:55:21
4873	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	53	2022-02-14 09:16:53	2022-02-14 09:16:53
4874	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	57	2022-02-14 09:16:53	2022-02-14 09:16:53
4876	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	71	2022-02-14 09:16:53	2022-02-14 09:16:53
4877	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	85	2022-02-14 09:16:53	2022-02-14 09:16:53
4939	Tâche nouvellement créee du nom de Envoyer le fichier export de l’écriture comptable sous format LOCPRO à Mr Andy pour un test d’import sur Incadea  par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	53	2022-02-14 13:17:28	2022-02-14 13:17:28
4940	Tâche nouvellement créee du nom de Envoyer le fichier export de l’écriture comptable sous format LOCPRO à Mr Andy pour un test d’import sur Incadea  par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	57	2022-02-14 13:17:28	2022-02-14 13:17:28
4941	Tâche nouvellement créee du nom de Envoyer le fichier export de l’écriture comptable sous format LOCPRO à Mr Andy pour un test d’import sur Incadea  par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	71	2022-02-14 13:17:28	2022-02-14 13:17:28
4942	Tâche nouvellement créee du nom de Envoyer le fichier export de l’écriture comptable sous format LOCPRO à Mr Andy pour un test d’import sur Incadea  par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	85	2022-02-14 13:17:28	2022-02-14 13:17:28
4971	Tâche nouvellement créee du nom de Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation par Mihaja dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	70	53	2022-02-14 13:24:18	2022-02-14 13:24:18
4972	Tâche nouvellement créee du nom de Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation par Mihaja dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	70	57	2022-02-14 13:24:18	2022-02-14 13:24:18
4973	Tâche nouvellement créee du nom de Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation par Mihaja dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	70	71	2022-02-14 13:24:18	2022-02-14 13:24:18
4974	Tâche nouvellement créee du nom de Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation par Mihaja dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	70	85	2022-02-14 13:24:18	2022-02-14 13:24:18
4985	Tâche nouvellement créee du nom de Envoyer de la liste des articles pour indiquer ceux qui sont à publier ou non sur le site par Mihaja dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	70	53	2022-02-14 13:25:36	2022-02-14 13:25:36
4986	Tâche nouvellement créee du nom de Envoyer de la liste des articles pour indiquer ceux qui sont à publier ou non sur le site par Mihaja dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	70	57	2022-02-14 13:25:36	2022-02-14 13:25:36
4987	Tâche nouvellement créee du nom de Envoyer de la liste des articles pour indiquer ceux qui sont à publier ou non sur le site par Mihaja dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	70	71	2022-02-14 13:25:36	2022-02-14 13:25:36
4988	Tâche nouvellement créee du nom de Envoyer de la liste des articles pour indiquer ceux qui sont à publier ou non sur le site par Mihaja dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	70	85	2022-02-14 13:25:36	2022-02-14 13:25:36
4875	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	t	74	70	2022-02-14 09:16:53	2022-02-14 09:16:53
5931	Tâche "Ajustement des stocks de hhs6301"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-21 14:23:38	2022-02-21 14:23:38
5932	Tâche "Ajustement des stocks de hhs6301"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-21 14:23:38	2022-02-21 14:23:38
5934	Tâche "Ajustement des stocks de hhs6301"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-21 14:23:38	2022-02-21 14:23:38
5935	Tâche "Ajustement des stocks de hhs6301"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-21 14:23:38	2022-02-21 14:23:38
5936	Tâche "Ajustement des stocks de hhs6301"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-21 14:23:42	2022-02-21 14:23:42
5937	Tâche "Ajustement des stocks de hhs6301"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-21 14:23:42	2022-02-21 14:23:42
5939	Tâche "Ajustement des stocks de hhs6301"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-21 14:23:42	2022-02-21 14:23:42
5940	Tâche "Ajustement des stocks de hhs6301"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-21 14:23:42	2022-02-21 14:23:42
5956	Tâche nouvellement créee du nom de Tester un module pour mettre les avances sur Odoo  par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	53	2022-02-21 14:26:18	2022-02-21 14:26:18
5957	Tâche nouvellement créee du nom de Tester un module pour mettre les avances sur Odoo  par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	57	2022-02-21 14:26:18	2022-02-21 14:26:18
5958	Tâche nouvellement créee du nom de Tester un module pour mettre les avances sur Odoo  par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	71	2022-02-21 14:26:18	2022-02-21 14:26:18
5959	Tâche nouvellement créee du nom de Tester un module pour mettre les avances sur Odoo  par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	85	2022-02-21 14:26:18	2022-02-21 14:26:18
5933	Tâche "Ajustement des stocks de hhs6301"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-21 14:23:38	2022-02-21 14:23:38
5938	Tâche "Ajustement des stocks de hhs6301"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-21 14:23:42	2022-02-21 14:23:42
6370	Tâche nouvellement créee du nom de Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes. par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-02-23 07:12:59	2022-02-23 07:12:59
6371	Tâche nouvellement créee du nom de Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes. par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-02-23 07:12:59	2022-02-23 07:12:59
7074	La tâche Mise à jour emplacement dépôt 2 du 23/02/2022 a été achevée.	f	77	71	2022-02-28 13:33:50	2022-02-28 13:33:50
4882	Mihaja vous a assigné à la tâche Intégration des requêtes et adaptation des programmes synchro dans le projet Synchro du site Computek.	f	70	74	2022-02-14 09:17:21	2022-02-14 09:17:21
4929	Tâche nouvellement créee du nom de Mise à jour tarifs par Michel dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	71	53	2022-02-14 11:35:50	2022-02-14 11:35:50
4930	Tâche nouvellement créee du nom de Mise à jour tarifs par Michel dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	71	57	2022-02-14 11:35:50	2022-02-14 11:35:50
4932	Tâche nouvellement créee du nom de Mise à jour tarifs par Michel dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	71	85	2022-02-14 11:35:50	2022-02-14 11:35:50
4952	Tâche "Demander la liste de tous les clients Incadea à mettre en place sur le dossier de test"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-14 13:18:14	2022-02-14 13:18:14
4953	Tâche "Demander la liste de tous les clients Incadea à mettre en place sur le dossier de test"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-14 13:18:14	2022-02-14 13:18:14
4954	Tâche "Demander la liste de tous les clients Incadea à mettre en place sur le dossier de test"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-14 13:18:14	2022-02-14 13:18:14
4979	Tâche nouvellement créee du nom de Finir le rapprochement bancaire pour une banque par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	53	2022-02-14 13:25:13	2022-02-14 13:25:13
4980	Tâche nouvellement créee du nom de Finir le rapprochement bancaire pour une banque par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	57	2022-02-14 13:25:13	2022-02-14 13:25:13
4982	Tâche nouvellement créee du nom de Finir le rapprochement bancaire pour une banque par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	71	2022-02-14 13:25:13	2022-02-14 13:25:13
4983	Tâche nouvellement créee du nom de Finir le rapprochement bancaire pour une banque par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	85	2022-02-14 13:25:13	2022-02-14 13:25:13
4931	Tâche nouvellement créee du nom de Mise à jour tarifs par Michel dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	71	70	2022-02-14 11:35:50	2022-02-14 11:35:50
4981	Tâche nouvellement créee du nom de Finir le rapprochement bancaire pour une banque par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	79	70	2022-02-14 13:25:13	2022-02-14 13:25:13
5945	La tâche Renommer "Agence de voyage" en "Agences de voyage" a été achevée.	f	78	85	2022-02-21 14:25:48	2022-02-21 14:25:48
5965	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Matthieu	f	81	53	2022-02-21 14:39:40	2022-02-21 14:39:40
5966	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Matthieu	f	81	57	2022-02-21 14:39:40	2022-02-21 14:39:40
5968	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Matthieu	f	81	71	2022-02-21 14:39:40	2022-02-21 14:39:40
5969	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Matthieu	f	81	85	2022-02-21 14:39:40	2022-02-21 14:39:40
5967	Tâche "Rajouter sur l'historique quand il y a un ajustement de stock"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Matthieu	t	81	70	2022-02-21 14:39:40	2022-02-21 14:39:40
6372	Tâche nouvellement créee du nom de Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes. par Osé dans le projet Sauvegarde FTP des clients .	f	74	70	2022-02-23 07:12:59	2022-02-23 07:12:59
6373	Tâche nouvellement créee du nom de Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes. par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-02-23 07:12:59	2022-02-23 07:12:59
6374	Tâche nouvellement créee du nom de Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes. par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-02-23 07:12:59	2022-02-23 07:12:59
6391	Tâche nouvellement créee du nom de Intégration inventaire Showroom Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-23 14:38:33	2022-02-23 14:38:33
6392	Tâche nouvellement créee du nom de Intégration inventaire Showroom Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-23 14:38:33	2022-02-23 14:38:33
6393	Tâche nouvellement créee du nom de Intégration inventaire Showroom Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-02-23 14:38:33	2022-02-23 14:38:33
6394	Tâche nouvellement créee du nom de Intégration inventaire Showroom Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-23 14:38:33	2022-02-23 14:38:33
6395	Tâche nouvellement créee du nom de Intégration inventaire Showroom Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-23 14:38:33	2022-02-23 14:38:33
6422	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-02-24 05:02:09	2022-02-24 05:02:09
6423	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-02-24 05:02:09	2022-02-24 05:02:09
6425	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-02-24 05:02:09	2022-02-24 05:02:09
6424	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	t	74	70	2022-02-24 05:02:09	2022-02-24 05:02:09
4887	Tâche "Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	53	2022-02-14 09:17:35	2022-02-14 09:17:35
4888	Tâche "Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	57	2022-02-14 09:17:35	2022-02-14 09:17:35
4889	Tâche "Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	71	2022-02-14 09:17:35	2022-02-14 09:17:35
4890	Tâche "Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	85	2022-02-14 09:17:35	2022-02-14 09:17:35
4955	Tâche nouvellement créee du nom de Demander l'accès au serveur sftp à Mr Andy par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	53	2022-02-14 13:18:42	2022-02-14 13:18:42
4956	Tâche nouvellement créee du nom de Demander l'accès au serveur sftp à Mr Andy par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	57	2022-02-14 13:18:42	2022-02-14 13:18:42
4957	Tâche nouvellement créee du nom de Demander l'accès au serveur sftp à Mr Andy par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	71	2022-02-14 13:18:42	2022-02-14 13:18:42
4958	Tâche nouvellement créee du nom de Demander l'accès au serveur sftp à Mr Andy par Mihaja dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	70	85	2022-02-14 13:18:42	2022-02-14 13:18:42
4989	Tâche nouvellement créee du nom de Analyser la problématique d'envoi automatique des messages whatsapp et mails par Mihaja dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	70	53	2022-02-14 13:26:23	2022-02-14 13:26:23
4990	Tâche nouvellement créee du nom de Analyser la problématique d'envoi automatique des messages whatsapp et mails par Mihaja dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	70	57	2022-02-14 13:26:23	2022-02-14 13:26:23
4991	Tâche nouvellement créee du nom de Analyser la problématique d'envoi automatique des messages whatsapp et mails par Mihaja dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	70	71	2022-02-14 13:26:23	2022-02-14 13:26:23
4992	Tâche nouvellement créee du nom de Analyser la problématique d'envoi automatique des messages whatsapp et mails par Mihaja dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	70	85	2022-02-14 13:26:23	2022-02-14 13:26:23
4993	Un projet du nom de M-TEC - Mise en place d'un nouveau dossier a été crée par Michel	f	71	53	2022-02-14 22:56:37	2022-02-14 22:56:37
4994	Un projet du nom de M-TEC - Mise en place d'un nouveau dossier a été crée par Michel	f	71	57	2022-02-14 22:56:37	2022-02-14 22:56:37
4996	Un projet du nom de M-TEC - Mise en place d'un nouveau dossier a été crée par Michel	f	71	85	2022-02-14 22:56:37	2022-02-14 22:56:37
4997	Tâche nouvellement créee du nom de Création d'un champ "publier sur le web"  sur les catégories par Nasolo dans le projet Site web QLM.	f	72	53	2022-02-15 07:11:45	2022-02-15 07:11:45
4998	Tâche nouvellement créee du nom de Création d'un champ "publier sur le web"  sur les catégories par Nasolo dans le projet Site web QLM.	f	72	57	2022-02-15 07:11:45	2022-02-15 07:11:45
5000	Tâche nouvellement créee du nom de Création d'un champ "publier sur le web"  sur les catégories par Nasolo dans le projet Site web QLM.	f	72	71	2022-02-15 07:11:45	2022-02-15 07:11:45
5001	Tâche nouvellement créee du nom de Création d'un champ "publier sur le web"  sur les catégories par Nasolo dans le projet Site web QLM.	f	72	85	2022-02-15 07:11:45	2022-02-15 07:11:45
4995	Un projet du nom de M-TEC - Mise en place d'un nouveau dossier a été crée par Michel	t	71	70	2022-02-14 22:56:37	2022-02-14 22:56:37
4999	Tâche nouvellement créee du nom de Création d'un champ "publier sur le web"  sur les catégories par Nasolo dans le projet Site web QLM.	t	72	70	2022-02-15 07:11:45	2022-02-15 07:11:45
5949	La tâche Renommer "Émis" en "émis" dans impression facture a été achevée.	f	78	71	2022-02-21 14:26:00	2022-02-21 14:26:00
5950	La tâche Renommer "Émis" en "émis" dans impression facture a été achevée.	f	78	85	2022-02-21 14:26:00	2022-02-21 14:26:00
5951	La tâche Dans la fiche facture, masquer le bouton "Remettre en brouillon" a été achevée.	f	78	53	2022-02-21 14:26:11	2022-02-21 14:26:11
5952	La tâche Dans la fiche facture, masquer le bouton "Remettre en brouillon" a été achevée.	f	78	57	2022-02-21 14:26:11	2022-02-21 14:26:11
5954	La tâche Dans la fiche facture, masquer le bouton "Remettre en brouillon" a été achevée.	f	78	71	2022-02-21 14:26:11	2022-02-21 14:26:11
5955	La tâche Dans la fiche facture, masquer le bouton "Remettre en brouillon" a été achevée.	f	78	85	2022-02-21 14:26:11	2022-02-21 14:26:11
5961	Tâche "Tester un module pour mettre les avances sur Odoo "\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	53	2022-02-21 14:26:29	2022-02-21 14:26:29
5962	Tâche "Tester un module pour mettre les avances sur Odoo "\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	57	2022-02-21 14:26:29	2022-02-21 14:26:29
5963	Tâche "Tester un module pour mettre les avances sur Odoo "\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	71	2022-02-21 14:26:29	2022-02-21 14:26:29
5964	Tâche "Tester un module pour mettre les avances sur Odoo "\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	85	2022-02-21 14:26:29	2022-02-21 14:26:29
5970	Tâche "Vérification des articles avec doublons"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-22 05:21:12	2022-02-22 05:21:12
5971	Tâche "Vérification des articles avec doublons"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-22 05:21:12	2022-02-22 05:21:12
5973	Tâche "Vérification des articles avec doublons"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-22 05:21:12	2022-02-22 05:21:12
5948	La tâche Renommer "Émis" en "émis" dans impression facture a été achevée.	t	78	70	2022-02-21 14:26:00	2022-02-21 14:26:00
7075	La tâche Mise à jour emplacement dépôt 2 du 23/02/2022 a été achevée.	f	77	85	2022-02-28 13:33:50	2022-02-28 13:33:50
7130	Tâche nouvellement créee du nom de Tâche 1 par Michel dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	71	53	2022-03-01 09:08:00	2022-03-01 09:08:00
7131	Tâche nouvellement créee du nom de Tâche 1 par Michel dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	71	57	2022-03-01 09:08:00	2022-03-01 09:08:00
4912	Tâche nouvellement créee du nom de Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on par Mihaja dans le projet Synchro du site Computek.	f	70	53	2022-02-14 09:20:37	2022-02-14 09:20:37
4913	Tâche nouvellement créee du nom de Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on par Mihaja dans le projet Synchro du site Computek.	f	70	57	2022-02-14 09:20:37	2022-02-14 09:20:37
4914	Tâche nouvellement créee du nom de Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on par Mihaja dans le projet Synchro du site Computek.	f	70	71	2022-02-14 09:20:37	2022-02-14 09:20:37
4915	Tâche nouvellement créee du nom de Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on par Mihaja dans le projet Synchro du site Computek.	f	70	85	2022-02-14 09:20:37	2022-02-14 09:20:37
4920	Un projet du nom de COMPUTEK - Intervention / Accompagnement 2022 a été crée par Michel	f	71	53	2022-02-14 11:32:14	2022-02-14 11:32:14
4921	Un projet du nom de COMPUTEK - Intervention / Accompagnement 2022 a été crée par Michel	f	71	57	2022-02-14 11:32:14	2022-02-14 11:32:14
4923	Un projet du nom de COMPUTEK - Intervention / Accompagnement 2022 a été crée par Michel	f	71	85	2022-02-14 11:32:14	2022-02-14 11:32:14
4938	Michel vous a assigné à la tâche Prise en compte des données Tour (en cas de modification du circuit) dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	71	79	2022-02-14 11:43:00	2022-02-14 11:43:00
5018	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	53	2022-02-15 07:14:29	2022-02-15 07:14:29
5019	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	57	2022-02-15 07:14:29	2022-02-15 07:14:29
5021	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	71	2022-02-15 07:14:29	2022-02-15 07:14:29
5022	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	85	2022-02-15 07:14:29	2022-02-15 07:14:29
5002	Nasolo vous a assigné à la tâche Création d'un champ "publier sur le web"  sur les catégories dans le projet Site web QLM.	t	72	72	2022-02-15 07:11:45	2022-02-15 07:11:45
4922	Un projet du nom de COMPUTEK - Intervention / Accompagnement 2022 a été crée par Michel	t	71	70	2022-02-14 11:32:14	2022-02-14 11:32:14
5020	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	t	74	70	2022-02-15 07:14:29	2022-02-15 07:14:29
4895	Mihaja vous a assigné à la tâche Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site dans le projet Synchro du site Computek.	t	70	75	2022-02-14 09:18:12	2022-02-14 09:18:12
5974	Tâche "Vérification des articles avec doublons"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-22 05:21:12	2022-02-22 05:21:12
5996	Tâche "Correction des conflits entre la version WP all import et Wordpress"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	53	2022-02-22 07:42:31	2022-02-22 07:42:31
5997	Tâche "Correction des conflits entre la version WP all import et Wordpress"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	57	2022-02-22 07:42:31	2022-02-22 07:42:31
5999	Tâche "Correction des conflits entre la version WP all import et Wordpress"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	71	2022-02-22 07:42:31	2022-02-22 07:42:31
6000	Tâche "Correction des conflits entre la version WP all import et Wordpress"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	85	2022-02-22 07:42:31	2022-02-22 07:42:31
5998	Tâche "Correction des conflits entre la version WP all import et Wordpress"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	t	75	70	2022-02-22 07:42:31	2022-02-22 07:42:31
6375	Osé vous a assigné à la tâche Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes. dans le projet Sauvegarde FTP des clients .	f	74	74	2022-02-23 07:12:59	2022-02-23 07:12:59
6386	Tâche "Tester un module pour mettre les avances sur Odoo "\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Nasolo	f	72	53	2022-02-23 12:21:56	2022-02-23 12:21:56
6387	Tâche "Tester un module pour mettre les avances sur Odoo "\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Nasolo	f	72	57	2022-02-23 12:21:56	2022-02-23 12:21:56
6388	Tâche "Tester un module pour mettre les avances sur Odoo "\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Nasolo	f	72	70	2022-02-23 12:21:56	2022-02-23 12:21:56
6389	Tâche "Tester un module pour mettre les avances sur Odoo "\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Nasolo	f	72	71	2022-02-23 12:21:56	2022-02-23 12:21:56
6390	Tâche "Tester un module pour mettre les avances sur Odoo "\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Nasolo	f	72	85	2022-02-23 12:21:56	2022-02-23 12:21:56
6455	Mihaja vous a assigné à la tâche Modification du banner sur l'accueil dans le projet CDC - Intervention Site web.	f	70	75	2022-02-24 07:31:39	2022-02-24 07:31:39
6589	Tâche nouvellement créee du nom de Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:12:35	2022-02-25 07:12:35
6590	Tâche nouvellement créee du nom de Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:12:35	2022-02-25 07:12:35
6657	Tâche "Renommer "Nombre" en "Nombre de nuitées""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	71	2022-02-25 07:22:03	2022-02-25 07:22:03
7123	Tâche nouvellement créee du nom de Tâche 1 par Michel dans le projet NAJMI - Mise en place.	f	71	70	2022-03-01 09:03:49	2022-03-01 09:03:49
7124	Tâche nouvellement créee du nom de Tâche 1 par Michel dans le projet NAJMI - Mise en place.	f	71	85	2022-03-01 09:03:49	2022-03-01 09:03:49
7231	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	53	2022-03-01 11:43:49	2022-03-01 11:43:49
7232	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	57	2022-03-01 11:43:49	2022-03-01 11:43:49
4904	Tâche nouvellement créee du nom de création d'import produit et catégories, et correspondance des champs d'import sur le site par Mihaja dans le projet Synchro du site Computek.	f	70	53	2022-02-14 09:19:58	2022-02-14 09:19:58
4905	Tâche nouvellement créee du nom de création d'import produit et catégories, et correspondance des champs d'import sur le site par Mihaja dans le projet Synchro du site Computek.	f	70	57	2022-02-14 09:19:58	2022-02-14 09:19:58
4906	Tâche nouvellement créee du nom de création d'import produit et catégories, et correspondance des champs d'import sur le site par Mihaja dans le projet Synchro du site Computek.	f	70	71	2022-02-14 09:19:58	2022-02-14 09:19:58
4907	Tâche nouvellement créee du nom de création d'import produit et catégories, et correspondance des champs d'import sur le site par Mihaja dans le projet Synchro du site Computek.	f	70	85	2022-02-14 09:19:58	2022-02-14 09:19:58
4908	Tâche "création d'import produit et catégories, et correspondance des champs d'import sur le site"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	53	2022-02-14 09:20:02	2022-02-14 09:20:02
4909	Tâche "création d'import produit et catégories, et correspondance des champs d'import sur le site"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	57	2022-02-14 09:20:02	2022-02-14 09:20:02
4910	Tâche "création d'import produit et catégories, et correspondance des champs d'import sur le site"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	71	2022-02-14 09:20:02	2022-02-14 09:20:02
4911	Tâche "création d'import produit et catégories, et correspondance des champs d'import sur le site"\n          du projet Synchro du site Computek mise dans " En cours " par Mihaja	f	70	85	2022-02-14 09:20:02	2022-02-14 09:20:02
4924	Tâche nouvellement créee du nom de Mise à jour des familles par Michel dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	71	53	2022-02-14 11:34:35	2022-02-14 11:34:35
4925	Tâche nouvellement créee du nom de Mise à jour des familles par Michel dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	71	57	2022-02-14 11:34:35	2022-02-14 11:34:35
4927	Tâche nouvellement créee du nom de Mise à jour des familles par Michel dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	71	85	2022-02-14 11:34:35	2022-02-14 11:34:35
5003	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	53	2022-02-15 07:12:19	2022-02-15 07:12:19
5004	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	57	2022-02-15 07:12:19	2022-02-15 07:12:19
5006	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	71	2022-02-15 07:12:19	2022-02-15 07:12:19
5007	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	85	2022-02-15 07:12:19	2022-02-15 07:12:19
4926	Tâche nouvellement créee du nom de Mise à jour des familles par Michel dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	71	70	2022-02-14 11:34:35	2022-02-14 11:34:35
5005	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	t	72	70	2022-02-15 07:12:19	2022-02-15 07:12:19
5986	Tâche "Départ et Arrivée: des listes déroulantes (quand on a la liste)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	57	2022-02-22 06:33:50	2022-02-22 06:33:50
5988	Tâche "Départ et Arrivée: des listes déroulantes (quand on a la liste)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	71	2022-02-22 06:33:50	2022-02-22 06:33:50
5989	Tâche "Départ et Arrivée: des listes déroulantes (quand on a la liste)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	85	2022-02-22 06:33:50	2022-02-22 06:33:50
5987	Tâche "Départ et Arrivée: des listes déroulantes (quand on a la liste)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	t	78	70	2022-02-22 06:33:50	2022-02-22 06:33:50
6376	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	53	2022-02-23 07:13:13	2022-02-23 07:13:13
6377	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	57	2022-02-23 07:13:13	2022-02-23 07:13:13
6378	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	70	2022-02-23 07:13:13	2022-02-23 07:13:13
6379	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	71	2022-02-23 07:13:13	2022-02-23 07:13:13
6380	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	85	2022-02-23 07:13:13	2022-02-23 07:13:13
6451	Tâche nouvellement créee du nom de Modification du banner sur l'accueil par Mihaja dans le projet CDC - Intervention Site web.	f	70	53	2022-02-24 07:31:39	2022-02-24 07:31:39
6452	Tâche nouvellement créee du nom de Modification du banner sur l'accueil par Mihaja dans le projet CDC - Intervention Site web.	f	70	57	2022-02-24 07:31:39	2022-02-24 07:31:39
6453	Tâche nouvellement créee du nom de Modification du banner sur l'accueil par Mihaja dans le projet CDC - Intervention Site web.	f	70	71	2022-02-24 07:31:39	2022-02-24 07:31:39
6454	Tâche nouvellement créee du nom de Modification du banner sur l'accueil par Mihaja dans le projet CDC - Intervention Site web.	f	70	85	2022-02-24 07:31:39	2022-02-24 07:31:39
6465	Elie vous a assigné à la tâche Mise à jour Code-barre articles Pointes dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-02-24 08:00:31	2022-02-24 08:00:31
6476	Tâche nouvellement créee du nom de Mise en place E-mail "cheinmaltcompta2@groupe-qlm.com" par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-24 08:50:40	2022-02-24 08:50:40
6477	Tâche nouvellement créee du nom de Mise en place E-mail "cheinmaltcompta2@groupe-qlm.com" par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-24 08:50:40	2022-02-24 08:50:40
5008	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	53	2022-02-15 07:12:23	2022-02-15 07:12:23
5009	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	57	2022-02-15 07:12:23	2022-02-15 07:12:23
5011	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	71	2022-02-15 07:12:23	2022-02-15 07:12:23
5012	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	85	2022-02-15 07:12:23	2022-02-15 07:12:23
5010	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En cours " par Nasolo	t	72	70	2022-02-15 07:12:23	2022-02-15 07:12:23
5189	Osé vous a assigné à la tâche Envoyer fichier dans l'FTP du Site COMPUTEK dans le projet Synchro du site Computek.	t	74	74	2022-02-16 07:11:44	2022-02-16 07:11:44
5308	Osé vous a assigné à la tâche Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro  dans le projet Synchro du site Computek.	t	74	74	2022-02-17 06:56:59	2022-02-17 06:56:59
5828	Mihaja vous a assigné à la tâche Adaptation/Vérification du programme Import Devis sur EBP dans le projet Synchro du site Computek.	t	70	74	2022-02-21 09:21:02	2022-02-21 09:21:02
6381	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	53	2022-02-23 08:33:12	2022-02-23 08:33:12
6382	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	57	2022-02-23 08:33:12	2022-02-23 08:33:12
6383	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	70	2022-02-23 08:33:12	2022-02-23 08:33:12
6384	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	71	2022-02-23 08:33:12	2022-02-23 08:33:12
6385	Tâche "module de notification odoo"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	85	2022-02-23 08:33:12	2022-02-23 08:33:12
6397	Tâche "Intégration inventaire Showroom Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-23 14:38:37	2022-02-23 14:38:37
6398	Tâche "Intégration inventaire Showroom Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-23 14:38:37	2022-02-23 14:38:37
6399	Tâche "Intégration inventaire Showroom Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	70	2022-02-23 14:38:37	2022-02-23 14:38:37
6400	Tâche "Intégration inventaire Showroom Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-23 14:38:37	2022-02-23 14:38:37
6401	Tâche "Intégration inventaire Showroom Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-23 14:38:37	2022-02-23 14:38:37
6481	Elie vous a assigné à la tâche Mise en place E-mail "cheinmaltcompta2@groupe-qlm.com" dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-02-24 08:50:40	2022-02-24 08:50:40
6513	La tâche Intégration d'inventaire pour MOB+ a été achevée.	f	76	53	2022-02-24 12:44:48	2022-02-24 12:44:48
6514	La tâche Intégration d'inventaire pour MOB+ a été achevée.	f	76	57	2022-02-24 12:44:48	2022-02-24 12:44:48
6516	La tâche Intégration d'inventaire pour MOB+ a été achevée.	f	76	71	2022-02-24 12:44:48	2022-02-24 12:44:48
6517	La tâche Intégration d'inventaire pour MOB+ a été achevée.	f	76	85	2022-02-24 12:44:48	2022-02-24 12:44:48
6518	Tâche nouvellement créee du nom de Suppression des doublons des clients par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-24 12:45:41	2022-02-24 12:45:41
6519	Tâche nouvellement créee du nom de Suppression des doublons des clients par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-24 12:45:41	2022-02-24 12:45:41
6521	Tâche nouvellement créee du nom de Suppression des doublons des clients par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-24 12:45:41	2022-02-24 12:45:41
6522	Tâche nouvellement créee du nom de Suppression des doublons des clients par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-24 12:45:41	2022-02-24 12:45:41
6558	Tâche nouvellement créee du nom de Intégration des Stocks dépôt 2 PO24141 et autres articles (carreaux) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-24 14:00:50	2022-02-24 14:00:50
6559	Tâche nouvellement créee du nom de Intégration des Stocks dépôt 2 PO24141 et autres articles (carreaux) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-24 14:00:50	2022-02-24 14:00:50
6561	Tâche nouvellement créee du nom de Intégration des Stocks dépôt 2 PO24141 et autres articles (carreaux) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-24 14:00:50	2022-02-24 14:00:50
6562	Tâche nouvellement créee du nom de Intégration des Stocks dépôt 2 PO24141 et autres articles (carreaux) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-24 14:00:50	2022-02-24 14:00:50
6596	Tâche nouvellement créee du nom de Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:13:42	2022-02-25 07:13:42
6608	Rémi vous a assigné à la tâche Synchronisation des clients odoo avec ceux dans Incadea dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:15:13	2022-02-25 07:15:13
6637	Tâche nouvellement créee du nom de Renommer "Quantité" en "Nombre de chambres/personnes" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:20:53	2022-02-25 07:20:53
6638	Tâche nouvellement créee du nom de Renommer "Quantité" en "Nombre de chambres/personnes" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:20:53	2022-02-25 07:20:53
5013	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	f	74	53	2022-02-15 07:14:23	2022-02-15 07:14:23
5014	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	f	74	57	2022-02-15 07:14:23	2022-02-15 07:14:23
5016	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	f	74	71	2022-02-15 07:14:23	2022-02-15 07:14:23
5017	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	f	74	85	2022-02-15 07:14:23	2022-02-15 07:14:23
4150	Tâche "Paramétrage paie - création structure solde de congé, min irsa sur 3000"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-04 12:53:49	2022-02-04 12:53:49
4153	Tâche nouvellement créee du nom de Vérification des sauvegardes sur les serveurs clients  par Osé dans le projet Sauvegarde FTP des clients .	t	74	70	2022-02-07 08:52:08	2022-02-07 08:52:08
4210	Tâche "module de notification windows lors d'un nouveau message odoo"\n          du projet Site web QLM mise dans " En cours " par Nasolo	t	72	70	2022-02-07 10:45:51	2022-02-07 10:45:51
4214	Tâche nouvellement créee du nom de Ajout de colonne comptes auxiliaires dans les écritures comptables par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 10:47:37	2022-02-07 10:47:37
4219	Tâche nouvellement créee du nom de Afficher les autres taxes dans les documents factures et achats par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 10:51:20	2022-02-07 10:51:20
4224	Tâche nouvellement créee du nom de Document travel order doit être non modifiable à partir de 'accepté' par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 10:52:35	2022-02-07 10:52:35
4239	Tâche nouvellement créee du nom de Gestion des clients en compte et client de passage par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 10:56:48	2022-02-07 10:56:48
4245	Tâche nouvellement créee du nom de statut accepté => génération de doc achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 12:44:44	2022-02-07 12:44:44
4250	Tâche nouvellement créee du nom de statut confirmé => génération de factures clients et fournisseurs par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 12:45:57	2022-02-07 12:45:57
4270	Tâche nouvellement créee du nom de Copie de certains champs lors d'une duplication de document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 12:50:50	2022-02-07 12:50:50
4298	Tâche nouvellement créee du nom de Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 12:59:55	2022-02-07 12:59:55
4319	Tâche nouvellement créee du nom de Ajouter un champs pour le numéro de jour par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-07 13:06:59	2022-02-07 13:06:59
4342	Tâche "Document travel order doit être non modifiable à partir de 'accepté'"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-07 13:23:33	2022-02-07 13:23:33
4346	Tâche "Afficher les fournisseurs dans la facture client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-07 13:23:44	2022-02-07 13:23:44
4355	Tâche nouvellement créee du nom de module de notification odoo par Nasolo dans le projet Site web QLM.	t	72	70	2022-02-07 13:38:13	2022-02-07 13:38:13
4364	Tâche "Gestion des droits de validations de devis"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 08:57:46	2022-02-08 08:57:46
4376	Tâche "statut accepté => génération de doc achat"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 08:58:12	2022-02-08 08:58:12
4396	Tâche "Ajouter le numéro pnr dans la commande (nouveau champs)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 08:59:11	2022-02-08 08:59:11
4404	Tâche "Changement de libellé: Usager => Passager, Partenaire => Client"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 09:00:56	2022-02-08 09:00:56
4408	Tâche "Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 09:01:16	2022-02-08 09:01:16
4412	Tâche "Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 09:01:25	2022-02-08 09:01:25
4428	Tâche "Ne pas afficher les détails des lignes dans l'impression (facture, devis, commande, pro forma)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 09:02:02	2022-02-08 09:02:02
4432	Tâche "Type du chams libellé global: Char => Text"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-08 09:02:15	2022-02-08 09:02:15
4436	Tâche nouvellement créee du nom de Suppression backup ancienne par Osé dans le projet Sauvegarde FTP des clients .	t	74	70	2022-02-08 09:05:09	2022-02-08 09:05:09
4441	Tâche nouvellement créee du nom de Normalisation l'heure d'envoie backup par Osé dans le projet Sauvegarde FTP des clients .	t	74	70	2022-02-08 09:07:00	2022-02-08 09:07:00
4446	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	t	74	70	2022-02-08 09:08:02	2022-02-08 09:08:02
4450	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	t	74	70	2022-02-08 09:08:42	2022-02-08 09:08:42
4454	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	t	74	70	2022-02-08 09:08:48	2022-02-08 09:08:48
4458	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	t	74	70	2022-02-08 09:08:49	2022-02-08 09:08:49
4488	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	t	74	70	2022-02-08 10:04:34	2022-02-08 10:04:34
4493	Tâche nouvellement créee du nom de Photos INGCO par Elie dans le projet Intervention / Accompagnement 2022.	t	77	70	2022-02-08 10:42:12	2022-02-08 10:42:12
4541	Tâche nouvellement créee du nom de Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-08 13:29:51	2022-02-08 13:29:51
4546	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	t	78	70	2022-02-08 13:30:29	2022-02-08 13:30:29
4579	Tâche nouvellement créee du nom de Pouvoir attribuer une tâche à un attributteur par Michel dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	t	71	70	2022-02-08 14:18:14	2022-02-08 14:18:14
4616	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-09 08:34:42	2022-02-09 08:34:42
4626	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-09 08:35:07	2022-02-09 08:35:07
4641	Tâche nouvellement créee du nom de Mise à jours totes les photos INGCO par Elie dans le projet Intervention / Accompagnement 2022.	t	77	70	2022-02-09 09:04:07	2022-02-09 09:04:07
4663	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En blocage " par Famenontsoa	t	73	70	2022-02-09 09:54:08	2022-02-09 09:54:08
4668	Tâche "Définir le libellé des lignes 401 fournisseurs et 411 clients de l'écriture comptables (valeur: libellé global de la commande)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	t	78	70	2022-02-09 10:03:25	2022-02-09 10:03:25
4717	Tâche "Mise en place des articles sans emplacement Odoo"\n          du projet Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-10 09:02:48	2022-02-10 09:02:48
4727	Tâche "Ajouter une référence du document achat dans le document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-10 09:16:56	2022-02-10 09:16:56
4732	Tâche "Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-10 09:17:10	2022-02-10 09:17:10
4743	Tâche "Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-10 09:21:55	2022-02-10 09:21:55
4770	Tâche "Photos INGCO"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-10 19:02:14	2022-02-10 19:02:14
4774	Tâche "Intégration stock P025886"\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-10 19:03:16	2022-02-10 19:03:16
4791	Tâche nouvellement créee du nom de Intégration inventaire QLM par Elie dans le projet Intervention / Accompagnement 2022.	t	77	70	2022-02-11 07:15:01	2022-02-11 07:15:01
4802	Tâche "Intégration inventaire QLM"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-11 07:15:12	2022-02-11 07:15:12
4807	Tâche nouvellement créee du nom de Résolution des problèmes d'envoie des fichiers backup dans l'FTP par Osé dans le projet Sauvegarde FTP des clients .	t	74	70	2022-02-11 07:33:42	2022-02-11 07:33:42
4813	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	t	74	70	2022-02-11 07:33:54	2022-02-11 07:33:54
4818	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	t	74	70	2022-02-11 07:33:56	2022-02-11 07:33:56
4823	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	t	74	70	2022-02-11 07:34:11	2022-02-11 07:34:11
4828	Tâche "Installation du nouveau programme sauvegarde sur les serveurs clients"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	t	74	70	2022-02-11 07:34:30	2022-02-11 07:34:30
4839	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	t	73	70	2022-02-11 07:43:32	2022-02-11 07:43:32
4844	Tâche "Restauration du site sur le serveur de test"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	t	75	70	2022-02-11 12:53:36	2022-02-11 12:53:36
4849	Tâche nouvellement créee du nom de Mise en place du site et intégration de 'wp all import' par Fanantenana dans le projet Synchro du site Computek.	t	75	70	2022-02-11 12:57:37	2022-02-11 12:57:37
4855	Tâche "Mise en place du site et intégration de 'wp all import'"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	t	75	70	2022-02-11 12:57:45	2022-02-11 12:57:45
4864	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	t	74	70	2022-02-14 09:15:49	2022-02-14 09:15:49
4869	Tâche nouvellement créee du nom de Extraction Image EBP par Osé dans le projet Sauvegarde FTP des clients .	t	74	70	2022-02-14 09:16:47	2022-02-14 09:16:47
4936	Tâche nouvellement créee du nom de Prise en compte des données Tour (en cas de modification du circuit) par Michel dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	71	70	2022-02-14 11:43:00	2022-02-14 11:43:00
5015	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	t	74	70	2022-02-15 07:14:23	2022-02-15 07:14:23
6001	Tâche "Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-22 08:45:47	2022-02-22 08:45:47
6002	Tâche "Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-22 08:45:47	2022-02-22 08:45:47
6003	Tâche "Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-22 08:45:47	2022-02-22 08:45:47
6004	Tâche "Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-22 08:45:47	2022-02-22 08:45:47
5023	Tâche "Description technique des familles "\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-15 07:19:11	2022-02-15 07:19:11
5024	Tâche "Description technique des familles "\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-15 07:19:11	2022-02-15 07:19:11
5025	Tâche "Description technique des familles "\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-15 07:19:11	2022-02-15 07:19:11
5026	Tâche "Description technique des familles "\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-15 07:19:11	2022-02-15 07:19:11
5051	Tâche nouvellement créee du nom de Module pour bloquer le mouvement de stock quand on valide un BL daté avant l'inventaire par Mihaja dans le projet Intervention / Accompagnement 2022.	f	70	53	2022-02-15 07:35:19	2022-02-15 07:35:19
5052	Tâche nouvellement créee du nom de Module pour bloquer le mouvement de stock quand on valide un BL daté avant l'inventaire par Mihaja dans le projet Intervention / Accompagnement 2022.	f	70	57	2022-02-15 07:35:19	2022-02-15 07:35:19
5053	Tâche nouvellement créee du nom de Module pour bloquer le mouvement de stock quand on valide un BL daté avant l'inventaire par Mihaja dans le projet Intervention / Accompagnement 2022.	f	70	71	2022-02-15 07:35:19	2022-02-15 07:35:19
5054	Tâche nouvellement créee du nom de Module pour bloquer le mouvement de stock quand on valide un BL daté avant l'inventaire par Mihaja dans le projet Intervention / Accompagnement 2022.	f	70	85	2022-02-15 07:35:19	2022-02-15 07:35:19
5124	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Matthieu dans le projet Intervention / Accompagnement 2022.	f	81	53	2022-02-15 10:54:22	2022-02-15 10:54:22
5125	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Matthieu dans le projet Intervention / Accompagnement 2022.	f	81	57	2022-02-15 10:54:22	2022-02-15 10:54:22
5127	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Matthieu dans le projet Intervention / Accompagnement 2022.	f	81	71	2022-02-15 10:54:22	2022-02-15 10:54:22
5128	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Matthieu dans le projet Intervention / Accompagnement 2022.	f	81	85	2022-02-15 10:54:22	2022-02-15 10:54:22
5135	Tâche nouvellement créee du nom de Calcul automatique du montant du service fees par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	53	2022-02-15 11:14:04	2022-02-15 11:14:04
5136	Tâche nouvellement créee du nom de Calcul automatique du montant du service fees par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	57	2022-02-15 11:14:04	2022-02-15 11:14:04
5138	Tâche nouvellement créee du nom de Calcul automatique du montant du service fees par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	71	2022-02-15 11:14:04	2022-02-15 11:14:04
5139	Tâche nouvellement créee du nom de Calcul automatique du montant du service fees par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	85	2022-02-15 11:14:04	2022-02-15 11:14:04
5146	Tâche nouvellement créee du nom de Droit des utilisateurS COMPUTEK TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-15 11:17:34	2022-02-15 11:17:34
5147	Tâche nouvellement créee du nom de Droit des utilisateurS COMPUTEK TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-15 11:17:34	2022-02-15 11:17:34
5149	Tâche nouvellement créee du nom de Droit des utilisateurS COMPUTEK TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-15 11:17:34	2022-02-15 11:17:34
5150	Tâche nouvellement créee du nom de Droit des utilisateurS COMPUTEK TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-15 11:17:34	2022-02-15 11:17:34
5152	Tâche "Prise en compte des données Tour (en cas de modification du circuit)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	53	2022-02-15 11:25:15	2022-02-15 11:25:15
5153	Tâche "Prise en compte des données Tour (en cas de modification du circuit)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	57	2022-02-15 11:25:15	2022-02-15 11:25:15
5155	Tâche "Prise en compte des données Tour (en cas de modification du circuit)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	71	2022-02-15 11:25:15	2022-02-15 11:25:15
5156	Tâche "Prise en compte des données Tour (en cas de modification du circuit)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	85	2022-02-15 11:25:15	2022-02-15 11:25:15
5815	Tâche nouvellement créee du nom de Vérification des articles avec doublons par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-21 09:17:41	2022-02-21 09:17:41
5821	Tâche "Vérification des articles avec doublons"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	t	76	70	2022-02-21 09:17:52	2022-02-21 09:17:52
5831	Tâche nouvellement créee du nom de Préparation un fichier d'inventaire COMPUTEK par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-21 09:21:15	2022-02-21 09:21:15
5872	Tâche "Renommer "Montant TVA" en "Montant TVA sur fees" dans le document travel order"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-21 09:31:27	2022-02-21 09:31:27
5982	Tâche "Mettre le montant en lettre dans l'impression de facture"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	t	78	70	2022-02-22 06:33:35	2022-02-22 06:33:35
5914	La tâche Renommer "TVA" en "TVA sur fees" dans la facture a été achevée.	t	78	70	2022-02-21 11:55:21	2022-02-21 11:55:21
5953	La tâche Dans la fiche facture, masquer le bouton "Remettre en brouillon" a été achevée.	t	78	70	2022-02-21 14:26:11	2022-02-21 14:26:11
5027	Tâche "Modification de la page d'accueil"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-15 07:19:13	2022-02-15 07:19:13
5028	Tâche "Modification de la page d'accueil"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-15 07:19:13	2022-02-15 07:19:13
5029	Tâche "Modification de la page d'accueil"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-15 07:19:13	2022-02-15 07:19:13
5030	Tâche "Modification de la page d'accueil"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-15 07:19:13	2022-02-15 07:19:13
5031	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	53	2022-02-15 07:33:43	2022-02-15 07:33:43
5032	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	57	2022-02-15 07:33:43	2022-02-15 07:33:43
5034	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	71	2022-02-15 07:33:43	2022-02-15 07:33:43
5035	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	85	2022-02-15 07:33:43	2022-02-15 07:33:43
5046	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-02-15 07:34:38	2022-02-15 07:34:38
5047	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-02-15 07:34:38	2022-02-15 07:34:38
5049	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-02-15 07:34:38	2022-02-15 07:34:38
5050	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-02-15 07:34:38	2022-02-15 07:34:38
5067	Tâche nouvellement créee du nom de Modification compte article par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-15 07:38:33	2022-02-15 07:38:33
5068	Tâche nouvellement créee du nom de Modification compte article par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-15 07:38:33	2022-02-15 07:38:33
5070	Tâche nouvellement créee du nom de Modification compte article par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-15 07:38:33	2022-02-15 07:38:33
5071	Tâche nouvellement créee du nom de Modification compte article par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-15 07:38:33	2022-02-15 07:38:33
5106	Miandrisoa vous a assigné à la tâche RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-15 07:43:40	2022-02-15 07:43:40
5107	Tâche nouvellement créee du nom de Modification de la catégories d'articles  par Mihaja dans le projet Intervention / Accompagnement 2022.	f	70	53	2022-02-15 10:07:05	2022-02-15 10:07:05
5108	Tâche nouvellement créee du nom de Modification de la catégories d'articles  par Mihaja dans le projet Intervention / Accompagnement 2022.	f	70	57	2022-02-15 10:07:05	2022-02-15 10:07:05
5109	Tâche nouvellement créee du nom de Modification de la catégories d'articles  par Mihaja dans le projet Intervention / Accompagnement 2022.	f	70	71	2022-02-15 10:07:05	2022-02-15 10:07:05
5110	Tâche nouvellement créee du nom de Modification de la catégories d'articles  par Mihaja dans le projet Intervention / Accompagnement 2022.	f	70	85	2022-02-15 10:07:05	2022-02-15 10:07:05
5115	Tâche Récupération de la tva sur Odoo de l'article pour le site archivée par Mihaja.	f	70	53	2022-02-15 10:08:36	2022-02-15 10:08:36
5116	Tâche Récupération de la tva sur Odoo de l'article pour le site archivée par Mihaja.	f	70	57	2022-02-15 10:08:36	2022-02-15 10:08:36
5117	Tâche Récupération de la tva sur Odoo de l'article pour le site archivée par Mihaja.	f	70	71	2022-02-15 10:08:36	2022-02-15 10:08:36
5118	Tâche Récupération de la tva sur Odoo de l'article pour le site archivée par Mihaja.	f	70	85	2022-02-15 10:08:36	2022-02-15 10:08:36
5140	Famenontsoa vous a assigné à la tâche Calcul automatique du montant du service fees dans le projet SIGM - Application inter Amadeus et Odoo.	t	73	73	2022-02-15 11:14:04	2022-02-15 11:14:04
5151	Miandrisoa vous a assigné à la tâche Droit des utilisateurS COMPUTEK TANA dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-15 11:17:34	2022-02-15 11:17:34
5157	Tâche "Finir le rapprochement bancaire pour une banque"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	53	2022-02-15 11:25:40	2022-02-15 11:25:40
5158	Tâche "Finir le rapprochement bancaire pour une banque"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	57	2022-02-15 11:25:40	2022-02-15 11:25:40
5160	Tâche "Finir le rapprochement bancaire pour une banque"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	71	2022-02-15 11:25:40	2022-02-15 11:25:40
5033	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	t	76	70	2022-02-15 07:33:43	2022-02-15 07:33:43
5129	Matthieu vous a assigné à la tâche Récupération de la tva sur Odoo de l'article pour le site dans le projet Intervention / Accompagnement 2022.	t	81	81	2022-02-15 10:54:22	2022-02-15 10:54:22
5055	Mihaja vous a assigné à la tâche Module pour bloquer le mouvement de stock quand on valide un BL daté avant l'inventaire dans le projet Intervention / Accompagnement 2022.	t	70	81	2022-02-15 07:35:19	2022-02-15 07:35:19
5089	Matthieu vous a assigné à la tâche Restriction sur la modifcation des catégories dans le projet Intervention / Accompagnement 2022.	t	81	81	2022-02-15 07:41:21	2022-02-15 07:41:21
4571	Michel vous a assigné à la tâche •\tAjouter un champ description dans une tâche dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	t	71	81	2022-02-08 14:15:34	2022-02-08 14:15:34
4572	Michel vous a assigné à la tâche •\tNombre de tâches dans Kanban view devrait être selon utilisateur connecté (ne voir que le nombre de tâches de l’utilisateur connecté).	t	71	81	2022-02-08 14:15:49	2022-02-08 14:15:49
4581	Michel vous a assigné à la tâche Pouvoir attribuer une tâche à un attributteur dans le projet Correction/Amélioration de l'application Project Monitoring MGBI.	t	71	81	2022-02-08 14:18:14	2022-02-08 14:18:14
5130	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Matthieu	f	81	53	2022-02-15 10:54:54	2022-02-15 10:54:54
5131	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Matthieu	f	81	57	2022-02-15 10:54:54	2022-02-15 10:54:54
5133	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Matthieu	f	81	71	2022-02-15 10:54:54	2022-02-15 10:54:54
5134	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Matthieu	f	81	85	2022-02-15 10:54:54	2022-02-15 10:54:54
5141	Tâche "Calcul automatique du montant du service fees"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	53	2022-02-15 11:14:13	2022-02-15 11:14:13
5142	Tâche "Calcul automatique du montant du service fees"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	57	2022-02-15 11:14:13	2022-02-15 11:14:13
5144	Tâche "Calcul automatique du montant du service fees"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	71	2022-02-15 11:14:13	2022-02-15 11:14:13
5145	Tâche "Calcul automatique du montant du service fees"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	85	2022-02-15 11:14:13	2022-02-15 11:14:13
5161	Tâche "Finir le rapprochement bancaire pour une banque"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	85	2022-02-15 11:25:40	2022-02-15 11:25:40
5972	Tâche "Vérification des articles avec doublons"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	t	76	70	2022-02-22 05:21:12	2022-02-22 05:21:12
5350	Tâche nouvellement créee du nom de Ajouter INF dans civilité dans la ligne de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-17 07:01:47	2022-02-17 07:01:47
5362	Tâche nouvellement créee du nom de Départ et Arrivée: des listes déroulantes (quand on a la liste) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-17 07:02:49	2022-02-17 07:02:49
5368	Tâche nouvellement créee du nom de Paramétrage model d'impression par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-17 07:03:30	2022-02-17 07:03:30
5442	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	t	72	70	2022-02-17 13:13:29	2022-02-17 13:13:29
5490	Tâche "Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Rémi	t	78	70	2022-02-18 13:01:34	2022-02-18 13:01:34
5389	Tâche nouvellement créee du nom de Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-17 07:04:15	2022-02-17 07:04:15
5395	Tâche nouvellement créee du nom de Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-17 07:05:09	2022-02-17 07:05:09
5421	Tâche nouvellement créee du nom de Ajuster la taille des colonnes par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-17 07:13:24	2022-02-17 07:13:24
5463	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " En cours " par Nasolo	t	72	70	2022-02-18 08:25:23	2022-02-18 08:25:23
5520	La tâche Mettre la liste de prix en mode lecture seule et/ou la masquer a été achevée.	t	78	70	2022-02-18 13:24:18	2022-02-18 13:24:18
5284	Tâche "RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	t	76	70	2022-02-16 10:24:13	2022-02-16 10:24:13
5328	Tâche nouvellement créee du nom de Mettre la liste de prix en mode lecture seule et/ou la masquer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-17 07:00:30	2022-02-17 07:00:30
5322	Tâche nouvellement créee du nom de Enlever User 01, User 02, User 03 de la liste des clients dans document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-17 06:59:48	2022-02-17 06:59:48
5379	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	t	76	70	2022-02-17 07:03:51	2022-02-17 07:03:51
5474	Tâche nouvellement créee du nom de Création STC de deux salariés par Elie dans le projet QLM Intervention / Accompagnement 2022.	t	77	70	2022-02-18 09:24:00	2022-02-18 09:24:00
5263	Tâche "Assistance pour les articles stock négatif"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	t	76	70	2022-02-16 08:29:02	2022-02-16 08:29:02
5305	Tâche nouvellement créee du nom de Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro  par Osé dans le projet Synchro du site Computek.	t	74	70	2022-02-17 06:56:59	2022-02-17 06:56:59
5384	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	t	76	70	2022-02-17 07:03:58	2022-02-17 07:03:58
5401	Tâche nouvellement créee du nom de Renommer "Date d'arrivé" en "Date d'arrivée" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-17 07:05:09	2022-02-17 07:05:09
5036	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	53	2022-02-15 07:33:58	2022-02-15 07:33:58
5037	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	57	2022-02-15 07:33:58	2022-02-15 07:33:58
5039	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	71	2022-02-15 07:33:58	2022-02-15 07:33:58
5040	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	85	2022-02-15 07:33:58	2022-02-15 07:33:58
5056	Tâche nouvellement créee du nom de Création utilisateur EBP par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-15 07:36:23	2022-02-15 07:36:23
5057	Tâche nouvellement créee du nom de Création utilisateur EBP par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-15 07:36:23	2022-02-15 07:36:23
5059	Tâche nouvellement créee du nom de Création utilisateur EBP par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-15 07:36:23	2022-02-15 07:36:23
5060	Tâche nouvellement créee du nom de Création utilisateur EBP par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-15 07:36:23	2022-02-15 07:36:23
5096	Tâche "IMPRESSION DES TICKETS DE CAISSE A MOB+"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	53	2022-02-15 07:42:49	2022-02-15 07:42:49
5097	Tâche "IMPRESSION DES TICKETS DE CAISSE A MOB+"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	57	2022-02-15 07:42:49	2022-02-15 07:42:49
5099	Tâche "IMPRESSION DES TICKETS DE CAISSE A MOB+"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	71	2022-02-15 07:42:49	2022-02-15 07:42:49
5100	Tâche "IMPRESSION DES TICKETS DE CAISSE A MOB+"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	85	2022-02-15 07:42:49	2022-02-15 07:42:49
5162	Tâche nouvellement créee du nom de Extraction Image EBP par Osé dans le projet Synchro du site Computek.	f	74	53	2022-02-16 07:08:56	2022-02-16 07:08:56
5163	Tâche nouvellement créee du nom de Extraction Image EBP par Osé dans le projet Synchro du site Computek.	f	74	57	2022-02-16 07:08:56	2022-02-16 07:08:56
5165	Tâche nouvellement créee du nom de Extraction Image EBP par Osé dans le projet Synchro du site Computek.	f	74	71	2022-02-16 07:08:56	2022-02-16 07:08:56
5166	Tâche nouvellement créee du nom de Extraction Image EBP par Osé dans le projet Synchro du site Computek.	f	74	85	2022-02-16 07:08:56	2022-02-16 07:08:56
5216	Le projet "QLM Intervention / Accompagnement 2022" a été mise à jour par Mihaja	f	70	53	2022-02-16 08:06:28	2022-02-16 08:06:28
5217	Le projet "QLM Intervention / Accompagnement 2022" a été mise à jour par Mihaja	f	70	57	2022-02-16 08:06:28	2022-02-16 08:06:28
5218	Le projet "QLM Intervention / Accompagnement 2022" a été mise à jour par Mihaja	f	70	71	2022-02-16 08:06:28	2022-02-16 08:06:28
5219	Le projet "QLM Intervention / Accompagnement 2022" a été mise à jour par Mihaja	f	70	85	2022-02-16 08:06:28	2022-02-16 08:06:28
5319	Rémi vous a assigné à la tâche Rendre le champs Numéro PNR dans le document de commande obligatoire dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-17 06:58:35	2022-02-17 06:58:35
5331	Rémi vous a assigné à la tâche Mettre la liste de prix en mode lecture seule et/ou la masquer dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-17 07:00:30	2022-02-17 07:00:30
5332	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	53	2022-02-17 07:00:54	2022-02-17 07:00:54
5333	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	57	2022-02-17 07:00:54	2022-02-17 07:00:54
5335	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	71	2022-02-17 07:00:54	2022-02-17 07:00:54
5336	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	85	2022-02-17 07:00:54	2022-02-17 07:00:54
5348	Tâche nouvellement créee du nom de Ajouter INF dans civilité dans la ligne de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-17 07:01:47	2022-02-17 07:01:47
5349	Tâche nouvellement créee du nom de Ajouter INF dans civilité dans la ligne de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-17 07:01:47	2022-02-17 07:01:47
5351	Tâche nouvellement créee du nom de Ajouter INF dans civilité dans la ligne de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-17 07:01:47	2022-02-17 07:01:47
5352	Tâche nouvellement créee du nom de Ajouter INF dans civilité dans la ligne de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-17 07:01:47	2022-02-17 07:01:47
5366	Tâche nouvellement créee du nom de Paramétrage model d'impression par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-17 07:03:30	2022-02-17 07:03:30
5334	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	t	76	70	2022-02-17 07:00:54	2022-02-17 07:00:54
5038	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	t	76	70	2022-02-15 07:33:58	2022-02-15 07:33:58
5058	Tâche nouvellement créee du nom de Création utilisateur EBP par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-15 07:36:23	2022-02-15 07:36:23
5164	Tâche nouvellement créee du nom de Extraction Image EBP par Osé dans le projet Synchro du site Computek.	t	74	70	2022-02-16 07:08:56	2022-02-16 07:08:56
5041	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-02-15 07:34:17	2022-02-15 07:34:17
5042	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-02-15 07:34:17	2022-02-15 07:34:17
5044	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-02-15 07:34:17	2022-02-15 07:34:17
5045	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-02-15 07:34:17	2022-02-15 07:34:17
5072	Miandrisoa vous a assigné à la tâche Modification compte article dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-15 07:38:33	2022-02-15 07:38:33
5167	Osé vous a assigné à la tâche Extraction Image EBP dans le projet Synchro du site Computek.	f	74	74	2022-02-16 07:08:56	2022-02-16 07:08:56
5225	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	53	2022-02-16 08:07:54	2022-02-16 08:07:54
5226	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	57	2022-02-16 08:07:54	2022-02-16 08:07:54
5227	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	71	2022-02-16 08:07:54	2022-02-16 08:07:54
5228	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	85	2022-02-16 08:07:54	2022-02-16 08:07:54
5240	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-16 08:19:54	2022-02-16 08:19:54
5241	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-16 08:19:54	2022-02-16 08:19:54
5243	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-16 08:19:54	2022-02-16 08:19:54
5244	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-16 08:19:54	2022-02-16 08:19:54
5234	Elie vous a assigné à la tâche Création nouvel utilisateur Odoo dans le projet QLM Intervention / Accompagnement 2022.	t	77	77	2022-02-16 08:19:35	2022-02-16 08:19:35
5347	Rémi vous a assigné à la tâche Afficher TVA en bas de la fiche commande même si c'est à 0 dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-17 07:01:11	2022-02-17 07:01:11
5360	Tâche nouvellement créee du nom de Départ et Arrivée: des listes déroulantes (quand on a la liste) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-17 07:02:49	2022-02-17 07:02:49
5361	Tâche nouvellement créee du nom de Départ et Arrivée: des listes déroulantes (quand on a la liste) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-17 07:02:49	2022-02-17 07:02:49
5363	Tâche nouvellement créee du nom de Départ et Arrivée: des listes déroulantes (quand on a la liste) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-17 07:02:49	2022-02-17 07:02:49
5364	Tâche nouvellement créee du nom de Départ et Arrivée: des listes déroulantes (quand on a la liste) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-17 07:02:49	2022-02-17 07:02:49
5367	Tâche nouvellement créee du nom de Paramétrage model d'impression par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-17 07:03:30	2022-02-17 07:03:30
5369	Tâche nouvellement créee du nom de Paramétrage model d'impression par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-17 07:03:30	2022-02-17 07:03:30
5370	Tâche nouvellement créee du nom de Paramétrage model d'impression par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-17 07:03:30	2022-02-17 07:03:30
5440	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	53	2022-02-17 13:13:29	2022-02-17 13:13:29
5441	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	57	2022-02-17 13:13:29	2022-02-17 13:13:29
5443	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	71	2022-02-17 13:13:29	2022-02-17 13:13:29
5444	Tâche "Création d'un champ "publier sur le web"  sur les catégories"\n          du projet Site web QLM mise dans " En contrôle " par Nasolo	f	72	85	2022-02-17 13:13:29	2022-02-17 13:13:29
5488	Tâche "Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Rémi	f	78	53	2022-02-18 13:01:34	2022-02-18 13:01:34
5489	Tâche "Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Rémi	f	78	57	2022-02-18 13:01:34	2022-02-18 13:01:34
5242	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-16 08:19:54	2022-02-16 08:19:54
5043	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	t	76	70	2022-02-15 07:34:17	2022-02-15 07:34:17
5061	Miandrisoa vous a assigné à la tâche Création utilisateur EBP dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-15 07:36:23	2022-02-15 07:36:23
5062	Tâche "Création utilisateur EBP"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-15 07:36:34	2022-02-15 07:36:34
5063	Tâche "Création utilisateur EBP"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-15 07:36:34	2022-02-15 07:36:34
5065	Tâche "Création utilisateur EBP"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-15 07:36:34	2022-02-15 07:36:34
5066	Tâche "Création utilisateur EBP"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-15 07:36:34	2022-02-15 07:36:34
5168	Tâche nouvellement créee du nom de Transfert Image To FTP par Osé dans le projet Synchro du site Computek.	f	74	53	2022-02-16 07:09:37	2022-02-16 07:09:37
5169	Tâche nouvellement créee du nom de Transfert Image To FTP par Osé dans le projet Synchro du site Computek.	f	74	57	2022-02-16 07:09:37	2022-02-16 07:09:37
5171	Tâche nouvellement créee du nom de Transfert Image To FTP par Osé dans le projet Synchro du site Computek.	f	74	71	2022-02-16 07:09:37	2022-02-16 07:09:37
5172	Tâche nouvellement créee du nom de Transfert Image To FTP par Osé dans le projet Synchro du site Computek.	f	74	85	2022-02-16 07:09:37	2022-02-16 07:09:37
5179	Tâche "Transfert Image To FTP"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	53	2022-02-16 07:09:53	2022-02-16 07:09:53
5180	Tâche "Transfert Image To FTP"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	57	2022-02-16 07:09:53	2022-02-16 07:09:53
5182	Tâche "Transfert Image To FTP"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	71	2022-02-16 07:09:53	2022-02-16 07:09:53
5183	Tâche "Transfert Image To FTP"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	85	2022-02-16 07:09:53	2022-02-16 07:09:53
5271	Tâche nouvellement créee du nom de Création compte utilisateur EBP COMPTA, FRANK par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-16 10:22:21	2022-02-16 10:22:21
5272	Tâche nouvellement créee du nom de Création compte utilisateur EBP COMPTA, FRANK par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-16 10:22:21	2022-02-16 10:22:21
5274	Tâche nouvellement créee du nom de Création compte utilisateur EBP COMPTA, FRANK par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-16 10:22:21	2022-02-16 10:22:21
5275	Tâche nouvellement créee du nom de Création compte utilisateur EBP COMPTA, FRANK par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-16 10:22:21	2022-02-16 10:22:21
5387	Tâche nouvellement créee du nom de Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-17 07:04:15	2022-02-17 07:04:15
5388	Tâche nouvellement créee du nom de Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-17 07:04:15	2022-02-17 07:04:15
5390	Tâche nouvellement créee du nom de Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-17 07:04:15	2022-02-17 07:04:15
5391	Tâche nouvellement créee du nom de Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-17 07:04:15	2022-02-17 07:04:15
5393	Tâche nouvellement créee du nom de Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-17 07:05:09	2022-02-17 07:05:09
5394	Tâche nouvellement créee du nom de Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-17 07:05:09	2022-02-17 07:05:09
5396	Tâche nouvellement créee du nom de Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-17 07:05:09	2022-02-17 07:05:09
5397	Tâche nouvellement créee du nom de Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-17 07:05:09	2022-02-17 07:05:09
5419	Tâche nouvellement créee du nom de Ajuster la taille des colonnes par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-17 07:13:24	2022-02-17 07:13:24
5420	Tâche nouvellement créee du nom de Ajuster la taille des colonnes par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-17 07:13:24	2022-02-17 07:13:24
5422	Tâche nouvellement créee du nom de Ajuster la taille des colonnes par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-17 07:13:24	2022-02-17 07:13:24
5273	Tâche nouvellement créee du nom de Création compte utilisateur EBP COMPTA, FRANK par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-16 10:22:21	2022-02-16 10:22:21
5064	Tâche "Création utilisateur EBP"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	t	76	70	2022-02-15 07:36:34	2022-02-15 07:36:34
5170	Tâche nouvellement créee du nom de Transfert Image To FTP par Osé dans le projet Synchro du site Computek.	t	74	70	2022-02-16 07:09:37	2022-02-16 07:09:37
5181	Tâche "Transfert Image To FTP"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	t	74	70	2022-02-16 07:09:53	2022-02-16 07:09:53
5073	Tâche "Modification compte article"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-15 07:39:03	2022-02-15 07:39:03
5074	Tâche "Modification compte article"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-15 07:39:03	2022-02-15 07:39:03
5076	Tâche "Modification compte article"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-15 07:39:03	2022-02-15 07:39:03
5077	Tâche "Modification compte article"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-15 07:39:03	2022-02-15 07:39:03
5090	Tâche nouvellement créee du nom de IMPRESSION DES TICKETS DE CAISSE A MOB+ par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-15 07:42:10	2022-02-15 07:42:10
5091	Tâche nouvellement créee du nom de IMPRESSION DES TICKETS DE CAISSE A MOB+ par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-15 07:42:10	2022-02-15 07:42:10
5093	Tâche nouvellement créee du nom de IMPRESSION DES TICKETS DE CAISSE A MOB+ par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-15 07:42:10	2022-02-15 07:42:10
5094	Tâche nouvellement créee du nom de IMPRESSION DES TICKETS DE CAISSE A MOB+ par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-15 07:42:10	2022-02-15 07:42:10
5101	Tâche nouvellement créee du nom de RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-15 07:43:40	2022-02-15 07:43:40
5102	Tâche nouvellement créee du nom de RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-15 07:43:40	2022-02-15 07:43:40
5104	Tâche nouvellement créee du nom de RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-15 07:43:40	2022-02-15 07:43:40
5105	Tâche nouvellement créee du nom de RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-15 07:43:40	2022-02-15 07:43:40
5174	Tâche "Extraction Image EBP"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	53	2022-02-16 07:09:50	2022-02-16 07:09:50
5175	Tâche "Extraction Image EBP"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	57	2022-02-16 07:09:50	2022-02-16 07:09:50
5177	Tâche "Extraction Image EBP"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	71	2022-02-16 07:09:50	2022-02-16 07:09:50
5178	Tâche "Extraction Image EBP"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	85	2022-02-16 07:09:50	2022-02-16 07:09:50
5372	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	53	2022-02-17 07:03:44	2022-02-17 07:03:44
5373	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	57	2022-02-17 07:03:44	2022-02-17 07:03:44
5375	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	71	2022-02-17 07:03:44	2022-02-17 07:03:44
5376	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	85	2022-02-17 07:03:44	2022-02-17 07:03:44
5424	Rémi vous a assigné à la tâche Ajuster la taille des colonnes dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-17 07:13:24	2022-02-17 07:13:24
5461	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	53	2022-02-18 08:25:23	2022-02-18 08:25:23
5462	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	57	2022-02-18 08:25:23	2022-02-18 08:25:23
5464	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	71	2022-02-18 08:25:23	2022-02-18 08:25:23
5465	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " En cours " par Nasolo	f	72	85	2022-02-18 08:25:23	2022-02-18 08:25:23
5518	La tâche Mettre la liste de prix en mode lecture seule et/ou la masquer a été achevée.	f	78	53	2022-02-18 13:24:18	2022-02-18 13:24:18
5519	La tâche Mettre la liste de prix en mode lecture seule et/ou la masquer a été achevée.	f	78	57	2022-02-18 13:24:18	2022-02-18 13:24:18
5521	La tâche Mettre la liste de prix en mode lecture seule et/ou la masquer a été achevée.	f	78	71	2022-02-18 13:24:18	2022-02-18 13:24:18
5173	Osé vous a assigné à la tâche Transfert Image To FTP dans le projet Synchro du site Computek.	t	74	74	2022-02-16 07:09:37	2022-02-16 07:09:37
5374	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	t	76	70	2022-02-17 07:03:44	2022-02-17 07:03:44
5075	Tâche "Modification compte article"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	t	76	70	2022-02-15 07:39:03	2022-02-15 07:39:03
5092	Tâche nouvellement créee du nom de IMPRESSION DES TICKETS DE CAISSE A MOB+ par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-15 07:42:10	2022-02-15 07:42:10
5103	Tâche nouvellement créee du nom de RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-15 07:43:40	2022-02-15 07:43:40
5078	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Matthieu dans le projet Intervention / Accompagnement 2022.	f	81	53	2022-02-15 07:40:39	2022-02-15 07:40:39
5079	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Matthieu dans le projet Intervention / Accompagnement 2022.	f	81	57	2022-02-15 07:40:39	2022-02-15 07:40:39
5081	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Matthieu dans le projet Intervention / Accompagnement 2022.	f	81	71	2022-02-15 07:40:39	2022-02-15 07:40:39
5082	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Matthieu dans le projet Intervention / Accompagnement 2022.	f	81	85	2022-02-15 07:40:39	2022-02-15 07:40:39
5084	Tâche nouvellement créee du nom de Restriction sur la modifcation des catégories par Matthieu dans le projet Intervention / Accompagnement 2022.	f	81	53	2022-02-15 07:41:21	2022-02-15 07:41:21
5085	Tâche nouvellement créee du nom de Restriction sur la modifcation des catégories par Matthieu dans le projet Intervention / Accompagnement 2022.	f	81	57	2022-02-15 07:41:21	2022-02-15 07:41:21
5087	Tâche nouvellement créee du nom de Restriction sur la modifcation des catégories par Matthieu dans le projet Intervention / Accompagnement 2022.	f	81	71	2022-02-15 07:41:21	2022-02-15 07:41:21
5088	Tâche nouvellement créee du nom de Restriction sur la modifcation des catégories par Matthieu dans le projet Intervention / Accompagnement 2022.	f	81	85	2022-02-15 07:41:21	2022-02-15 07:41:21
5095	Miandrisoa vous a assigné à la tâche IMPRESSION DES TICKETS DE CAISSE A MOB+ dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-15 07:42:10	2022-02-15 07:42:10
5111	Tâche "Modification de la catégories d'articles "\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-15 10:07:14	2022-02-15 10:07:14
5112	Tâche "Modification de la catégories d'articles "\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-15 10:07:14	2022-02-15 10:07:14
5113	Tâche "Modification de la catégories d'articles "\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-15 10:07:14	2022-02-15 10:07:14
5114	Tâche "Modification de la catégories d'articles "\n          du projet Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-15 10:07:14	2022-02-15 10:07:14
5184	Tâche nouvellement créee du nom de Envoyer fichier dans l'FTP du Site COMPUTEK par Osé dans le projet Synchro du site Computek.	f	74	53	2022-02-16 07:11:44	2022-02-16 07:11:44
5185	Tâche nouvellement créee du nom de Envoyer fichier dans l'FTP du Site COMPUTEK par Osé dans le projet Synchro du site Computek.	f	74	57	2022-02-16 07:11:44	2022-02-16 07:11:44
5187	Tâche nouvellement créee du nom de Envoyer fichier dans l'FTP du Site COMPUTEK par Osé dans le projet Synchro du site Computek.	f	74	71	2022-02-16 07:11:44	2022-02-16 07:11:44
5188	Tâche nouvellement créee du nom de Envoyer fichier dans l'FTP du Site COMPUTEK par Osé dans le projet Synchro du site Computek.	f	74	85	2022-02-16 07:11:44	2022-02-16 07:11:44
5282	Tâche "RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-16 10:24:13	2022-02-16 10:24:13
5283	Tâche "RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-16 10:24:13	2022-02-16 10:24:13
5285	Tâche "RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-16 10:24:13	2022-02-16 10:24:13
5286	Tâche "RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-16 10:24:13	2022-02-16 10:24:13
5292	Tâche nouvellement créee du nom de Validation BL Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-16 12:45:56	2022-02-16 12:45:56
5293	Tâche nouvellement créee du nom de Validation BL Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-16 12:45:56	2022-02-16 12:45:56
5295	Tâche nouvellement créee du nom de Validation BL Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-16 12:45:56	2022-02-16 12:45:56
5296	Tâche nouvellement créee du nom de Validation BL Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-16 12:45:56	2022-02-16 12:45:56
5326	Tâche nouvellement créee du nom de Mettre la liste de prix en mode lecture seule et/ou la masquer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-17 07:00:30	2022-02-17 07:00:30
5327	Tâche nouvellement créee du nom de Mettre la liste de prix en mode lecture seule et/ou la masquer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-17 07:00:30	2022-02-17 07:00:30
5329	Tâche nouvellement créee du nom de Mettre la liste de prix en mode lecture seule et/ou la masquer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-17 07:00:30	2022-02-17 07:00:30
5330	Tâche nouvellement créee du nom de Mettre la liste de prix en mode lecture seule et/ou la masquer par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-17 07:00:30	2022-02-17 07:00:30
5294	Tâche nouvellement créee du nom de Validation BL Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	t	77	70	2022-02-16 12:45:56	2022-02-16 12:45:56
5080	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Matthieu dans le projet Intervention / Accompagnement 2022.	t	81	70	2022-02-15 07:40:39	2022-02-15 07:40:39
5086	Tâche nouvellement créee du nom de Restriction sur la modifcation des catégories par Matthieu dans le projet Intervention / Accompagnement 2022.	t	81	70	2022-02-15 07:41:21	2022-02-15 07:41:21
5186	Tâche nouvellement créee du nom de Envoyer fichier dans l'FTP du Site COMPUTEK par Osé dans le projet Synchro du site Computek.	t	74	70	2022-02-16 07:11:44	2022-02-16 07:11:44
5119	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Mihaja dans le projet Site web QLM.	f	70	53	2022-02-15 10:09:11	2022-02-15 10:09:11
5120	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Mihaja dans le projet Site web QLM.	f	70	57	2022-02-15 10:09:11	2022-02-15 10:09:11
5121	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Mihaja dans le projet Site web QLM.	f	70	71	2022-02-15 10:09:11	2022-02-15 10:09:11
5122	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Mihaja dans le projet Site web QLM.	f	70	85	2022-02-15 10:09:11	2022-02-15 10:09:11
5190	Tâche "Envoyer fichier dans l'FTP du Site COMPUTEK"\n          du projet Synchro du site Computek mise dans " En blocage " par Osé	f	74	53	2022-02-16 07:11:49	2022-02-16 07:11:49
5191	Tâche "Envoyer fichier dans l'FTP du Site COMPUTEK"\n          du projet Synchro du site Computek mise dans " En blocage " par Osé	f	74	57	2022-02-16 07:11:49	2022-02-16 07:11:49
5193	Tâche "Envoyer fichier dans l'FTP du Site COMPUTEK"\n          du projet Synchro du site Computek mise dans " En blocage " par Osé	f	74	71	2022-02-16 07:11:49	2022-02-16 07:11:49
5194	Tâche "Envoyer fichier dans l'FTP du Site COMPUTEK"\n          du projet Synchro du site Computek mise dans " En blocage " par Osé	f	74	85	2022-02-16 07:11:49	2022-02-16 07:11:49
5260	Miandrisoa vous a assigné à la tâche Assistance pour les articles stock négatif dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-16 08:28:53	2022-02-16 08:28:53
5277	Tâche "Création compte utilisateur EBP COMPTA, FRANK"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-16 10:22:27	2022-02-16 10:22:27
5278	Tâche "Création compte utilisateur EBP COMPTA, FRANK"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-16 10:22:27	2022-02-16 10:22:27
5280	Tâche "Création compte utilisateur EBP COMPTA, FRANK"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-16 10:22:27	2022-02-16 10:22:27
5281	Tâche "Création compte utilisateur EBP COMPTA, FRANK"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-16 10:22:27	2022-02-16 10:22:27
5320	Tâche nouvellement créee du nom de Enlever User 01, User 02, User 03 de la liste des clients dans document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-17 06:59:48	2022-02-17 06:59:48
5321	Tâche nouvellement créee du nom de Enlever User 01, User 02, User 03 de la liste des clients dans document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-17 06:59:48	2022-02-17 06:59:48
5323	Tâche nouvellement créee du nom de Enlever User 01, User 02, User 03 de la liste des clients dans document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-17 06:59:48	2022-02-17 06:59:48
5324	Tâche nouvellement créee du nom de Enlever User 01, User 02, User 03 de la liste des clients dans document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-17 06:59:48	2022-02-17 06:59:48
5325	Rémi vous a assigné à la tâche Enlever User 01, User 02, User 03 de la liste des clients dans document de commande dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-17 06:59:48	2022-02-17 06:59:48
5377	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-17 07:03:51	2022-02-17 07:03:51
5378	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-17 07:03:51	2022-02-17 07:03:51
5380	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-17 07:03:51	2022-02-17 07:03:51
5381	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-17 07:03:51	2022-02-17 07:03:51
5392	Rémi vous a assigné à la tâche Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-17 07:04:15	2022-02-17 07:04:15
5418	Vous avez été assigné à la sous-tâche Mettre la total des Fees, la total des taxes (autres taxes) en dessous de s lignes de commande du projet SIGM - Gestion  Agence de Voyage sur Odoo 15	f	78	78	2022-02-17 07:12:12	2022-02-17 07:12:12
5472	Tâche nouvellement créee du nom de Création STC de deux salariés par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-18 09:24:00	2022-02-18 09:24:00
5473	Tâche nouvellement créee du nom de Création STC de deux salariés par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-18 09:24:00	2022-02-18 09:24:00
5279	Tâche "Création compte utilisateur EBP COMPTA, FRANK"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	t	76	70	2022-02-16 10:22:27	2022-02-16 10:22:27
5192	Tâche "Envoyer fichier dans l'FTP du Site COMPUTEK"\n          du projet Synchro du site Computek mise dans " En blocage " par Osé	t	74	70	2022-02-16 07:11:49	2022-02-16 07:11:49
5123	Mihaja vous a assigné à la tâche Récupération de la tva sur Odoo de l'article pour le site.	t	70	81	2022-02-15 10:09:18	2022-02-15 10:09:18
5083	Matthieu vous a assigné à la tâche Récupération de la tva sur Odoo de l'article pour le site dans le projet Intervention / Accompagnement 2022.	t	81	81	2022-02-15 07:40:39	2022-02-15 07:40:39
5195	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	f	74	53	2022-02-16 07:12:06	2022-02-16 07:12:06
5196	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	f	74	57	2022-02-16 07:12:06	2022-02-16 07:12:06
5198	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	f	74	71	2022-02-16 07:12:06	2022-02-16 07:12:06
5199	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	f	74	85	2022-02-16 07:12:06	2022-02-16 07:12:06
5220	Tâche nouvellement créee du nom de Création champ description technique des articles par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	53	2022-02-16 08:07:34	2022-02-16 08:07:34
5221	Tâche nouvellement créee du nom de Création champ description technique des articles par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	57	2022-02-16 08:07:34	2022-02-16 08:07:34
5222	Tâche nouvellement créee du nom de Création champ description technique des articles par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	71	2022-02-16 08:07:34	2022-02-16 08:07:34
5223	Tâche nouvellement créee du nom de Création champ description technique des articles par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	85	2022-02-16 08:07:34	2022-02-16 08:07:34
5224	Mihaja vous a assigné à la tâche Création champ description technique des articles dans le projet QLM Intervention / Accompagnement 2022.	f	70	78	2022-02-16 08:07:34	2022-02-16 08:07:34
5261	Tâche "Assistance pour les articles stock négatif"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-02-16 08:29:02	2022-02-16 08:29:02
5262	Tâche "Assistance pour les articles stock négatif"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-02-16 08:29:02	2022-02-16 08:29:02
5264	Tâche "Assistance pour les articles stock négatif"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-02-16 08:29:02	2022-02-16 08:29:02
5265	Tâche "Assistance pour les articles stock négatif"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-02-16 08:29:02	2022-02-16 08:29:02
5303	Tâche nouvellement créee du nom de Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro  par Osé dans le projet Synchro du site Computek.	f	74	53	2022-02-17 06:56:59	2022-02-17 06:56:59
5304	Tâche nouvellement créee du nom de Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro  par Osé dans le projet Synchro du site Computek.	f	74	57	2022-02-17 06:56:59	2022-02-17 06:56:59
5306	Tâche nouvellement créee du nom de Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro  par Osé dans le projet Synchro du site Computek.	f	74	71	2022-02-17 06:56:59	2022-02-17 06:56:59
5307	Tâche nouvellement créee du nom de Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro  par Osé dans le projet Synchro du site Computek.	f	74	85	2022-02-17 06:56:59	2022-02-17 06:56:59
5382	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-02-17 07:03:58	2022-02-17 07:03:58
5383	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-02-17 07:03:58	2022-02-17 07:03:58
5385	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-02-17 07:03:58	2022-02-17 07:03:58
5386	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-02-17 07:03:58	2022-02-17 07:03:58
5399	Tâche nouvellement créee du nom de Renommer "Date d'arrivé" en "Date d'arrivée" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-17 07:05:09	2022-02-17 07:05:09
5400	Tâche nouvellement créee du nom de Renommer "Date d'arrivé" en "Date d'arrivée" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-17 07:05:09	2022-02-17 07:05:09
5402	Tâche nouvellement créee du nom de Renommer "Date d'arrivé" en "Date d'arrivée" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-17 07:05:09	2022-02-17 07:05:09
5403	Tâche nouvellement créee du nom de Renommer "Date d'arrivé" en "Date d'arrivée" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-17 07:05:09	2022-02-17 07:05:09
5435	Tâche "Validation BL Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-17 08:46:55	2022-02-17 08:46:55
5436	Tâche "Validation BL Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-17 08:46:55	2022-02-17 08:46:55
5438	Tâche "Validation BL Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-17 08:46:55	2022-02-17 08:46:55
5439	Tâche "Validation BL Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-17 08:46:55	2022-02-17 08:46:55
5197	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " En contrôle " par Osé	t	74	70	2022-02-16 07:12:06	2022-02-16 07:12:06
5200	Tâche "Envoyer fichier dans l'FTP du Site COMPUTEK"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	53	2022-02-16 07:12:11	2022-02-16 07:12:11
5201	Tâche "Envoyer fichier dans l'FTP du Site COMPUTEK"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	57	2022-02-16 07:12:11	2022-02-16 07:12:11
5203	Tâche "Envoyer fichier dans l'FTP du Site COMPUTEK"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	71	2022-02-16 07:12:11	2022-02-16 07:12:11
5204	Tâche "Envoyer fichier dans l'FTP du Site COMPUTEK"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	85	2022-02-16 07:12:11	2022-02-16 07:12:11
5235	Tâche "Création nouvel utilisateur Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-16 08:19:41	2022-02-16 08:19:41
5236	Tâche "Création nouvel utilisateur Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-16 08:19:41	2022-02-16 08:19:41
5238	Tâche "Création nouvel utilisateur Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-16 08:19:41	2022-02-16 08:19:41
5239	Tâche "Création nouvel utilisateur Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-16 08:19:41	2022-02-16 08:19:41
5255	Tâche nouvellement créee du nom de Assistance pour les articles stock négatif par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-16 08:28:53	2022-02-16 08:28:53
5256	Tâche nouvellement créee du nom de Assistance pour les articles stock négatif par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-16 08:28:53	2022-02-16 08:28:53
5258	Tâche nouvellement créee du nom de Assistance pour les articles stock négatif par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-16 08:28:53	2022-02-16 08:28:53
5259	Tâche nouvellement créee du nom de Assistance pour les articles stock négatif par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-16 08:28:53	2022-02-16 08:28:53
5309	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " En blocage " par Osé	f	74	53	2022-02-17 06:57:12	2022-02-17 06:57:12
5310	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " En blocage " par Osé	f	74	57	2022-02-17 06:57:12	2022-02-17 06:57:12
5312	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " En blocage " par Osé	f	74	71	2022-02-17 06:57:12	2022-02-17 06:57:12
5313	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " En blocage " par Osé	f	74	85	2022-02-17 06:57:12	2022-02-17 06:57:12
5354	Tâche nouvellement créee du nom de Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-17 07:02:29	2022-02-17 07:02:29
5355	Tâche nouvellement créee du nom de Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-17 07:02:29	2022-02-17 07:02:29
5357	Tâche nouvellement créee du nom de Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-17 07:02:29	2022-02-17 07:02:29
5358	Tâche nouvellement créee du nom de Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-17 07:02:29	2022-02-17 07:02:29
5466	Tâche nouvellement créee du nom de Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable par Rémi dans le projet QLM Intervention / Accompagnement 2022.	f	78	53	2022-02-18 08:42:10	2022-02-18 08:42:10
5467	Tâche nouvellement créee du nom de Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable par Rémi dans le projet QLM Intervention / Accompagnement 2022.	f	78	57	2022-02-18 08:42:10	2022-02-18 08:42:10
5469	Tâche nouvellement créee du nom de Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable par Rémi dans le projet QLM Intervention / Accompagnement 2022.	f	78	71	2022-02-18 08:42:10	2022-02-18 08:42:10
5470	Tâche nouvellement créee du nom de Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable par Rémi dans le projet QLM Intervention / Accompagnement 2022.	f	78	85	2022-02-18 08:42:10	2022-02-18 08:42:10
5493	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Rémi	f	78	53	2022-02-18 13:02:57	2022-02-18 13:02:57
5257	Tâche nouvellement créee du nom de Assistance pour les articles stock négatif par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-16 08:28:53	2022-02-16 08:28:53
5311	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " En blocage " par Osé	t	74	70	2022-02-17 06:57:12	2022-02-17 06:57:12
5202	Tâche "Envoyer fichier dans l'FTP du Site COMPUTEK"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	t	74	70	2022-02-16 07:12:11	2022-02-16 07:12:11
5237	Tâche "Création nouvel utilisateur Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-16 08:19:41	2022-02-16 08:19:41
5205	Tâche nouvellement créee du nom de Envoi des anomalies d'enregistrement des PNRs sur email par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	53	2022-02-16 07:32:30	2022-02-16 07:32:30
5206	Tâche nouvellement créee du nom de Envoi des anomalies d'enregistrement des PNRs sur email par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	57	2022-02-16 07:32:30	2022-02-16 07:32:30
5208	Tâche nouvellement créee du nom de Envoi des anomalies d'enregistrement des PNRs sur email par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	71	2022-02-16 07:32:30	2022-02-16 07:32:30
5209	Tâche nouvellement créee du nom de Envoi des anomalies d'enregistrement des PNRs sur email par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	85	2022-02-16 07:32:30	2022-02-16 07:32:30
5229	Tâche nouvellement créee du nom de Création nouvel utilisateur Odoo par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-16 08:19:35	2022-02-16 08:19:35
5230	Tâche nouvellement créee du nom de Création nouvel utilisateur Odoo par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-16 08:19:35	2022-02-16 08:19:35
5232	Tâche nouvellement créee du nom de Création nouvel utilisateur Odoo par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-16 08:19:35	2022-02-16 08:19:35
5233	Tâche nouvellement créee du nom de Création nouvel utilisateur Odoo par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-16 08:19:35	2022-02-16 08:19:35
5266	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	53	2022-02-16 08:55:06	2022-02-16 08:55:06
5267	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	57	2022-02-16 08:55:06	2022-02-16 08:55:06
5269	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	71	2022-02-16 08:55:06	2022-02-16 08:55:06
5270	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	85	2022-02-16 08:55:06	2022-02-16 08:55:06
5287	Tâche "Restriction sur la modifcation des catégories"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	53	2022-02-16 11:49:09	2022-02-16 11:49:09
5288	Tâche "Restriction sur la modifcation des catégories"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	57	2022-02-16 11:49:09	2022-02-16 11:49:09
5290	Tâche "Restriction sur la modifcation des catégories"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	71	2022-02-16 11:49:09	2022-02-16 11:49:09
5291	Tâche "Restriction sur la modifcation des catégories"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	85	2022-02-16 11:49:09	2022-02-16 11:49:09
5314	Tâche nouvellement créee du nom de Rendre le champs Numéro PNR dans le document de commande obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-17 06:58:35	2022-02-17 06:58:35
5315	Tâche nouvellement créee du nom de Rendre le champs Numéro PNR dans le document de commande obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-17 06:58:35	2022-02-17 06:58:35
5317	Tâche nouvellement créee du nom de Rendre le champs Numéro PNR dans le document de commande obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-17 06:58:35	2022-02-17 06:58:35
5318	Tâche nouvellement créee du nom de Rendre le champs Numéro PNR dans le document de commande obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-17 06:58:35	2022-02-17 06:58:35
5337	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " A faire " par Miandrisoa	f	76	53	2022-02-17 07:00:59	2022-02-17 07:00:59
5338	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " A faire " par Miandrisoa	f	76	57	2022-02-17 07:00:59	2022-02-17 07:00:59
5340	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " A faire " par Miandrisoa	f	76	71	2022-02-17 07:00:59	2022-02-17 07:00:59
5341	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " A faire " par Miandrisoa	f	76	85	2022-02-17 07:00:59	2022-02-17 07:00:59
5404	Rémi vous a assigné à la tâche Renommer "Date d'arrivé" en "Date d'arrivée" dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-17 07:05:09	2022-02-17 07:05:09
5405	Tâche nouvellement créee du nom de droit d'autorisation pour SABIR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-17 07:06:24	2022-02-17 07:06:24
5406	Tâche nouvellement créee du nom de droit d'autorisation pour SABIR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-17 07:06:24	2022-02-17 07:06:24
5268	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	t	81	70	2022-02-16 08:55:06	2022-02-16 08:55:06
5207	Tâche nouvellement créee du nom de Envoi des anomalies d'enregistrement des PNRs sur email par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	t	73	70	2022-02-16 07:32:30	2022-02-16 07:32:30
5231	Tâche nouvellement créee du nom de Création nouvel utilisateur Odoo par Elie dans le projet QLM Intervention / Accompagnement 2022.	t	77	70	2022-02-16 08:19:35	2022-02-16 08:19:35
5210	Famenontsoa vous a assigné à la tâche Envoi des anomalies d'enregistrement des PNRs sur email dans le projet SIGM - Application inter Amadeus et Odoo.	t	73	73	2022-02-16 07:32:30	2022-02-16 07:32:30
5245	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-16 08:19:59	2022-02-16 08:19:59
5246	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-16 08:19:59	2022-02-16 08:19:59
5248	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-16 08:19:59	2022-02-16 08:19:59
5249	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-16 08:19:59	2022-02-16 08:19:59
5276	Miandrisoa vous a assigné à la tâche Création compte utilisateur EBP COMPTA, FRANK dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-16 10:22:21	2022-02-16 10:22:21
5298	Tâche "Validation BL Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-16 12:46:04	2022-02-16 12:46:04
5299	Tâche "Validation BL Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-16 12:46:04	2022-02-16 12:46:04
5301	Tâche "Validation BL Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-16 12:46:04	2022-02-16 12:46:04
5302	Tâche "Validation BL Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-16 12:46:04	2022-02-16 12:46:04
5342	Tâche nouvellement créee du nom de Afficher TVA en bas de la fiche commande même si c'est à 0 par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-17 07:01:11	2022-02-17 07:01:11
5343	Tâche nouvellement créee du nom de Afficher TVA en bas de la fiche commande même si c'est à 0 par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-17 07:01:11	2022-02-17 07:01:11
5345	Tâche nouvellement créee du nom de Afficher TVA en bas de la fiche commande même si c'est à 0 par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-17 07:01:11	2022-02-17 07:01:11
5346	Tâche nouvellement créee du nom de Afficher TVA en bas de la fiche commande même si c'est à 0 par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-17 07:01:11	2022-02-17 07:01:11
5365	Rémi vous a assigné à la tâche Départ et Arrivée: des listes déroulantes (quand on a la liste) dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-17 07:02:49	2022-02-17 07:02:49
5408	Tâche nouvellement créee du nom de droit d'autorisation pour SABIR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-17 07:06:24	2022-02-17 07:06:24
5409	Tâche nouvellement créee du nom de droit d'autorisation pour SABIR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-17 07:06:24	2022-02-17 07:06:24
5483	Tâche "Création STC de deux salariés"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-18 10:01:53	2022-02-18 10:01:53
5484	Tâche "Création STC de deux salariés"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-18 10:01:53	2022-02-18 10:01:53
5486	Tâche "Création STC de deux salariés"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-18 10:01:53	2022-02-18 10:01:53
5487	Tâche "Création STC de deux salariés"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-18 10:01:53	2022-02-18 10:01:53
5437	Tâche "Validation BL Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-17 08:46:55	2022-02-17 08:46:55
5356	Tâche nouvellement créee du nom de Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-17 07:02:29	2022-02-17 07:02:29
5468	Tâche nouvellement créee du nom de Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable par Rémi dans le projet QLM Intervention / Accompagnement 2022.	t	78	70	2022-02-18 08:42:10	2022-02-18 08:42:10
5289	Tâche "Restriction sur la modifcation des catégories"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	t	81	70	2022-02-16 11:49:09	2022-02-16 11:49:09
5316	Tâche nouvellement créee du nom de Rendre le champs Numéro PNR dans le document de commande obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-17 06:58:35	2022-02-17 06:58:35
5339	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " A faire " par Miandrisoa	t	76	70	2022-02-17 07:00:59	2022-02-17 07:00:59
5407	Tâche nouvellement créee du nom de droit d'autorisation pour SABIR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-17 07:06:24	2022-02-17 07:06:24
5247	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-16 08:19:59	2022-02-16 08:19:59
5300	Tâche "Validation BL Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-16 12:46:04	2022-02-16 12:46:04
5344	Tâche nouvellement créee du nom de Afficher TVA en bas de la fiche commande même si c'est à 0 par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-17 07:01:11	2022-02-17 07:01:11
5485	Tâche "Création STC de deux salariés"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-18 10:01:53	2022-02-18 10:01:53
7370	La tâche Déblocage compte bloqué par ADM et MGBI2 a été achevée.	f	76	53	2022-03-02 11:19:55	2022-03-02 11:19:55
7371	La tâche Déblocage compte bloqué par ADM et MGBI2 a été achevée.	f	76	57	2022-03-02 11:19:55	2022-03-02 11:19:55
7372	La tâche Déblocage compte bloqué par ADM et MGBI2 a été achevée.	f	76	70	2022-03-02 11:19:55	2022-03-02 11:19:55
7373	La tâche Déblocage compte bloqué par ADM et MGBI2 a été achevée.	f	76	71	2022-03-02 11:19:55	2022-03-02 11:19:55
7374	La tâche Déblocage compte bloqué par ADM et MGBI2 a été achevée.	f	76	85	2022-03-02 11:19:55	2022-03-02 11:19:55
7402	La tâche Contre inventaire pour COMPUTEK TANA a été achevée.	f	76	53	2022-03-02 11:22:52	2022-03-02 11:22:52
7403	La tâche Contre inventaire pour COMPUTEK TANA a été achevée.	f	76	57	2022-03-02 11:22:52	2022-03-02 11:22:52
5211	Tâche "Envoi des anomalies d'enregistrement des PNRs sur email"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	53	2022-02-16 07:32:38	2022-02-16 07:32:38
5212	Tâche "Envoi des anomalies d'enregistrement des PNRs sur email"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	57	2022-02-16 07:32:38	2022-02-16 07:32:38
5214	Tâche "Envoi des anomalies d'enregistrement des PNRs sur email"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	71	2022-02-16 07:32:38	2022-02-16 07:32:38
5215	Tâche "Envoi des anomalies d'enregistrement des PNRs sur email"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	85	2022-02-16 07:32:38	2022-02-16 07:32:38
5250	Tâche "Création nouvel utilisateur Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-16 08:20:21	2022-02-16 08:20:21
5251	Tâche "Création nouvel utilisateur Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-16 08:20:21	2022-02-16 08:20:21
5253	Tâche "Création nouvel utilisateur Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-16 08:20:21	2022-02-16 08:20:21
5254	Tâche "Création nouvel utilisateur Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-16 08:20:21	2022-02-16 08:20:21
5353	Rémi vous a assigné à la tâche Ajouter INF dans civilité dans la ligne de commande dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-17 07:01:47	2022-02-17 07:01:47
5411	Tâche nouvellement créee du nom de Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-17 07:09:34	2022-02-17 07:09:34
5412	Tâche nouvellement créee du nom de Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-17 07:09:34	2022-02-17 07:09:34
5414	Tâche nouvellement créee du nom de Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-17 07:09:34	2022-02-17 07:09:34
5415	Tâche nouvellement créee du nom de Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-17 07:09:34	2022-02-17 07:09:34
5445	Tâche "droit d'autorisation pour SABIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-17 13:48:49	2022-02-17 13:48:49
5446	Tâche "droit d'autorisation pour SABIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-17 13:48:49	2022-02-17 13:48:49
5448	Tâche "droit d'autorisation pour SABIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-17 13:48:49	2022-02-17 13:48:49
5449	Tâche "droit d'autorisation pour SABIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-17 13:48:49	2022-02-17 13:48:49
5450	Tâche "Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-17 13:48:55	2022-02-17 13:48:55
5451	Tâche "Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-17 13:48:55	2022-02-17 13:48:55
5453	Tâche "Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-17 13:48:55	2022-02-17 13:48:55
5454	Tâche "Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-17 13:48:55	2022-02-17 13:48:55
5543	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	53	2022-02-18 14:09:15	2022-02-18 14:09:15
5544	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	57	2022-02-18 14:09:15	2022-02-18 14:09:15
5546	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	71	2022-02-18 14:09:15	2022-02-18 14:09:15
5547	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	85	2022-02-18 14:09:15	2022-02-18 14:09:15
5252	Tâche "Création nouvel utilisateur Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-16 08:20:21	2022-02-16 08:20:21
5413	Tâche nouvellement créee du nom de Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-17 07:09:34	2022-02-17 07:09:34
5213	Tâche "Envoi des anomalies d'enregistrement des PNRs sur email"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	t	73	70	2022-02-16 07:32:38	2022-02-16 07:32:38
5416	Rémi vous a assigné à la tâche Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet) dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-17 07:09:34	2022-02-17 07:09:34
5425	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-17 08:07:18	2022-02-17 08:07:18
5426	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-17 08:07:18	2022-02-17 08:07:18
5428	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-17 08:07:18	2022-02-17 08:07:18
5429	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-17 08:07:18	2022-02-17 08:07:18
5430	Tâche "Droit des utilisateurS COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-17 08:07:46	2022-02-17 08:07:46
5431	Tâche "Droit des utilisateurS COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-17 08:07:46	2022-02-17 08:07:46
5433	Tâche "Droit des utilisateurS COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-17 08:07:46	2022-02-17 08:07:46
5434	Tâche "Droit des utilisateurS COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-17 08:07:46	2022-02-17 08:07:46
5471	Rémi vous a assigné à la tâche Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable dans le projet QLM Intervention / Accompagnement 2022.	f	78	78	2022-02-18 08:42:10	2022-02-18 08:42:10
5523	La tâche Afficher TVA en bas de la fiche commande même si c'est à 0 a été achevée.	f	78	53	2022-02-18 13:24:40	2022-02-18 13:24:40
5524	La tâche Afficher TVA en bas de la fiche commande même si c'est à 0 a été achevée.	f	78	57	2022-02-18 13:24:40	2022-02-18 13:24:40
5526	La tâche Afficher TVA en bas de la fiche commande même si c'est à 0 a été achevée.	f	78	71	2022-02-18 13:24:40	2022-02-18 13:24:40
5527	La tâche Afficher TVA en bas de la fiche commande même si c'est à 0 a été achevée.	f	78	85	2022-02-18 13:24:40	2022-02-18 13:24:40
5548	Tâche "Calcul automatique du montant du service fees"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	53	2022-02-18 14:09:20	2022-02-18 14:09:20
5549	Tâche "Calcul automatique du montant du service fees"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	57	2022-02-18 14:09:20	2022-02-18 14:09:20
5551	Tâche "Calcul automatique du montant du service fees"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	71	2022-02-18 14:09:20	2022-02-18 14:09:20
5552	Tâche "Calcul automatique du montant du service fees"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	85	2022-02-18 14:09:20	2022-02-18 14:09:20
5460	Nasolo vous a assigné à la tâche synchronisation des categories odoo et site web dans le projet Site web QLM.	t	72	72	2022-02-18 08:25:18	2022-02-18 08:25:18
5477	Elie vous a assigné à la tâche Création STC de deux salariés dans le projet QLM Intervention / Accompagnement 2022.	t	77	77	2022-02-18 09:24:00	2022-02-18 09:24:00
5447	Tâche "droit d'autorisation pour SABIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	t	76	70	2022-02-17 13:48:49	2022-02-17 13:48:49
5452	Tâche "Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	t	76	70	2022-02-17 13:48:55	2022-02-17 13:48:55
5545	Tâche "Mise à jour export vers Odoo"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	t	73	70	2022-02-18 14:09:15	2022-02-18 14:09:15
5427	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	t	76	70	2022-02-17 08:07:18	2022-02-17 08:07:18
5432	Tâche "Droit des utilisateurS COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	t	76	70	2022-02-17 08:07:46	2022-02-17 08:07:46
5525	La tâche Afficher TVA en bas de la fiche commande même si c'est à 0 a été achevée.	t	78	70	2022-02-18 13:24:40	2022-02-18 13:24:40
5550	Tâche "Calcul automatique du montant du service fees"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	t	73	70	2022-02-18 14:09:20	2022-02-18 14:09:20
5566	Tâche nouvellement créee du nom de Enlever les boutons créer une facture, envoyer la commande par courriel, annuler, bloquer dans le document d'achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-18 14:23:35	2022-02-18 14:23:35
5577	Tâche "Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-21 06:01:01	2022-02-21 06:01:01
5701	Tâche nouvellement créee du nom de Ajouter dans le document d'achat le numéro du vol et les dates (dates de départ et d'arrivée) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:00:22	2022-02-21 07:00:22
5417	Vous avez été assigné à la sous-tâche Mettre total Billet en dessous des lignes de commande du projet SIGM - Gestion  Agence de Voyage sur Odoo 15	f	78	78	2022-02-17 07:10:57	2022-02-17 07:10:57
5719	Tâche nouvellement créee du nom de Dans la ficher client, enlever tout dans les conditions de paiement et ne laisser que Paiement immédiat et 30 jours par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:03:58	2022-02-21 07:03:58
5731	Tâche nouvellement créee du nom de Mettre la même présentation dans la facture (lignes) que dans le document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:05:22	2022-02-21 07:05:22
5749	Tâche nouvellement créee du nom de Afficher les autres taxes dans l'impression facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:08:07	2022-02-21 07:08:07
5572	La tâche Enlever les boutons créer une facture, envoyer la commande par courriel, annuler, bloquer dans le document d'achat a été achevée.	t	78	70	2022-02-18 14:23:42	2022-02-18 14:23:42
5581	Tâche "droit d'autorisation pour SABIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-21 06:01:09	2022-02-21 06:01:09
5614	Tâche "Rapprochement bancaire mai-juin BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Haro	t	79	70	2022-02-21 06:07:56	2022-02-21 06:07:56
5619	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " En cours " par Osé	t	74	70	2022-02-21 06:25:03	2022-02-21 06:25:03
5652	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	t	71	70	2022-02-21 06:52:59	2022-02-21 06:52:59
5656	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	t	78	70	2022-02-21 06:53:38	2022-02-21 06:53:38
5644	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-21 06:52:14	2022-02-21 06:52:14
5661	Tâche "Droit des utilisateurS COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	t	71	70	2022-02-21 06:54:02	2022-02-21 06:54:02
5683	Tâche nouvellement créee du nom de Renommer "Remboursement partiel" en "Avoir partiel" dans document facture > ajouter un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 06:58:23	2022-02-21 06:58:23
5725	Tâche nouvellement créee du nom de Dans la fiche facture, masquer le bouton "Remettre en brouillon" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:04:41	2022-02-21 07:04:41
5743	Tâche nouvellement créee du nom de Dans fiche facture > Ecriture comptable, mettre une ligne par billet par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:06:48	2022-02-21 07:06:48
6402	Tâche "Intégration inventaire Showroom Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-23 14:38:40	2022-02-23 14:38:40
6403	Tâche "Intégration inventaire Showroom Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-23 14:38:40	2022-02-23 14:38:40
6404	Tâche "Intégration inventaire Showroom Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	70	2022-02-23 14:38:40	2022-02-23 14:38:40
6405	Tâche "Intégration inventaire Showroom Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-23 14:38:40	2022-02-23 14:38:40
6406	Tâche "Intégration inventaire Showroom Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-23 14:38:40	2022-02-23 14:38:40
6407	La tâche Intégration inventaire Showroom Cheinmalt a été achevée.	f	77	53	2022-02-23 14:38:46	2022-02-23 14:38:46
6408	La tâche Intégration inventaire Showroom Cheinmalt a été achevée.	f	77	57	2022-02-23 14:38:46	2022-02-23 14:38:46
6409	La tâche Intégration inventaire Showroom Cheinmalt a été achevée.	f	77	70	2022-02-23 14:38:46	2022-02-23 14:38:46
6410	La tâche Intégration inventaire Showroom Cheinmalt a été achevée.	f	77	71	2022-02-23 14:38:46	2022-02-23 14:38:46
6411	La tâche Intégration inventaire Showroom Cheinmalt a été achevée.	f	77	85	2022-02-23 14:38:46	2022-02-23 14:38:46
6417	Tâche "création d'import produit et catégories, et correspondance des champs d'import sur le site"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	53	2022-02-24 04:49:21	2022-02-24 04:49:21
6418	Tâche "création d'import produit et catégories, et correspondance des champs d'import sur le site"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	57	2022-02-24 04:49:21	2022-02-24 04:49:21
6420	Tâche "création d'import produit et catégories, et correspondance des champs d'import sur le site"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	71	2022-02-24 04:49:21	2022-02-24 04:49:21
6421	Tâche "création d'import produit et catégories, et correspondance des champs d'import sur le site"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	85	2022-02-24 04:49:21	2022-02-24 04:49:21
6487	Tâche "Modification du banner sur l'accueil"\n          du projet CDC - Intervention Site web mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-24 09:24:43	2022-02-24 09:24:43
6488	Tâche "Modification du banner sur l'accueil"\n          du projet CDC - Intervention Site web mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-24 09:24:43	2022-02-24 09:24:43
6489	Tâche "Modification du banner sur l'accueil"\n          du projet CDC - Intervention Site web mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-24 09:24:43	2022-02-24 09:24:43
6490	Tâche "Modification du banner sur l'accueil"\n          du projet CDC - Intervention Site web mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-24 09:24:43	2022-02-24 09:24:43
6496	Tâche nouvellement créee du nom de Déblocage d'un problème de connexion à la base par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-24 12:42:50	2022-02-24 12:42:50
7404	La tâche Contre inventaire pour COMPUTEK TANA a été achevée.	f	76	70	2022-03-02 11:22:52	2022-03-02 11:22:52
7405	La tâche Contre inventaire pour COMPUTEK TANA a été achevée.	f	76	71	2022-03-02 11:22:52	2022-03-02 11:22:52
7406	La tâche Contre inventaire pour COMPUTEK TANA a été achevée.	f	76	85	2022-03-02 11:22:52	2022-03-02 11:22:52
5423	Tâche nouvellement créee du nom de Ajuster la taille des colonnes par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-17 07:13:24	2022-02-17 07:13:24
5498	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-18 13:04:18	2022-02-18 13:04:18
5499	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-18 13:04:18	2022-02-18 13:04:18
5501	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-18 13:04:18	2022-02-18 13:04:18
5502	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	85	2022-02-18 13:04:18	2022-02-18 13:04:18
5500	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-18 13:04:18	2022-02-18 13:04:18
5048	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	t	76	70	2022-02-15 07:34:38	2022-02-15 07:34:38
5069	Tâche nouvellement créee du nom de Modification compte article par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-15 07:38:33	2022-02-15 07:38:33
5098	Tâche "IMPRESSION DES TICKETS DE CAISSE A MOB+"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	t	76	70	2022-02-15 07:42:49	2022-02-15 07:42:49
5126	Tâche nouvellement créee du nom de Récupération de la tva sur Odoo de l'article pour le site par Matthieu dans le projet Intervention / Accompagnement 2022.	t	81	70	2022-02-15 10:54:22	2022-02-15 10:54:22
5132	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet Intervention / Accompagnement 2022 mise dans " En cours " par Matthieu	t	81	70	2022-02-15 10:54:54	2022-02-15 10:54:54
5137	Tâche nouvellement créee du nom de Calcul automatique du montant du service fees par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	t	73	70	2022-02-15 11:14:04	2022-02-15 11:14:04
5143	Tâche "Calcul automatique du montant du service fees"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	t	73	70	2022-02-15 11:14:13	2022-02-15 11:14:13
5148	Tâche nouvellement créee du nom de Droit des utilisateurS COMPUTEK TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-15 11:17:34	2022-02-15 11:17:34
5154	Tâche "Prise en compte des données Tour (en cas de modification du circuit)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	t	79	70	2022-02-15 11:25:15	2022-02-15 11:25:15
5159	Tâche "Finir le rapprochement bancaire pour une banque"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	t	79	70	2022-02-15 11:25:40	2022-02-15 11:25:40
5176	Tâche "Extraction Image EBP"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	t	74	70	2022-02-16 07:09:50	2022-02-16 07:09:50
6045	Vous avez été assigné à la sous-tâche Affichage des 'PNR AirSegments' dans la liste des vols effectués du projet SIGM - Application inter Amadeus et Odoo	t	73	73	2022-02-22 08:56:16	2022-02-22 08:56:16
6046	Vous avez été assigné à la sous-tâche Affichage des autres informations significatives d'un billet du projet SIGM - Application inter Amadeus et Odoo	t	73	73	2022-02-22 08:57:11	2022-02-22 08:57:11
6063	Tâche "Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement."\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-02-22 09:35:22	2022-02-22 09:35:22
6064	Tâche "Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement."\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-02-22 09:35:22	2022-02-22 09:35:22
6065	Tâche "Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement."\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-02-22 09:35:22	2022-02-22 09:35:22
6066	Tâche "Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement."\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-02-22 09:35:22	2022-02-22 09:35:22
6067	Tâche "Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement."\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-02-22 09:35:22	2022-02-22 09:35:22
6074	Tâche "Modèle d'impression BON DE TRANSFERT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-02-22 09:37:49	2022-02-22 09:37:49
6075	Tâche "Modèle d'impression BON DE TRANSFERT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-02-22 09:37:49	2022-02-22 09:37:49
6076	Tâche "Modèle d'impression BON DE TRANSFERT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-02-22 09:37:49	2022-02-22 09:37:49
6077	Tâche "Modèle d'impression BON DE TRANSFERT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-02-22 09:37:49	2022-02-22 09:37:49
6078	Tâche "Modèle d'impression BON DE TRANSFERT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-02-22 09:37:49	2022-02-22 09:37:49
6415	Tâche "Mise en place WPAllExport des clients et commandes "\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	71	2022-02-24 04:48:13	2022-02-24 04:48:13
6416	Tâche "Mise en place WPAllExport des clients et commandes "\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	85	2022-02-24 04:48:13	2022-02-24 04:48:13
6456	Tâche "Modification du banner sur l'accueil"\n          du projet CDC - Intervention Site web mise dans " En cours " par Mihaja	f	70	53	2022-02-24 07:31:42	2022-02-24 07:31:42
6457	Tâche "Modification du banner sur l'accueil"\n          du projet CDC - Intervention Site web mise dans " En cours " par Mihaja	f	70	57	2022-02-24 07:31:42	2022-02-24 07:31:42
5455	Tâche nouvellement créee du nom de synchronisation des categories odoo et site web par Nasolo dans le projet Site web QLM.	f	72	53	2022-02-18 08:25:18	2022-02-18 08:25:18
5456	Tâche nouvellement créee du nom de synchronisation des categories odoo et site web par Nasolo dans le projet Site web QLM.	f	72	57	2022-02-18 08:25:18	2022-02-18 08:25:18
5458	Tâche nouvellement créee du nom de synchronisation des categories odoo et site web par Nasolo dans le projet Site web QLM.	f	72	71	2022-02-18 08:25:18	2022-02-18 08:25:18
5459	Tâche nouvellement créee du nom de synchronisation des categories odoo et site web par Nasolo dans le projet Site web QLM.	f	72	85	2022-02-18 08:25:18	2022-02-18 08:25:18
5478	Tâche "Création STC de deux salariés"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-18 09:24:12	2022-02-18 09:24:12
5479	Tâche "Création STC de deux salariés"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-18 09:24:12	2022-02-18 09:24:12
5481	Tâche "Création STC de deux salariés"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-18 09:24:12	2022-02-18 09:24:12
5482	Tâche "Création STC de deux salariés"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-18 09:24:12	2022-02-18 09:24:12
5553	Tâche nouvellement créee du nom de Rendre la référence de travel order obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-18 14:17:15	2022-02-18 14:17:15
5554	Tâche nouvellement créee du nom de Rendre la référence de travel order obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-18 14:17:15	2022-02-18 14:17:15
5556	Tâche nouvellement créee du nom de Rendre la référence de travel order obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-18 14:17:15	2022-02-18 14:17:15
5557	Tâche nouvellement créee du nom de Rendre la référence de travel order obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-18 14:17:15	2022-02-18 14:17:15
5457	Tâche nouvellement créee du nom de synchronisation des categories odoo et site web par Nasolo dans le projet Site web QLM.	t	72	70	2022-02-18 08:25:18	2022-02-18 08:25:18
5480	Tâche "Création STC de deux salariés"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-18 09:24:12	2022-02-18 09:24:12
5555	Tâche nouvellement créee du nom de Rendre la référence de travel order obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-18 14:17:15	2022-02-18 14:17:15
6005	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-22 08:49:31	2022-02-22 08:49:31
6006	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-22 08:49:31	2022-02-22 08:49:31
6007	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-22 08:49:31	2022-02-22 08:49:31
6008	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-22 08:49:31	2022-02-22 08:49:31
6009	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " En contrôle " par Mihaja	f	70	53	2022-02-22 08:50:57	2022-02-22 08:50:57
6010	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " En contrôle " par Mihaja	f	70	57	2022-02-22 08:50:57	2022-02-22 08:50:57
6011	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " En contrôle " par Mihaja	f	70	71	2022-02-22 08:50:57	2022-02-22 08:50:57
6012	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " En contrôle " par Mihaja	f	70	85	2022-02-22 08:50:57	2022-02-22 08:50:57
6028	Osé vous a assigné à la tâche Création modèle d'Import Client et Devis sur EBP.  dans le projet Synchro du site Computek.	f	74	74	2022-02-22 08:52:55	2022-02-22 08:52:55
6040	Tâche "Adaptation/vérification du programme import client"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	53	2022-02-22 08:55:12	2022-02-22 08:55:12
6041	Tâche "Adaptation/vérification du programme import client"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	57	2022-02-22 08:55:12	2022-02-22 08:55:12
6042	Tâche "Adaptation/vérification du programme import client"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	70	2022-02-22 08:55:12	2022-02-22 08:55:12
6043	Tâche "Adaptation/vérification du programme import client"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	71	2022-02-22 08:55:12	2022-02-22 08:55:12
6044	Tâche "Adaptation/vérification du programme import client"\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	85	2022-02-22 08:55:12	2022-02-22 08:55:12
6052	Tâche "Affichage des autres informations significatives d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	53	2022-02-22 08:57:29	2022-02-22 08:57:29
6053	Tâche "Affichage des autres informations significatives d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	57	2022-02-22 08:57:29	2022-02-22 08:57:29
6054	Tâche "Affichage des autres informations significatives d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	70	2022-02-22 08:57:29	2022-02-22 08:57:29
6055	Tâche "Affichage des autres informations significatives d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	71	2022-02-22 08:57:29	2022-02-22 08:57:29
6777	La tâche Suppression des doublons des clients a été achevée avec toutes ses tâches filles.	f	76	85	2022-02-25 13:28:36	2022-02-25 13:28:36
6794	La tâche Listes des articles déjà bloqués a été achevée.	f	76	53	2022-02-25 13:28:58	2022-02-25 13:28:58
6795	La tâche Listes des articles déjà bloqués a été achevée.	f	76	57	2022-02-25 13:28:58	2022-02-25 13:28:58
6797	La tâche Listes des articles déjà bloqués a été achevée.	f	76	71	2022-02-25 13:28:58	2022-02-25 13:28:58
5475	Tâche nouvellement créee du nom de Création STC de deux salariés par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-18 09:24:00	2022-02-18 09:24:00
5476	Tâche nouvellement créee du nom de Création STC de deux salariés par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-18 09:24:00	2022-02-18 09:24:00
5508	La tâche Rendre le champs Numéro PNR dans le document de commande obligatoire a été achevée.	f	78	53	2022-02-18 13:19:56	2022-02-18 13:19:56
5509	La tâche Rendre le champs Numéro PNR dans le document de commande obligatoire a été achevée.	f	78	57	2022-02-18 13:19:56	2022-02-18 13:19:56
5511	La tâche Rendre le champs Numéro PNR dans le document de commande obligatoire a été achevée.	f	78	71	2022-02-18 13:19:56	2022-02-18 13:19:56
5512	La tâche Rendre le champs Numéro PNR dans le document de commande obligatoire a été achevée.	f	78	85	2022-02-18 13:19:56	2022-02-18 13:19:56
5513	Tâche "Enlever User 01, User 02, User 03 de la liste des clients dans document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-18 13:24:07	2022-02-18 13:24:07
5514	Tâche "Enlever User 01, User 02, User 03 de la liste des clients dans document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-18 13:24:07	2022-02-18 13:24:07
5516	Tâche "Enlever User 01, User 02, User 03 de la liste des clients dans document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-18 13:24:07	2022-02-18 13:24:07
5517	Tâche "Enlever User 01, User 02, User 03 de la liste des clients dans document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	85	2022-02-18 13:24:07	2022-02-18 13:24:07
5528	La tâche Ajouter INF dans civilité dans la ligne de commande a été achevée.	f	78	53	2022-02-18 13:24:47	2022-02-18 13:24:47
5529	La tâche Ajouter INF dans civilité dans la ligne de commande a été achevée.	f	78	57	2022-02-18 13:24:47	2022-02-18 13:24:47
5531	La tâche Ajouter INF dans civilité dans la ligne de commande a été achevée.	f	78	71	2022-02-18 13:24:47	2022-02-18 13:24:47
5532	La tâche Ajouter INF dans civilité dans la ligne de commande a été achevée.	f	78	85	2022-02-18 13:24:47	2022-02-18 13:24:47
5510	La tâche Rendre le champs Numéro PNR dans le document de commande obligatoire a été achevée.	t	78	70	2022-02-18 13:19:56	2022-02-18 13:19:56
5515	Tâche "Enlever User 01, User 02, User 03 de la liste des clients dans document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-18 13:24:07	2022-02-18 13:24:07
5530	La tâche Ajouter INF dans civilité dans la ligne de commande a été achevée.	t	78	70	2022-02-18 13:24:47	2022-02-18 13:24:47
6013	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	53	2022-02-22 08:52:16	2022-02-22 08:52:16
6014	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	57	2022-02-22 08:52:16	2022-02-22 08:52:16
6015	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	70	2022-02-22 08:52:16	2022-02-22 08:52:16
6016	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	71	2022-02-22 08:52:16	2022-02-22 08:52:16
6017	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	85	2022-02-22 08:52:16	2022-02-22 08:52:16
6034	Tâche nouvellement créee du nom de Adaptation/vérification du programme import client par Osé dans le projet Synchro du site Computek.	f	74	53	2022-02-22 08:55:03	2022-02-22 08:55:03
6035	Tâche nouvellement créee du nom de Adaptation/vérification du programme import client par Osé dans le projet Synchro du site Computek.	f	74	57	2022-02-22 08:55:03	2022-02-22 08:55:03
6036	Tâche nouvellement créee du nom de Adaptation/vérification du programme import client par Osé dans le projet Synchro du site Computek.	f	74	70	2022-02-22 08:55:03	2022-02-22 08:55:03
6037	Tâche nouvellement créee du nom de Adaptation/vérification du programme import client par Osé dans le projet Synchro du site Computek.	f	74	71	2022-02-22 08:55:03	2022-02-22 08:55:03
6038	Tâche nouvellement créee du nom de Adaptation/vérification du programme import client par Osé dans le projet Synchro du site Computek.	f	74	85	2022-02-22 08:55:03	2022-02-22 08:55:03
6100	Tâche "Préparation un fichier d'inventaire COMPUTEK"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-22 09:39:55	2022-02-22 09:39:55
6101	Tâche "Préparation un fichier d'inventaire COMPUTEK"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-22 09:39:55	2022-02-22 09:39:55
6102	Tâche "Préparation un fichier d'inventaire COMPUTEK"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	70	2022-02-22 09:39:55	2022-02-22 09:39:55
6103	Tâche "Préparation un fichier d'inventaire COMPUTEK"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-22 09:39:55	2022-02-22 09:39:55
6104	Tâche "Préparation un fichier d'inventaire COMPUTEK"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-22 09:39:55	2022-02-22 09:39:55
6426	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	85	2022-02-24 05:02:09	2022-02-24 05:02:09
5960	Mihaja vous a assigné à la tâche Tester un module pour mettre les avances sur Odoo  dans le projet QLM Intervention / Accompagnement 2022.	t	70	72	2022-02-21 14:26:18	2022-02-21 14:26:18
6471	La tâche Mise à jour Code-barre articles Pointes a été achevée.	f	77	53	2022-02-24 08:01:05	2022-02-24 08:01:05
6472	La tâche Mise à jour Code-barre articles Pointes a été achevée.	f	77	57	2022-02-24 08:01:05	2022-02-24 08:01:05
6474	La tâche Mise à jour Code-barre articles Pointes a été achevée.	f	77	71	2022-02-24 08:01:05	2022-02-24 08:01:05
6475	La tâche Mise à jour Code-barre articles Pointes a été achevée.	f	77	85	2022-02-24 08:01:05	2022-02-24 08:01:05
6798	La tâche Listes des articles déjà bloqués a été achevée.	f	76	85	2022-02-25 13:28:58	2022-02-25 13:28:58
5491	Tâche "Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Rémi	f	78	71	2022-02-18 13:01:34	2022-02-18 13:01:34
5492	Tâche "Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Rémi	f	78	85	2022-02-18 13:01:34	2022-02-18 13:01:34
5558	Rémi vous a assigné à la tâche Rendre la référence de travel order obligatoire dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-18 14:17:15	2022-02-18 14:17:15
5559	Tâche "Rendre la référence de travel order obligatoire"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-18 14:18:06	2022-02-18 14:18:06
5560	Tâche "Rendre la référence de travel order obligatoire"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-18 14:18:06	2022-02-18 14:18:06
5562	Tâche "Rendre la référence de travel order obligatoire"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-18 14:18:06	2022-02-18 14:18:06
5563	Tâche "Rendre la référence de travel order obligatoire"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	85	2022-02-18 14:18:06	2022-02-18 14:18:06
5561	Tâche "Rendre la référence de travel order obligatoire"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-18 14:18:06	2022-02-18 14:18:06
6018	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	53	2022-02-22 08:52:20	2022-02-22 08:52:20
6019	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	57	2022-02-22 08:52:20	2022-02-22 08:52:20
6020	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	70	2022-02-22 08:52:20	2022-02-22 08:52:20
6021	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	71	2022-02-22 08:52:20	2022-02-22 08:52:20
6022	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	85	2022-02-22 08:52:20	2022-02-22 08:52:20
6427	Tâche nouvellement créee du nom de Repertorier les ecritures non rapprochées - BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	53	2022-02-24 06:34:50	2022-02-24 06:34:50
6428	Tâche nouvellement créee du nom de Repertorier les ecritures non rapprochées - BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	57	2022-02-24 06:34:50	2022-02-24 06:34:50
6430	Tâche nouvellement créee du nom de Repertorier les ecritures non rapprochées - BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	71	2022-02-24 06:34:50	2022-02-24 06:34:50
6431	Tâche nouvellement créee du nom de Repertorier les ecritures non rapprochées - BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	85	2022-02-24 06:34:50	2022-02-24 06:34:50
6447	Un projet du nom de CDC - Intervention Site web a été crée par Mihaja	f	70	53	2022-02-24 07:31:14	2022-02-24 07:31:14
6448	Un projet du nom de CDC - Intervention Site web a été crée par Mihaja	f	70	57	2022-02-24 07:31:14	2022-02-24 07:31:14
6449	Un projet du nom de CDC - Intervention Site web a été crée par Mihaja	f	70	71	2022-02-24 07:31:14	2022-02-24 07:31:14
6450	Un projet du nom de CDC - Intervention Site web a été crée par Mihaja	f	70	85	2022-02-24 07:31:14	2022-02-24 07:31:14
6507	Tâche nouvellement créee du nom de Intégration d'inventaire pour MOB+ par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-24 12:44:43	2022-02-24 12:44:43
6508	Tâche nouvellement créee du nom de Intégration d'inventaire pour MOB+ par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-24 12:44:43	2022-02-24 12:44:43
6510	Tâche nouvellement créee du nom de Intégration d'inventaire pour MOB+ par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-24 12:44:43	2022-02-24 12:44:43
6511	Tâche nouvellement créee du nom de Intégration d'inventaire pour MOB+ par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-24 12:44:43	2022-02-24 12:44:43
6512	Miandrisoa vous a assigné à la tâche Intégration d'inventaire pour MOB+ dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-24 12:44:43	2022-02-24 12:44:43
6534	Miandrisoa vous a assigné à la tâche Listes des articles déjà bloqués dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-24 12:51:34	2022-02-24 12:51:34
6591	Rémi vous a assigné à la tâche Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:12:35	2022-02-25 07:12:35
6609	Tâche nouvellement créee du nom de Enlever le champs référence dans doc de type to par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:16:04	2022-02-25 07:16:04
6610	Tâche nouvellement créee du nom de Enlever le champs référence dans doc de type to par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:16:04	2022-02-25 07:16:04
6612	Tâche nouvellement créee du nom de Enlever le champs référence dans doc de type to par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:16:04	2022-02-25 07:16:04
6613	Tâche nouvellement créee du nom de Enlever le champs référence dans doc de type to par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:16:04	2022-02-25 07:16:04
6619	Tâche nouvellement créee du nom de Déplacer la colonne fournisseur avant la colonne articles par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:16:51	2022-02-25 07:16:51
5494	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Rémi	f	78	57	2022-02-18 13:02:57	2022-02-18 13:02:57
5496	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Rémi	f	78	71	2022-02-18 13:02:57	2022-02-18 13:02:57
5497	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Rémi	f	78	85	2022-02-18 13:02:57	2022-02-18 13:02:57
5503	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'a pas le droit de confirmer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-18 13:19:27	2022-02-18 13:19:27
5504	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'a pas le droit de confirmer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-18 13:19:27	2022-02-18 13:19:27
5506	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'a pas le droit de confirmer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-18 13:19:27	2022-02-18 13:19:27
5507	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'a pas le droit de confirmer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	85	2022-02-18 13:19:27	2022-02-18 13:19:27
5533	La tâche Renommer "Date d'arrivé" en "Date d'arrivée" a été achevée.	f	78	53	2022-02-18 13:25:09	2022-02-18 13:25:09
5534	La tâche Renommer "Date d'arrivé" en "Date d'arrivée" a été achevée.	f	78	57	2022-02-18 13:25:09	2022-02-18 13:25:09
5536	La tâche Renommer "Date d'arrivé" en "Date d'arrivée" a été achevée.	f	78	71	2022-02-18 13:25:09	2022-02-18 13:25:09
5537	La tâche Renommer "Date d'arrivé" en "Date d'arrivée" a été achevée.	f	78	85	2022-02-18 13:25:09	2022-02-18 13:25:09
5538	La tâche Ordre des colonnes des lignes de commandes: Type d'article (billet, fees, supplément/voucher), Article,... (Fournisseur  et numéro de billet côte à côte) a été achevée.	f	78	53	2022-02-18 13:25:46	2022-02-18 13:25:46
5539	La tâche Ordre des colonnes des lignes de commandes: Type d'article (billet, fees, supplément/voucher), Article,... (Fournisseur  et numéro de billet côte à côte) a été achevée.	f	78	57	2022-02-18 13:25:46	2022-02-18 13:25:46
5541	La tâche Ordre des colonnes des lignes de commandes: Type d'article (billet, fees, supplément/voucher), Article,... (Fournisseur  et numéro de billet côte à côte) a été achevée.	f	78	71	2022-02-18 13:25:46	2022-02-18 13:25:46
5542	La tâche Ordre des colonnes des lignes de commandes: Type d'article (billet, fees, supplément/voucher), Article,... (Fournisseur  et numéro de billet côte à côte) a été achevée.	f	78	85	2022-02-18 13:25:46	2022-02-18 13:25:46
5495	Tâche "Création champ description technique des articles"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Rémi	t	78	70	2022-02-18 13:02:57	2022-02-18 13:02:57
5505	Tâche "Cacher le bouton confirmer dans travel order si l'utilisateur n'a pas le droit de confirmer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	t	78	70	2022-02-18 13:19:27	2022-02-18 13:19:27
5535	La tâche Renommer "Date d'arrivé" en "Date d'arrivée" a été achevée.	t	78	70	2022-02-18 13:25:09	2022-02-18 13:25:09
5540	La tâche Ordre des colonnes des lignes de commandes: Type d'article (billet, fees, supplément/voucher), Article,... (Fournisseur  et numéro de billet côte à côte) a été achevée.	t	78	70	2022-02-18 13:25:46	2022-02-18 13:25:46
6023	Tâche nouvellement créee du nom de Création modèle d'Import Client et Devis sur EBP.  par Osé dans le projet Synchro du site Computek.	f	74	53	2022-02-22 08:52:55	2022-02-22 08:52:55
6024	Tâche nouvellement créee du nom de Création modèle d'Import Client et Devis sur EBP.  par Osé dans le projet Synchro du site Computek.	f	74	57	2022-02-22 08:52:55	2022-02-22 08:52:55
6025	Tâche nouvellement créee du nom de Création modèle d'Import Client et Devis sur EBP.  par Osé dans le projet Synchro du site Computek.	f	74	70	2022-02-22 08:52:55	2022-02-22 08:52:55
6026	Tâche nouvellement créee du nom de Création modèle d'Import Client et Devis sur EBP.  par Osé dans le projet Synchro du site Computek.	f	74	71	2022-02-22 08:52:55	2022-02-22 08:52:55
6027	Tâche nouvellement créee du nom de Création modèle d'Import Client et Devis sur EBP.  par Osé dans le projet Synchro du site Computek.	f	74	85	2022-02-22 08:52:55	2022-02-22 08:52:55
6029	Tâche "Création modèle d'Import Client et Devis sur EBP. "\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	53	2022-02-22 08:53:29	2022-02-22 08:53:29
6030	Tâche "Création modèle d'Import Client et Devis sur EBP. "\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	57	2022-02-22 08:53:29	2022-02-22 08:53:29
6031	Tâche "Création modèle d'Import Client et Devis sur EBP. "\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	70	2022-02-22 08:53:29	2022-02-22 08:53:29
6032	Tâche "Création modèle d'Import Client et Devis sur EBP. "\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	71	2022-02-22 08:53:29	2022-02-22 08:53:29
6033	Tâche "Création modèle d'Import Client et Devis sur EBP. "\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	85	2022-02-22 08:53:29	2022-02-22 08:53:29
6437	Tâche nouvellement créee du nom de Installation des paquets  par Mihaja dans le projet EDR - Application Web Réappro.	f	70	53	2022-02-24 07:15:16	2022-02-24 07:15:16
6438	Tâche nouvellement créee du nom de Installation des paquets  par Mihaja dans le projet EDR - Application Web Réappro.	f	70	57	2022-02-24 07:15:16	2022-02-24 07:15:16
6439	Tâche nouvellement créee du nom de Installation des paquets  par Mihaja dans le projet EDR - Application Web Réappro.	f	70	71	2022-02-24 07:15:16	2022-02-24 07:15:16
6440	Tâche nouvellement créee du nom de Installation des paquets  par Mihaja dans le projet EDR - Application Web Réappro.	f	70	85	2022-02-24 07:15:16	2022-02-24 07:15:16
6441	Mihaja vous a assigné à la tâche Installation des paquets  dans le projet EDR - Application Web Réappro.	t	70	72	2022-02-24 07:15:16	2022-02-24 07:15:16
6482	La tâche Mise en place E-mail "cheinmaltcompta2@groupe-qlm.com" a été achevée.	f	77	53	2022-02-24 08:50:55	2022-02-24 08:50:55
6483	La tâche Mise en place E-mail "cheinmaltcompta2@groupe-qlm.com" a été achevée.	f	77	57	2022-02-24 08:50:55	2022-02-24 08:50:55
6484	La tâche Mise en place E-mail "cheinmaltcompta2@groupe-qlm.com" a été achevée.	t	77	70	2022-02-24 08:50:55	2022-02-24 08:50:55
5522	La tâche Mettre la liste de prix en mode lecture seule et/ou la masquer a été achevée.	f	78	85	2022-02-18 13:24:18	2022-02-18 13:24:18
6039	Osé vous a assigné à la tâche Adaptation/vérification du programme import client dans le projet Synchro du site Computek.	f	74	74	2022-02-22 08:55:03	2022-02-22 08:55:03
6047	Tâche "Affichage des 'PNR AirSegments' dans la liste des vols effectués"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	53	2022-02-22 08:57:24	2022-02-22 08:57:24
6048	Tâche "Affichage des 'PNR AirSegments' dans la liste des vols effectués"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	57	2022-02-22 08:57:24	2022-02-22 08:57:24
6049	Tâche "Affichage des 'PNR AirSegments' dans la liste des vols effectués"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	70	2022-02-22 08:57:24	2022-02-22 08:57:24
6050	Tâche "Affichage des 'PNR AirSegments' dans la liste des vols effectués"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	71	2022-02-22 08:57:24	2022-02-22 08:57:24
6051	Tâche "Affichage des 'PNR AirSegments' dans la liste des vols effectués"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	85	2022-02-22 08:57:24	2022-02-22 08:57:24
6062	Miandrisoa vous a assigné à la tâche Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement. dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-22 09:35:06	2022-02-22 09:35:06
6085	Tâche "Préparation fichier d'inventaire"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-22 09:39:21	2022-02-22 09:39:21
6086	Tâche "Préparation fichier d'inventaire"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-22 09:39:21	2022-02-22 09:39:21
6087	Tâche "Préparation fichier d'inventaire"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	70	2022-02-22 09:39:21	2022-02-22 09:39:21
6088	Tâche "Préparation fichier d'inventaire"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-22 09:39:21	2022-02-22 09:39:21
6089	Tâche "Préparation fichier d'inventaire"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-22 09:39:21	2022-02-22 09:39:21
6433	Un projet du nom de EDR - Application Web Réappro a été crée par Mihaja	f	70	53	2022-02-24 07:13:56	2022-02-24 07:13:56
6434	Un projet du nom de EDR - Application Web Réappro a été crée par Mihaja	f	70	57	2022-02-24 07:13:56	2022-02-24 07:13:56
6435	Un projet du nom de EDR - Application Web Réappro a été crée par Mihaja	f	70	71	2022-02-24 07:13:56	2022-02-24 07:13:56
6436	Un projet du nom de EDR - Application Web Réappro a été crée par Mihaja	f	70	85	2022-02-24 07:13:56	2022-02-24 07:13:56
6442	Tâche "Installation des paquets "\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	53	2022-02-24 07:15:51	2022-02-24 07:15:51
6443	Tâche "Installation des paquets "\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	57	2022-02-24 07:15:51	2022-02-24 07:15:51
6445	Tâche "Installation des paquets "\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	71	2022-02-24 07:15:51	2022-02-24 07:15:51
6446	Tâche "Installation des paquets "\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	85	2022-02-24 07:15:51	2022-02-24 07:15:51
6466	Tâche "Mise à jour Code-barre articles Pointes"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-24 08:00:49	2022-02-24 08:00:49
6467	Tâche "Mise à jour Code-barre articles Pointes"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-24 08:00:49	2022-02-24 08:00:49
6469	Tâche "Mise à jour Code-barre articles Pointes"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-24 08:00:49	2022-02-24 08:00:49
6470	Tâche "Mise à jour Code-barre articles Pointes"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-24 08:00:49	2022-02-24 08:00:49
6501	Miandrisoa vous a assigné à la tâche Déblocage d'un problème de connexion à la base dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-24 12:42:50	2022-02-24 12:42:50
6564	La tâche Intégration des Stocks dépôt 2 PO24141 et autres articles (carreaux) a été achevée.	f	77	53	2022-02-24 14:00:56	2022-02-24 14:00:56
6565	La tâche Intégration des Stocks dépôt 2 PO24141 et autres articles (carreaux) a été achevée.	f	77	57	2022-02-24 14:00:56	2022-02-24 14:00:56
6567	La tâche Intégration des Stocks dépôt 2 PO24141 et autres articles (carreaux) a été achevée.	f	77	71	2022-02-24 14:00:56	2022-02-24 14:00:56
6568	La tâche Intégration des Stocks dépôt 2 PO24141 et autres articles (carreaux) a été achevée.	f	77	85	2022-02-24 14:00:56	2022-02-24 14:00:56
6592	Tâche nouvellement créee du nom de Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:13:42	2022-02-25 07:13:42
6593	Tâche nouvellement créee du nom de Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:13:42	2022-02-25 07:13:42
6595	Tâche nouvellement créee du nom de Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:13:42	2022-02-25 07:13:42
6658	Tâche "Renommer "Nombre" en "Nombre de nuitées""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	85	2022-02-25 07:22:03	2022-02-25 07:22:03
5564	Tâche nouvellement créee du nom de Enlever les boutons créer une facture, envoyer la commande par courriel, annuler, bloquer dans le document d'achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-18 14:23:35	2022-02-18 14:23:35
5565	Tâche nouvellement créee du nom de Enlever les boutons créer une facture, envoyer la commande par courriel, annuler, bloquer dans le document d'achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-18 14:23:35	2022-02-18 14:23:35
5567	Tâche nouvellement créee du nom de Enlever les boutons créer une facture, envoyer la commande par courriel, annuler, bloquer dans le document d'achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-18 14:23:35	2022-02-18 14:23:35
5568	Tâche nouvellement créee du nom de Enlever les boutons créer une facture, envoyer la commande par courriel, annuler, bloquer dans le document d'achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-18 14:23:35	2022-02-18 14:23:35
5575	Tâche "Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-21 06:01:01	2022-02-21 06:01:01
5576	Tâche "Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-21 06:01:01	2022-02-21 06:01:01
5578	Tâche "Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	85	2022-02-21 06:01:01	2022-02-21 06:01:01
5674	Rémi vous a assigné à la tâche Renommer "TVA" en "TVA sur fees" dans la facture dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 06:56:36	2022-02-21 06:56:36
5699	Tâche nouvellement créee du nom de Ajouter dans le document d'achat le numéro du vol et les dates (dates de départ et d'arrivée) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:00:22	2022-02-21 07:00:22
5700	Tâche nouvellement créee du nom de Ajouter dans le document d'achat le numéro du vol et les dates (dates de départ et d'arrivée) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:00:22	2022-02-21 07:00:22
5702	Tâche nouvellement créee du nom de Ajouter dans le document d'achat le numéro du vol et les dates (dates de départ et d'arrivée) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:00:22	2022-02-21 07:00:22
5703	Tâche nouvellement créee du nom de Ajouter dans le document d'achat le numéro du vol et les dates (dates de départ et d'arrivée) par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:00:22	2022-02-21 07:00:22
5717	Tâche nouvellement créee du nom de Dans la ficher client, enlever tout dans les conditions de paiement et ne laisser que Paiement immédiat et 30 jours par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:03:58	2022-02-21 07:03:58
5718	Tâche nouvellement créee du nom de Dans la ficher client, enlever tout dans les conditions de paiement et ne laisser que Paiement immédiat et 30 jours par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:03:58	2022-02-21 07:03:58
5720	Tâche nouvellement créee du nom de Dans la ficher client, enlever tout dans les conditions de paiement et ne laisser que Paiement immédiat et 30 jours par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:03:58	2022-02-21 07:03:58
5721	Tâche nouvellement créee du nom de Dans la ficher client, enlever tout dans les conditions de paiement et ne laisser que Paiement immédiat et 30 jours par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:03:58	2022-02-21 07:03:58
5729	Tâche nouvellement créee du nom de Mettre la même présentation dans la facture (lignes) que dans le document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:05:22	2022-02-21 07:05:22
5730	Tâche nouvellement créee du nom de Mettre la même présentation dans la facture (lignes) que dans le document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:05:22	2022-02-21 07:05:22
5732	Tâche nouvellement créee du nom de Mettre la même présentation dans la facture (lignes) que dans le document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:05:22	2022-02-21 07:05:22
5733	Tâche nouvellement créee du nom de Mettre la même présentation dans la facture (lignes) que dans le document de commande par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:05:22	2022-02-21 07:05:22
5747	Tâche nouvellement créee du nom de Afficher les autres taxes dans l'impression facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:08:07	2022-02-21 07:08:07
5748	Tâche nouvellement créee du nom de Afficher les autres taxes dans l'impression facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:08:07	2022-02-21 07:08:07
5750	Tâche nouvellement créee du nom de Afficher les autres taxes dans l'impression facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:08:07	2022-02-21 07:08:07
5569	Rémi vous a assigné à la tâche Enlever les boutons créer une facture, envoyer la commande par courriel, annuler, bloquer dans le document d'achat dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-18 14:23:35	2022-02-18 14:23:35
5570	La tâche Enlever les boutons créer une facture, envoyer la commande par courriel, annuler, bloquer dans le document d'achat a été achevée.	f	78	53	2022-02-18 14:23:42	2022-02-18 14:23:42
5571	La tâche Enlever les boutons créer une facture, envoyer la commande par courriel, annuler, bloquer dans le document d'achat a été achevée.	f	78	57	2022-02-18 14:23:42	2022-02-18 14:23:42
5573	La tâche Enlever les boutons créer une facture, envoyer la commande par courriel, annuler, bloquer dans le document d'achat a été achevée.	f	78	71	2022-02-18 14:23:42	2022-02-18 14:23:42
5574	La tâche Enlever les boutons créer une facture, envoyer la commande par courriel, annuler, bloquer dans le document d'achat a été achevée.	f	78	85	2022-02-18 14:23:42	2022-02-18 14:23:42
5579	Tâche "droit d'autorisation pour SABIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-21 06:01:09	2022-02-21 06:01:09
5580	Tâche "droit d'autorisation pour SABIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-21 06:01:09	2022-02-21 06:01:09
5582	Tâche "droit d'autorisation pour SABIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	85	2022-02-21 06:01:09	2022-02-21 06:01:09
5612	Tâche "Rapprochement bancaire mai-juin BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Haro	f	79	53	2022-02-21 06:07:56	2022-02-21 06:07:56
5613	Tâche "Rapprochement bancaire mai-juin BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Haro	f	79	57	2022-02-21 06:07:56	2022-02-21 06:07:56
5615	Tâche "Rapprochement bancaire mai-juin BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Haro	f	79	71	2022-02-21 06:07:56	2022-02-21 06:07:56
5616	Tâche "Rapprochement bancaire mai-juin BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Haro	f	79	85	2022-02-21 06:07:56	2022-02-21 06:07:56
5617	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	53	2022-02-21 06:25:03	2022-02-21 06:25:03
5618	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	57	2022-02-21 06:25:03	2022-02-21 06:25:03
5620	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	71	2022-02-21 06:25:03	2022-02-21 06:25:03
5621	Tâche "Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro "\n          du projet Synchro du site Computek mise dans " En cours " par Osé	f	74	85	2022-02-21 06:25:03	2022-02-21 06:25:03
5634	Tâche "Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 06:50:17	2022-02-21 06:50:17
5635	Tâche "Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 06:50:17	2022-02-21 06:50:17
5636	Tâche "Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 06:50:17	2022-02-21 06:50:17
5637	Tâche "Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 06:50:17	2022-02-21 06:50:17
5650	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	f	71	53	2022-02-21 06:52:59	2022-02-21 06:52:59
5651	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	f	71	57	2022-02-21 06:52:59	2022-02-21 06:52:59
5653	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	f	71	85	2022-02-21 06:52:59	2022-02-21 06:52:59
5654	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	53	2022-02-21 06:53:38	2022-02-21 06:53:38
5655	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	57	2022-02-21 06:53:38	2022-02-21 06:53:38
5657	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	71	2022-02-21 06:53:38	2022-02-21 06:53:38
5658	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	85	2022-02-21 06:53:38	2022-02-21 06:53:38
5583	Tâche "Droit des utilisateurS COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-21 06:01:16	2022-02-21 06:01:16
5584	Tâche "Droit des utilisateurS COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-21 06:01:16	2022-02-21 06:01:16
5586	Tâche "Droit des utilisateurS COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	85	2022-02-21 06:01:16	2022-02-21 06:01:16
5601	Tâche nouvellement créee du nom de Rapprochement bancaire mai-juin BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	53	2022-02-21 06:07:07	2022-02-21 06:07:07
5602	Tâche nouvellement créee du nom de Rapprochement bancaire mai-juin BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	57	2022-02-21 06:07:07	2022-02-21 06:07:07
5604	Tâche nouvellement créee du nom de Rapprochement bancaire mai-juin BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	71	2022-02-21 06:07:07	2022-02-21 06:07:07
5605	Tâche nouvellement créee du nom de Rapprochement bancaire mai-juin BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	85	2022-02-21 06:07:07	2022-02-21 06:07:07
5622	Tâche "Extraction Image EBP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 06:49:26	2022-02-21 06:49:26
5623	Tâche "Extraction Image EBP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 06:49:26	2022-02-21 06:49:26
5624	Tâche "Extraction Image EBP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 06:49:26	2022-02-21 06:49:26
5625	Tâche "Extraction Image EBP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 06:49:26	2022-02-21 06:49:26
5646	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	f	71	53	2022-02-21 06:52:42	2022-02-21 06:52:42
5647	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	f	71	57	2022-02-21 06:52:42	2022-02-21 06:52:42
5649	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	f	71	85	2022-02-21 06:52:42	2022-02-21 06:52:42
5675	Tâche nouvellement créee du nom de Renommer "Nombre d'achat" en "Achat" dans le document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 06:57:25	2022-02-21 06:57:25
5676	Tâche nouvellement créee du nom de Renommer "Nombre d'achat" en "Achat" dans le document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 06:57:25	2022-02-21 06:57:25
5678	Tâche nouvellement créee du nom de Renommer "Nombre d'achat" en "Achat" dans le document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 06:57:25	2022-02-21 06:57:25
5679	Tâche nouvellement créee du nom de Renommer "Nombre d'achat" en "Achat" dans le document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 06:57:25	2022-02-21 06:57:25
5752	Rémi vous a assigné à la tâche Afficher les autres taxes dans l'impression facture dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:08:07	2022-02-21 07:08:07
5585	Tâche "Droit des utilisateurS COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-21 06:01:16	2022-02-21 06:01:16
5603	Tâche nouvellement créee du nom de Rapprochement bancaire mai-juin BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	79	70	2022-02-21 06:07:07	2022-02-21 06:07:07
5648	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	t	71	70	2022-02-21 06:52:42	2022-02-21 06:52:42
5677	Tâche nouvellement créee du nom de Renommer "Nombre d'achat" en "Achat" dans le document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 06:57:25	2022-02-21 06:57:25
6056	Tâche "Affichage des autres informations significatives d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	85	2022-02-22 08:57:29	2022-02-22 08:57:29
6057	Tâche nouvellement créee du nom de Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement. par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-22 09:35:06	2022-02-22 09:35:06
6058	Tâche nouvellement créee du nom de Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement. par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-22 09:35:06	2022-02-22 09:35:06
6059	Tâche nouvellement créee du nom de Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement. par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-02-22 09:35:06	2022-02-22 09:35:06
6060	Tâche nouvellement créee du nom de Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement. par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-22 09:35:06	2022-02-22 09:35:06
6061	Tâche nouvellement créee du nom de Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement. par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-22 09:35:06	2022-02-22 09:35:06
6079	Tâche nouvellement créee du nom de Préparation fichier d'inventaire par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-22 09:38:25	2022-02-22 09:38:25
6080	Tâche nouvellement créee du nom de Préparation fichier d'inventaire par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-22 09:38:25	2022-02-22 09:38:25
6081	Tâche nouvellement créee du nom de Préparation fichier d'inventaire par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-02-22 09:38:25	2022-02-22 09:38:25
6082	Tâche nouvellement créee du nom de Préparation fichier d'inventaire par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-22 09:38:25	2022-02-22 09:38:25
7550	La tâche Ajustement de stock ATG0601 et PEG60*18 pour validation BL a été achevée.	f	77	71	2022-03-03 10:16:20	2022-03-03 10:16:20
5587	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-21 06:03:29	2022-02-21 06:03:29
5588	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-21 06:03:29	2022-02-21 06:03:29
5590	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	85	2022-02-21 06:03:29	2022-02-21 06:03:29
5591	Tâche "Finir le rapprochement bancaire pour une banque"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	53	2022-02-21 06:05:19	2022-02-21 06:05:19
5592	Tâche "Finir le rapprochement bancaire pour une banque"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	57	2022-02-21 06:05:19	2022-02-21 06:05:19
5594	Tâche "Finir le rapprochement bancaire pour une banque"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	71	2022-02-21 06:05:19	2022-02-21 06:05:19
5595	Tâche "Finir le rapprochement bancaire pour une banque"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	85	2022-02-21 06:05:19	2022-02-21 06:05:19
5638	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 06:50:40	2022-02-21 06:50:40
5639	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 06:50:40	2022-02-21 06:50:40
5640	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 06:50:40	2022-02-21 06:50:40
5641	Tâche "Intégration des requêtes et adaptation des programmes synchro"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 06:50:40	2022-02-21 06:50:40
5711	Tâche nouvellement créee du nom de Renommer "Émis" en "émis" dans impression facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:03:06	2022-02-21 07:03:06
5712	Tâche nouvellement créee du nom de Renommer "Émis" en "émis" dans impression facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:03:06	2022-02-21 07:03:06
5714	Tâche nouvellement créee du nom de Renommer "Émis" en "émis" dans impression facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:03:06	2022-02-21 07:03:06
5715	Tâche nouvellement créee du nom de Renommer "Émis" en "émis" dans impression facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:03:06	2022-02-21 07:03:06
5722	Rémi vous a assigné à la tâche Dans la ficher client, enlever tout dans les conditions de paiement et ne laisser que Paiement immédiat et 30 jours dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:03:58	2022-02-21 07:03:58
5734	Rémi vous a assigné à la tâche Mettre la même présentation dans la facture (lignes) que dans le document de commande dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:05:22	2022-02-21 07:05:22
5589	Tâche "Paramétrage model d'impression"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	t	71	70	2022-02-21 06:03:29	2022-02-21 06:03:29
5593	Tâche "Finir le rapprochement bancaire pour une banque"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	t	79	70	2022-02-21 06:05:19	2022-02-21 06:05:19
5713	Tâche nouvellement créee du nom de Renommer "Émis" en "émis" dans impression facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:03:06	2022-02-21 07:03:06
6068	Tâche nouvellement créee du nom de Modèle d'impression BON DE TRANSFERT par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-22 09:36:04	2022-02-22 09:36:04
6069	Tâche nouvellement créee du nom de Modèle d'impression BON DE TRANSFERT par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-22 09:36:04	2022-02-22 09:36:04
6070	Tâche nouvellement créee du nom de Modèle d'impression BON DE TRANSFERT par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-02-22 09:36:04	2022-02-22 09:36:04
6071	Tâche nouvellement créee du nom de Modèle d'impression BON DE TRANSFERT par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-22 09:36:04	2022-02-22 09:36:04
6072	Tâche nouvellement créee du nom de Modèle d'impression BON DE TRANSFERT par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-22 09:36:04	2022-02-22 09:36:04
6458	Tâche "Modification du banner sur l'accueil"\n          du projet CDC - Intervention Site web mise dans " En cours " par Mihaja	f	70	71	2022-02-24 07:31:42	2022-02-24 07:31:42
6459	Tâche "Modification du banner sur l'accueil"\n          du projet CDC - Intervention Site web mise dans " En cours " par Mihaja	f	70	85	2022-02-24 07:31:42	2022-02-24 07:31:42
6491	La tâche Mettre le montant en lettre dans l'impression de facture a été achevée.	f	78	53	2022-02-24 10:34:54	2022-02-24 10:34:54
6492	La tâche Mettre le montant en lettre dans l'impression de facture a été achevée.	f	78	57	2022-02-24 10:34:54	2022-02-24 10:34:54
6494	La tâche Mettre le montant en lettre dans l'impression de facture a été achevée.	f	78	71	2022-02-24 10:34:54	2022-02-24 10:34:54
6495	La tâche Mettre le montant en lettre dans l'impression de facture a été achevée.	f	78	85	2022-02-24 10:34:54	2022-02-24 10:34:54
6541	Tâche nouvellement créee du nom de Déblocage d'un problème de création d'un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-24 12:53:05	2022-02-24 12:53:05
6542	Tâche nouvellement créee du nom de Déblocage d'un problème de création d'un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-24 12:53:05	2022-02-24 12:53:05
6544	Tâche nouvellement créee du nom de Déblocage d'un problème de création d'un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-24 12:53:05	2022-02-24 12:53:05
5359	Miandrisoa vous a assigné à la tâche Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	76	2022-02-17 07:02:29	2022-02-17 07:02:29
5371	Miandrisoa vous a assigné à la tâche Paramétrage model d'impression dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	76	2022-02-17 07:03:30	2022-02-17 07:03:30
5398	Miandrisoa vous a assigné à la tâche Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	76	2022-02-17 07:05:09	2022-02-17 07:05:09
5410	Miandrisoa vous a assigné à la tâche droit d'autorisation pour SABIR dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	76	2022-02-17 07:06:24	2022-02-17 07:06:24
5607	Tâche "Rapprochement bancaire mai-juin BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	53	2022-02-21 06:07:23	2022-02-21 06:07:23
5608	Tâche "Rapprochement bancaire mai-juin BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	57	2022-02-21 06:07:23	2022-02-21 06:07:23
5610	Tâche "Rapprochement bancaire mai-juin BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	71	2022-02-21 06:07:23	2022-02-21 06:07:23
5611	Tâche "Rapprochement bancaire mai-juin BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	85	2022-02-21 06:07:23	2022-02-21 06:07:23
5735	Tâche nouvellement créee du nom de Dans fiche facture > Ecriture comptable, les libellés doivent avoir la même valeur sur toutes les lignes par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:06:17	2022-02-21 07:06:17
5736	Tâche nouvellement créee du nom de Dans fiche facture > Ecriture comptable, les libellés doivent avoir la même valeur sur toutes les lignes par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:06:17	2022-02-21 07:06:17
5738	Tâche nouvellement créee du nom de Dans fiche facture > Ecriture comptable, les libellés doivent avoir la même valeur sur toutes les lignes par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:06:17	2022-02-21 07:06:17
5739	Tâche nouvellement créee du nom de Dans fiche facture > Ecriture comptable, les libellés doivent avoir la même valeur sur toutes les lignes par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:06:17	2022-02-21 07:06:17
5746	Rémi vous a assigné à la tâche Dans fiche facture > Ecriture comptable, mettre une ligne par billet dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:06:48	2022-02-21 07:06:48
5776	Rémi vous a assigné à la tâche Erreur lors de la confirmation d'un avoir dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:11:28	2022-02-21 07:11:28
5609	Tâche "Rapprochement bancaire mai-juin BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	t	79	70	2022-02-21 06:07:23	2022-02-21 06:07:23
5737	Tâche nouvellement créee du nom de Dans fiche facture > Ecriture comptable, les libellés doivent avoir la même valeur sur toutes les lignes par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:06:17	2022-02-21 07:06:17
6073	Miandrisoa vous a assigné à la tâche Modèle d'impression BON DE TRANSFERT dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-22 09:36:04	2022-02-22 09:36:04
6095	Tâche "Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement."\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-22 09:39:48	2022-02-22 09:39:48
6096	Tâche "Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement."\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-22 09:39:48	2022-02-22 09:39:48
6097	Tâche "Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement."\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	70	2022-02-22 09:39:48	2022-02-22 09:39:48
6098	Tâche "Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement."\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-22 09:39:48	2022-02-22 09:39:48
6099	Tâche "Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement."\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-22 09:39:48	2022-02-22 09:39:48
6460	Tâche nouvellement créee du nom de Mise à jour Code-barre articles Pointes par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-24 08:00:31	2022-02-24 08:00:31
6461	Tâche nouvellement créee du nom de Mise à jour Code-barre articles Pointes par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-24 08:00:31	2022-02-24 08:00:31
6463	Tâche nouvellement créee du nom de Mise à jour Code-barre articles Pointes par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-24 08:00:31	2022-02-24 08:00:31
6464	Tâche nouvellement créee du nom de Mise à jour Code-barre articles Pointes par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-24 08:00:31	2022-02-24 08:00:31
6502	La tâche Déblocage d'un problème de connexion à la base a été achevée.	f	76	53	2022-02-24 12:43:19	2022-02-24 12:43:19
6503	La tâche Déblocage d'un problème de connexion à la base a été achevée.	f	76	57	2022-02-24 12:43:19	2022-02-24 12:43:19
6505	La tâche Déblocage d'un problème de connexion à la base a été achevée.	f	76	71	2022-02-24 12:43:19	2022-02-24 12:43:19
6506	La tâche Déblocage d'un problème de connexion à la base a été achevée.	f	76	85	2022-02-24 12:43:19	2022-02-24 12:43:19
6529	Tâche nouvellement créee du nom de Listes des articles déjà bloqués par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-24 12:51:34	2022-02-24 12:51:34
6530	Tâche nouvellement créee du nom de Listes des articles déjà bloqués par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-24 12:51:34	2022-02-24 12:51:34
5596	Tâche "Prise en compte des données Tour (en cas de modification du circuit)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	53	2022-02-21 06:05:27	2022-02-21 06:05:27
5597	Tâche "Prise en compte des données Tour (en cas de modification du circuit)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	57	2022-02-21 06:05:27	2022-02-21 06:05:27
5599	Tâche "Prise en compte des données Tour (en cas de modification du circuit)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	71	2022-02-21 06:05:27	2022-02-21 06:05:27
5600	Tâche "Prise en compte des données Tour (en cas de modification du circuit)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	85	2022-02-21 06:05:27	2022-02-21 06:05:27
5698	Rémi vous a assigné à la tâche Renommer "Agence de voyage" en "Agences de voyage" dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 06:59:20	2022-02-21 06:59:20
5740	Rémi vous a assigné à la tâche Dans fiche facture > Ecriture comptable, les libellés doivent avoir la même valeur sur toutes les lignes dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:06:17	2022-02-21 07:06:17
5598	Tâche "Prise en compte des données Tour (en cas de modification du circuit)"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	t	79	70	2022-02-21 06:05:27	2022-02-21 06:05:27
6083	Tâche nouvellement créee du nom de Préparation fichier d'inventaire par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-22 09:38:25	2022-02-22 09:38:25
6084	Miandrisoa vous a assigné à la tâche Préparation fichier d'inventaire dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-22 09:38:25	2022-02-22 09:38:25
6479	Tâche nouvellement créee du nom de Mise en place E-mail "cheinmaltcompta2@groupe-qlm.com" par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-24 08:50:40	2022-02-24 08:50:40
6480	Tâche nouvellement créee du nom de Mise en place E-mail "cheinmaltcompta2@groupe-qlm.com" par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-24 08:50:40	2022-02-24 08:50:40
6535	Tâche nouvellement créee du nom de Paramétrage sur les fiches Clients par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-24 12:52:21	2022-02-24 12:52:21
6536	Tâche nouvellement créee du nom de Paramétrage sur les fiches Clients par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-24 12:52:21	2022-02-24 12:52:21
6538	Tâche nouvellement créee du nom de Paramétrage sur les fiches Clients par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-24 12:52:21	2022-02-24 12:52:21
6539	Tâche nouvellement créee du nom de Paramétrage sur les fiches Clients par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-24 12:52:21	2022-02-24 12:52:21
6540	Miandrisoa vous a assigné à la tâche Paramétrage sur les fiches Clients dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-24 12:52:21	2022-02-24 12:52:21
6574	Miandrisoa vous a assigné à la tâche Intégration d'inventaire pour Computek Tamatave dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-25 06:05:24	2022-02-25 06:05:24
6630	Tâche "Déplacer la colonne fournisseur avant la colonne articles"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	85	2022-02-25 07:17:18	2022-02-25 07:17:18
6643	Tâche "Renommer "Quantité" en "Nombre de chambres/personnes""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	53	2022-02-25 07:21:18	2022-02-25 07:21:18
6644	Tâche "Renommer "Quantité" en "Nombre de chambres/personnes""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	57	2022-02-25 07:21:18	2022-02-25 07:21:18
6646	Tâche "Renommer "Quantité" en "Nombre de chambres/personnes""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	71	2022-02-25 07:21:18	2022-02-25 07:21:18
6647	Tâche "Renommer "Quantité" en "Nombre de chambres/personnes""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	85	2022-02-25 07:21:18	2022-02-25 07:21:18
6648	Tâche nouvellement créee du nom de Renommer "Nombre" en "Nombre de nuitées" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:21:52	2022-02-25 07:21:52
6649	Tâche nouvellement créee du nom de Renommer "Nombre" en "Nombre de nuitées" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:21:52	2022-02-25 07:21:52
6651	Tâche nouvellement créee du nom de Renommer "Nombre" en "Nombre de nuitées" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:21:52	2022-02-25 07:21:52
6652	Tâche nouvellement créee du nom de Renommer "Nombre" en "Nombre de nuitées" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:21:52	2022-02-25 07:21:52
6659	Tâche nouvellement créee du nom de Prendre en compte "Nombre" dans le calcul du prix total et du total HT par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:23:38	2022-02-25 07:23:38
6660	Tâche nouvellement créee du nom de Prendre en compte "Nombre" dans le calcul du prix total et du total HT par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:23:38	2022-02-25 07:23:38
6662	Tâche nouvellement créee du nom de Prendre en compte "Nombre" dans le calcul du prix total et du total HT par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:23:38	2022-02-25 07:23:38
6537	Tâche nouvellement créee du nom de Paramétrage sur les fiches Clients par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-24 12:52:21	2022-02-24 12:52:21
5630	Tâche "Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 06:49:48	2022-02-21 06:49:48
5631	Tâche "Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 06:49:48	2022-02-21 06:49:48
5632	Tâche "Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 06:49:48	2022-02-21 06:49:48
5633	Tâche "Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 06:49:48	2022-02-21 06:49:48
5642	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	53	2022-02-21 06:52:14	2022-02-21 06:52:14
5643	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	57	2022-02-21 06:52:14	2022-02-21 06:52:14
5645	Tâche "Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Michel	f	71	85	2022-02-21 06:52:14	2022-02-21 06:52:14
5659	Tâche "Droit des utilisateurS COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	f	71	53	2022-02-21 06:54:02	2022-02-21 06:54:02
5660	Tâche "Droit des utilisateurS COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	f	71	57	2022-02-21 06:54:02	2022-02-21 06:54:02
5662	Tâche "Droit des utilisateurS COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Michel	f	71	85	2022-02-21 06:54:02	2022-02-21 06:54:02
5680	Rémi vous a assigné à la tâche Renommer "Nombre d'achat" en "Achat" dans le document travel order dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 06:57:25	2022-02-21 06:57:25
5681	Tâche nouvellement créee du nom de Renommer "Remboursement partiel" en "Avoir partiel" dans document facture > ajouter un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 06:58:23	2022-02-21 06:58:23
5682	Tâche nouvellement créee du nom de Renommer "Remboursement partiel" en "Avoir partiel" dans document facture > ajouter un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 06:58:23	2022-02-21 06:58:23
5684	Tâche nouvellement créee du nom de Renommer "Remboursement partiel" en "Avoir partiel" dans document facture > ajouter un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 06:58:23	2022-02-21 06:58:23
5685	Tâche nouvellement créee du nom de Renommer "Remboursement partiel" en "Avoir partiel" dans document facture > ajouter un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 06:58:23	2022-02-21 06:58:23
5710	Rémi vous a assigné à la tâche Mettre le montant en lettre dans l'impression de facture dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:01:40	2022-02-21 07:01:40
5723	Tâche nouvellement créee du nom de Dans la fiche facture, masquer le bouton "Remettre en brouillon" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:04:41	2022-02-21 07:04:41
5724	Tâche nouvellement créee du nom de Dans la fiche facture, masquer le bouton "Remettre en brouillon" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:04:41	2022-02-21 07:04:41
5726	Tâche nouvellement créee du nom de Dans la fiche facture, masquer le bouton "Remettre en brouillon" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:04:41	2022-02-21 07:04:41
5727	Tâche nouvellement créee du nom de Dans la fiche facture, masquer le bouton "Remettre en brouillon" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:04:41	2022-02-21 07:04:41
5741	Tâche nouvellement créee du nom de Dans fiche facture > Ecriture comptable, mettre une ligne par billet par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:06:48	2022-02-21 07:06:48
5742	Tâche nouvellement créee du nom de Dans fiche facture > Ecriture comptable, mettre une ligne par billet par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:06:48	2022-02-21 07:06:48
5744	Tâche nouvellement créee du nom de Dans fiche facture > Ecriture comptable, mettre une ligne par billet par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:06:48	2022-02-21 07:06:48
5745	Tâche nouvellement créee du nom de Dans fiche facture > Ecriture comptable, mettre une ligne par billet par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:06:48	2022-02-21 07:06:48
5753	Tâche nouvellement créee du nom de Dans impression facture, mettre les fournisseurs au niveau de la ligne par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:08:43	2022-02-21 07:08:43
6485	La tâche Mise en place E-mail "cheinmaltcompta2@groupe-qlm.com" a été achevée.	f	77	71	2022-02-24 08:50:55	2022-02-24 08:50:55
6486	La tâche Mise en place E-mail "cheinmaltcompta2@groupe-qlm.com" a été achevée.	f	77	85	2022-02-24 08:50:55	2022-02-24 08:50:55
6523	Miandrisoa vous a assigné à la tâche Suppression des doublons des clients dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-24 12:45:41	2022-02-24 12:45:41
6546	Miandrisoa vous a assigné à la tâche Déblocage d'un problème de création d'un BL dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-24 12:53:05	2022-02-24 12:53:05
6547	La tâche Déblocage d'un problème de création d'un BL a été achevée.	f	76	53	2022-02-24 12:53:33	2022-02-24 12:53:33
6548	La tâche Déblocage d'un problème de création d'un BL a été achevée.	f	76	57	2022-02-24 12:53:33	2022-02-24 12:53:33
6550	La tâche Déblocage d'un problème de création d'un BL a été achevée.	f	76	71	2022-02-24 12:53:33	2022-02-24 12:53:33
6549	La tâche Déblocage d'un problème de création d'un BL a été achevée.	t	76	70	2022-02-24 12:53:33	2022-02-24 12:53:33
5626	Tâche "Transfert Image To FTP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-21 06:49:30	2022-02-21 06:49:30
5627	Tâche "Transfert Image To FTP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-21 06:49:30	2022-02-21 06:49:30
5628	Tâche "Transfert Image To FTP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-21 06:49:30	2022-02-21 06:49:30
5629	Tâche "Transfert Image To FTP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-21 06:49:30	2022-02-21 06:49:30
5669	Tâche nouvellement créee du nom de Renommer "TVA" en "TVA sur fees" dans la facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 06:56:36	2022-02-21 06:56:36
5670	Tâche nouvellement créee du nom de Renommer "TVA" en "TVA sur fees" dans la facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 06:56:36	2022-02-21 06:56:36
5672	Tâche nouvellement créee du nom de Renommer "TVA" en "TVA sur fees" dans la facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 06:56:36	2022-02-21 06:56:36
5673	Tâche nouvellement créee du nom de Renommer "TVA" en "TVA sur fees" dans la facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 06:56:36	2022-02-21 06:56:36
5686	Rémi vous a assigné à la tâche Renommer "Remboursement partiel" en "Avoir partiel" dans document facture > ajouter un avoir dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 06:58:23	2022-02-21 06:58:23
5693	Tâche nouvellement créee du nom de Renommer "Agence de voyage" en "Agences de voyage" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 06:59:20	2022-02-21 06:59:20
5694	Tâche nouvellement créee du nom de Renommer "Agence de voyage" en "Agences de voyage" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 06:59:20	2022-02-21 06:59:20
5696	Tâche nouvellement créee du nom de Renommer "Agence de voyage" en "Agences de voyage" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 06:59:20	2022-02-21 06:59:20
5697	Tâche nouvellement créee du nom de Renommer "Agence de voyage" en "Agences de voyage" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 06:59:20	2022-02-21 06:59:20
5705	Tâche nouvellement créee du nom de Mettre le montant en lettre dans l'impression de facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:01:40	2022-02-21 07:01:40
5706	Tâche nouvellement créee du nom de Mettre le montant en lettre dans l'impression de facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:01:40	2022-02-21 07:01:40
5708	Tâche nouvellement créee du nom de Mettre le montant en lettre dans l'impression de facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:01:40	2022-02-21 07:01:40
5709	Tâche nouvellement créee du nom de Mettre le montant en lettre dans l'impression de facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:01:40	2022-02-21 07:01:40
5716	Rémi vous a assigné à la tâche Renommer "Émis" en "émis" dans impression facture dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:03:06	2022-02-21 07:03:06
5758	Rémi vous a assigné à la tâche Dans impression facture, mettre les fournisseurs au niveau de la ligne dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:08:43	2022-02-21 07:08:43
5759	Tâche nouvellement créee du nom de Dans la fiche facture > Ajouter un avoir, l'option date d'extourne doit être la date du jour et non la date de la pièce comptable par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:10:24	2022-02-21 07:10:24
5760	Tâche nouvellement créee du nom de Dans la fiche facture > Ajouter un avoir, l'option date d'extourne doit être la date du jour et non la date de la pièce comptable par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:10:24	2022-02-21 07:10:24
5762	Tâche nouvellement créee du nom de Dans la fiche facture > Ajouter un avoir, l'option date d'extourne doit être la date du jour et non la date de la pièce comptable par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:10:24	2022-02-21 07:10:24
5763	Tâche nouvellement créee du nom de Dans la fiche facture > Ajouter un avoir, l'option date d'extourne doit être la date du jour et non la date de la pièce comptable par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:10:24	2022-02-21 07:10:24
5764	Rémi vous a assigné à la tâche Dans la fiche facture > Ajouter un avoir, l'option date d'extourne doit être la date du jour et non la date de la pièce comptable dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:10:24	2022-02-21 07:10:24
5671	Tâche nouvellement créee du nom de Renommer "TVA" en "TVA sur fees" dans la facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 06:56:36	2022-02-21 06:56:36
5695	Tâche nouvellement créee du nom de Renommer "Agence de voyage" en "Agences de voyage" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 06:59:20	2022-02-21 06:59:20
5707	Tâche nouvellement créee du nom de Mettre le montant en lettre dans l'impression de facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:01:40	2022-02-21 07:01:40
5761	Tâche nouvellement créee du nom de Dans la fiche facture > Ajouter un avoir, l'option date d'extourne doit être la date du jour et non la date de la pièce comptable par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:10:24	2022-02-21 07:10:24
6090	Tâche "Modèle d'impression BON DE TRANSFERT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-22 09:39:44	2022-02-22 09:39:44
6091	Tâche "Modèle d'impression BON DE TRANSFERT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-22 09:39:44	2022-02-22 09:39:44
6092	Tâche "Modèle d'impression BON DE TRANSFERT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	70	2022-02-22 09:39:44	2022-02-22 09:39:44
6093	Tâche "Modèle d'impression BON DE TRANSFERT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-22 09:39:44	2022-02-22 09:39:44
6094	Tâche "Modèle d'impression BON DE TRANSFERT"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-22 09:39:44	2022-02-22 09:39:44
5663	Tâche nouvellement créee du nom de Renommer "Montant TVA" en "Montant TVA sur fees" dans le document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 06:55:58	2022-02-21 06:55:58
5664	Tâche nouvellement créee du nom de Renommer "Montant TVA" en "Montant TVA sur fees" dans le document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 06:55:58	2022-02-21 06:55:58
5666	Tâche nouvellement créee du nom de Renommer "Montant TVA" en "Montant TVA sur fees" dans le document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 06:55:58	2022-02-21 06:55:58
5667	Tâche nouvellement créee du nom de Renommer "Montant TVA" en "Montant TVA sur fees" dans le document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 06:55:58	2022-02-21 06:55:58
5765	Tâche nouvellement créee du nom de Dans la fiche facture > Ajouter un avoir, le motif doit être obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:10:57	2022-02-21 07:10:57
5766	Tâche nouvellement créee du nom de Dans la fiche facture > Ajouter un avoir, le motif doit être obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:10:57	2022-02-21 07:10:57
5768	Tâche nouvellement créee du nom de Dans la fiche facture > Ajouter un avoir, le motif doit être obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:10:57	2022-02-21 07:10:57
5769	Tâche nouvellement créee du nom de Dans la fiche facture > Ajouter un avoir, le motif doit être obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:10:57	2022-02-21 07:10:57
5665	Tâche nouvellement créee du nom de Renommer "Montant TVA" en "Montant TVA sur fees" dans le document travel order par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 06:55:58	2022-02-21 06:55:58
5767	Tâche nouvellement créee du nom de Dans la fiche facture > Ajouter un avoir, le motif doit être obligatoire par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:10:57	2022-02-21 07:10:57
6105	Tâche nouvellement créee du nom de Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-22 09:41:36	2022-02-22 09:41:36
6106	Tâche nouvellement créee du nom de Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-22 09:41:36	2022-02-22 09:41:36
6107	Tâche nouvellement créee du nom de Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-02-22 09:41:36	2022-02-22 09:41:36
6108	Tâche nouvellement créee du nom de Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-22 09:41:36	2022-02-22 09:41:36
6109	Tâche nouvellement créee du nom de Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-22 09:41:36	2022-02-22 09:41:36
6117	Tâche "Intégration de stock du PO26496 dépôt 3"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-22 09:49:50	2022-02-22 09:49:50
6118	Tâche "Intégration de stock du PO26496 dépôt 3"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-22 09:49:50	2022-02-22 09:49:50
6119	Tâche "Intégration de stock du PO26496 dépôt 3"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	70	2022-02-22 09:49:50	2022-02-22 09:49:50
6120	Tâche "Intégration de stock du PO26496 dépôt 3"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-22 09:49:50	2022-02-22 09:49:50
6121	Tâche "Intégration de stock du PO26496 dépôt 3"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-22 09:49:50	2022-02-22 09:49:50
6179	Tâche "Correction erreurs sur le module Fabrication"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	53	2022-02-22 11:19:39	2022-02-22 11:19:39
6180	Tâche "Correction erreurs sur le module Fabrication"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	57	2022-02-22 11:19:39	2022-02-22 11:19:39
6181	Tâche "Correction erreurs sur le module Fabrication"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	71	2022-02-22 11:19:39	2022-02-22 11:19:39
6182	Tâche "Correction erreurs sur le module Fabrication"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Mihaja	f	70	85	2022-02-22 11:19:39	2022-02-22 11:19:39
6203	Tâche nouvellement créee du nom de Intégration de stock du PO26335 et PO26713 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-22 11:37:35	2022-02-22 11:37:35
6204	Tâche nouvellement créee du nom de Intégration de stock du PO26335 et PO26713 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-22 11:37:35	2022-02-22 11:37:35
6206	Tâche nouvellement créee du nom de Intégration de stock du PO26335 et PO26713 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-22 11:37:35	2022-02-22 11:37:35
6207	Tâche nouvellement créee du nom de Intégration de stock du PO26335 et PO26713 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-22 11:37:35	2022-02-22 11:37:35
6214	Tâche "Programme de transfert des backup clients sur FTP"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-22 11:38:54	2022-02-22 11:38:54
6215	Tâche "Programme de transfert des backup clients sur FTP"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-22 11:38:54	2022-02-22 11:38:54
6216	Tâche "Programme de transfert des backup clients sur FTP"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-22 11:38:54	2022-02-22 11:38:54
6217	Tâche "Programme de transfert des backup clients sur FTP"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-22 11:38:54	2022-02-22 11:38:54
6205	Tâche nouvellement créee du nom de Intégration de stock du PO26335 et PO26713 par Elie dans le projet QLM Intervention / Accompagnement 2022.	t	77	70	2022-02-22 11:37:35	2022-02-22 11:37:35
6279	La tâche Préparation un fichier d'inventaire COMPUTEK a été achevée.	f	76	53	2022-02-22 12:37:27	2022-02-22 12:37:27
5668	Rémi vous a assigné à la tâche Renommer "Montant TVA" en "Montant TVA sur fees" dans le document travel order dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 06:55:58	2022-02-21 06:55:58
5687	Tâche nouvellement créee du nom de Renommer "Remboursement intégral" en "Avoir intégral" dans document facture > ajouter un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 06:58:48	2022-02-21 06:58:48
5688	Tâche nouvellement créee du nom de Renommer "Remboursement intégral" en "Avoir intégral" dans document facture > ajouter un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 06:58:48	2022-02-21 06:58:48
5690	Tâche nouvellement créee du nom de Renommer "Remboursement intégral" en "Avoir intégral" dans document facture > ajouter un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 06:58:48	2022-02-21 06:58:48
5691	Tâche nouvellement créee du nom de Renommer "Remboursement intégral" en "Avoir intégral" dans document facture > ajouter un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 06:58:48	2022-02-21 06:58:48
5692	Rémi vous a assigné à la tâche Renommer "Remboursement intégral" en "Avoir intégral" dans document facture > ajouter un avoir dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 06:58:48	2022-02-21 06:58:48
5728	Rémi vous a assigné à la tâche Dans la fiche facture, masquer le bouton "Remettre en brouillon" dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:04:41	2022-02-21 07:04:41
5689	Tâche nouvellement créee du nom de Renommer "Remboursement intégral" en "Avoir intégral" dans document facture > ajouter un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 06:58:48	2022-02-21 06:58:48
6110	Miandrisoa vous a assigné à la tâche Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-22 09:41:36	2022-02-22 09:41:36
6169	Rémi vous a assigné à la tâche Mettre à jour import article depuis hfsql dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-22 10:58:05	2022-02-22 10:58:05
6187	Tâche nouvellement créee du nom de Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-22 11:32:56	2022-02-22 11:32:56
6188	Tâche nouvellement créee du nom de Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-22 11:32:56	2022-02-22 11:32:56
6189	Tâche nouvellement créee du nom de Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-02-22 11:32:56	2022-02-22 11:32:56
6190	Tâche nouvellement créee du nom de Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-22 11:32:56	2022-02-22 11:32:56
6191	Tâche nouvellement créee du nom de Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-22 11:32:56	2022-02-22 11:32:56
6355	Tâche "Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-23 05:50:48	2022-02-23 05:50:48
6356	Tâche "Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-23 05:50:48	2022-02-23 05:50:48
6357	Tâche "Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	70	2022-02-23 05:50:48	2022-02-23 05:50:48
6358	Tâche "Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-23 05:50:48	2022-02-23 05:50:48
6359	Tâche "Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-23 05:50:48	2022-02-23 05:50:48
6192	Elie vous a assigné à la tâche Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM dans le projet QLM Intervention / Accompagnement 2022.	t	77	77	2022-02-22 11:32:56	2022-02-22 11:32:56
6497	Tâche nouvellement créee du nom de Déblocage d'un problème de connexion à la base par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-24 12:42:50	2022-02-24 12:42:50
6499	Tâche nouvellement créee du nom de Déblocage d'un problème de connexion à la base par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-24 12:42:50	2022-02-24 12:42:50
6500	Tâche nouvellement créee du nom de Déblocage d'un problème de connexion à la base par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-24 12:42:50	2022-02-24 12:42:50
6524	Tâche "Suppression des doublons des clients"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-02-24 12:45:50	2022-02-24 12:45:50
6525	Tâche "Suppression des doublons des clients"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-02-24 12:45:50	2022-02-24 12:45:50
6527	Tâche "Suppression des doublons des clients"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-02-24 12:45:50	2022-02-24 12:45:50
6715	La tâche Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci a été achevée.	f	78	53	2022-02-25 09:19:01	2022-02-25 09:19:01
6716	La tâche Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci a été achevée.	f	78	57	2022-02-25 09:19:01	2022-02-25 09:19:01
7551	La tâche Ajustement de stock ATG0601 et PEG60*18 pour validation BL a été achevée.	f	77	85	2022-03-03 10:16:20	2022-03-03 10:16:20
7577	Tâche nouvellement créee du nom de Validation des BL CHM/BL/21377, CHM/BL/21326,CHM/BL/19980,CHM/BL/21179,CHM/BL/19542,CHM/BL/16176 (démande de Mme Jeanne) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-03 13:10:42	2022-03-03 13:10:42
7578	Tâche nouvellement créee du nom de Validation des BL CHM/BL/21377, CHM/BL/21326,CHM/BL/19980,CHM/BL/21179,CHM/BL/19542,CHM/BL/16176 (démande de Mme Jeanne) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-03 13:10:42	2022-03-03 13:10:42
5704	Rémi vous a assigné à la tâche Ajouter dans le document d'achat le numéro du vol et les dates (dates de départ et d'arrivée) dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:00:22	2022-02-21 07:00:22
5771	Tâche nouvellement créee du nom de Erreur lors de la confirmation d'un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:11:28	2022-02-21 07:11:28
5772	Tâche nouvellement créee du nom de Erreur lors de la confirmation d'un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:11:28	2022-02-21 07:11:28
5774	Tâche nouvellement créee du nom de Erreur lors de la confirmation d'un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:11:28	2022-02-21 07:11:28
5775	Tâche nouvellement créee du nom de Erreur lors de la confirmation d'un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:11:28	2022-02-21 07:11:28
5773	Tâche nouvellement créee du nom de Erreur lors de la confirmation d'un avoir par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:11:28	2022-02-21 07:11:28
6111	Tâche nouvellement créee du nom de Intégration de stock du PO26496 dépôt 3 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-22 09:49:42	2022-02-22 09:49:42
6112	Tâche nouvellement créee du nom de Intégration de stock du PO26496 dépôt 3 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-22 09:49:42	2022-02-22 09:49:42
6113	Tâche nouvellement créee du nom de Intégration de stock du PO26496 dépôt 3 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-02-22 09:49:42	2022-02-22 09:49:42
6114	Tâche nouvellement créee du nom de Intégration de stock du PO26496 dépôt 3 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-22 09:49:42	2022-02-22 09:49:42
6115	Tâche nouvellement créee du nom de Intégration de stock du PO26496 dépôt 3 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-22 09:49:42	2022-02-22 09:49:42
6122	La tâche Rapprochement bancaire mai-juin BMOI Chainmalt a été achevée.	f	79	53	2022-02-22 10:29:04	2022-02-22 10:29:04
6123	La tâche Rapprochement bancaire mai-juin BMOI Chainmalt a été achevée.	f	79	57	2022-02-22 10:29:04	2022-02-22 10:29:04
6124	La tâche Rapprochement bancaire mai-juin BMOI Chainmalt a été achevée.	f	79	70	2022-02-22 10:29:04	2022-02-22 10:29:04
6125	La tâche Rapprochement bancaire mai-juin BMOI Chainmalt a été achevée.	f	79	71	2022-02-22 10:29:04	2022-02-22 10:29:04
6126	La tâche Rapprochement bancaire mai-juin BMOI Chainmalt a été achevée.	f	79	85	2022-02-22 10:29:04	2022-02-22 10:29:04
6149	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-22 10:50:44	2022-02-22 10:50:44
6150	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-22 10:50:44	2022-02-22 10:50:44
6152	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-22 10:50:44	2022-02-22 10:50:44
6153	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-22 10:50:44	2022-02-22 10:50:44
6151	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-22 10:50:44	2022-02-22 10:50:44
6264	La tâche Intégration de stock du PO26335 et PO26713 a été achevée.	f	77	53	2022-02-22 12:36:25	2022-02-22 12:36:25
6265	La tâche Intégration de stock du PO26335 et PO26713 a été achevée.	f	77	57	2022-02-22 12:36:25	2022-02-22 12:36:25
6266	La tâche Intégration de stock du PO26335 et PO26713 a été achevée.	f	77	70	2022-02-22 12:36:25	2022-02-22 12:36:25
6267	La tâche Intégration de stock du PO26335 et PO26713 a été achevée.	f	77	71	2022-02-22 12:36:25	2022-02-22 12:36:25
6268	La tâche Intégration de stock du PO26335 et PO26713 a été achevée.	f	77	85	2022-02-22 12:36:25	2022-02-22 12:36:25
6284	La tâche Préparation fichier d'inventaire a été achevée.	f	76	53	2022-02-22 12:37:34	2022-02-22 12:37:34
6285	La tâche Préparation fichier d'inventaire a été achevée.	f	76	57	2022-02-22 12:37:34	2022-02-22 12:37:34
6286	La tâche Préparation fichier d'inventaire a été achevée.	f	76	70	2022-02-22 12:37:34	2022-02-22 12:37:34
6287	La tâche Préparation fichier d'inventaire a été achevée.	f	76	71	2022-02-22 12:37:34	2022-02-22 12:37:34
6288	La tâche Préparation fichier d'inventaire a été achevée.	f	76	85	2022-02-22 12:37:34	2022-02-22 12:37:34
6528	Tâche "Suppression des doublons des clients"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-02-24 12:45:50	2022-02-24 12:45:50
6575	Tâche "Intégration d'inventaire pour Computek Tamatave"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-02-25 06:05:34	2022-02-25 06:05:34
6576	Tâche "Intégration d'inventaire pour Computek Tamatave"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-02-25 06:05:34	2022-02-25 06:05:34
6578	Tâche "Intégration d'inventaire pour Computek Tamatave"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-02-25 06:05:34	2022-02-25 06:05:34
6579	Tâche "Intégration d'inventaire pour Computek Tamatave"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-02-25 06:05:34	2022-02-25 06:05:34
6626	Tâche "Déplacer la colonne fournisseur avant la colonne articles"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	53	2022-02-25 07:17:18	2022-02-25 07:17:18
6627	Tâche "Déplacer la colonne fournisseur avant la colonne articles"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	57	2022-02-25 07:17:18	2022-02-25 07:17:18
6629	Tâche "Déplacer la colonne fournisseur avant la colonne articles"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	71	2022-02-25 07:17:18	2022-02-25 07:17:18
5751	Tâche nouvellement créee du nom de Afficher les autres taxes dans l'impression facture par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:08:07	2022-02-21 07:08:07
6116	Elie vous a assigné à la tâche Intégration de stock du PO26496 dépôt 3 dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-02-22 09:49:42	2022-02-22 09:49:42
6166	Tâche nouvellement créee du nom de Mettre à jour import article depuis hfsql par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-22 10:58:05	2022-02-22 10:58:05
6218	Tâche "Installation du nouveau programme sauvegarde sur les serveurs clients"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-22 11:39:23	2022-02-22 11:39:23
6219	Tâche "Installation du nouveau programme sauvegarde sur les serveurs clients"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-22 11:39:23	2022-02-22 11:39:23
6220	Tâche "Installation du nouveau programme sauvegarde sur les serveurs clients"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-22 11:39:23	2022-02-22 11:39:23
6221	Tâche "Installation du nouveau programme sauvegarde sur les serveurs clients"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-22 11:39:23	2022-02-22 11:39:23
6339	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	53	2022-02-22 13:47:58	2022-02-22 13:47:58
6340	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	57	2022-02-22 13:47:58	2022-02-22 13:47:58
6341	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	70	2022-02-22 13:47:58	2022-02-22 13:47:58
6342	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	71	2022-02-22 13:47:58	2022-02-22 13:47:58
6343	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Rémi	f	78	85	2022-02-22 13:47:58	2022-02-22 13:47:58
6532	Tâche nouvellement créee du nom de Listes des articles déjà bloqués par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-24 12:51:34	2022-02-24 12:51:34
6533	Tâche nouvellement créee du nom de Listes des articles déjà bloqués par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-24 12:51:34	2022-02-24 12:51:34
6563	Elie vous a assigné à la tâche Intégration des Stocks dépôt 2 PO24141 et autres articles (carreaux) dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-02-24 14:00:50	2022-02-24 14:00:50
6569	Tâche nouvellement créee du nom de Intégration d'inventaire pour Computek Tamatave par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-25 06:05:24	2022-02-25 06:05:24
6570	Tâche nouvellement créee du nom de Intégration d'inventaire pour Computek Tamatave par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-25 06:05:24	2022-02-25 06:05:24
6572	Tâche nouvellement créee du nom de Intégration d'inventaire pour Computek Tamatave par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-25 06:05:24	2022-02-25 06:05:24
6573	Tâche nouvellement créee du nom de Intégration d'inventaire pour Computek Tamatave par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-25 06:05:24	2022-02-25 06:05:24
6585	Rémi vous a assigné à la tâche Créer un manuel d'utilisation pour l'application dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:11:20	2022-02-25 07:11:20
6597	Rémi vous a assigné à la tâche Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:13:42	2022-02-25 07:13:42
6598	Tâche "Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	53	2022-02-25 07:13:53	2022-02-25 07:13:53
6599	Tâche "Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	57	2022-02-25 07:13:53	2022-02-25 07:13:53
6601	Tâche "Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	71	2022-02-25 07:13:53	2022-02-25 07:13:53
6602	Tâche "Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	85	2022-02-25 07:13:53	2022-02-25 07:13:53
6631	Tâche nouvellement créee du nom de Filtrer les articles selon le fournisseur selectionné par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:19:56	2022-02-25 07:19:56
6632	Tâche nouvellement créee du nom de Filtrer les articles selon le fournisseur selectionné par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:19:56	2022-02-25 07:19:56
6634	Tâche nouvellement créee du nom de Filtrer les articles selon le fournisseur selectionné par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:19:56	2022-02-25 07:19:56
6635	Tâche nouvellement créee du nom de Filtrer les articles selon le fournisseur selectionné par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:19:56	2022-02-25 07:19:56
5754	Tâche nouvellement créee du nom de Dans impression facture, mettre les fournisseurs au niveau de la ligne par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:08:43	2022-02-21 07:08:43
5756	Tâche nouvellement créee du nom de Dans impression facture, mettre les fournisseurs au niveau de la ligne par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:08:43	2022-02-21 07:08:43
5757	Tâche nouvellement créee du nom de Dans impression facture, mettre les fournisseurs au niveau de la ligne par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:08:43	2022-02-21 07:08:43
5770	Rémi vous a assigné à la tâche Dans la fiche facture > Ajouter un avoir, le motif doit être obligatoire dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:10:57	2022-02-21 07:10:57
5755	Tâche nouvellement créee du nom de Dans impression facture, mettre les fournisseurs au niveau de la ligne par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:08:43	2022-02-21 07:08:43
6127	La tâche Finir le rapprochement bancaire pour une banque a été achevée.	f	79	53	2022-02-22 10:29:19	2022-02-22 10:29:19
6128	La tâche Finir le rapprochement bancaire pour une banque a été achevée.	f	79	57	2022-02-22 10:29:19	2022-02-22 10:29:19
6129	La tâche Finir le rapprochement bancaire pour une banque a été achevée.	f	79	70	2022-02-22 10:29:19	2022-02-22 10:29:19
6130	La tâche Finir le rapprochement bancaire pour une banque a été achevée.	f	79	71	2022-02-22 10:29:19	2022-02-22 10:29:19
6131	La tâche Finir le rapprochement bancaire pour une banque a été achevée.	f	79	85	2022-02-22 10:29:19	2022-02-22 10:29:19
6138	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	53	2022-02-22 10:30:27	2022-02-22 10:30:27
6139	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	57	2022-02-22 10:30:27	2022-02-22 10:30:27
6140	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	70	2022-02-22 10:30:27	2022-02-22 10:30:27
6141	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	71	2022-02-22 10:30:27	2022-02-22 10:30:27
6142	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Haro	f	79	85	2022-02-22 10:30:27	2022-02-22 10:30:27
6170	Tâche "Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-22 11:18:42	2022-02-22 11:18:42
6171	Tâche "Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-22 11:18:42	2022-02-22 11:18:42
6172	Tâche "Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-22 11:18:42	2022-02-22 11:18:42
6173	Tâche "Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-22 11:18:42	2022-02-22 11:18:42
6259	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	53	2022-02-22 12:34:40	2022-02-22 12:34:40
6260	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	57	2022-02-22 12:34:40	2022-02-22 12:34:40
6261	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	70	2022-02-22 12:34:40	2022-02-22 12:34:40
6262	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	71	2022-02-22 12:34:40	2022-02-22 12:34:40
6263	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	85	2022-02-22 12:34:40	2022-02-22 12:34:40
6299	La tâche Assistance pour les articles stock négatif a été achevée.	f	76	53	2022-02-22 12:38:20	2022-02-22 12:38:20
6300	La tâche Assistance pour les articles stock négatif a été achevée.	f	76	57	2022-02-22 12:38:20	2022-02-22 12:38:20
6301	La tâche Assistance pour les articles stock négatif a été achevée.	f	76	70	2022-02-22 12:38:20	2022-02-22 12:38:20
6302	La tâche Assistance pour les articles stock négatif a été achevée.	f	76	71	2022-02-22 12:38:20	2022-02-22 12:38:20
6303	La tâche Assistance pour les articles stock négatif a été achevée.	f	76	85	2022-02-22 12:38:20	2022-02-22 12:38:20
6309	La tâche Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM a été achevée.	f	77	53	2022-02-22 13:10:20	2022-02-22 13:10:20
6310	La tâche Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM a été achevée.	f	77	57	2022-02-22 13:10:20	2022-02-22 13:10:20
6311	La tâche Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM a été achevée.	f	77	70	2022-02-22 13:10:20	2022-02-22 13:10:20
6312	La tâche Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM a été achevée.	f	77	71	2022-02-22 13:10:20	2022-02-22 13:10:20
6313	La tâche Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM a été achevée.	f	77	85	2022-02-22 13:10:20	2022-02-22 13:10:20
6350	Tâche "Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	53	2022-02-23 05:50:38	2022-02-23 05:50:38
6351	Tâche "Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En blocage " par Miandrisoa	f	76	57	2022-02-23 05:50:38	2022-02-23 05:50:38
6137	Haro vous a assigné à la tâche Rapprochement bancaire juiller-aôut BMOI Chainmalt dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	79	79	2022-02-22 10:30:16	2022-02-22 10:30:16
7680	La tâche Intégration inventaire RFI du 03/03/2022 a été achevée.	f	77	70	2022-03-04 11:32:08	2022-03-04 11:32:08
7681	La tâche Intégration inventaire RFI du 03/03/2022 a été achevée.	f	77	71	2022-03-04 11:32:08	2022-03-04 11:32:08
5777	Tâche nouvellement créee du nom de Automatiser la création d'un avoir fournisseur lors de la création d'un avoir client ou vice versa par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-21 07:12:16	2022-02-21 07:12:16
5778	Tâche nouvellement créee du nom de Automatiser la création d'un avoir fournisseur lors de la création d'un avoir client ou vice versa par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-21 07:12:16	2022-02-21 07:12:16
5780	Tâche nouvellement créee du nom de Automatiser la création d'un avoir fournisseur lors de la création d'un avoir client ou vice versa par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-21 07:12:16	2022-02-21 07:12:16
5781	Tâche nouvellement créee du nom de Automatiser la création d'un avoir fournisseur lors de la création d'un avoir client ou vice versa par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-21 07:12:16	2022-02-21 07:12:16
5779	Tâche nouvellement créee du nom de Automatiser la création d'un avoir fournisseur lors de la création d'un avoir client ou vice versa par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-21 07:12:16	2022-02-21 07:12:16
6132	Tâche nouvellement créee du nom de Rapprochement bancaire juiller-aôut BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	53	2022-02-22 10:30:16	2022-02-22 10:30:16
6133	Tâche nouvellement créee du nom de Rapprochement bancaire juiller-aôut BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	57	2022-02-22 10:30:16	2022-02-22 10:30:16
6134	Tâche nouvellement créee du nom de Rapprochement bancaire juiller-aôut BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	70	2022-02-22 10:30:16	2022-02-22 10:30:16
6135	Tâche nouvellement créee du nom de Rapprochement bancaire juiller-aôut BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	71	2022-02-22 10:30:16	2022-02-22 10:30:16
6136	Tâche nouvellement créee du nom de Rapprochement bancaire juiller-aôut BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	85	2022-02-22 10:30:16	2022-02-22 10:30:16
6193	Tâche "Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-22 11:33:02	2022-02-22 11:33:02
6194	Tâche "Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-22 11:33:02	2022-02-22 11:33:02
6196	Tâche "Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-22 11:33:02	2022-02-22 11:33:02
6197	Tâche "Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-22 11:33:02	2022-02-22 11:33:02
6226	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-22 11:45:37	2022-02-22 11:45:37
6227	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-22 11:45:37	2022-02-22 11:45:37
6228	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-22 11:45:37	2022-02-22 11:45:37
6229	Tâche "Récupération de la tva sur Odoo de l'article pour le site"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-22 11:45:37	2022-02-22 11:45:37
6195	Tâche "Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-22 11:33:02	2022-02-22 11:33:02
6230	Tâche "Intégration de stock du PO26335 et PO26713"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-22 11:56:47	2022-02-22 11:56:47
6231	Tâche "Intégration de stock du PO26335 et PO26713"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-22 11:56:47	2022-02-22 11:56:47
6232	Tâche "Intégration de stock du PO26335 et PO26713"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	70	2022-02-22 11:56:47	2022-02-22 11:56:47
6233	Tâche "Intégration de stock du PO26335 et PO26713"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-22 11:56:47	2022-02-22 11:56:47
6234	Tâche "Intégration de stock du PO26335 et PO26713"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-22 11:56:47	2022-02-22 11:56:47
6269	La tâche Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement. a été achevée.	f	76	53	2022-02-22 12:37:15	2022-02-22 12:37:15
6270	La tâche Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement. a été achevée.	f	76	57	2022-02-22 12:37:15	2022-02-22 12:37:15
6271	La tâche Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement. a été achevée.	f	76	70	2022-02-22 12:37:15	2022-02-22 12:37:15
6272	La tâche Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement. a été achevée.	f	76	71	2022-02-22 12:37:15	2022-02-22 12:37:15
6273	La tâche Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement. a été achevée.	f	76	85	2022-02-22 12:37:15	2022-02-22 12:37:15
6304	La tâche Intégration de stock du PO24141 et PO26463 a été achevée.	f	77	53	2022-02-22 13:10:10	2022-02-22 13:10:10
6305	La tâche Intégration de stock du PO24141 et PO26463 a été achevée.	f	77	57	2022-02-22 13:10:10	2022-02-22 13:10:10
6306	La tâche Intégration de stock du PO24141 et PO26463 a été achevée.	f	77	70	2022-02-22 13:10:10	2022-02-22 13:10:10
6307	La tâche Intégration de stock du PO24141 et PO26463 a été achevée.	f	77	71	2022-02-22 13:10:10	2022-02-22 13:10:10
6308	La tâche Intégration de stock du PO24141 et PO26463 a été achevée.	f	77	85	2022-02-22 13:10:10	2022-02-22 13:10:10
6344	Tâche nouvellement créee du nom de Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-23 05:50:20	2022-02-23 05:50:20
6345	Tâche nouvellement créee du nom de Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-23 05:50:20	2022-02-23 05:50:20
3939	Mihaja vous a assigné à la tâche Lecture des données XML  dans le projet SIGM - Application inter Amadeus et Odoo.	t	70	73	2022-02-03 07:27:55	2022-02-03 07:27:55
5782	Rémi vous a assigné à la tâche Automatiser la création d'un avoir fournisseur lors de la création d'un avoir client ou vice versa dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-21 07:12:16	2022-02-21 07:12:16
5790	Tâche "Assistance pour les articles stock négatif"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-02-21 07:36:18	2022-02-21 07:36:18
5791	Tâche "Assistance pour les articles stock négatif"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-02-21 07:36:18	2022-02-21 07:36:18
5793	Tâche "Assistance pour les articles stock négatif"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-02-21 07:36:18	2022-02-21 07:36:18
5794	Tâche "Assistance pour les articles stock négatif"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-02-21 07:36:18	2022-02-21 07:36:18
5792	Tâche "Assistance pour les articles stock négatif"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	t	76	70	2022-02-21 07:36:18	2022-02-21 07:36:18
6143	Tâche nouvellement créee du nom de Intégration de stock du PO24141 et PO26463 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-22 10:50:32	2022-02-22 10:50:32
6144	Tâche nouvellement créee du nom de Intégration de stock du PO24141 et PO26463 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-22 10:50:32	2022-02-22 10:50:32
6145	Tâche nouvellement créee du nom de Intégration de stock du PO24141 et PO26463 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-02-22 10:50:32	2022-02-22 10:50:32
6146	Tâche nouvellement créee du nom de Intégration de stock du PO24141 et PO26463 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-22 10:50:32	2022-02-22 10:50:32
6147	Tâche nouvellement créee du nom de Intégration de stock du PO24141 et PO26463 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-22 10:50:32	2022-02-22 10:50:32
6154	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " A faire " par Elie	f	77	53	2022-02-22 10:50:52	2022-02-22 10:50:52
6155	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " A faire " par Elie	f	77	57	2022-02-22 10:50:52	2022-02-22 10:50:52
6157	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " A faire " par Elie	f	77	71	2022-02-22 10:50:52	2022-02-22 10:50:52
6158	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " A faire " par Elie	f	77	85	2022-02-22 10:50:52	2022-02-22 10:50:52
6174	Tâche nouvellement créee du nom de Correction erreurs sur le module Fabrication par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	53	2022-02-22 11:19:33	2022-02-22 11:19:33
6175	Tâche nouvellement créee du nom de Correction erreurs sur le module Fabrication par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	57	2022-02-22 11:19:33	2022-02-22 11:19:33
6176	Tâche nouvellement créee du nom de Correction erreurs sur le module Fabrication par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	71	2022-02-22 11:19:33	2022-02-22 11:19:33
6177	Tâche nouvellement créee du nom de Correction erreurs sur le module Fabrication par Mihaja dans le projet QLM Intervention / Accompagnement 2022.	f	70	85	2022-02-22 11:19:33	2022-02-22 11:19:33
6156	Tâche "Intégration de stock du PO24141 et PO26463"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " A faire " par Elie	t	77	70	2022-02-22 10:50:52	2022-02-22 10:50:52
6209	Tâche "Intégration de stock du PO26335 et PO26713"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-22 11:37:38	2022-02-22 11:37:38
6210	Tâche "Intégration de stock du PO26335 et PO26713"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-22 11:37:38	2022-02-22 11:37:38
6212	Tâche "Intégration de stock du PO26335 et PO26713"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-22 11:37:38	2022-02-22 11:37:38
6213	Tâche "Intégration de stock du PO26335 et PO26713"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-22 11:37:38	2022-02-22 11:37:38
6222	Tâche Récupération de la tva sur Odoo de l'article pour le site archivée par Mihaja.	f	70	53	2022-02-22 11:44:37	2022-02-22 11:44:37
6223	Tâche Récupération de la tva sur Odoo de l'article pour le site archivée par Mihaja.	f	70	57	2022-02-22 11:44:37	2022-02-22 11:44:37
3936	Tâche nouvellement créee du nom de Lecture des données XML  par Mihaja dans le projet SIGM - Application inter Amadeus et Odoo.	f	70	53	2022-02-03 07:27:55	2022-02-03 07:27:55
3937	Tâche nouvellement créee du nom de Lecture des données XML  par Mihaja dans le projet SIGM - Application inter Amadeus et Odoo.	f	70	57	2022-02-03 07:27:55	2022-02-03 07:27:55
3938	Tâche nouvellement créee du nom de Lecture des données XML  par Mihaja dans le projet SIGM - Application inter Amadeus et Odoo.	f	70	71	2022-02-03 07:27:55	2022-02-03 07:27:55
6224	Tâche Récupération de la tva sur Odoo de l'article pour le site archivée par Mihaja.	f	70	71	2022-02-22 11:44:37	2022-02-22 11:44:37
6225	Tâche Récupération de la tva sur Odoo de l'article pour le site archivée par Mihaja.	f	70	85	2022-02-22 11:44:37	2022-02-22 11:44:37
6211	Tâche "Intégration de stock du PO26335 et PO26713"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-22 11:37:38	2022-02-22 11:37:38
6249	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	53	2022-02-22 12:32:59	2022-02-22 12:32:59
6250	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	57	2022-02-22 12:32:59	2022-02-22 12:32:59
6251	Tâche "Rapprochement bancaire juiller-aôut BMOI Chainmalt"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	70	2022-02-22 12:32:59	2022-02-22 12:32:59
6665	Tâche nouvellement créee du nom de Ajouter une colonne pour la référence facture fournisseur à côté de la colonne fournisseur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:24:32	2022-02-25 07:24:32
6666	Tâche nouvellement créee du nom de Ajouter une colonne pour la référence facture fournisseur à côté de la colonne fournisseur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:24:32	2022-02-25 07:24:32
6668	Tâche nouvellement créee du nom de Ajouter une colonne pour la référence facture fournisseur à côté de la colonne fournisseur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:24:32	2022-02-25 07:24:32
6669	Tâche nouvellement créee du nom de Ajouter une colonne pour la référence facture fournisseur à côté de la colonne fournisseur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:24:32	2022-02-25 07:24:32
6670	Rémi vous a assigné à la tâche Ajouter une colonne pour la référence facture fournisseur à côté de la colonne fournisseur dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:24:32	2022-02-25 07:24:32
6671	Tâche nouvellement créee du nom de Relier la colonne référence fournisseur avec le champ référence fournisseur dans doc achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:25:48	2022-02-25 07:25:48
6672	Tâche nouvellement créee du nom de Relier la colonne référence fournisseur avec le champ référence fournisseur dans doc achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:25:48	2022-02-25 07:25:48
6674	Tâche nouvellement créee du nom de Relier la colonne référence fournisseur avec le champ référence fournisseur dans doc achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:25:48	2022-02-25 07:25:48
6675	Tâche nouvellement créee du nom de Relier la colonne référence fournisseur avec le champ référence fournisseur dans doc achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:25:48	2022-02-25 07:25:48
6676	Rémi vous a assigné à la tâche Relier la colonne référence fournisseur avec le champ référence fournisseur dans doc achat dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:25:48	2022-02-25 07:25:48
6677	Tâche nouvellement créee du nom de Baser toutes les politiques de facturations sur les quantités commandées par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:27:36	2022-02-25 07:27:36
6678	Tâche nouvellement créee du nom de Baser toutes les politiques de facturations sur les quantités commandées par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:27:36	2022-02-25 07:27:36
6680	Tâche nouvellement créee du nom de Baser toutes les politiques de facturations sur les quantités commandées par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:27:36	2022-02-25 07:27:36
6681	Tâche nouvellement créee du nom de Baser toutes les politiques de facturations sur les quantités commandées par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:27:36	2022-02-25 07:27:36
6682	Rémi vous a assigné à la tâche Baser toutes les politiques de facturations sur les quantités commandées dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:27:36	2022-02-25 07:27:36
6683	Tâche nouvellement créee du nom de Créer un champas pour la référence fournisseur dans doc facture et afficher sa valeur dans l'impression par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 07:32:31	2022-02-25 07:32:31
6684	Tâche nouvellement créee du nom de Créer un champas pour la référence fournisseur dans doc facture et afficher sa valeur dans l'impression par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 07:32:31	2022-02-25 07:32:31
6686	Tâche nouvellement créee du nom de Créer un champas pour la référence fournisseur dans doc facture et afficher sa valeur dans l'impression par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 07:32:31	2022-02-25 07:32:31
6687	Tâche nouvellement créee du nom de Créer un champas pour la référence fournisseur dans doc facture et afficher sa valeur dans l'impression par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 07:32:31	2022-02-25 07:32:31
6688	Rémi vous a assigné à la tâche Créer un champas pour la référence fournisseur dans doc facture et afficher sa valeur dans l'impression dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 07:32:31	2022-02-25 07:32:31
6699	Tâche nouvellement créee du nom de Mise en place server FTP par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-02-25 07:54:25	2022-02-25 07:54:25
6700	Tâche nouvellement créee du nom de Mise en place server FTP par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-02-25 07:54:25	2022-02-25 07:54:25
6702	Tâche nouvellement créee du nom de Mise en place server FTP par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-02-25 07:54:25	2022-02-25 07:54:25
6703	Tâche nouvellement créee du nom de Mise en place server FTP par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-02-25 07:54:25	2022-02-25 07:54:25
6704	Osé vous a assigné à la tâche Mise en place server FTP dans le projet Sauvegarde FTP des clients .	f	74	74	2022-02-25 07:54:25	2022-02-25 07:54:25
5606	Haro vous a assigné à la tâche Rapprochement bancaire mai-juin BMOI Chainmalt dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	79	79	2022-02-21 06:07:07	2022-02-21 06:07:07
6432	Haro vous a assigné à la tâche Repertorier les ecritures non rapprochées - BMOI Chainmalt dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	79	79	2022-02-24 06:34:50	2022-02-24 06:34:50
6689	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-02-25 07:52:48	2022-02-25 07:52:48
6690	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-02-25 07:52:48	2022-02-25 07:52:48
6692	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-02-25 07:52:48	2022-02-25 07:52:48
6693	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-02-25 07:52:48	2022-02-25 07:52:48
6691	Tâche "Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes."\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	t	74	70	2022-02-25 07:52:48	2022-02-25 07:52:48
6710	Tâche "Correction erreurs sur le module Fabrication"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	53	2022-02-25 09:17:14	2022-02-25 09:17:14
6711	Tâche "Correction erreurs sur le module Fabrication"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	57	2022-02-25 09:17:14	2022-02-25 09:17:14
6713	Tâche "Correction erreurs sur le module Fabrication"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	71	2022-02-25 09:17:14	2022-02-25 09:17:14
6714	Tâche "Correction erreurs sur le module Fabrication"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	f	81	85	2022-02-25 09:17:14	2022-02-25 09:17:14
6720	Tâche nouvellement créee du nom de Relier Travel Order et Account Move par des ids par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-25 09:24:20	2022-02-25 09:24:20
6721	Tâche nouvellement créee du nom de Relier Travel Order et Account Move par des ids par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-25 09:24:20	2022-02-25 09:24:20
6723	Tâche nouvellement créee du nom de Relier Travel Order et Account Move par des ids par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-25 09:24:20	2022-02-25 09:24:20
6724	Tâche nouvellement créee du nom de Relier Travel Order et Account Move par des ids par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-25 09:24:20	2022-02-25 09:24:20
6725	Rémi vous a assigné à la tâche Relier Travel Order et Account Move par des ids dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-25 09:24:20	2022-02-25 09:24:20
6726	La tâche Enlever le champs référence dans doc de type to a été achevée.	f	78	53	2022-02-25 10:06:42	2022-02-25 10:06:42
6727	La tâche Enlever le champs référence dans doc de type to a été achevée.	f	78	57	2022-02-25 10:06:42	2022-02-25 10:06:42
6729	La tâche Enlever le champs référence dans doc de type to a été achevée.	f	78	71	2022-02-25 10:06:42	2022-02-25 10:06:42
6730	La tâche Enlever le champs référence dans doc de type to a été achevée.	f	78	85	2022-02-25 10:06:42	2022-02-25 10:06:42
6731	La tâche Intégration d'inventaire pour Computek Tamatave a été achevée.	f	76	53	2022-02-25 12:30:31	2022-02-25 12:30:31
6732	La tâche Intégration d'inventaire pour Computek Tamatave a été achevée.	f	76	57	2022-02-25 12:30:31	2022-02-25 12:30:31
6734	La tâche Intégration d'inventaire pour Computek Tamatave a été achevée.	f	76	71	2022-02-25 12:30:31	2022-02-25 12:30:31
6735	La tâche Intégration d'inventaire pour Computek Tamatave a été achevée.	f	76	85	2022-02-25 12:30:31	2022-02-25 12:30:31
6736	Tâche nouvellement créee du nom de Intégration stock dépôt 2 du 24/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-25 13:18:52	2022-02-25 13:18:52
6737	Tâche nouvellement créee du nom de Intégration stock dépôt 2 du 24/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-25 13:18:52	2022-02-25 13:18:52
6739	Tâche nouvellement créee du nom de Intégration stock dépôt 2 du 24/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-25 13:18:52	2022-02-25 13:18:52
6740	Tâche nouvellement créee du nom de Intégration stock dépôt 2 du 24/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-25 13:18:52	2022-02-25 13:18:52
6741	Elie vous a assigné à la tâche Intégration stock dépôt 2 du 24/02/2022 dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-02-25 13:18:52	2022-02-25 13:18:52
6742	Tâche "Intégration stock dépôt 2 du 24/02/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-25 13:18:58	2022-02-25 13:18:58
6743	Tâche "Intégration stock dépôt 2 du 24/02/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-25 13:18:58	2022-02-25 13:18:58
6745	Tâche "Intégration stock dépôt 2 du 24/02/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-25 13:18:58	2022-02-25 13:18:58
6746	Tâche "Intégration stock dépôt 2 du 24/02/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-25 13:18:58	2022-02-25 13:18:58
6757	Tâche nouvellement créee du nom de Préparation fichier d'import avoirs MOURTAZA VALIBHAY par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-25 13:20:55	2022-02-25 13:20:55
6758	Tâche nouvellement créee du nom de Préparation fichier d'import avoirs MOURTAZA VALIBHAY par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-25 13:20:55	2022-02-25 13:20:55
6760	Tâche nouvellement créee du nom de Préparation fichier d'import avoirs MOURTAZA VALIBHAY par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-25 13:20:55	2022-02-25 13:20:55
6761	Tâche nouvellement créee du nom de Préparation fichier d'import avoirs MOURTAZA VALIBHAY par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-25 13:20:55	2022-02-25 13:20:55
6763	Tâche "Préparation fichier d'import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	53	2022-02-25 13:21:02	2022-02-25 13:21:02
6764	Tâche "Préparation fichier d'import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	57	2022-02-25 13:21:02	2022-02-25 13:21:02
6773	La tâche Suppression des doublons des clients a été achevée avec toutes ses tâches filles.	f	76	53	2022-02-25 13:28:36	2022-02-25 13:28:36
6755	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	71	2022-02-25 13:19:13	2022-02-25 13:19:13
6756	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	85	2022-02-25 13:19:13	2022-02-25 13:19:13
6762	Elie vous a assigné à la tâche Préparation fichier d'import avoirs MOURTAZA VALIBHAY dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-02-25 13:20:55	2022-02-25 13:20:55
6778	La tâche Suppression des doublons des clients a été achevée.	f	76	53	2022-02-25 13:28:36	2022-02-25 13:28:36
6779	La tâche Suppression des doublons des clients a été achevée.	f	76	57	2022-02-25 13:28:36	2022-02-25 13:28:36
6781	La tâche Suppression des doublons des clients a été achevée.	f	76	71	2022-02-25 13:28:36	2022-02-25 13:28:36
6782	La tâche Suppression des doublons des clients a été achevée.	f	76	85	2022-02-25 13:28:36	2022-02-25 13:28:36
6799	Tâche "Paramétrage sur les fiches Clients"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-02-25 13:29:10	2022-02-25 13:29:10
6800	Tâche "Paramétrage sur les fiches Clients"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-02-25 13:29:10	2022-02-25 13:29:10
6802	Tâche "Paramétrage sur les fiches Clients"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-02-25 13:29:10	2022-02-25 13:29:10
6803	Tâche "Paramétrage sur les fiches Clients"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-02-25 13:29:10	2022-02-25 13:29:10
6814	La tâche Renommer "Nombre" en "Nombre de nuitées" a été achevée.	f	78	53	2022-02-27 15:19:43	2022-02-27 15:19:43
6815	La tâche Renommer "Nombre" en "Nombre de nuitées" a été achevée.	f	78	57	2022-02-27 15:19:43	2022-02-27 15:19:43
6817	La tâche Renommer "Nombre" en "Nombre de nuitées" a été achevée.	f	78	71	2022-02-27 15:19:43	2022-02-27 15:19:43
6818	La tâche Renommer "Nombre" en "Nombre de nuitées" a été achevée.	f	78	85	2022-02-27 15:19:43	2022-02-27 15:19:43
6819	Tâche "Renommer "Quantité" en "Nombre de chambres/personnes""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	53	2022-02-27 15:20:02	2022-02-27 15:20:02
6820	Tâche "Renommer "Quantité" en "Nombre de chambres/personnes""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	57	2022-02-27 15:20:02	2022-02-27 15:20:02
6822	Tâche "Renommer "Quantité" en "Nombre de chambres/personnes""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	71	2022-02-27 15:20:02	2022-02-27 15:20:02
6823	Tâche "Renommer "Quantité" en "Nombre de chambres/personnes""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	85	2022-02-27 15:20:02	2022-02-27 15:20:02
6850	Tâche "Prendre en compte "Nombre" dans le calcul du prix total et du total HT"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	53	2022-02-27 15:51:35	2022-02-27 15:51:35
6851	Tâche "Prendre en compte "Nombre" dans le calcul du prix total et du total HT"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	57	2022-02-27 15:51:35	2022-02-27 15:51:35
6853	Tâche "Prendre en compte "Nombre" dans le calcul du prix total et du total HT"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	71	2022-02-27 15:51:35	2022-02-27 15:51:35
6854	Tâche "Prendre en compte "Nombre" dans le calcul du prix total et du total HT"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	85	2022-02-27 15:51:35	2022-02-27 15:51:35
6861	Tâche nouvellement créee du nom de Déblocage d'un problème de création d'un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-28 07:51:09	2022-02-28 07:51:09
6862	Tâche nouvellement créee du nom de Déblocage d'un problème de création d'un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-28 07:51:09	2022-02-28 07:51:09
6864	Tâche nouvellement créee du nom de Déblocage d'un problème de création d'un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-28 07:51:09	2022-02-28 07:51:09
6865	Tâche nouvellement créee du nom de Déblocage d'un problème de création d'un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-28 07:51:09	2022-02-28 07:51:09
6867	La tâche Déblocage d'un problème de création d'un BL a été achevée.	f	76	53	2022-02-28 07:51:24	2022-02-28 07:51:24
6868	La tâche Déblocage d'un problème de création d'un BL a été achevée.	f	76	57	2022-02-28 07:51:24	2022-02-28 07:51:24
6870	La tâche Déblocage d'un problème de création d'un BL a été achevée.	f	76	71	2022-02-28 07:51:24	2022-02-28 07:51:24
6871	La tâche Déblocage d'un problème de création d'un BL a été achevée.	f	76	85	2022-02-28 07:51:24	2022-02-28 07:51:24
6900	Tâche nouvellement créee du nom de Bébloquage erreur de réconciliation de donnée GESCOM et CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-28 07:55:42	2022-02-28 07:55:42
6901	Tâche nouvellement créee du nom de Bébloquage erreur de réconciliation de donnée GESCOM et CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-28 07:55:42	2022-02-28 07:55:42
6766	Tâche "Préparation fichier d'import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	71	2022-02-25 13:21:02	2022-02-25 13:21:02
6767	Tâche "Préparation fichier d'import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	85	2022-02-25 13:21:02	2022-02-25 13:21:02
6768	Tâche "Préparation fichier d'import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-25 13:21:05	2022-02-25 13:21:05
6769	Tâche "Préparation fichier d'import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-25 13:21:05	2022-02-25 13:21:05
6771	Tâche "Préparation fichier d'import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-25 13:21:05	2022-02-25 13:21:05
6772	Tâche "Préparation fichier d'import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-25 13:21:05	2022-02-25 13:21:05
6788	Elie vous a assigné à la tâche Import avoirs MOURTAZA VALIBHAY dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-02-25 13:28:39	2022-02-25 13:28:39
6789	Tâche "Import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-25 13:28:46	2022-02-25 13:28:46
6790	Tâche "Import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-25 13:28:46	2022-02-25 13:28:46
6792	Tâche "Import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-25 13:28:46	2022-02-25 13:28:46
6793	Tâche "Import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-25 13:28:46	2022-02-25 13:28:46
6809	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-02-25 13:29:32	2022-02-25 13:29:32
6810	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-02-25 13:29:32	2022-02-25 13:29:32
6812	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-02-25 13:29:32	2022-02-25 13:29:32
6813	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-02-25 13:29:32	2022-02-25 13:29:32
6824	Tâche "Créer un champas pour la référence fournisseur dans doc facture et afficher sa valeur dans l'impression"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	53	2022-02-27 15:42:21	2022-02-27 15:42:21
6825	Tâche "Créer un champas pour la référence fournisseur dans doc facture et afficher sa valeur dans l'impression"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	57	2022-02-27 15:42:21	2022-02-27 15:42:21
6827	Tâche "Créer un champas pour la référence fournisseur dans doc facture et afficher sa valeur dans l'impression"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	71	2022-02-27 15:42:21	2022-02-27 15:42:21
6828	Tâche "Créer un champas pour la référence fournisseur dans doc facture et afficher sa valeur dans l'impression"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	f	78	85	2022-02-27 15:42:21	2022-02-27 15:42:21
6829	La tâche Relier la colonne référence fournisseur avec le champ référence fournisseur dans doc achat a été achevée.	f	78	53	2022-02-27 15:45:16	2022-02-27 15:45:16
6830	La tâche Relier la colonne référence fournisseur avec le champ référence fournisseur dans doc achat a été achevée.	f	78	57	2022-02-27 15:45:16	2022-02-27 15:45:16
6832	La tâche Relier la colonne référence fournisseur avec le champ référence fournisseur dans doc achat a été achevée.	f	78	71	2022-02-27 15:45:16	2022-02-27 15:45:16
6833	La tâche Relier la colonne référence fournisseur avec le champ référence fournisseur dans doc achat a été achevée.	f	78	85	2022-02-27 15:45:16	2022-02-27 15:45:16
6839	Vous avez été assigné à la sous-tâche Enlever le champs numéro de dossier et considérer le numéro de document à sa place du projet SIGM - Gestion  Agence de Voyage sur Odoo 15	f	78	78	2022-02-27 15:46:59	2022-02-27 15:46:59
6860	Miandrisoa vous a assigné à la tâche Paramétrage sur les fiches CLIENTS dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-28 07:49:18	2022-02-28 07:49:18
6872	Tâche nouvellement créee du nom de Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-02-28 07:52:30	2022-02-28 07:52:30
6873	Tâche nouvellement créee du nom de Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-02-28 07:52:30	2022-02-28 07:52:30
6875	Tâche nouvellement créee du nom de Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-02-28 07:52:30	2022-02-28 07:52:30
6783	Tâche nouvellement créee du nom de Import avoirs MOURTAZA VALIBHAY par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-25 13:28:39	2022-02-25 13:28:39
6784	Tâche nouvellement créee du nom de Import avoirs MOURTAZA VALIBHAY par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-25 13:28:39	2022-02-25 13:28:39
6786	Tâche nouvellement créee du nom de Import avoirs MOURTAZA VALIBHAY par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-25 13:28:39	2022-02-25 13:28:39
6787	Tâche nouvellement créee du nom de Import avoirs MOURTAZA VALIBHAY par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-25 13:28:39	2022-02-25 13:28:39
6845	La tâche Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert a été achevée.	f	78	53	2022-02-27 15:50:20	2022-02-27 15:50:20
6846	La tâche Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert a été achevée.	f	78	57	2022-02-27 15:50:20	2022-02-27 15:50:20
6848	La tâche Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert a été achevée.	f	78	71	2022-02-27 15:50:20	2022-02-27 15:50:20
6849	La tâche Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert a été achevée.	f	78	85	2022-02-27 15:50:20	2022-02-27 15:50:20
6883	Tâche nouvellement créee du nom de Inventaire TANA et TAMATAVE par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-28 07:53:14	2022-02-28 07:53:14
6884	Tâche nouvellement créee du nom de Inventaire TANA et TAMATAVE par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-28 07:53:14	2022-02-28 07:53:14
6886	Tâche nouvellement créee du nom de Inventaire TANA et TAMATAVE par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-28 07:53:14	2022-02-28 07:53:14
6887	Tâche nouvellement créee du nom de Inventaire TANA et TAMATAVE par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-28 07:53:14	2022-02-28 07:53:14
6785	Tâche nouvellement créee du nom de Import avoirs MOURTAZA VALIBHAY par Elie dans le projet QLM Intervention / Accompagnement 2022.	t	77	70	2022-02-25 13:28:39	2022-02-25 13:28:39
6847	La tâche Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert a été achevée.	t	78	70	2022-02-27 15:50:20	2022-02-27 15:50:20
6885	Tâche nouvellement créee du nom de Inventaire TANA et TAMATAVE par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-28 07:53:14	2022-02-28 07:53:14
6804	Tâche "Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-02-25 13:29:18	2022-02-25 13:29:18
6805	Tâche "Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-02-25 13:29:18	2022-02-25 13:29:18
6807	Tâche "Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-02-25 13:29:18	2022-02-25 13:29:18
6808	Tâche "Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-02-25 13:29:18	2022-02-25 13:29:18
6834	La tâche Ajouter une colonne pour la référence facture fournisseur à côté de la colonne fournisseur a été achevée.	f	78	53	2022-02-27 15:45:26	2022-02-27 15:45:26
6835	La tâche Ajouter une colonne pour la référence facture fournisseur à côté de la colonne fournisseur a été achevée.	f	78	57	2022-02-27 15:45:26	2022-02-27 15:45:26
6837	La tâche Ajouter une colonne pour la référence facture fournisseur à côté de la colonne fournisseur a été achevée.	f	78	71	2022-02-27 15:45:26	2022-02-27 15:45:26
6838	La tâche Ajouter une colonne pour la référence facture fournisseur à côté de la colonne fournisseur a été achevée.	f	78	85	2022-02-27 15:45:26	2022-02-27 15:45:26
6840	La tâche Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert a été achevée avec toutes ses tâches filles.	f	78	53	2022-02-27 15:50:20	2022-02-27 15:50:20
6841	La tâche Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert a été achevée avec toutes ses tâches filles.	f	78	57	2022-02-27 15:50:20	2022-02-27 15:50:20
6843	La tâche Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert a été achevée avec toutes ses tâches filles.	f	78	71	2022-02-27 15:50:20	2022-02-27 15:50:20
6844	La tâche Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert a été achevée avec toutes ses tâches filles.	f	78	85	2022-02-27 15:50:20	2022-02-27 15:50:20
6877	Osé vous a assigné à la tâche Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows dans le projet Sauvegarde FTP des clients .	f	74	74	2022-02-28 07:52:30	2022-02-28 07:52:30
6894	Tâche nouvellement créee du nom de Liste des articles sans code barre par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-28 07:54:11	2022-02-28 07:54:11
6895	Tâche nouvellement créee du nom de Liste des articles sans code barre par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-28 07:54:11	2022-02-28 07:54:11
6897	Tâche nouvellement créee du nom de Liste des articles sans code barre par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-28 07:54:11	2022-02-28 07:54:11
6898	Tâche nouvellement créee du nom de Liste des articles sans code barre par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-28 07:54:11	2022-02-28 07:54:11
6917	La tâche Ajouter dans le document d'achat le numéro du vol et les dates (dates de départ et d'arrivée) a été achevée.	f	78	53	2022-02-28 08:16:34	2022-02-28 08:16:34
6918	La tâche Ajouter dans le document d'achat le numéro du vol et les dates (dates de départ et d'arrivée) a été achevée.	f	78	57	2022-02-28 08:16:34	2022-02-28 08:16:34
6920	La tâche Ajouter dans le document d'achat le numéro du vol et les dates (dates de départ et d'arrivée) a été achevée.	f	78	71	2022-02-28 08:16:34	2022-02-28 08:16:34
6921	La tâche Ajouter dans le document d'achat le numéro du vol et les dates (dates de départ et d'arrivée) a été achevée.	f	78	85	2022-02-28 08:16:34	2022-02-28 08:16:34
6926	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-28 08:38:07	2022-02-28 08:38:07
6927	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-28 08:38:07	2022-02-28 08:38:07
6928	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-28 08:38:07	2022-02-28 08:38:07
6929	Tâche "Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-28 08:38:07	2022-02-28 08:38:07
6935	Tâche "Import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-02-28 08:46:16	2022-02-28 08:46:16
6936	Tâche "Import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-02-28 08:46:16	2022-02-28 08:46:16
6938	Tâche "Import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-02-28 08:46:16	2022-02-28 08:46:16
6939	Tâche "Import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-02-28 08:46:16	2022-02-28 08:46:16
6855	Tâche nouvellement créee du nom de Paramétrage sur les fiches CLIENTS par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-02-28 07:49:18	2022-02-28 07:49:18
6856	Tâche nouvellement créee du nom de Paramétrage sur les fiches CLIENTS par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-02-28 07:49:18	2022-02-28 07:49:18
6858	Tâche nouvellement créee du nom de Paramétrage sur les fiches CLIENTS par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-28 07:49:18	2022-02-28 07:49:18
6859	Tâche nouvellement créee du nom de Paramétrage sur les fiches CLIENTS par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-28 07:49:18	2022-02-28 07:49:18
6866	Miandrisoa vous a assigné à la tâche Déblocage d'un problème de création d'un BL dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-28 07:51:09	2022-02-28 07:51:09
6878	Tâche "Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	53	2022-02-28 07:52:35	2022-02-28 07:52:35
6879	Tâche "Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	57	2022-02-28 07:52:35	2022-02-28 07:52:35
6881	Tâche "Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	71	2022-02-28 07:52:35	2022-02-28 07:52:35
6882	Tâche "Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	85	2022-02-28 07:52:35	2022-02-28 07:52:35
6888	Miandrisoa vous a assigné à la tâche Inventaire TANA et TAMATAVE dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-28 07:53:14	2022-02-28 07:53:14
6889	La tâche Inventaire TANA et TAMATAVE a été achevée.	f	76	53	2022-02-28 07:53:25	2022-02-28 07:53:25
6890	La tâche Inventaire TANA et TAMATAVE a été achevée.	f	76	57	2022-02-28 07:53:25	2022-02-28 07:53:25
6892	La tâche Inventaire TANA et TAMATAVE a été achevée.	f	76	71	2022-02-28 07:53:25	2022-02-28 07:53:25
6893	La tâche Inventaire TANA et TAMATAVE a été achevée.	f	76	85	2022-02-28 07:53:25	2022-02-28 07:53:25
6912	La tâche Prendre en compte "Nombre" dans le calcul du prix total et du total HT a été achevée.	f	78	53	2022-02-28 08:16:09	2022-02-28 08:16:09
6913	La tâche Prendre en compte "Nombre" dans le calcul du prix total et du total HT a été achevée.	f	78	57	2022-02-28 08:16:09	2022-02-28 08:16:09
6915	La tâche Prendre en compte "Nombre" dans le calcul du prix total et du total HT a été achevée.	f	78	71	2022-02-28 08:16:09	2022-02-28 08:16:09
6916	La tâche Prendre en compte "Nombre" dans le calcul du prix total et du total HT a été achevée.	f	78	85	2022-02-28 08:16:09	2022-02-28 08:16:09
6940	Tâche nouvellement créee du nom de Ajustement de stock via Mme Jeanne (image whatsapp) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-28 08:50:35	2022-02-28 08:50:35
6941	Tâche nouvellement créee du nom de Ajustement de stock via Mme Jeanne (image whatsapp) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-28 08:50:35	2022-02-28 08:50:35
6943	Tâche nouvellement créee du nom de Ajustement de stock via Mme Jeanne (image whatsapp) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-28 08:50:35	2022-02-28 08:50:35
6944	Tâche nouvellement créee du nom de Ajustement de stock via Mme Jeanne (image whatsapp) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-28 08:50:35	2022-02-28 08:50:35
6857	Tâche nouvellement créee du nom de Paramétrage sur les fiches CLIENTS par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-28 07:49:18	2022-02-28 07:49:18
6880	Tâche "Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	t	74	70	2022-02-28 07:52:35	2022-02-28 07:52:35
6891	La tâche Inventaire TANA et TAMATAVE a été achevée.	t	76	70	2022-02-28 07:53:25	2022-02-28 07:53:25
6914	La tâche Prendre en compte "Nombre" dans le calcul du prix total et du total HT a été achevée.	t	78	70	2022-02-28 08:16:09	2022-02-28 08:16:09
6942	Tâche nouvellement créee du nom de Ajustement de stock via Mme Jeanne (image whatsapp) par Elie dans le projet QLM Intervention / Accompagnement 2022.	t	77	70	2022-02-28 08:50:35	2022-02-28 08:50:35
6876	Tâche nouvellement créee du nom de Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-02-28 07:52:30	2022-02-28 07:52:30
6899	Miandrisoa vous a assigné à la tâche Liste des articles sans code barre dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-28 07:54:11	2022-02-28 07:54:11
6922	Tâche "Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-28 08:37:56	2022-02-28 08:37:56
6923	Tâche "Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-28 08:37:56	2022-02-28 08:37:56
6924	Tâche "Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-28 08:37:56	2022-02-28 08:37:56
6925	Tâche "Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-28 08:37:56	2022-02-28 08:37:56
6969	La tâche Afficher les autres taxes dans l'impression facture a été achevée.	f	78	53	2022-02-28 09:35:57	2022-02-28 09:35:57
6970	La tâche Afficher les autres taxes dans l'impression facture a été achevée.	f	78	57	2022-02-28 09:35:57	2022-02-28 09:35:57
6972	La tâche Afficher les autres taxes dans l'impression facture a été achevée.	f	78	71	2022-02-28 09:35:57	2022-02-28 09:35:57
6973	La tâche Afficher les autres taxes dans l'impression facture a été achevée.	f	78	85	2022-02-28 09:35:57	2022-02-28 09:35:57
6971	La tâche Afficher les autres taxes dans l'impression facture a été achevée.	t	78	70	2022-02-28 09:35:57	2022-02-28 09:35:57
6903	Tâche nouvellement créee du nom de Bébloquage erreur de réconciliation de donnée GESCOM et CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-02-28 07:55:42	2022-02-28 07:55:42
6904	Tâche nouvellement créee du nom de Bébloquage erreur de réconciliation de donnée GESCOM et CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-02-28 07:55:42	2022-02-28 07:55:42
6930	La tâche Préparation fichier d'import avoirs MOURTAZA VALIBHAY a été achevée.	f	77	53	2022-02-28 08:45:09	2022-02-28 08:45:09
6931	La tâche Préparation fichier d'import avoirs MOURTAZA VALIBHAY a été achevée.	f	77	57	2022-02-28 08:45:09	2022-02-28 08:45:09
6933	La tâche Préparation fichier d'import avoirs MOURTAZA VALIBHAY a été achevée.	f	77	71	2022-02-28 08:45:09	2022-02-28 08:45:09
6934	La tâche Préparation fichier d'import avoirs MOURTAZA VALIBHAY a été achevée.	f	77	85	2022-02-28 08:45:09	2022-02-28 08:45:09
6902	Tâche nouvellement créee du nom de Bébloquage erreur de réconciliation de donnée GESCOM et CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-28 07:55:42	2022-02-28 07:55:42
6932	La tâche Préparation fichier d'import avoirs MOURTAZA VALIBHAY a été achevée.	t	77	70	2022-02-28 08:45:09	2022-02-28 08:45:09
6905	Miandrisoa vous a assigné à la tâche Bébloquage erreur de réconciliation de donnée GESCOM et CRM dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-02-28 07:55:42	2022-02-28 07:55:42
6951	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " A faire " par Elie	f	77	53	2022-02-28 08:50:49	2022-02-28 08:50:49
6952	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " A faire " par Elie	f	77	57	2022-02-28 08:50:49	2022-02-28 08:50:49
6954	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " A faire " par Elie	f	77	71	2022-02-28 08:50:49	2022-02-28 08:50:49
6955	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " A faire " par Elie	f	77	85	2022-02-28 08:50:49	2022-02-28 08:50:49
6953	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " A faire " par Elie	t	77	70	2022-02-28 08:50:49	2022-02-28 08:50:49
6906	Tâche nouvellement créee du nom de Finalisation de la requête Granit par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	53	2022-02-28 08:00:44	2022-02-28 08:00:44
6907	Tâche nouvellement créee du nom de Finalisation de la requête Granit par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	57	2022-02-28 08:00:44	2022-02-28 08:00:44
6909	Tâche nouvellement créee du nom de Finalisation de la requête Granit par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	71	2022-02-28 08:00:44	2022-02-28 08:00:44
6910	Tâche nouvellement créee du nom de Finalisation de la requête Granit par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	85	2022-02-28 08:00:44	2022-02-28 08:00:44
6605	Tâche nouvellement créee du nom de Synchronisation des clients odoo avec ceux dans Incadea par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:15:13	2022-02-25 07:15:13
6623	Tâche "Enlever le champs référence dans doc de type to"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	t	78	70	2022-02-25 07:16:58	2022-02-25 07:16:58
6639	Tâche nouvellement créee du nom de Renommer "Quantité" en "Nombre de chambres/personnes" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:20:53	2022-02-25 07:20:53
6696	La tâche Repertorier les ecritures non rapprochées - BMOI Chainmalt a été achevée.	t	79	70	2022-02-25 07:53:44	2022-02-25 07:53:44
6554	Tâche nouvellement créee du nom de Suppression des bases SQL EBP par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-24 12:55:09	2022-02-24 12:55:09
6754	Tâche "Intégration inventaire QLM"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	t	77	70	2022-02-25 13:19:13	2022-02-25 13:19:13
6582	Tâche nouvellement créee du nom de Créer un manuel d'utilisation pour l'application par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:11:20	2022-02-25 07:11:20
6707	Tâche "Mise en place server FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	t	74	70	2022-02-25 07:54:36	2022-02-25 07:54:36
6775	La tâche Suppression des doublons des clients a été achevée avec toutes ses tâches filles.	t	76	70	2022-02-25 13:28:36	2022-02-25 13:28:36
6414	Tâche "Mise en place WPAllExport des clients et commandes "\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	t	75	70	2022-02-24 04:48:13	2022-02-24 04:48:13
6588	Tâche nouvellement créee du nom de Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:12:35	2022-02-25 07:12:35
6656	Tâche "Renommer "Nombre" en "Nombre de nuitées""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	t	78	70	2022-02-25 07:22:03	2022-02-25 07:22:03
6478	Tâche nouvellement créee du nom de Mise en place E-mail "cheinmaltcompta2@groupe-qlm.com" par Elie dans le projet QLM Intervention / Accompagnement 2022.	t	77	70	2022-02-24 08:50:40	2022-02-24 08:50:40
6515	La tâche Intégration d'inventaire pour MOB+ a été achevée.	t	76	70	2022-02-24 12:44:48	2022-02-24 12:44:48
6520	Tâche nouvellement créee du nom de Suppression des doublons des clients par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-24 12:45:41	2022-02-24 12:45:41
6560	Tâche nouvellement créee du nom de Intégration des Stocks dépôt 2 PO24141 et autres articles (carreaux) par Elie dans le projet QLM Intervention / Accompagnement 2022.	t	77	70	2022-02-24 14:00:50	2022-02-24 14:00:50
6419	Tâche "création d'import produit et catégories, et correspondance des champs d'import sur le site"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	t	75	70	2022-02-24 04:49:21	2022-02-24 04:49:21
6796	La tâche Listes des articles déjà bloqués a été achevée.	t	76	70	2022-02-25 13:28:58	2022-02-25 13:28:58
6473	La tâche Mise à jour Code-barre articles Pointes a été achevée.	t	77	70	2022-02-24 08:01:05	2022-02-24 08:01:05
6429	Tâche nouvellement créee du nom de Repertorier les ecritures non rapprochées - BMOI Chainmalt par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	79	70	2022-02-24 06:34:50	2022-02-24 06:34:50
6509	Tâche nouvellement créee du nom de Intégration d'inventaire pour MOB+ par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-24 12:44:43	2022-02-24 12:44:43
6611	Tâche nouvellement créee du nom de Enlever le champs référence dans doc de type to par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:16:04	2022-02-25 07:16:04
6444	Tâche "Installation des paquets "\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	t	72	70	2022-02-24 07:15:51	2022-02-24 07:15:51
6468	Tâche "Mise à jour Code-barre articles Pointes"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-24 08:00:49	2022-02-24 08:00:49
6566	La tâche Intégration des Stocks dépôt 2 PO24141 et autres articles (carreaux) a été achevée.	t	77	70	2022-02-24 14:00:56	2022-02-24 14:00:56
6594	Tâche nouvellement créee du nom de Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:13:42	2022-02-25 07:13:42
6493	La tâche Mettre le montant en lettre dans l'impression de facture a été achevée.	t	78	70	2022-02-24 10:34:54	2022-02-24 10:34:54
6543	Tâche nouvellement créee du nom de Déblocage d'un problème de création d'un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-24 12:53:05	2022-02-24 12:53:05
6462	Tâche nouvellement créee du nom de Mise à jour Code-barre articles Pointes par Elie dans le projet QLM Intervention / Accompagnement 2022.	t	77	70	2022-02-24 08:00:31	2022-02-24 08:00:31
6504	La tâche Déblocage d'un problème de connexion à la base a été achevée.	t	76	70	2022-02-24 12:43:19	2022-02-24 12:43:19
6645	Tâche "Renommer "Quantité" en "Nombre de chambres/personnes""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	t	78	70	2022-02-25 07:21:18	2022-02-25 07:21:18
6650	Tâche nouvellement créee du nom de Renommer "Nombre" en "Nombre de nuitées" par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:21:52	2022-02-25 07:21:52
6980	La tâche Dans impression facture, mettre les fournisseurs au niveau de la ligne a été achevée.	f	78	53	2022-02-28 09:43:06	2022-02-28 09:43:06
6981	La tâche Dans impression facture, mettre les fournisseurs au niveau de la ligne a été achevée.	f	78	57	2022-02-28 09:43:06	2022-02-28 09:43:06
6911	Haro vous a assigné à la tâche Finalisation de la requête Granit dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	79	2022-02-28 08:00:44	2022-02-28 08:00:44
6946	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	53	2022-02-28 08:50:41	2022-02-28 08:50:41
6947	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	57	2022-02-28 08:50:41	2022-02-28 08:50:41
6949	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	71	2022-02-28 08:50:41	2022-02-28 08:50:41
6950	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	85	2022-02-28 08:50:41	2022-02-28 08:50:41
6948	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	t	77	70	2022-02-28 08:50:41	2022-02-28 08:50:41
6945	Elie vous a assigné à la tâche Ajustement de stock via Mme Jeanne (image whatsapp) dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-02-28 08:50:35	2022-02-28 08:50:35
6965	Tâche "Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-28 09:00:19	2022-02-28 09:00:19
6966	Tâche "Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-28 09:00:19	2022-02-28 09:00:19
6967	Tâche "Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-28 09:00:19	2022-02-28 09:00:19
6968	Tâche "Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-28 09:00:19	2022-02-28 09:00:19
6956	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-28 08:50:52	2022-02-28 08:50:52
6957	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-28 08:50:52	2022-02-28 08:50:52
6959	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-28 08:50:52	2022-02-28 08:50:52
6960	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-28 08:50:52	2022-02-28 08:50:52
6958	Tâche "Ajustement de stock via Mme Jeanne (image whatsapp)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-28 08:50:52	2022-02-28 08:50:52
6961	Tâche "Enlever User 01, User 02, User 03 de la liste des clients dans document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-28 09:00:09	2022-02-28 09:00:09
6962	Tâche "Enlever User 01, User 02, User 03 de la liste des clients dans document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-28 09:00:09	2022-02-28 09:00:09
6963	Tâche "Enlever User 01, User 02, User 03 de la liste des clients dans document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-28 09:00:09	2022-02-28 09:00:09
6964	Tâche "Enlever User 01, User 02, User 03 de la liste des clients dans document de commande"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-28 09:00:09	2022-02-28 09:00:09
6661	Tâche nouvellement créee du nom de Prendre en compte "Nombre" dans le calcul du prix total et du total HT par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:23:38	2022-02-25 07:23:38
6498	Tâche nouvellement créee du nom de Déblocage d'un problème de connexion à la base par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-24 12:42:50	2022-02-24 12:42:50
6526	Tâche "Suppression des doublons des clients"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	t	76	70	2022-02-24 12:45:50	2022-02-24 12:45:50
6717	La tâche Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci a été achevée.	t	78	70	2022-02-25 09:19:01	2022-02-25 09:19:01
6577	Tâche "Intégration d'inventaire pour Computek Tamatave"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	t	76	70	2022-02-25 06:05:34	2022-02-25 06:05:34
6628	Tâche "Déplacer la colonne fournisseur avant la colonne articles"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	t	78	70	2022-02-25 07:17:18	2022-02-25 07:17:18
6531	Tâche nouvellement créee du nom de Listes des articles déjà bloqués par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-24 12:51:34	2022-02-24 12:51:34
6571	Tâche nouvellement créee du nom de Intégration d'inventaire pour Computek Tamatave par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-25 06:05:24	2022-02-25 06:05:24
6600	Tâche "Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	t	78	70	2022-02-25 07:13:53	2022-02-25 07:13:53
6633	Tâche nouvellement créee du nom de Filtrer les articles selon le fournisseur selectionné par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:19:56	2022-02-25 07:19:56
6667	Tâche nouvellement créee du nom de Ajouter une colonne pour la référence facture fournisseur à côté de la colonne fournisseur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:24:32	2022-02-25 07:24:32
6673	Tâche nouvellement créee du nom de Relier la colonne référence fournisseur avec le champ référence fournisseur dans doc achat par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:25:48	2022-02-25 07:25:48
6679	Tâche nouvellement créee du nom de Baser toutes les politiques de facturations sur les quantités commandées par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:27:36	2022-02-25 07:27:36
6685	Tâche nouvellement créee du nom de Créer un champas pour la référence fournisseur dans doc facture et afficher sa valeur dans l'impression par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 07:32:31	2022-02-25 07:32:31
6701	Tâche nouvellement créee du nom de Mise en place server FTP par Osé dans le projet Sauvegarde FTP des clients .	t	74	70	2022-02-25 07:54:25	2022-02-25 07:54:25
6712	Tâche "Correction erreurs sur le module Fabrication"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Matthieu	t	81	70	2022-02-25 09:17:14	2022-02-25 09:17:14
6722	Tâche nouvellement créee du nom de Relier Travel Order et Account Move par des ids par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-02-25 09:24:20	2022-02-25 09:24:20
6728	La tâche Enlever le champs référence dans doc de type to a été achevée.	t	78	70	2022-02-25 10:06:42	2022-02-25 10:06:42
6733	La tâche Intégration d'inventaire pour Computek Tamatave a été achevée.	t	76	70	2022-02-25 12:30:31	2022-02-25 12:30:31
6738	Tâche nouvellement créee du nom de Intégration stock dépôt 2 du 24/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	t	77	70	2022-02-25 13:18:52	2022-02-25 13:18:52
6744	Tâche "Intégration stock dépôt 2 du 24/02/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-25 13:18:58	2022-02-25 13:18:58
6759	Tâche nouvellement créee du nom de Préparation fichier d'import avoirs MOURTAZA VALIBHAY par Elie dans le projet QLM Intervention / Accompagnement 2022.	t	77	70	2022-02-25 13:20:55	2022-02-25 13:20:55
6780	La tâche Suppression des doublons des clients a été achevée.	t	76	70	2022-02-25 13:28:36	2022-02-25 13:28:36
6801	Tâche "Paramétrage sur les fiches Clients"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	t	76	70	2022-02-25 13:29:10	2022-02-25 13:29:10
6816	La tâche Renommer "Nombre" en "Nombre de nuitées" a été achevée.	t	78	70	2022-02-27 15:19:43	2022-02-27 15:19:43
6821	Tâche "Renommer "Quantité" en "Nombre de chambres/personnes""\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	t	78	70	2022-02-27 15:20:02	2022-02-27 15:20:02
6852	Tâche "Prendre en compte "Nombre" dans le calcul du prix total et du total HT"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	t	78	70	2022-02-27 15:51:35	2022-02-27 15:51:35
6863	Tâche nouvellement créee du nom de Déblocage d'un problème de création d'un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-28 07:51:09	2022-02-28 07:51:09
6869	La tâche Déblocage d'un problème de création d'un BL a été achevée.	t	76	70	2022-02-28 07:51:24	2022-02-28 07:51:24
6765	Tâche "Préparation fichier d'import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	t	77	70	2022-02-25 13:21:02	2022-02-25 13:21:02
6770	Tâche "Préparation fichier d'import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-25 13:21:05	2022-02-25 13:21:05
6791	Tâche "Import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	t	77	70	2022-02-25 13:28:46	2022-02-25 13:28:46
6811	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	t	76	70	2022-02-25 13:29:32	2022-02-25 13:29:32
6826	Tâche "Créer un champas pour la référence fournisseur dans doc facture et afficher sa valeur dans l'impression"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En blocage " par Rémi	t	78	70	2022-02-27 15:42:21	2022-02-27 15:42:21
6831	La tâche Relier la colonne référence fournisseur avec le champ référence fournisseur dans doc achat a été achevée.	t	78	70	2022-02-27 15:45:16	2022-02-27 15:45:16
6874	Tâche nouvellement créee du nom de Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows par Osé dans le projet Sauvegarde FTP des clients .	t	74	70	2022-02-28 07:52:30	2022-02-28 07:52:30
6806	Tâche "Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	t	76	70	2022-02-25 13:29:18	2022-02-25 13:29:18
6836	La tâche Ajouter une colonne pour la référence facture fournisseur à côté de la colonne fournisseur a été achevée.	t	78	70	2022-02-27 15:45:26	2022-02-27 15:45:26
6842	La tâche Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert a été achevée avec toutes ses tâches filles.	t	78	70	2022-02-27 15:50:20	2022-02-27 15:50:20
6896	Tâche nouvellement créee du nom de Liste des articles sans code barre par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	t	76	70	2022-02-28 07:54:11	2022-02-28 07:54:11
6919	La tâche Ajouter dans le document d'achat le numéro du vol et les dates (dates de départ et d'arrivée) a été achevée.	t	78	70	2022-02-28 08:16:34	2022-02-28 08:16:34
6937	Tâche "Import avoirs MOURTAZA VALIBHAY"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	t	77	70	2022-02-28 08:46:16	2022-02-28 08:46:16
6908	Tâche nouvellement créee du nom de Finalisation de la requête Granit par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	79	70	2022-02-28 08:00:44	2022-02-28 08:00:44
6974	Tâche nouvellement créee du nom de Adapter les fichiers de configurations Import/Export avec le nouveau sftp Incadea par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-28 09:42:13	2022-02-28 09:42:13
6975	Tâche nouvellement créee du nom de Adapter les fichiers de configurations Import/Export avec le nouveau sftp Incadea par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-28 09:42:13	2022-02-28 09:42:13
6976	Tâche nouvellement créee du nom de Adapter les fichiers de configurations Import/Export avec le nouveau sftp Incadea par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	70	2022-02-28 09:42:13	2022-02-28 09:42:13
6977	Tâche nouvellement créee du nom de Adapter les fichiers de configurations Import/Export avec le nouveau sftp Incadea par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-28 09:42:13	2022-02-28 09:42:13
6978	Tâche nouvellement créee du nom de Adapter les fichiers de configurations Import/Export avec le nouveau sftp Incadea par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-28 09:42:13	2022-02-28 09:42:13
6979	Rémi vous a assigné à la tâche Adapter les fichiers de configurations Import/Export avec le nouveau sftp Incadea dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-28 09:42:13	2022-02-28 09:42:13
6985	Un projet du nom de NAJMI - Mise en place a été crée par Michel	f	71	53	2022-02-28 09:53:10	2022-02-28 09:53:10
6986	Un projet du nom de NAJMI - Mise en place a été crée par Michel	f	71	57	2022-02-28 09:53:10	2022-02-28 09:53:10
6987	Un projet du nom de NAJMI - Mise en place a été crée par Michel	f	71	70	2022-02-28 09:53:10	2022-02-28 09:53:10
6988	Un projet du nom de NAJMI - Mise en place a été crée par Michel	f	71	85	2022-02-28 09:53:10	2022-02-28 09:53:10
6989	Le projet "Sauvegarde FTP des clients " a été mise à jour par Michel	f	71	53	2022-02-28 10:07:16	2022-02-28 10:07:16
6990	Le projet "Sauvegarde FTP des clients " a été mise à jour par Michel	f	71	57	2022-02-28 10:07:16	2022-02-28 10:07:16
6991	Le projet "Sauvegarde FTP des clients " a été mise à jour par Michel	f	71	70	2022-02-28 10:07:16	2022-02-28 10:07:16
6992	Le projet "Sauvegarde FTP des clients " a été mise à jour par Michel	f	71	85	2022-02-28 10:07:16	2022-02-28 10:07:16
7001	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-28 10:23:21	2022-02-28 10:23:21
7002	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-28 10:23:21	2022-02-28 10:23:21
7003	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-28 10:23:21	2022-02-28 10:23:21
7004	Tâche "Normalisation l'heure d'envoie backup"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-28 10:23:21	2022-02-28 10:23:21
7017	Tâche nouvellement créee du nom de Module de gestion d'avance salariale Odoo par Nasolo dans le projet QLM Intervention / Accompagnement 2022.	f	72	53	2022-02-28 12:15:36	2022-02-28 12:15:36
7018	Tâche nouvellement créee du nom de Module de gestion d'avance salariale Odoo par Nasolo dans le projet QLM Intervention / Accompagnement 2022.	f	72	57	2022-02-28 12:15:36	2022-02-28 12:15:36
7019	Tâche nouvellement créee du nom de Module de gestion d'avance salariale Odoo par Nasolo dans le projet QLM Intervention / Accompagnement 2022.	f	72	70	2022-02-28 12:15:36	2022-02-28 12:15:36
7020	Tâche nouvellement créee du nom de Module de gestion d'avance salariale Odoo par Nasolo dans le projet QLM Intervention / Accompagnement 2022.	f	72	71	2022-02-28 12:15:36	2022-02-28 12:15:36
7021	Tâche nouvellement créee du nom de Module de gestion d'avance salariale Odoo par Nasolo dans le projet QLM Intervention / Accompagnement 2022.	f	72	85	2022-02-28 12:15:36	2022-02-28 12:15:36
7060	La tâche Mise à jour emplacement Dépôt 2 du 25/02/2022 a été achevée.	f	77	53	2022-02-28 13:19:54	2022-02-28 13:19:54
7061	La tâche Mise à jour emplacement Dépôt 2 du 25/02/2022 a été achevée.	f	77	57	2022-02-28 13:19:54	2022-02-28 13:19:54
7062	La tâche Mise à jour emplacement Dépôt 2 du 25/02/2022 a été achevée.	f	77	70	2022-02-28 13:19:54	2022-02-28 13:19:54
7063	La tâche Mise à jour emplacement Dépôt 2 du 25/02/2022 a été achevée.	f	77	71	2022-02-28 13:19:54	2022-02-28 13:19:54
7064	La tâche Mise à jour emplacement Dépôt 2 du 25/02/2022 a été achevée.	f	77	85	2022-02-28 13:19:54	2022-02-28 13:19:54
7082	Tâche nouvellement créee du nom de Gestion de paie mois de février 2022 - Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-01 07:11:15	2022-03-01 07:11:15
7083	Tâche nouvellement créee du nom de Gestion de paie mois de février 2022 - Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-01 07:11:15	2022-03-01 07:11:15
7084	Tâche nouvellement créee du nom de Gestion de paie mois de février 2022 - Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-01 07:11:15	2022-03-01 07:11:15
7085	Tâche nouvellement créee du nom de Gestion de paie mois de février 2022 - Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-01 07:11:15	2022-03-01 07:11:15
7086	Tâche nouvellement créee du nom de Gestion de paie mois de février 2022 - Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-01 07:11:15	2022-03-01 07:11:15
6982	La tâche Dans impression facture, mettre les fournisseurs au niveau de la ligne a été achevée.	f	78	70	2022-02-28 09:43:06	2022-02-28 09:43:06
6983	La tâche Dans impression facture, mettre les fournisseurs au niveau de la ligne a été achevée.	f	78	71	2022-02-28 09:43:06	2022-02-28 09:43:06
6984	La tâche Dans impression facture, mettre les fournisseurs au niveau de la ligne a été achevée.	f	78	85	2022-02-28 09:43:06	2022-02-28 09:43:06
6993	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-28 10:23:13	2022-02-28 10:23:13
6994	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-28 10:23:13	2022-02-28 10:23:13
6995	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-28 10:23:13	2022-02-28 10:23:13
6996	Tâche "Extraction Image EBP"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-28 10:23:13	2022-02-28 10:23:13
6997	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-28 10:23:17	2022-02-28 10:23:17
6998	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-28 10:23:17	2022-02-28 10:23:17
6999	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-28 10:23:17	2022-02-28 10:23:17
7000	Tâche "Suppression backup ancienne"\n          du projet Sauvegarde FTP des clients  mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-28 10:23:17	2022-02-28 10:23:17
7005	Tâche "Tester un module pour mettre les avances sur Odoo "\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-28 10:26:09	2022-02-28 10:26:09
7006	Tâche "Tester un module pour mettre les avances sur Odoo "\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-28 10:26:09	2022-02-28 10:26:09
7007	Tâche "Tester un module pour mettre les avances sur Odoo "\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-28 10:26:09	2022-02-28 10:26:09
7008	Tâche "Tester un module pour mettre les avances sur Odoo "\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-28 10:26:09	2022-02-28 10:26:09
7009	Tâche "Correction erreurs sur le module Fabrication"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-28 10:28:00	2022-02-28 10:28:00
7010	Tâche "Correction erreurs sur le module Fabrication"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-28 10:28:00	2022-02-28 10:28:00
7011	Tâche "Correction erreurs sur le module Fabrication"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-28 10:28:00	2022-02-28 10:28:00
7012	Tâche "Correction erreurs sur le module Fabrication"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-28 10:28:00	2022-02-28 10:28:00
7013	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	53	2022-02-28 10:28:31	2022-02-28 10:28:31
7014	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	57	2022-02-28 10:28:31	2022-02-28 10:28:31
7015	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	71	2022-02-28 10:28:31	2022-02-28 10:28:31
7016	Tâche "Adaptation/Vérification du programme Import Devis sur EBP"\n          du projet Synchro du site Computek mise dans " Achevée(s) " par Mihaja	f	70	85	2022-02-28 10:28:31	2022-02-28 10:28:31
7023	Tâche "Module de gestion d'avance salariale Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Nasolo	f	72	53	2022-02-28 12:15:45	2022-02-28 12:15:45
7024	Tâche "Module de gestion d'avance salariale Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Nasolo	f	72	57	2022-02-28 12:15:45	2022-02-28 12:15:45
7025	Tâche "Module de gestion d'avance salariale Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Nasolo	f	72	70	2022-02-28 12:15:45	2022-02-28 12:15:45
7026	Tâche "Module de gestion d'avance salariale Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Nasolo	f	72	71	2022-02-28 12:15:45	2022-02-28 12:15:45
7027	Tâche "Module de gestion d'avance salariale Odoo"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Nasolo	f	72	85	2022-02-28 12:15:45	2022-02-28 12:15:45
7028	La tâche Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina a été achevée.	f	76	53	2022-02-28 12:38:43	2022-02-28 12:38:43
7029	La tâche Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina a été achevée.	f	76	57	2022-02-28 12:38:43	2022-02-28 12:38:43
7030	La tâche Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina a été achevée.	f	76	70	2022-02-28 12:38:43	2022-02-28 12:38:43
7031	La tâche Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina a été achevée.	f	76	71	2022-02-28 12:38:43	2022-02-28 12:38:43
7032	La tâche Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina a été achevée.	f	76	85	2022-02-28 12:38:43	2022-02-28 12:38:43
7033	Tâche "Adapter les fichiers de configurations Import/Export avec le nouveau sftp Incadea"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	53	2022-02-28 12:39:03	2022-02-28 12:39:03
7034	Tâche "Adapter les fichiers de configurations Import/Export avec le nouveau sftp Incadea"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	57	2022-02-28 12:39:03	2022-02-28 12:39:03
7035	Tâche "Adapter les fichiers de configurations Import/Export avec le nouveau sftp Incadea"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	70	2022-02-28 12:39:03	2022-02-28 12:39:03
7036	Tâche "Adapter les fichiers de configurations Import/Export avec le nouveau sftp Incadea"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	71	2022-02-28 12:39:03	2022-02-28 12:39:03
7037	Tâche "Adapter les fichiers de configurations Import/Export avec le nouveau sftp Incadea"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En cours " par Rémi	f	78	85	2022-02-28 12:39:03	2022-02-28 12:39:03
7054	Tâche nouvellement créee du nom de Créer un champs dans res.partner pour y stocker GenBusPostingGroup_G par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-02-28 12:51:25	2022-02-28 12:51:25
7055	Tâche nouvellement créee du nom de Créer un champs dans res.partner pour y stocker GenBusPostingGroup_G par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-02-28 12:51:25	2022-02-28 12:51:25
7056	Tâche nouvellement créee du nom de Créer un champs dans res.partner pour y stocker GenBusPostingGroup_G par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	70	2022-02-28 12:51:25	2022-02-28 12:51:25
7057	Tâche nouvellement créee du nom de Créer un champs dans res.partner pour y stocker GenBusPostingGroup_G par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-02-28 12:51:25	2022-02-28 12:51:25
7058	Tâche nouvellement créee du nom de Créer un champs dans res.partner pour y stocker GenBusPostingGroup_G par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-02-28 12:51:25	2022-02-28 12:51:25
7081	Rémi vous a assigné à la tâche Ne pas afficher le champs "type de client" dans la fiche fournisseur dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-03-01 06:56:48	2022-03-01 06:56:48
7098	Famenontsoa vous a assigné à la tâche Ajout autres détails d'un PNR: Affichage + Traitement dans le projet SIGM - Application inter Amadeus et Odoo.	t	73	73	2022-03-01 07:17:29	2022-03-01 07:17:29
7125	Michel vous a assigné à la tâche Tâche 1 dans le projet NAJMI - Mise en place.	f	71	92	2022-03-01 09:03:49	2022-03-01 09:03:49
7140	Elie vous a assigné à la tâche Ajustement des stocks pour reglement Avoir [TPN2] dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-01 09:11:46	2022-03-01 09:11:46
7141	La tâche Ajustement des stocks pour reglement Avoir [TPN2] a été achevée.	f	77	53	2022-03-01 09:11:52	2022-03-01 09:11:52
7142	La tâche Ajustement des stocks pour reglement Avoir [TPN2] a été achevée.	f	77	57	2022-03-01 09:11:52	2022-03-01 09:11:52
7143	La tâche Ajustement des stocks pour reglement Avoir [TPN2] a été achevée.	f	77	70	2022-03-01 09:11:52	2022-03-01 09:11:52
7144	La tâche Ajustement des stocks pour reglement Avoir [TPN2] a été achevée.	f	77	71	2022-03-01 09:11:52	2022-03-01 09:11:52
7145	La tâche Ajustement des stocks pour reglement Avoir [TPN2] a été achevée.	f	77	85	2022-03-01 09:11:52	2022-03-01 09:11:52
7146	Tâche nouvellement créee du nom de Tâche 1 par Michel dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	71	53	2022-03-01 09:12:19	2022-03-01 09:12:19
7147	Tâche nouvellement créee du nom de Tâche 1 par Michel dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	71	57	2022-03-01 09:12:19	2022-03-01 09:12:19
7148	Tâche nouvellement créee du nom de Tâche 1 par Michel dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	71	70	2022-03-01 09:12:19	2022-03-01 09:12:19
7149	Tâche nouvellement créee du nom de Tâche 1 par Michel dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	71	85	2022-03-01 09:12:19	2022-03-01 09:12:19
7151	La tâche Ajouter un champs posting group dans res.partner a été achevée.	f	78	53	2022-03-01 09:12:46	2022-03-01 09:12:46
7152	La tâche Ajouter un champs posting group dans res.partner a été achevée.	f	78	57	2022-03-01 09:12:46	2022-03-01 09:12:46
7153	La tâche Ajouter un champs posting group dans res.partner a été achevée.	f	78	70	2022-03-01 09:12:46	2022-03-01 09:12:46
7154	La tâche Ajouter un champs posting group dans res.partner a été achevée.	f	78	71	2022-03-01 09:12:46	2022-03-01 09:12:46
7155	La tâche Ajouter un champs posting group dans res.partner a été achevée.	f	78	85	2022-03-01 09:12:46	2022-03-01 09:12:46
7178	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En blocage " par Nicky	f	92	53	2022-03-01 09:35:56	2022-03-01 09:35:56
7179	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En blocage " par Nicky	f	92	57	2022-03-01 09:35:56	2022-03-01 09:35:56
7181	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En blocage " par Nicky	f	92	71	2022-03-01 09:35:56	2022-03-01 09:35:56
7182	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En blocage " par Nicky	f	92	85	2022-03-01 09:35:56	2022-03-01 09:35:56
7204	Rémi vous a assigné à la tâche Importer les GenBusPostingGroup des clients et fournisseurs dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-03-01 09:48:30	2022-03-01 09:48:30
7210	La tâche Importer les GenBusPostingGroup des clients et fournisseurs a été achevée.	f	78	53	2022-03-01 10:00:52	2022-03-01 10:00:52
7211	La tâche Importer les GenBusPostingGroup des clients et fournisseurs a été achevée.	f	78	57	2022-03-01 10:00:52	2022-03-01 10:00:52
7213	La tâche Importer les GenBusPostingGroup des clients et fournisseurs a été achevée.	f	78	71	2022-03-01 10:00:52	2022-03-01 10:00:52
7214	La tâche Importer les GenBusPostingGroup des clients et fournisseurs a été achevée.	f	78	85	2022-03-01 10:00:52	2022-03-01 10:00:52
7236	Tâche nouvellement créee du nom de Ajustement de stock Chein/Stock pour validation BL par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-01 11:52:25	2022-03-01 11:52:25
7237	Tâche nouvellement créee du nom de Ajustement de stock Chein/Stock pour validation BL par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-01 11:52:25	2022-03-01 11:52:25
7239	Tâche nouvellement créee du nom de Ajustement de stock Chein/Stock pour validation BL par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-01 11:52:25	2022-03-01 11:52:25
7240	Tâche nouvellement créee du nom de Ajustement de stock Chein/Stock pour validation BL par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-01 11:52:25	2022-03-01 11:52:25
7241	Elie vous a assigné à la tâche Ajustement de stock Chein/Stock pour validation BL dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-01 11:52:25	2022-03-01 11:52:25
7238	Tâche nouvellement créee du nom de Ajustement de stock Chein/Stock pour validation BL par Elie dans le projet QLM Intervention / Accompagnement 2022.	t	77	70	2022-03-01 11:52:25	2022-03-01 11:52:25
7180	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En blocage " par Nicky	t	92	70	2022-03-01 09:35:56	2022-03-01 09:35:56
7212	La tâche Importer les GenBusPostingGroup des clients et fournisseurs a été achevée.	t	78	70	2022-03-01 10:00:52	2022-03-01 10:00:52
7246	Tâche nouvellement créee du nom de Bébloquage d'utilisateur dans CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-01 13:44:28	2022-03-01 13:44:28
7038	Tâche nouvellement créee du nom de Mise à jour emplacement Dépôt 2 du 25/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-28 12:39:27	2022-02-28 12:39:27
7039	Tâche nouvellement créee du nom de Mise à jour emplacement Dépôt 2 du 25/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-28 12:39:27	2022-02-28 12:39:27
7040	Tâche nouvellement créee du nom de Mise à jour emplacement Dépôt 2 du 25/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-02-28 12:39:27	2022-02-28 12:39:27
7041	Tâche nouvellement créee du nom de Mise à jour emplacement Dépôt 2 du 25/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-28 12:39:27	2022-02-28 12:39:27
7042	Tâche nouvellement créee du nom de Mise à jour emplacement Dépôt 2 du 25/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-28 12:39:27	2022-02-28 12:39:27
7109	Tâche nouvellement créee du nom de Ajouter un champs posting group dans res.partner par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-03-01 08:34:18	2022-03-01 08:34:18
7110	Tâche nouvellement créee du nom de Ajouter un champs posting group dans res.partner par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-03-01 08:34:18	2022-03-01 08:34:18
7111	Tâche nouvellement créee du nom de Ajouter un champs posting group dans res.partner par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	70	2022-03-01 08:34:18	2022-03-01 08:34:18
7112	Tâche nouvellement créee du nom de Ajouter un champs posting group dans res.partner par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-03-01 08:34:18	2022-03-01 08:34:18
7113	Tâche nouvellement créee du nom de Ajouter un champs posting group dans res.partner par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-03-01 08:34:18	2022-03-01 08:34:18
7115	Tâche nouvellement créee du nom de Importer les postings group des clients et dans odoo par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-03-01 08:35:11	2022-03-01 08:35:11
7116	Tâche nouvellement créee du nom de Importer les postings group des clients et dans odoo par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-03-01 08:35:11	2022-03-01 08:35:11
7117	Tâche nouvellement créee du nom de Importer les postings group des clients et dans odoo par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	70	2022-03-01 08:35:11	2022-03-01 08:35:11
7118	Tâche nouvellement créee du nom de Importer les postings group des clients et dans odoo par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-03-01 08:35:11	2022-03-01 08:35:11
7119	Tâche nouvellement créee du nom de Importer les postings group des clients et dans odoo par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-03-01 08:35:11	2022-03-01 08:35:11
7316	La tâche Validation BL Cheinmalt CHM/BL/21868, CHM/BL/21828, CHM/BL/20587 a été achevée.	f	77	53	2022-03-02 08:25:27	2022-03-02 08:25:27
7317	La tâche Validation BL Cheinmalt CHM/BL/21868, CHM/BL/21828, CHM/BL/20587 a été achevée.	f	77	57	2022-03-02 08:25:27	2022-03-02 08:25:27
7318	La tâche Validation BL Cheinmalt CHM/BL/21868, CHM/BL/21828, CHM/BL/20587 a été achevée.	f	77	70	2022-03-02 08:25:27	2022-03-02 08:25:27
7319	La tâche Validation BL Cheinmalt CHM/BL/21868, CHM/BL/21828, CHM/BL/20587 a été achevée.	f	77	71	2022-03-02 08:25:27	2022-03-02 08:25:27
7320	La tâche Validation BL Cheinmalt CHM/BL/21868, CHM/BL/21828, CHM/BL/20587 a été achevée.	f	77	85	2022-03-02 08:25:27	2022-03-02 08:25:27
7043	Elie vous a assigné à la tâche Mise à jour emplacement Dépôt 2 du 25/02/2022 dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-02-28 12:39:27	2022-02-28 12:39:27
7044	Tâche "Mise à jour emplacement Dépôt 2 du 25/02/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-02-28 12:40:29	2022-02-28 12:40:29
7045	Tâche "Mise à jour emplacement Dépôt 2 du 25/02/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-02-28 12:40:29	2022-02-28 12:40:29
7046	Tâche "Mise à jour emplacement Dépôt 2 du 25/02/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	70	2022-02-28 12:40:29	2022-02-28 12:40:29
7047	Tâche "Mise à jour emplacement Dépôt 2 du 25/02/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-02-28 12:40:29	2022-02-28 12:40:29
7048	Tâche "Mise à jour emplacement Dépôt 2 du 25/02/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-02-28 12:40:29	2022-02-28 12:40:29
7049	La tâche Ajustement de stock via Mme Jeanne (image whatsapp) a été achevée.	f	77	53	2022-02-28 12:40:35	2022-02-28 12:40:35
7050	La tâche Ajustement de stock via Mme Jeanne (image whatsapp) a été achevée.	f	77	57	2022-02-28 12:40:35	2022-02-28 12:40:35
7051	La tâche Ajustement de stock via Mme Jeanne (image whatsapp) a été achevée.	f	77	70	2022-02-28 12:40:35	2022-02-28 12:40:35
7052	La tâche Ajustement de stock via Mme Jeanne (image whatsapp) a été achevée.	f	77	71	2022-02-28 12:40:35	2022-02-28 12:40:35
7053	La tâche Ajustement de stock via Mme Jeanne (image whatsapp) a été achevée.	f	77	85	2022-02-28 12:40:35	2022-02-28 12:40:35
7059	Rémi vous a assigné à la tâche Créer un champs dans res.partner pour y stocker GenBusPostingGroup_G dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-02-28 12:51:25	2022-02-28 12:51:25
7065	Tâche nouvellement créee du nom de Mise à jour emplacement dépôt 2 du 23/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-02-28 13:33:44	2022-02-28 13:33:44
7066	Tâche nouvellement créee du nom de Mise à jour emplacement dépôt 2 du 23/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-02-28 13:33:44	2022-02-28 13:33:44
7067	Tâche nouvellement créee du nom de Mise à jour emplacement dépôt 2 du 23/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-02-28 13:33:44	2022-02-28 13:33:44
7068	Tâche nouvellement créee du nom de Mise à jour emplacement dépôt 2 du 23/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-02-28 13:33:44	2022-02-28 13:33:44
7069	Tâche nouvellement créee du nom de Mise à jour emplacement dépôt 2 du 23/02/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-02-28 13:33:44	2022-02-28 13:33:44
7070	Elie vous a assigné à la tâche Mise à jour emplacement dépôt 2 du 23/02/2022 dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-02-28 13:33:44	2022-02-28 13:33:44
7076	Tâche nouvellement créee du nom de Ne pas afficher le champs "type de client" dans la fiche fournisseur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-03-01 06:56:48	2022-03-01 06:56:48
7077	Tâche nouvellement créee du nom de Ne pas afficher le champs "type de client" dans la fiche fournisseur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-03-01 06:56:48	2022-03-01 06:56:48
7078	Tâche nouvellement créee du nom de Ne pas afficher le champs "type de client" dans la fiche fournisseur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	70	2022-03-01 06:56:48	2022-03-01 06:56:48
7079	Tâche nouvellement créee du nom de Ne pas afficher le champs "type de client" dans la fiche fournisseur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-03-01 06:56:48	2022-03-01 06:56:48
7080	Tâche nouvellement créee du nom de Ne pas afficher le champs "type de client" dans la fiche fournisseur par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-03-01 06:56:48	2022-03-01 06:56:48
7087	Elie vous a assigné à la tâche Gestion de paie mois de février 2022 - Cheinmalt dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-01 07:11:15	2022-03-01 07:11:15
7088	Tâche "Gestion de paie mois de février 2022 - Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-03-01 07:11:21	2022-03-01 07:11:21
7089	Tâche "Gestion de paie mois de février 2022 - Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-03-01 07:11:21	2022-03-01 07:11:21
7090	Tâche "Gestion de paie mois de février 2022 - Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	70	2022-03-01 07:11:21	2022-03-01 07:11:21
7091	Tâche "Gestion de paie mois de février 2022 - Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-03-01 07:11:21	2022-03-01 07:11:21
7092	Tâche "Gestion de paie mois de février 2022 - Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-03-01 07:11:21	2022-03-01 07:11:21
7099	Tâche "Ajout autres détails d'un PNR: Affichage + Traitement"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	53	2022-03-01 07:17:39	2022-03-01 07:17:39
7100	Tâche "Ajout autres détails d'un PNR: Affichage + Traitement"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	57	2022-03-01 07:17:39	2022-03-01 07:17:39
7101	Tâche "Ajout autres détails d'un PNR: Affichage + Traitement"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	70	2022-03-01 07:17:39	2022-03-01 07:17:39
7102	Tâche "Ajout autres détails d'un PNR: Affichage + Traitement"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	71	2022-03-01 07:17:39	2022-03-01 07:17:39
7103	Tâche "Ajout autres détails d'un PNR: Affichage + Traitement"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	85	2022-03-01 07:17:39	2022-03-01 07:17:39
7120	Rémi vous a assigné à la tâche Importer les postings group des clients et dans odoo dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-03-01 08:35:11	2022-03-01 08:35:11
7121	Tâche nouvellement créee du nom de Tâche 1 par Michel dans le projet NAJMI - Mise en place.	f	71	53	2022-03-01 09:03:49	2022-03-01 09:03:49
7122	Tâche nouvellement créee du nom de Tâche 1 par Michel dans le projet NAJMI - Mise en place.	f	71	57	2022-03-01 09:03:49	2022-03-01 09:03:49
7093	Tâche nouvellement créee du nom de Ajout autres détails d'un PNR: Affichage + Traitement par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	53	2022-03-01 07:17:29	2022-03-01 07:17:29
7094	Tâche nouvellement créee du nom de Ajout autres détails d'un PNR: Affichage + Traitement par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	57	2022-03-01 07:17:29	2022-03-01 07:17:29
7095	Tâche nouvellement créee du nom de Ajout autres détails d'un PNR: Affichage + Traitement par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	70	2022-03-01 07:17:29	2022-03-01 07:17:29
7096	Tâche nouvellement créee du nom de Ajout autres détails d'un PNR: Affichage + Traitement par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	71	2022-03-01 07:17:29	2022-03-01 07:17:29
7097	Tâche nouvellement créee du nom de Ajout autres détails d'un PNR: Affichage + Traitement par Famenontsoa dans le projet SIGM - Application inter Amadeus et Odoo.	f	73	85	2022-03-01 07:17:29	2022-03-01 07:17:29
7188	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En blocage " par Nicky	f	92	53	2022-03-01 09:36:01	2022-03-01 09:36:01
7189	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En blocage " par Nicky	f	92	57	2022-03-01 09:36:01	2022-03-01 09:36:01
7191	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En blocage " par Nicky	f	92	71	2022-03-01 09:36:01	2022-03-01 09:36:01
7192	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En blocage " par Nicky	f	92	85	2022-03-01 09:36:01	2022-03-01 09:36:01
7205	La tâche Ajouter un champs gen_bus_pg dans res.partner a été achevée.	f	78	53	2022-03-01 09:59:24	2022-03-01 09:59:24
7206	La tâche Ajouter un champs gen_bus_pg dans res.partner a été achevée.	f	78	57	2022-03-01 09:59:24	2022-03-01 09:59:24
7208	La tâche Ajouter un champs gen_bus_pg dans res.partner a été achevée.	f	78	71	2022-03-01 09:59:24	2022-03-01 09:59:24
7209	La tâche Ajouter un champs gen_bus_pg dans res.partner a été achevée.	f	78	85	2022-03-01 09:59:24	2022-03-01 09:59:24
7215	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " A faire " par Nicky	f	92	53	2022-03-01 10:06:41	2022-03-01 10:06:41
7216	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " A faire " par Nicky	f	92	57	2022-03-01 10:06:41	2022-03-01 10:06:41
7218	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " A faire " par Nicky	f	92	71	2022-03-01 10:06:41	2022-03-01 10:06:41
7219	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " A faire " par Nicky	f	92	85	2022-03-01 10:06:41	2022-03-01 10:06:41
7225	Osé vous a assigné à la tâche Sauvegarde Manuel des backups dans le projet Sauvegarde FTP des clients .	f	74	74	2022-03-01 11:43:39	2022-03-01 11:43:39
7190	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En blocage " par Nicky	t	92	70	2022-03-01 09:36:01	2022-03-01 09:36:01
7207	La tâche Ajouter un champs gen_bus_pg dans res.partner a été achevée.	t	78	70	2022-03-01 09:59:24	2022-03-01 09:59:24
7217	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " A faire " par Nicky	t	92	70	2022-03-01 10:06:41	2022-03-01 10:06:41
7262	La tâche Bébloquage d'utilisateur dans CRM a été achevée.	f	76	53	2022-03-01 13:45:25	2022-03-01 13:45:25
7263	La tâche Bébloquage d'utilisateur dans CRM a été achevée.	f	76	57	2022-03-01 13:45:25	2022-03-01 13:45:25
7264	La tâche Bébloquage d'utilisateur dans CRM a été achevée.	f	76	70	2022-03-01 13:45:25	2022-03-01 13:45:25
7265	La tâche Bébloquage d'utilisateur dans CRM a été achevée.	f	76	71	2022-03-01 13:45:25	2022-03-01 13:45:25
7266	La tâche Bébloquage d'utilisateur dans CRM a été achevée.	f	76	85	2022-03-01 13:45:25	2022-03-01 13:45:25
7283	Rémi vous a assigné à la tâche Vérifier si modificaiton de rapport devis amadeus a impacté celui de to dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-03-02 08:12:56	2022-03-02 08:12:56
7104	Tâche "Affichage des 'PNR AirSegments' dans la liste des vols effectués"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	53	2022-03-01 07:20:56	2022-03-01 07:20:56
7105	Tâche "Affichage des 'PNR AirSegments' dans la liste des vols effectués"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	57	2022-03-01 07:20:56	2022-03-01 07:20:56
7106	Tâche "Affichage des 'PNR AirSegments' dans la liste des vols effectués"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	70	2022-03-01 07:20:56	2022-03-01 07:20:56
7107	Tâche "Affichage des 'PNR AirSegments' dans la liste des vols effectués"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	71	2022-03-01 07:20:56	2022-03-01 07:20:56
7108	Tâche "Affichage des 'PNR AirSegments' dans la liste des vols effectués"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	85	2022-03-01 07:20:56	2022-03-01 07:20:56
7114	Rémi vous a assigné à la tâche Ajouter un champs posting group dans res.partner dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-03-01 08:34:18	2022-03-01 08:34:18
7126	Un projet du nom de MADAPLAST - Intervention / Accompagnement 2022 a été crée par Michel	f	71	53	2022-03-01 09:07:34	2022-03-01 09:07:34
7127	Un projet du nom de MADAPLAST - Intervention / Accompagnement 2022 a été crée par Michel	f	71	57	2022-03-01 09:07:34	2022-03-01 09:07:34
7128	Un projet du nom de MADAPLAST - Intervention / Accompagnement 2022 a été crée par Michel	f	71	70	2022-03-01 09:07:34	2022-03-01 09:07:34
7129	Un projet du nom de MADAPLAST - Intervention / Accompagnement 2022 a été crée par Michel	f	71	85	2022-03-01 09:07:34	2022-03-01 09:07:34
7173	La tâche Ajustement de stock pour validation BL CHM/BL/21311 a été achevée.	f	77	53	2022-03-01 09:15:14	2022-03-01 09:15:14
7174	La tâche Ajustement de stock pour validation BL CHM/BL/21311 a été achevée.	f	77	57	2022-03-01 09:15:14	2022-03-01 09:15:14
7175	La tâche Ajustement de stock pour validation BL CHM/BL/21311 a été achevée.	f	77	70	2022-03-01 09:15:14	2022-03-01 09:15:14
7176	La tâche Ajustement de stock pour validation BL CHM/BL/21311 a été achevée.	f	77	71	2022-03-01 09:15:14	2022-03-01 09:15:14
7177	La tâche Ajustement de stock pour validation BL CHM/BL/21311 a été achevée.	f	77	85	2022-03-01 09:15:14	2022-03-01 09:15:14
7242	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	53	2022-03-01 11:53:36	2022-03-01 11:53:36
7243	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	57	2022-03-01 11:53:36	2022-03-01 11:53:36
7244	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	71	2022-03-01 11:53:36	2022-03-01 11:53:36
7245	Tâche "synchronisation des categories odoo et site web"\n          du projet Site web QLM mise dans " Achevée(s) " par Mihaja	f	70	85	2022-03-01 11:53:36	2022-03-01 11:53:36
7289	La tâche Gestion de paie mois de février 2022 - Cheinmalt a été achevée.	f	77	53	2022-03-02 08:23:32	2022-03-02 08:23:32
7290	La tâche Gestion de paie mois de février 2022 - Cheinmalt a été achevée.	f	77	57	2022-03-02 08:23:32	2022-03-02 08:23:32
7291	La tâche Gestion de paie mois de février 2022 - Cheinmalt a été achevée.	f	77	70	2022-03-02 08:23:32	2022-03-02 08:23:32
7292	La tâche Gestion de paie mois de février 2022 - Cheinmalt a été achevée.	f	77	71	2022-03-02 08:23:32	2022-03-02 08:23:32
7293	La tâche Gestion de paie mois de février 2022 - Cheinmalt a été achevée.	f	77	85	2022-03-02 08:23:32	2022-03-02 08:23:32
7299	Elie vous a assigné à la tâche Gestion de paie fév 2022 - QLM/Codigaz/Codimat dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-02 08:24:12	2022-03-02 08:24:12
7300	Tâche "Gestion de paie fév 2022 - QLM/Codigaz/Codimat"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	53	2022-03-02 08:24:15	2022-03-02 08:24:15
7301	Tâche "Gestion de paie fév 2022 - QLM/Codigaz/Codimat"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	57	2022-03-02 08:24:15	2022-03-02 08:24:15
7302	Tâche "Gestion de paie fév 2022 - QLM/Codigaz/Codimat"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	70	2022-03-02 08:24:15	2022-03-02 08:24:15
7303	Tâche "Gestion de paie fév 2022 - QLM/Codigaz/Codimat"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	71	2022-03-02 08:24:15	2022-03-02 08:24:15
7304	Tâche "Gestion de paie fév 2022 - QLM/Codigaz/Codimat"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	85	2022-03-02 08:24:15	2022-03-02 08:24:15
7132	Tâche nouvellement créee du nom de Tâche 1 par Michel dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	71	70	2022-03-01 09:08:00	2022-03-01 09:08:00
7133	Tâche nouvellement créee du nom de Tâche 1 par Michel dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	71	85	2022-03-01 09:08:00	2022-03-01 09:08:00
7156	La tâche Importer les postings group des clients et dans odoo a été achevée.	f	78	53	2022-03-01 09:13:00	2022-03-01 09:13:00
7157	La tâche Importer les postings group des clients et dans odoo a été achevée.	f	78	57	2022-03-01 09:13:00	2022-03-01 09:13:00
7158	La tâche Importer les postings group des clients et dans odoo a été achevée.	f	78	70	2022-03-01 09:13:00	2022-03-01 09:13:00
7159	La tâche Importer les postings group des clients et dans odoo a été achevée.	f	78	71	2022-03-01 09:13:00	2022-03-01 09:13:00
7160	La tâche Importer les postings group des clients et dans odoo a été achevée.	f	78	85	2022-03-01 09:13:00	2022-03-01 09:13:00
7161	Tâche nouvellement créee du nom de Définir la valeur de la colonne posting group dans l'export d'écriture comptable avec posting group des clients ou fournisseurs corrspondants par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-03-01 09:14:19	2022-03-01 09:14:19
7162	Tâche nouvellement créee du nom de Définir la valeur de la colonne posting group dans l'export d'écriture comptable avec posting group des clients ou fournisseurs corrspondants par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-03-01 09:14:19	2022-03-01 09:14:19
7163	Tâche nouvellement créee du nom de Définir la valeur de la colonne posting group dans l'export d'écriture comptable avec posting group des clients ou fournisseurs corrspondants par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	70	2022-03-01 09:14:19	2022-03-01 09:14:19
7164	Tâche nouvellement créee du nom de Définir la valeur de la colonne posting group dans l'export d'écriture comptable avec posting group des clients ou fournisseurs corrspondants par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-03-01 09:14:19	2022-03-01 09:14:19
7165	Tâche nouvellement créee du nom de Définir la valeur de la colonne posting group dans l'export d'écriture comptable avec posting group des clients ou fournisseurs corrspondants par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-03-01 09:14:19	2022-03-01 09:14:19
7199	Tâche nouvellement créee du nom de Importer les GenBusPostingGroup des clients et fournisseurs par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-03-01 09:48:30	2022-03-01 09:48:30
7200	Tâche nouvellement créee du nom de Importer les GenBusPostingGroup des clients et fournisseurs par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-03-01 09:48:30	2022-03-01 09:48:30
7202	Tâche nouvellement créee du nom de Importer les GenBusPostingGroup des clients et fournisseurs par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-03-01 09:48:30	2022-03-01 09:48:30
7203	Tâche nouvellement créee du nom de Importer les GenBusPostingGroup des clients et fournisseurs par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-03-01 09:48:30	2022-03-01 09:48:30
7220	Tâche nouvellement créee du nom de Sauvegarde Manuel des backups par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-03-01 11:43:39	2022-03-01 11:43:39
7221	Tâche nouvellement créee du nom de Sauvegarde Manuel des backups par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-03-01 11:43:39	2022-03-01 11:43:39
7223	Tâche nouvellement créee du nom de Sauvegarde Manuel des backups par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-03-01 11:43:39	2022-03-01 11:43:39
7224	Tâche nouvellement créee du nom de Sauvegarde Manuel des backups par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-03-01 11:43:39	2022-03-01 11:43:39
7222	Tâche nouvellement créee du nom de Sauvegarde Manuel des backups par Osé dans le projet Sauvegarde FTP des clients .	t	74	70	2022-03-01 11:43:39	2022-03-01 11:43:39
7201	Tâche nouvellement créee du nom de Importer les GenBusPostingGroup des clients et fournisseurs par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-03-01 09:48:30	2022-03-01 09:48:30
7278	Tâche nouvellement créee du nom de Vérifier si modificaiton de rapport devis amadeus a impacté celui de to par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-03-02 08:12:56	2022-03-02 08:12:56
7279	Tâche nouvellement créee du nom de Vérifier si modificaiton de rapport devis amadeus a impacté celui de to par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-03-02 08:12:56	2022-03-02 08:12:56
7280	Tâche nouvellement créee du nom de Vérifier si modificaiton de rapport devis amadeus a impacté celui de to par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	70	2022-03-02 08:12:56	2022-03-02 08:12:56
7281	Tâche nouvellement créee du nom de Vérifier si modificaiton de rapport devis amadeus a impacté celui de to par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-03-02 08:12:56	2022-03-02 08:12:56
7282	Tâche nouvellement créee du nom de Vérifier si modificaiton de rapport devis amadeus a impacté celui de to par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-03-02 08:12:56	2022-03-02 08:12:56
7310	Tâche nouvellement créee du nom de Validation BL Cheinmalt CHM/BL/21868, CHM/BL/21828, CHM/BL/20587 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-02 08:25:21	2022-03-02 08:25:21
7311	Tâche nouvellement créee du nom de Validation BL Cheinmalt CHM/BL/21868, CHM/BL/21828, CHM/BL/20587 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-02 08:25:21	2022-03-02 08:25:21
7312	Tâche nouvellement créee du nom de Validation BL Cheinmalt CHM/BL/21868, CHM/BL/21828, CHM/BL/20587 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-02 08:25:21	2022-03-02 08:25:21
7313	Tâche nouvellement créee du nom de Validation BL Cheinmalt CHM/BL/21868, CHM/BL/21828, CHM/BL/20587 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-02 08:25:21	2022-03-02 08:25:21
7314	Tâche nouvellement créee du nom de Validation BL Cheinmalt CHM/BL/21868, CHM/BL/21828, CHM/BL/20587 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-02 08:25:21	2022-03-02 08:25:21
7134	Michel vous a assigné à la tâche Tâche 1 dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	71	92	2022-03-01 09:08:00	2022-03-01 09:08:00
7183	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En cours " par Nicky	f	92	53	2022-03-01 09:35:59	2022-03-01 09:35:59
7184	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En cours " par Nicky	f	92	57	2022-03-01 09:35:59	2022-03-01 09:35:59
7186	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En cours " par Nicky	f	92	71	2022-03-01 09:35:59	2022-03-01 09:35:59
7187	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En cours " par Nicky	f	92	85	2022-03-01 09:35:59	2022-03-01 09:35:59
7185	Tâche "Tâche 1"\n          du projet NAJMI - Mise en place mise dans " En cours " par Nicky	t	92	70	2022-03-01 09:35:59	2022-03-01 09:35:59
7294	Tâche nouvellement créee du nom de Gestion de paie fév 2022 - QLM/Codigaz/Codimat par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-02 08:24:12	2022-03-02 08:24:12
7295	Tâche nouvellement créee du nom de Gestion de paie fév 2022 - QLM/Codigaz/Codimat par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-02 08:24:12	2022-03-02 08:24:12
7296	Tâche nouvellement créee du nom de Gestion de paie fév 2022 - QLM/Codigaz/Codimat par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-02 08:24:12	2022-03-02 08:24:12
7297	Tâche nouvellement créee du nom de Gestion de paie fév 2022 - QLM/Codigaz/Codimat par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-02 08:24:12	2022-03-02 08:24:12
7298	Tâche nouvellement créee du nom de Gestion de paie fév 2022 - QLM/Codigaz/Codimat par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-02 08:24:12	2022-03-02 08:24:12
7277	Nasolo vous a assigné à la tâche Débogage au niveau des filtres du tableau principale dans le projet EDR - Application Web Réappro.	t	72	72	2022-03-01 20:30:59	2022-03-01 20:30:59
7135	Tâche nouvellement créee du nom de Ajustement des stocks pour reglement Avoir [TPN2] par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-01 09:11:46	2022-03-01 09:11:46
7136	Tâche nouvellement créee du nom de Ajustement des stocks pour reglement Avoir [TPN2] par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-01 09:11:46	2022-03-01 09:11:46
7137	Tâche nouvellement créee du nom de Ajustement des stocks pour reglement Avoir [TPN2] par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-01 09:11:46	2022-03-01 09:11:46
7138	Tâche nouvellement créee du nom de Ajustement des stocks pour reglement Avoir [TPN2] par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-01 09:11:46	2022-03-01 09:11:46
7139	Tâche nouvellement créee du nom de Ajustement des stocks pour reglement Avoir [TPN2] par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-01 09:11:46	2022-03-01 09:11:46
7150	Michel vous a assigné à la tâche Tâche 1 dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	71	92	2022-03-01 09:12:19	2022-03-01 09:12:19
7167	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL CHM/BL/21311 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-01 09:15:06	2022-03-01 09:15:06
7168	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL CHM/BL/21311 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-01 09:15:06	2022-03-01 09:15:06
7169	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL CHM/BL/21311 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-01 09:15:06	2022-03-01 09:15:06
7170	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL CHM/BL/21311 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-01 09:15:06	2022-03-01 09:15:06
7171	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL CHM/BL/21311 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-01 09:15:06	2022-03-01 09:15:06
7193	Tâche nouvellement créee du nom de Ajouter un champs gen_bus_pg dans res.partner par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	53	2022-03-01 09:47:20	2022-03-01 09:47:20
7194	Tâche nouvellement créee du nom de Ajouter un champs gen_bus_pg dans res.partner par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	57	2022-03-01 09:47:20	2022-03-01 09:47:20
7196	Tâche nouvellement créee du nom de Ajouter un champs gen_bus_pg dans res.partner par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	71	2022-03-01 09:47:20	2022-03-01 09:47:20
7197	Tâche nouvellement créee du nom de Ajouter un champs gen_bus_pg dans res.partner par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	85	2022-03-01 09:47:20	2022-03-01 09:47:20
7195	Tâche nouvellement créee du nom de Ajouter un champs gen_bus_pg dans res.partner par Rémi dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	t	78	70	2022-03-01 09:47:20	2022-03-01 09:47:20
7251	Miandrisoa vous a assigné à la tâche Bébloquage d'utilisateur dans CRM dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-01 13:44:28	2022-03-01 13:44:28
7284	La tâche Ajustement de stock Chein/Stock pour validation BL a été achevée.	f	77	53	2022-03-02 08:23:26	2022-03-02 08:23:26
7285	La tâche Ajustement de stock Chein/Stock pour validation BL a été achevée.	f	77	57	2022-03-02 08:23:26	2022-03-02 08:23:26
7286	La tâche Ajustement de stock Chein/Stock pour validation BL a été achevée.	f	77	70	2022-03-02 08:23:26	2022-03-02 08:23:26
7287	La tâche Ajustement de stock Chein/Stock pour validation BL a été achevée.	f	77	71	2022-03-02 08:23:26	2022-03-02 08:23:26
7288	La tâche Ajustement de stock Chein/Stock pour validation BL a été achevée.	f	77	85	2022-03-02 08:23:26	2022-03-02 08:23:26
7315	Elie vous a assigné à la tâche Validation BL Cheinmalt CHM/BL/21868, CHM/BL/21828, CHM/BL/20587 dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-02 08:25:21	2022-03-02 08:25:21
7166	Rémi vous a assigné à la tâche Définir la valeur de la colonne posting group dans l'export d'écriture comptable avec posting group des clients ou fournisseurs corrspondants dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-03-01 09:14:19	2022-03-01 09:14:19
7172	Elie vous a assigné à la tâche Ajustement de stock pour validation BL CHM/BL/21311 dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-01 09:15:07	2022-03-01 09:15:07
7198	Rémi vous a assigné à la tâche Ajouter un champs gen_bus_pg dans res.partner dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	78	78	2022-03-01 09:47:20	2022-03-01 09:47:20
7226	Tâche "Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-01 11:43:44	2022-03-01 11:43:44
7227	Tâche "Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-01 11:43:44	2022-03-01 11:43:44
7229	Tâche "Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-01 11:43:44	2022-03-01 11:43:44
7230	Tâche "Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-01 11:43:44	2022-03-01 11:43:44
7228	Tâche "Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	t	74	70	2022-03-01 11:43:44	2022-03-01 11:43:44
7252	La tâche Bébloquage erreur de réconciliation de donnée GESCOM et CRM a été achevée.	f	76	53	2022-03-01 13:44:43	2022-03-01 13:44:43
7253	La tâche Bébloquage erreur de réconciliation de donnée GESCOM et CRM a été achevée.	f	76	57	2022-03-01 13:44:43	2022-03-01 13:44:43
7254	La tâche Bébloquage erreur de réconciliation de donnée GESCOM et CRM a été achevée.	f	76	70	2022-03-01 13:44:43	2022-03-01 13:44:43
7255	La tâche Bébloquage erreur de réconciliation de donnée GESCOM et CRM a été achevée.	f	76	71	2022-03-01 13:44:43	2022-03-01 13:44:43
7256	La tâche Bébloquage erreur de réconciliation de donnée GESCOM et CRM a été achevée.	f	76	85	2022-03-01 13:44:43	2022-03-01 13:44:43
7257	Tâche "Bébloquage d'utilisateur dans CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-01 13:45:20	2022-03-01 13:45:20
7258	Tâche "Bébloquage d'utilisateur dans CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-01 13:45:20	2022-03-01 13:45:20
7259	Tâche "Bébloquage d'utilisateur dans CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-01 13:45:20	2022-03-01 13:45:20
7260	Tâche "Bébloquage d'utilisateur dans CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-01 13:45:20	2022-03-01 13:45:20
7261	Tâche "Bébloquage d'utilisateur dans CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-01 13:45:20	2022-03-01 13:45:20
7272	Tâche nouvellement créee du nom de Débogage au niveau des filtres du tableau principale par Nasolo dans le projet EDR - Application Web Réappro.	f	72	53	2022-03-01 20:30:59	2022-03-01 20:30:59
7273	Tâche nouvellement créee du nom de Débogage au niveau des filtres du tableau principale par Nasolo dans le projet EDR - Application Web Réappro.	f	72	57	2022-03-01 20:30:59	2022-03-01 20:30:59
7274	Tâche nouvellement créee du nom de Débogage au niveau des filtres du tableau principale par Nasolo dans le projet EDR - Application Web Réappro.	f	72	70	2022-03-01 20:30:59	2022-03-01 20:30:59
7275	Tâche nouvellement créee du nom de Débogage au niveau des filtres du tableau principale par Nasolo dans le projet EDR - Application Web Réappro.	f	72	71	2022-03-01 20:30:59	2022-03-01 20:30:59
7276	Tâche nouvellement créee du nom de Débogage au niveau des filtres du tableau principale par Nasolo dans le projet EDR - Application Web Réappro.	f	72	85	2022-03-01 20:30:59	2022-03-01 20:30:59
7234	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	71	2022-03-01 11:43:49	2022-03-01 11:43:49
7235	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	85	2022-03-01 11:43:49	2022-03-01 11:43:49
7233	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	t	74	70	2022-03-01 11:43:49	2022-03-01 11:43:49
7305	Tâche "Gestion de paie fév 2022 - QLM/Codigaz/Codimat"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-03-02 08:24:23	2022-03-02 08:24:23
7306	Tâche "Gestion de paie fév 2022 - QLM/Codigaz/Codimat"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-03-02 08:24:23	2022-03-02 08:24:23
7307	Tâche "Gestion de paie fév 2022 - QLM/Codigaz/Codimat"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	70	2022-03-02 08:24:23	2022-03-02 08:24:23
7308	Tâche "Gestion de paie fév 2022 - QLM/Codigaz/Codimat"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-03-02 08:24:23	2022-03-02 08:24:23
7309	Tâche "Gestion de paie fév 2022 - QLM/Codigaz/Codimat"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-03-02 08:24:23	2022-03-02 08:24:23
7247	Tâche nouvellement créee du nom de Bébloquage d'utilisateur dans CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-01 13:44:28	2022-03-01 13:44:28
7248	Tâche nouvellement créee du nom de Bébloquage d'utilisateur dans CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-01 13:44:28	2022-03-01 13:44:28
7249	Tâche nouvellement créee du nom de Bébloquage d'utilisateur dans CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-01 13:44:28	2022-03-01 13:44:28
7250	Tâche nouvellement créee du nom de Bébloquage d'utilisateur dans CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-01 13:44:28	2022-03-01 13:44:28
7267	Tâche "Installation des paquets "\n          du projet EDR - Application Web Réappro mise dans " En contrôle " par Nasolo	f	72	53	2022-03-01 20:29:32	2022-03-01 20:29:32
7268	Tâche "Installation des paquets "\n          du projet EDR - Application Web Réappro mise dans " En contrôle " par Nasolo	f	72	57	2022-03-01 20:29:32	2022-03-01 20:29:32
7269	Tâche "Installation des paquets "\n          du projet EDR - Application Web Réappro mise dans " En contrôle " par Nasolo	f	72	70	2022-03-01 20:29:32	2022-03-01 20:29:32
7270	Tâche "Installation des paquets "\n          du projet EDR - Application Web Réappro mise dans " En contrôle " par Nasolo	f	72	71	2022-03-01 20:29:32	2022-03-01 20:29:32
7271	Tâche "Installation des paquets "\n          du projet EDR - Application Web Réappro mise dans " En contrôle " par Nasolo	f	72	85	2022-03-01 20:29:32	2022-03-01 20:29:32
7321	Tâche nouvellement créee du nom de Vérification stock des articles et validation des livraisons VCHD21123 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-02 08:26:24	2022-03-02 08:26:24
7322	Tâche nouvellement créee du nom de Vérification stock des articles et validation des livraisons VCHD21123 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-02 08:26:24	2022-03-02 08:26:24
7323	Tâche nouvellement créee du nom de Vérification stock des articles et validation des livraisons VCHD21123 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-02 08:26:24	2022-03-02 08:26:24
7324	Tâche nouvellement créee du nom de Vérification stock des articles et validation des livraisons VCHD21123 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-02 08:26:24	2022-03-02 08:26:24
7325	Tâche nouvellement créee du nom de Vérification stock des articles et validation des livraisons VCHD21123 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-02 08:26:24	2022-03-02 08:26:24
7326	Elie vous a assigné à la tâche Vérification stock des articles et validation des livraisons VCHD21123 dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-02 08:26:24	2022-03-02 08:26:24
7327	La tâche Vérification stock des articles et validation des livraisons VCHD21123 a été achevée.	f	77	53	2022-03-02 08:26:42	2022-03-02 08:26:42
7328	La tâche Vérification stock des articles et validation des livraisons VCHD21123 a été achevée.	f	77	57	2022-03-02 08:26:42	2022-03-02 08:26:42
7329	La tâche Vérification stock des articles et validation des livraisons VCHD21123 a été achevée.	f	77	70	2022-03-02 08:26:42	2022-03-02 08:26:42
7330	La tâche Vérification stock des articles et validation des livraisons VCHD21123 a été achevée.	f	77	71	2022-03-02 08:26:42	2022-03-02 08:26:42
7331	La tâche Vérification stock des articles et validation des livraisons VCHD21123 a été achevée.	f	77	85	2022-03-02 08:26:42	2022-03-02 08:26:42
7332	Tâche nouvellement créee du nom de Mise en place d'une methode de validation pour sauvegarder les ecritures rapprochés par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	53	2022-03-02 10:54:47	2022-03-02 10:54:47
7333	Tâche nouvellement créee du nom de Mise en place d'une methode de validation pour sauvegarder les ecritures rapprochés par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	57	2022-03-02 10:54:47	2022-03-02 10:54:47
7334	Tâche nouvellement créee du nom de Mise en place d'une methode de validation pour sauvegarder les ecritures rapprochés par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	70	2022-03-02 10:54:47	2022-03-02 10:54:47
7335	Tâche nouvellement créee du nom de Mise en place d'une methode de validation pour sauvegarder les ecritures rapprochés par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	71	2022-03-02 10:54:47	2022-03-02 10:54:47
7336	Tâche nouvellement créee du nom de Mise en place d'une methode de validation pour sauvegarder les ecritures rapprochés par Haro dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	85	2022-03-02 10:54:47	2022-03-02 10:54:47
7337	Haro vous a assigné à la tâche Mise en place d'une methode de validation pour sauvegarder les ecritures rapprochés dans le projet SIGM - Gestion  Agence de Voyage sur Odoo 15.	f	79	79	2022-03-02 10:54:47	2022-03-02 10:54:47
7338	Tâche "Mise en place d'une methode de validation pour sauvegarder les ecritures rapprochés"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	53	2022-03-02 10:55:01	2022-03-02 10:55:01
7339	Tâche "Mise en place d'une methode de validation pour sauvegarder les ecritures rapprochés"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	57	2022-03-02 10:55:01	2022-03-02 10:55:01
7340	Tâche "Mise en place d'une methode de validation pour sauvegarder les ecritures rapprochés"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	70	2022-03-02 10:55:01	2022-03-02 10:55:01
7341	Tâche "Mise en place d'une methode de validation pour sauvegarder les ecritures rapprochés"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	71	2022-03-02 10:55:01	2022-03-02 10:55:01
7342	Tâche "Mise en place d'une methode de validation pour sauvegarder les ecritures rapprochés"\n          du projet SIGM - Gestion  Agence de Voyage sur Odoo 15 mise dans " En contrôle " par Haro	f	79	85	2022-03-02 10:55:01	2022-03-02 10:55:01
7343	Tâche nouvellement créee du nom de Bébloquage utilisateur dans CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-02 11:18:07	2022-03-02 11:18:07
7344	Tâche nouvellement créee du nom de Bébloquage utilisateur dans CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-02 11:18:07	2022-03-02 11:18:07
7345	Tâche nouvellement créee du nom de Bébloquage utilisateur dans CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-02 11:18:07	2022-03-02 11:18:07
7346	Tâche nouvellement créee du nom de Bébloquage utilisateur dans CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-02 11:18:07	2022-03-02 11:18:07
7347	Tâche nouvellement créee du nom de Bébloquage utilisateur dans CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-02 11:18:07	2022-03-02 11:18:07
7348	Miandrisoa vous a assigné à la tâche Bébloquage utilisateur dans CRM dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-02 11:18:07	2022-03-02 11:18:07
7349	Tâche "Bébloquage utilisateur dans CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-02 11:18:17	2022-03-02 11:18:17
7350	Tâche "Bébloquage utilisateur dans CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-02 11:18:17	2022-03-02 11:18:17
7351	Tâche "Bébloquage utilisateur dans CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-02 11:18:17	2022-03-02 11:18:17
7352	Tâche "Bébloquage utilisateur dans CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-02 11:18:17	2022-03-02 11:18:17
7353	Tâche "Bébloquage utilisateur dans CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-02 11:18:17	2022-03-02 11:18:17
7354	La tâche Bébloquage utilisateur dans CRM a été achevée.	f	76	53	2022-03-02 11:18:25	2022-03-02 11:18:25
7355	La tâche Bébloquage utilisateur dans CRM a été achevée.	f	76	57	2022-03-02 11:18:25	2022-03-02 11:18:25
7356	La tâche Bébloquage utilisateur dans CRM a été achevée.	f	76	70	2022-03-02 11:18:25	2022-03-02 11:18:25
7357	La tâche Bébloquage utilisateur dans CRM a été achevée.	f	76	71	2022-03-02 11:18:25	2022-03-02 11:18:25
7358	La tâche Bébloquage utilisateur dans CRM a été achevée.	f	76	85	2022-03-02 11:18:25	2022-03-02 11:18:25
7364	Miandrisoa vous a assigné à la tâche Déblocage compte bloqué par ADM et MGBI2 dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-02 11:19:35	2022-03-02 11:19:35
7365	Tâche "Déblocage compte bloqué par ADM et MGBI2"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-02 11:19:40	2022-03-02 11:19:40
7366	Tâche "Déblocage compte bloqué par ADM et MGBI2"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-02 11:19:40	2022-03-02 11:19:40
7367	Tâche "Déblocage compte bloqué par ADM et MGBI2"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-02 11:19:40	2022-03-02 11:19:40
7368	Tâche "Déblocage compte bloqué par ADM et MGBI2"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-02 11:19:40	2022-03-02 11:19:40
7369	Tâche "Déblocage compte bloqué par ADM et MGBI2"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-02 11:19:40	2022-03-02 11:19:40
7380	Miandrisoa vous a assigné à la tâche Droit d'utilisateur dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-02 11:20:31	2022-03-02 11:20:31
7386	La tâche Droit d'utilisateur a été achevée.	f	76	53	2022-03-02 11:21:39	2022-03-02 11:21:39
7387	La tâche Droit d'utilisateur a été achevée.	f	76	57	2022-03-02 11:21:39	2022-03-02 11:21:39
7388	La tâche Droit d'utilisateur a été achevée.	f	76	70	2022-03-02 11:21:39	2022-03-02 11:21:39
7389	La tâche Droit d'utilisateur a été achevée.	f	76	71	2022-03-02 11:21:39	2022-03-02 11:21:39
7390	La tâche Droit d'utilisateur a été achevée.	f	76	85	2022-03-02 11:21:39	2022-03-02 11:21:39
7417	Tâche "Mise en place server FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-02 12:33:13	2022-03-02 12:33:13
7418	Tâche "Mise en place server FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-02 12:33:13	2022-03-02 12:33:13
7419	Tâche "Mise en place server FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-02 12:33:13	2022-03-02 12:33:13
7420	Tâche "Mise en place server FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-02 12:33:13	2022-03-02 12:33:13
7421	Tâche "Mise en place server FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-02 12:33:13	2022-03-02 12:33:13
7422	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-02 12:33:33	2022-03-02 12:33:33
7423	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-02 12:33:33	2022-03-02 12:33:33
7424	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-02 12:33:33	2022-03-02 12:33:33
7425	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-02 12:33:33	2022-03-02 12:33:33
7426	Tâche "Résolution des problèmes d'envoie des fichiers backup dans l'FTP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-02 12:33:33	2022-03-02 12:33:33
7427	Tâche "Vérification des sauvegardes sur les serveurs clients "\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-02 12:33:47	2022-03-02 12:33:47
7428	Tâche "Vérification des sauvegardes sur les serveurs clients "\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-02 12:33:47	2022-03-02 12:33:47
7429	Tâche "Vérification des sauvegardes sur les serveurs clients "\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-02 12:33:47	2022-03-02 12:33:47
7430	Tâche "Vérification des sauvegardes sur les serveurs clients "\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-02 12:33:47	2022-03-02 12:33:47
7431	Tâche "Vérification des sauvegardes sur les serveurs clients "\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-02 12:33:47	2022-03-02 12:33:47
7432	Tâche nouvellement créee du nom de Sauvegarde manuel backup EBP par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-03-02 12:34:07	2022-03-02 12:34:07
7433	Tâche nouvellement créee du nom de Sauvegarde manuel backup EBP par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-03-02 12:34:07	2022-03-02 12:34:07
7682	La tâche Intégration inventaire RFI du 03/03/2022 a été achevée.	f	77	85	2022-03-04 11:32:08	2022-03-04 11:32:08
7359	Tâche nouvellement créee du nom de Déblocage compte bloqué par ADM et MGBI2 par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-02 11:19:35	2022-03-02 11:19:35
7360	Tâche nouvellement créee du nom de Déblocage compte bloqué par ADM et MGBI2 par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-02 11:19:35	2022-03-02 11:19:35
7361	Tâche nouvellement créee du nom de Déblocage compte bloqué par ADM et MGBI2 par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-02 11:19:35	2022-03-02 11:19:35
7362	Tâche nouvellement créee du nom de Déblocage compte bloqué par ADM et MGBI2 par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-02 11:19:35	2022-03-02 11:19:35
7363	Tâche nouvellement créee du nom de Déblocage compte bloqué par ADM et MGBI2 par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-02 11:19:35	2022-03-02 11:19:35
7375	Tâche nouvellement créee du nom de Droit d'utilisateur par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-02 11:20:31	2022-03-02 11:20:31
7376	Tâche nouvellement créee du nom de Droit d'utilisateur par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-02 11:20:31	2022-03-02 11:20:31
7377	Tâche nouvellement créee du nom de Droit d'utilisateur par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-02 11:20:31	2022-03-02 11:20:31
7378	Tâche nouvellement créee du nom de Droit d'utilisateur par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-02 11:20:31	2022-03-02 11:20:31
7379	Tâche nouvellement créee du nom de Droit d'utilisateur par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-02 11:20:31	2022-03-02 11:20:31
7381	Tâche "Droit d'utilisateur"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-02 11:21:00	2022-03-02 11:21:00
7382	Tâche "Droit d'utilisateur"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-02 11:21:00	2022-03-02 11:21:00
7383	Tâche "Droit d'utilisateur"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-02 11:21:00	2022-03-02 11:21:00
7384	Tâche "Droit d'utilisateur"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-02 11:21:00	2022-03-02 11:21:00
7385	Tâche "Droit d'utilisateur"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-02 11:21:00	2022-03-02 11:21:00
7396	Miandrisoa vous a assigné à la tâche Contre inventaire pour COMPUTEK TANA dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-02 11:22:04	2022-03-02 11:22:04
7397	Tâche "Contre inventaire pour COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-02 11:22:08	2022-03-02 11:22:08
7398	Tâche "Contre inventaire pour COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-02 11:22:08	2022-03-02 11:22:08
7399	Tâche "Contre inventaire pour COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-02 11:22:08	2022-03-02 11:22:08
7400	Tâche "Contre inventaire pour COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-02 11:22:08	2022-03-02 11:22:08
7401	Tâche "Contre inventaire pour COMPUTEK TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-02 11:22:08	2022-03-02 11:22:08
7448	Fanantenana vous a assigné à la tâche Backup Site web/base de données et mise  en place WPAllimport dans le projet Synchro du site Computek.	f	75	75	2022-03-02 13:03:07	2022-03-02 13:03:07
7449	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	53	2022-03-02 13:14:55	2022-03-02 13:14:55
7450	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	57	2022-03-02 13:14:55	2022-03-02 13:14:55
7451	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	70	2022-03-02 13:14:55	2022-03-02 13:14:55
7452	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	71	2022-03-02 13:14:55	2022-03-02 13:14:55
7453	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	85	2022-03-02 13:14:55	2022-03-02 13:14:55
7465	Tâche "Sauvegarde manuel backup EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-03 04:56:43	2022-03-03 04:56:43
7466	Tâche "Sauvegarde manuel backup EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-03 04:56:43	2022-03-03 04:56:43
7467	Tâche "Sauvegarde manuel backup EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-03 04:56:43	2022-03-03 04:56:43
7468	Tâche "Sauvegarde manuel backup EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-03 04:56:43	2022-03-03 04:56:43
7469	Tâche "Sauvegarde manuel backup EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-03 04:56:43	2022-03-03 04:56:43
7486	Miandrisoa vous a assigné à la tâche Insertion d'ARTICLE qui ne sont pas dans la nouvelle base dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-03 06:20:49	2022-03-03 06:20:49
7502	Miandrisoa vous a assigné à la tâche Béblocage des utilisateurs bloqué du CRM dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-03 06:21:51	2022-03-03 06:21:51
7508	Tâche nouvellement créee du nom de Accès dans OLAP pour les MANAGERS par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-03 06:22:30	2022-03-03 06:22:30
7509	Tâche nouvellement créee du nom de Accès dans OLAP pour les MANAGERS par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-03 06:22:30	2022-03-03 06:22:30
7510	Tâche nouvellement créee du nom de Accès dans OLAP pour les MANAGERS par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-03 06:22:30	2022-03-03 06:22:30
7391	Tâche nouvellement créee du nom de Contre inventaire pour COMPUTEK TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-02 11:22:04	2022-03-02 11:22:04
7392	Tâche nouvellement créee du nom de Contre inventaire pour COMPUTEK TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-02 11:22:04	2022-03-02 11:22:04
7393	Tâche nouvellement créee du nom de Contre inventaire pour COMPUTEK TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-02 11:22:04	2022-03-02 11:22:04
7394	Tâche nouvellement créee du nom de Contre inventaire pour COMPUTEK TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-02 11:22:04	2022-03-02 11:22:04
7395	Tâche nouvellement créee du nom de Contre inventaire pour COMPUTEK TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-02 11:22:04	2022-03-02 11:22:04
7407	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-03-02 12:32:41	2022-03-02 12:32:41
7408	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-03-02 12:32:41	2022-03-02 12:32:41
7409	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	70	2022-03-02 12:32:41	2022-03-02 12:32:41
7410	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-03-02 12:32:41	2022-03-02 12:32:41
7411	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	85	2022-03-02 12:32:41	2022-03-02 12:32:41
7437	Osé vous a assigné à la tâche Sauvegarde manuel backup EBP dans le projet Sauvegarde FTP des clients .	f	74	74	2022-03-02 12:34:07	2022-03-02 12:34:07
7438	Tâche "Sauvegarde manuel backup EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-03-02 12:34:12	2022-03-02 12:34:12
7439	Tâche "Sauvegarde manuel backup EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-03-02 12:34:12	2022-03-02 12:34:12
7440	Tâche "Sauvegarde manuel backup EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	70	2022-03-02 12:34:12	2022-03-02 12:34:12
7441	Tâche "Sauvegarde manuel backup EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-03-02 12:34:12	2022-03-02 12:34:12
7442	Tâche "Sauvegarde manuel backup EBP"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	85	2022-03-02 12:34:12	2022-03-02 12:34:12
7454	Tâche nouvellement créee du nom de Envoie des fiches de salaire Cheinmalt, QLM, Codimat et Codigaz par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-02 13:15:51	2022-03-02 13:15:51
7455	Tâche nouvellement créee du nom de Envoie des fiches de salaire Cheinmalt, QLM, Codimat et Codigaz par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-02 13:15:51	2022-03-02 13:15:51
7456	Tâche nouvellement créee du nom de Envoie des fiches de salaire Cheinmalt, QLM, Codimat et Codigaz par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-02 13:15:51	2022-03-02 13:15:51
7457	Tâche nouvellement créee du nom de Envoie des fiches de salaire Cheinmalt, QLM, Codimat et Codigaz par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-02 13:15:51	2022-03-02 13:15:51
7458	Tâche nouvellement créee du nom de Envoie des fiches de salaire Cheinmalt, QLM, Codimat et Codigaz par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-02 13:15:51	2022-03-02 13:15:51
7460	La tâche Envoie des fiches de salaire Cheinmalt, QLM, Codimat et Codigaz a été achevée.	f	77	53	2022-03-02 13:16:00	2022-03-02 13:16:00
7461	La tâche Envoie des fiches de salaire Cheinmalt, QLM, Codimat et Codigaz a été achevée.	f	77	57	2022-03-02 13:16:00	2022-03-02 13:16:00
7462	La tâche Envoie des fiches de salaire Cheinmalt, QLM, Codimat et Codigaz a été achevée.	f	77	70	2022-03-02 13:16:00	2022-03-02 13:16:00
7463	La tâche Envoie des fiches de salaire Cheinmalt, QLM, Codimat et Codigaz a été achevée.	f	77	71	2022-03-02 13:16:00	2022-03-02 13:16:00
7464	La tâche Envoie des fiches de salaire Cheinmalt, QLM, Codimat et Codigaz a été achevée.	f	77	85	2022-03-02 13:16:00	2022-03-02 13:16:00
7476	Tâche "Sauvegarde manuel backup ebp"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	53	2022-03-03 04:57:17	2022-03-03 04:57:17
7477	Tâche "Sauvegarde manuel backup ebp"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	57	2022-03-03 04:57:17	2022-03-03 04:57:17
7478	Tâche "Sauvegarde manuel backup ebp"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	70	2022-03-03 04:57:17	2022-03-03 04:57:17
7479	Tâche "Sauvegarde manuel backup ebp"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	71	2022-03-03 04:57:17	2022-03-03 04:57:17
7480	Tâche "Sauvegarde manuel backup ebp"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	85	2022-03-03 04:57:17	2022-03-03 04:57:17
7503	Tâche "Béblocage des utilisateurs bloqué du CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-03 06:21:56	2022-03-03 06:21:56
7504	Tâche "Béblocage des utilisateurs bloqué du CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-03 06:21:56	2022-03-03 06:21:56
7505	Tâche "Béblocage des utilisateurs bloqué du CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-03 06:21:56	2022-03-03 06:21:56
7506	Tâche "Béblocage des utilisateurs bloqué du CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-03 06:21:56	2022-03-03 06:21:56
7507	Tâche "Béblocage des utilisateurs bloqué du CRM"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-03 06:21:56	2022-03-03 06:21:56
7541	Elie vous a assigné à la tâche Ajustement de stock ATG0601 et PEG60*18 pour validation BL dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-03 08:21:28	2022-03-03 08:21:28
7547	La tâche Ajustement de stock ATG0601 et PEG60*18 pour validation BL a été achevée.	f	77	53	2022-03-03 10:16:20	2022-03-03 10:16:20
7548	La tâche Ajustement de stock ATG0601 et PEG60*18 pour validation BL a été achevée.	f	77	57	2022-03-03 10:16:20	2022-03-03 10:16:20
7549	La tâche Ajustement de stock ATG0601 et PEG60*18 pour validation BL a été achevée.	f	77	70	2022-03-03 10:16:20	2022-03-03 10:16:20
7412	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-02 12:32:59	2022-03-02 12:32:59
7413	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-02 12:32:59	2022-03-02 12:32:59
7414	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-02 12:32:59	2022-03-02 12:32:59
7415	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-02 12:32:59	2022-03-02 12:32:59
7416	Tâche "Sauvegarde Manuel des backups"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-02 12:32:59	2022-03-02 12:32:59
7459	Elie vous a assigné à la tâche Envoie des fiches de salaire Cheinmalt, QLM, Codimat et Codigaz dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-02 13:15:51	2022-03-02 13:15:51
7481	Tâche nouvellement créee du nom de Insertion d'ARTICLE qui ne sont pas dans la nouvelle base par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-03 06:20:49	2022-03-03 06:20:49
7482	Tâche nouvellement créee du nom de Insertion d'ARTICLE qui ne sont pas dans la nouvelle base par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-03 06:20:49	2022-03-03 06:20:49
7483	Tâche nouvellement créee du nom de Insertion d'ARTICLE qui ne sont pas dans la nouvelle base par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-03 06:20:49	2022-03-03 06:20:49
7484	Tâche nouvellement créee du nom de Insertion d'ARTICLE qui ne sont pas dans la nouvelle base par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-03 06:20:49	2022-03-03 06:20:49
7485	Tâche nouvellement créee du nom de Insertion d'ARTICLE qui ne sont pas dans la nouvelle base par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-03 06:20:49	2022-03-03 06:20:49
7492	Tâche "Ajout autres détails d'un PNR: Affichage + Traitement"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	53	2022-03-03 06:21:32	2022-03-03 06:21:32
7493	Tâche "Ajout autres détails d'un PNR: Affichage + Traitement"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	57	2022-03-03 06:21:32	2022-03-03 06:21:32
7494	Tâche "Ajout autres détails d'un PNR: Affichage + Traitement"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	70	2022-03-03 06:21:32	2022-03-03 06:21:32
7495	Tâche "Ajout autres détails d'un PNR: Affichage + Traitement"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	71	2022-03-03 06:21:32	2022-03-03 06:21:32
7496	Tâche "Ajout autres détails d'un PNR: Affichage + Traitement"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	85	2022-03-03 06:21:32	2022-03-03 06:21:32
7497	Tâche nouvellement créee du nom de Béblocage des utilisateurs bloqué du CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-03 06:21:51	2022-03-03 06:21:51
7498	Tâche nouvellement créee du nom de Béblocage des utilisateurs bloqué du CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-03 06:21:51	2022-03-03 06:21:51
7499	Tâche nouvellement créee du nom de Béblocage des utilisateurs bloqué du CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-03 06:21:51	2022-03-03 06:21:51
7500	Tâche nouvellement créee du nom de Béblocage des utilisateurs bloqué du CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-03 06:21:51	2022-03-03 06:21:51
7501	Tâche nouvellement créee du nom de Béblocage des utilisateurs bloqué du CRM par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-03 06:21:51	2022-03-03 06:21:51
7562	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	53	2022-03-03 11:04:59	2022-03-03 11:04:59
7563	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	57	2022-03-03 11:04:59	2022-03-03 11:04:59
7564	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	70	2022-03-03 11:04:59	2022-03-03 11:04:59
7565	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	71	2022-03-03 11:04:59	2022-03-03 11:04:59
7566	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	85	2022-03-03 11:04:59	2022-03-03 11:04:59
7567	La tâche Béblocage des utilisateurs bloqué du CRM a été achevée.	f	76	53	2022-03-03 12:14:08	2022-03-03 12:14:08
7568	La tâche Béblocage des utilisateurs bloqué du CRM a été achevée.	f	76	57	2022-03-03 12:14:08	2022-03-03 12:14:08
7569	La tâche Béblocage des utilisateurs bloqué du CRM a été achevée.	f	76	70	2022-03-03 12:14:08	2022-03-03 12:14:08
7570	La tâche Béblocage des utilisateurs bloqué du CRM a été achevée.	f	76	71	2022-03-03 12:14:08	2022-03-03 12:14:08
7571	La tâche Béblocage des utilisateurs bloqué du CRM a été achevée.	f	76	85	2022-03-03 12:14:08	2022-03-03 12:14:08
7604	Tâche "Creation d'un Bon de sortie pour régulariser un AVOIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-04 06:34:45	2022-03-04 06:34:45
7605	Tâche "Creation d'un Bon de sortie pour régulariser un AVOIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-04 06:34:45	2022-03-04 06:34:45
7606	Tâche "Creation d'un Bon de sortie pour régulariser un AVOIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-04 06:34:45	2022-03-04 06:34:45
7607	Tâche "Creation d'un Bon de sortie pour régulariser un AVOIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-04 06:34:45	2022-03-04 06:34:45
7608	Tâche "Creation d'un Bon de sortie pour régulariser un AVOIR"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-04 06:34:45	2022-03-04 06:34:45
7678	La tâche Intégration inventaire RFI du 03/03/2022 a été achevée.	f	77	53	2022-03-04 11:32:08	2022-03-04 11:32:08
7679	La tâche Intégration inventaire RFI du 03/03/2022 a été achevée.	f	77	57	2022-03-04 11:32:08	2022-03-04 11:32:08
7434	Tâche nouvellement créee du nom de Sauvegarde manuel backup EBP par Osé dans le projet Sauvegarde FTP des clients .	f	74	70	2022-03-02 12:34:07	2022-03-02 12:34:07
7435	Tâche nouvellement créee du nom de Sauvegarde manuel backup EBP par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-03-02 12:34:07	2022-03-02 12:34:07
7436	Tâche nouvellement créee du nom de Sauvegarde manuel backup EBP par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-03-02 12:34:07	2022-03-02 12:34:07
7513	Miandrisoa vous a assigné à la tâche Accès dans OLAP pour les MANAGERS dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-03 06:22:30	2022-03-03 06:22:30
7552	La tâche Gestion de paie fév 2022 - QLM/Codigaz/Codimat a été achevée.	f	77	53	2022-03-03 10:16:53	2022-03-03 10:16:53
7553	La tâche Gestion de paie fév 2022 - QLM/Codigaz/Codimat a été achevée.	f	77	57	2022-03-03 10:16:53	2022-03-03 10:16:53
7554	La tâche Gestion de paie fév 2022 - QLM/Codigaz/Codimat a été achevée.	f	77	70	2022-03-03 10:16:53	2022-03-03 10:16:53
7555	La tâche Gestion de paie fév 2022 - QLM/Codigaz/Codimat a été achevée.	f	77	71	2022-03-03 10:16:53	2022-03-03 10:16:53
7556	La tâche Gestion de paie fév 2022 - QLM/Codigaz/Codimat a été achevée.	f	77	85	2022-03-03 10:16:53	2022-03-03 10:16:53
7588	Tâche "Listes des articles qui n'on pas de mouvement du 3 derniers mois"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-03 14:09:42	2022-03-03 14:09:42
7589	Tâche "Listes des articles qui n'on pas de mouvement du 3 derniers mois"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-03 14:09:42	2022-03-03 14:09:42
7590	Tâche "Listes des articles qui n'on pas de mouvement du 3 derniers mois"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-03 14:09:42	2022-03-03 14:09:42
7591	Tâche "Listes des articles qui n'on pas de mouvement du 3 derniers mois"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-03 14:09:42	2022-03-03 14:09:42
7592	Tâche "Listes des articles qui n'on pas de mouvement du 3 derniers mois"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-03 14:09:42	2022-03-03 14:09:42
7631	Tâche "Affichage des segments de vols d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	53	2022-03-04 07:47:14	2022-03-04 07:47:14
7632	Tâche "Affichage des segments de vols d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	57	2022-03-04 07:47:14	2022-03-04 07:47:14
7633	Tâche "Affichage des segments de vols d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	70	2022-03-04 07:47:14	2022-03-04 07:47:14
7634	Tâche "Affichage des segments de vols d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	71	2022-03-04 07:47:14	2022-03-04 07:47:14
7635	Tâche "Affichage des segments de vols d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	85	2022-03-04 07:47:14	2022-03-04 07:47:14
7683	Tâche nouvellement créee du nom de Validation BL CHM/BL/16176, CHM/BL/15175, CHM/BL/21054, CHM/BL/21065 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-04 14:08:40	2022-03-04 14:08:40
7684	Tâche nouvellement créee du nom de Validation BL CHM/BL/16176, CHM/BL/15175, CHM/BL/21054, CHM/BL/21065 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-04 14:08:40	2022-03-04 14:08:40
7685	Tâche nouvellement créee du nom de Validation BL CHM/BL/16176, CHM/BL/15175, CHM/BL/21054, CHM/BL/21065 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-04 14:08:40	2022-03-04 14:08:40
7686	Tâche nouvellement créee du nom de Validation BL CHM/BL/16176, CHM/BL/15175, CHM/BL/21054, CHM/BL/21065 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-04 14:08:40	2022-03-04 14:08:40
7687	Tâche nouvellement créee du nom de Validation BL CHM/BL/16176, CHM/BL/15175, CHM/BL/21054, CHM/BL/21065 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-04 14:08:40	2022-03-04 14:08:40
7475	Osé vous a assigné à la tâche Sauvegarde manuel backup ebp dans le projet Sauvegarde FTP des clients .	t	74	74	2022-03-03 04:57:12	2022-03-03 04:57:12
7443	Tâche nouvellement créee du nom de Backup Site web/base de données et mise  en place WPAllimport par Fanantenana dans le projet Synchro du site Computek.	f	75	53	2022-03-02 13:03:07	2022-03-02 13:03:07
7444	Tâche nouvellement créee du nom de Backup Site web/base de données et mise  en place WPAllimport par Fanantenana dans le projet Synchro du site Computek.	f	75	57	2022-03-02 13:03:07	2022-03-02 13:03:07
7445	Tâche nouvellement créee du nom de Backup Site web/base de données et mise  en place WPAllimport par Fanantenana dans le projet Synchro du site Computek.	f	75	70	2022-03-02 13:03:07	2022-03-02 13:03:07
7446	Tâche nouvellement créee du nom de Backup Site web/base de données et mise  en place WPAllimport par Fanantenana dans le projet Synchro du site Computek.	f	75	71	2022-03-02 13:03:07	2022-03-02 13:03:07
7447	Tâche nouvellement créee du nom de Backup Site web/base de données et mise  en place WPAllimport par Fanantenana dans le projet Synchro du site Computek.	f	75	85	2022-03-02 13:03:07	2022-03-02 13:03:07
7583	La tâche Validation des BL CHM/BL/21377, CHM/BL/21326,CHM/BL/19980,CHM/BL/21179,CHM/BL/19542,CHM/BL/16176 (démande de Mme Jeanne) a été achevée.	f	77	53	2022-03-03 13:11:02	2022-03-03 13:11:02
7584	La tâche Validation des BL CHM/BL/21377, CHM/BL/21326,CHM/BL/19980,CHM/BL/21179,CHM/BL/19542,CHM/BL/16176 (démande de Mme Jeanne) a été achevée.	f	77	57	2022-03-03 13:11:02	2022-03-03 13:11:02
7585	La tâche Validation des BL CHM/BL/21377, CHM/BL/21326,CHM/BL/19980,CHM/BL/21179,CHM/BL/19542,CHM/BL/16176 (démande de Mme Jeanne) a été achevée.	f	77	70	2022-03-03 13:11:02	2022-03-03 13:11:02
7586	La tâche Validation des BL CHM/BL/21377, CHM/BL/21326,CHM/BL/19980,CHM/BL/21179,CHM/BL/19542,CHM/BL/16176 (démande de Mme Jeanne) a été achevée.	f	77	71	2022-03-03 13:11:02	2022-03-03 13:11:02
7587	La tâche Validation des BL CHM/BL/21377, CHM/BL/21326,CHM/BL/19980,CHM/BL/21179,CHM/BL/19542,CHM/BL/16176 (démande de Mme Jeanne) a été achevée.	f	77	85	2022-03-03 13:11:02	2022-03-03 13:11:02
7603	Miandrisoa vous a assigné à la tâche Creation d'un Bon de sortie pour régulariser un AVOIR dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-04 06:34:38	2022-03-04 06:34:38
7636	Tâche "Affichage des autres informations significatives d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	53	2022-03-04 08:18:39	2022-03-04 08:18:39
7637	Tâche "Affichage des autres informations significatives d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	57	2022-03-04 08:18:39	2022-03-04 08:18:39
7638	Tâche "Affichage des autres informations significatives d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	70	2022-03-04 08:18:39	2022-03-04 08:18:39
7639	Tâche "Affichage des autres informations significatives d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	71	2022-03-04 08:18:39	2022-03-04 08:18:39
7640	Tâche "Affichage des autres informations significatives d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	85	2022-03-04 08:18:39	2022-03-04 08:18:39
7662	Tâche nouvellement créee du nom de Intégration inventaire RFI du 03/03/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-04 10:31:31	2022-03-04 10:31:31
7663	Tâche nouvellement créee du nom de Intégration inventaire RFI du 03/03/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-04 10:31:31	2022-03-04 10:31:31
7664	Tâche nouvellement créee du nom de Intégration inventaire RFI du 03/03/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-04 10:31:31	2022-03-04 10:31:31
7665	Tâche nouvellement créee du nom de Intégration inventaire RFI du 03/03/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-04 10:31:31	2022-03-04 10:31:31
7666	Tâche nouvellement créee du nom de Intégration inventaire RFI du 03/03/2022 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-04 10:31:31	2022-03-04 10:31:31
7667	Elie vous a assigné à la tâche Intégration inventaire RFI du 03/03/2022 dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-04 10:31:31	2022-03-04 10:31:31
7470	Tâche nouvellement créee du nom de Sauvegarde manuel backup ebp par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-03-03 04:57:12	2022-03-03 04:57:12
7471	Tâche nouvellement créee du nom de Sauvegarde manuel backup ebp par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-03-03 04:57:12	2022-03-03 04:57:12
7472	Tâche nouvellement créee du nom de Sauvegarde manuel backup ebp par Osé dans le projet Sauvegarde FTP des clients .	f	74	70	2022-03-03 04:57:12	2022-03-03 04:57:12
7473	Tâche nouvellement créee du nom de Sauvegarde manuel backup ebp par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-03-03 04:57:12	2022-03-03 04:57:12
7474	Tâche nouvellement créee du nom de Sauvegarde manuel backup ebp par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-03-03 04:57:12	2022-03-03 04:57:12
7524	Miandrisoa vous a assigné à la tâche Listes des articles qui n'on pas de mouvement du 3 derniers mois dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-03 06:23:19	2022-03-03 06:23:19
7531	Tâche "Liste des articles sans code barre"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-03 08:13:16	2022-03-03 08:13:16
7532	Tâche "Liste des articles sans code barre"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-03 08:13:16	2022-03-03 08:13:16
7533	Tâche "Liste des articles sans code barre"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-03 08:13:16	2022-03-03 08:13:16
7534	Tâche "Liste des articles sans code barre"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-03 08:13:16	2022-03-03 08:13:16
7535	Tâche "Liste des articles sans code barre"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-03 08:13:16	2022-03-03 08:13:16
7536	Tâche nouvellement créee du nom de Ajustement de stock ATG0601 et PEG60*18 pour validation BL par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-03 08:21:27	2022-03-03 08:21:27
7537	Tâche nouvellement créee du nom de Ajustement de stock ATG0601 et PEG60*18 pour validation BL par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-03 08:21:27	2022-03-03 08:21:27
7538	Tâche nouvellement créee du nom de Ajustement de stock ATG0601 et PEG60*18 pour validation BL par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-03 08:21:27	2022-03-03 08:21:27
7539	Tâche nouvellement créee du nom de Ajustement de stock ATG0601 et PEG60*18 pour validation BL par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-03 08:21:27	2022-03-03 08:21:27
7540	Tâche nouvellement créee du nom de Ajustement de stock ATG0601 et PEG60*18 pour validation BL par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-03 08:21:27	2022-03-03 08:21:27
7542	La tâche Ajustement de stock ATG0601 et PEG60*18 pour validation BL a été achevée.	f	77	53	2022-03-03 10:16:15	2022-03-03 10:16:15
7543	La tâche Ajustement de stock ATG0601 et PEG60*18 pour validation BL a été achevée.	f	77	57	2022-03-03 10:16:15	2022-03-03 10:16:15
7544	La tâche Ajustement de stock ATG0601 et PEG60*18 pour validation BL a été achevée.	f	77	70	2022-03-03 10:16:15	2022-03-03 10:16:15
7545	La tâche Ajustement de stock ATG0601 et PEG60*18 pour validation BL a été achevée.	f	77	71	2022-03-03 10:16:15	2022-03-03 10:16:15
7546	La tâche Ajustement de stock ATG0601 et PEG60*18 pour validation BL a été achevée.	f	77	85	2022-03-03 10:16:15	2022-03-03 10:16:15
7557	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	53	2022-03-03 11:04:45	2022-03-03 11:04:45
7558	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	57	2022-03-03 11:04:45	2022-03-03 11:04:45
7559	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	70	2022-03-03 11:04:45	2022-03-03 11:04:45
7560	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	71	2022-03-03 11:04:45	2022-03-03 11:04:45
7561	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	85	2022-03-03 11:04:45	2022-03-03 11:04:45
7652	La tâche Creation d'un Bon de sortie pour régulariser un AVOIR a été achevée.	f	76	53	2022-03-04 10:14:49	2022-03-04 10:14:49
7653	La tâche Creation d'un Bon de sortie pour régulariser un AVOIR a été achevée.	f	76	57	2022-03-04 10:14:49	2022-03-04 10:14:49
7654	La tâche Creation d'un Bon de sortie pour régulariser un AVOIR a été achevée.	f	76	70	2022-03-04 10:14:49	2022-03-04 10:14:49
7655	La tâche Creation d'un Bon de sortie pour régulariser un AVOIR a été achevée.	f	76	71	2022-03-04 10:14:49	2022-03-04 10:14:49
7656	La tâche Creation d'un Bon de sortie pour régulariser un AVOIR a été achevée.	f	76	85	2022-03-04 10:14:49	2022-03-04 10:14:49
7699	Tâche nouvellement créee du nom de Création Tableau pour les articles Bien par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	53	2022-03-07 06:27:10	2022-03-07 06:27:10
7700	Tâche nouvellement créee du nom de Création Tableau pour les articles Bien par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	57	2022-03-07 06:27:10	2022-03-07 06:27:10
7701	Tâche nouvellement créee du nom de Création Tableau pour les articles Bien par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	70	2022-03-07 06:27:10	2022-03-07 06:27:10
7702	Tâche nouvellement créee du nom de Création Tableau pour les articles Bien par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	71	2022-03-07 06:27:10	2022-03-07 06:27:10
7703	Tâche nouvellement créee du nom de Création Tableau pour les articles Bien par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	85	2022-03-07 06:27:10	2022-03-07 06:27:10
7487	Tâche "Insertion d'ARTICLE qui ne sont pas dans la nouvelle base"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-03 06:20:55	2022-03-03 06:20:55
7488	Tâche "Insertion d'ARTICLE qui ne sont pas dans la nouvelle base"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-03 06:20:55	2022-03-03 06:20:55
7489	Tâche "Insertion d'ARTICLE qui ne sont pas dans la nouvelle base"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-03 06:20:55	2022-03-03 06:20:55
7490	Tâche "Insertion d'ARTICLE qui ne sont pas dans la nouvelle base"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-03 06:20:55	2022-03-03 06:20:55
7491	Tâche "Insertion d'ARTICLE qui ne sont pas dans la nouvelle base"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-03 06:20:55	2022-03-03 06:20:55
7593	La tâche Listes des articles qui n'on pas de mouvement du 3 derniers mois a été achevée.	f	76	53	2022-03-04 06:32:20	2022-03-04 06:32:20
7594	La tâche Listes des articles qui n'on pas de mouvement du 3 derniers mois a été achevée.	f	76	57	2022-03-04 06:32:20	2022-03-04 06:32:20
7595	La tâche Listes des articles qui n'on pas de mouvement du 3 derniers mois a été achevée.	f	76	70	2022-03-04 06:32:20	2022-03-04 06:32:20
7596	La tâche Listes des articles qui n'on pas de mouvement du 3 derniers mois a été achevée.	f	76	71	2022-03-04 06:32:20	2022-03-04 06:32:20
7597	La tâche Listes des articles qui n'on pas de mouvement du 3 derniers mois a été achevée.	f	76	85	2022-03-04 06:32:20	2022-03-04 06:32:20
7710	Nicky vous a assigné à la tâche Inventaire sur une période dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	92	2022-03-07 06:28:29	2022-03-07 06:28:29
7511	Tâche nouvellement créee du nom de Accès dans OLAP pour les MANAGERS par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-03 06:22:30	2022-03-03 06:22:30
7512	Tâche nouvellement créee du nom de Accès dans OLAP pour les MANAGERS par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-03 06:22:30	2022-03-03 06:22:30
7572	La tâche Insertion d'ARTICLE qui ne sont pas dans la nouvelle base a été achevée.	f	76	53	2022-03-03 12:39:26	2022-03-03 12:39:26
7573	La tâche Insertion d'ARTICLE qui ne sont pas dans la nouvelle base a été achevée.	f	76	57	2022-03-03 12:39:26	2022-03-03 12:39:26
7574	La tâche Insertion d'ARTICLE qui ne sont pas dans la nouvelle base a été achevée.	f	76	70	2022-03-03 12:39:26	2022-03-03 12:39:26
7575	La tâche Insertion d'ARTICLE qui ne sont pas dans la nouvelle base a été achevée.	f	76	71	2022-03-03 12:39:26	2022-03-03 12:39:26
7576	La tâche Insertion d'ARTICLE qui ne sont pas dans la nouvelle base a été achevée.	f	76	85	2022-03-03 12:39:26	2022-03-03 12:39:26
7625	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " A faire " par Osé	f	74	53	2022-03-04 07:00:39	2022-03-04 07:00:39
7626	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " A faire " par Osé	f	74	57	2022-03-04 07:00:39	2022-03-04 07:00:39
7627	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " A faire " par Osé	f	74	70	2022-03-04 07:00:39	2022-03-04 07:00:39
7628	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " A faire " par Osé	f	74	71	2022-03-04 07:00:39	2022-03-04 07:00:39
7629	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " A faire " par Osé	f	74	85	2022-03-04 07:00:39	2022-03-04 07:00:39
7514	Tâche "Accès dans OLAP pour les MANAGERS"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-03 06:22:36	2022-03-03 06:22:36
7515	Tâche "Accès dans OLAP pour les MANAGERS"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-03 06:22:36	2022-03-03 06:22:36
7516	Tâche "Accès dans OLAP pour les MANAGERS"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-03 06:22:36	2022-03-03 06:22:36
7517	Tâche "Accès dans OLAP pour les MANAGERS"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-03 06:22:36	2022-03-03 06:22:36
7518	Tâche "Accès dans OLAP pour les MANAGERS"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-03 06:22:36	2022-03-03 06:22:36
7519	Tâche nouvellement créee du nom de Listes des articles qui n'on pas de mouvement du 3 derniers mois par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-03 06:23:19	2022-03-03 06:23:19
7520	Tâche nouvellement créee du nom de Listes des articles qui n'on pas de mouvement du 3 derniers mois par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-03 06:23:19	2022-03-03 06:23:19
7521	Tâche nouvellement créee du nom de Listes des articles qui n'on pas de mouvement du 3 derniers mois par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-03 06:23:19	2022-03-03 06:23:19
7522	Tâche nouvellement créee du nom de Listes des articles qui n'on pas de mouvement du 3 derniers mois par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-03 06:23:19	2022-03-03 06:23:19
7523	Tâche nouvellement créee du nom de Listes des articles qui n'on pas de mouvement du 3 derniers mois par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-03 06:23:19	2022-03-03 06:23:19
7525	Tâche nouvellement créee du nom de Paramétrage des vues dans GESCOM, accès au filtrage d'une date par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-03 06:24:32	2022-03-03 06:24:32
7526	Tâche nouvellement créee du nom de Paramétrage des vues dans GESCOM, accès au filtrage d'une date par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-03 06:24:32	2022-03-03 06:24:32
7527	Tâche nouvellement créee du nom de Paramétrage des vues dans GESCOM, accès au filtrage d'une date par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-03 06:24:32	2022-03-03 06:24:32
7528	Tâche nouvellement créee du nom de Paramétrage des vues dans GESCOM, accès au filtrage d'une date par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-03 06:24:32	2022-03-03 06:24:32
7529	Tâche nouvellement créee du nom de Paramétrage des vues dans GESCOM, accès au filtrage d'une date par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-03 06:24:32	2022-03-03 06:24:32
7530	Miandrisoa vous a assigné à la tâche Paramétrage des vues dans GESCOM, accès au filtrage d'une date dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-03 06:24:32	2022-03-03 06:24:32
7609	Tâche "Sauvegarde manuel backup ebp"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-04 06:59:29	2022-03-04 06:59:29
7610	Tâche "Sauvegarde manuel backup ebp"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-04 06:59:29	2022-03-04 06:59:29
7611	Tâche "Sauvegarde manuel backup ebp"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-04 06:59:29	2022-03-04 06:59:29
7612	Tâche "Sauvegarde manuel backup ebp"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-04 06:59:29	2022-03-04 06:59:29
7613	Tâche "Sauvegarde manuel backup ebp"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-04 06:59:29	2022-03-04 06:59:29
7673	La tâche Paramétrage sur les fiches CLIENTS a été achevée.	f	76	53	2022-03-04 11:21:27	2022-03-04 11:21:27
7674	La tâche Paramétrage sur les fiches CLIENTS a été achevée.	f	76	57	2022-03-04 11:21:27	2022-03-04 11:21:27
7675	La tâche Paramétrage sur les fiches CLIENTS a été achevée.	f	76	70	2022-03-04 11:21:27	2022-03-04 11:21:27
7676	La tâche Paramétrage sur les fiches CLIENTS a été achevée.	f	76	71	2022-03-04 11:21:27	2022-03-04 11:21:27
7677	La tâche Paramétrage sur les fiches CLIENTS a été achevée.	f	76	85	2022-03-04 11:21:27	2022-03-04 11:21:27
7694	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	53	2022-03-07 06:06:15	2022-03-07 06:06:15
7695	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	57	2022-03-07 06:06:15	2022-03-07 06:06:15
7696	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	70	2022-03-07 06:06:15	2022-03-07 06:06:15
7697	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	71	2022-03-07 06:06:15	2022-03-07 06:06:15
7698	Tâche "Ajout historique d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	85	2022-03-07 06:06:15	2022-03-07 06:06:15
7704	Nicky vous a assigné à la tâche Création Tableau pour les articles Bien dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	92	2022-03-07 06:27:10	2022-03-07 06:27:10
7619	Osé vous a assigné à la tâche Sauvegarde manuelle vers Syn.com dans le projet Sauvegarde FTP des clients .	t	74	74	2022-03-04 07:00:30	2022-03-04 07:00:30
7579	Tâche nouvellement créee du nom de Validation des BL CHM/BL/21377, CHM/BL/21326,CHM/BL/19980,CHM/BL/21179,CHM/BL/19542,CHM/BL/16176 (démande de Mme Jeanne) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-03 13:10:42	2022-03-03 13:10:42
7580	Tâche nouvellement créee du nom de Validation des BL CHM/BL/21377, CHM/BL/21326,CHM/BL/19980,CHM/BL/21179,CHM/BL/19542,CHM/BL/16176 (démande de Mme Jeanne) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-03 13:10:42	2022-03-03 13:10:42
7581	Tâche nouvellement créee du nom de Validation des BL CHM/BL/21377, CHM/BL/21326,CHM/BL/19980,CHM/BL/21179,CHM/BL/19542,CHM/BL/16176 (démande de Mme Jeanne) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-03 13:10:42	2022-03-03 13:10:42
7598	Tâche nouvellement créee du nom de Creation d'un Bon de sortie pour régulariser un AVOIR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-04 06:34:38	2022-03-04 06:34:38
7599	Tâche nouvellement créee du nom de Creation d'un Bon de sortie pour régulariser un AVOIR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-04 06:34:38	2022-03-04 06:34:38
7600	Tâche nouvellement créee du nom de Creation d'un Bon de sortie pour régulariser un AVOIR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-04 06:34:38	2022-03-04 06:34:38
7601	Tâche nouvellement créee du nom de Creation d'un Bon de sortie pour régulariser un AVOIR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-04 06:34:38	2022-03-04 06:34:38
7602	Tâche nouvellement créee du nom de Creation d'un Bon de sortie pour régulariser un AVOIR par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-04 06:34:38	2022-03-04 06:34:38
7614	Tâche nouvellement créee du nom de Sauvegarde manuelle vers Syn.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-03-04 07:00:30	2022-03-04 07:00:30
7615	Tâche nouvellement créee du nom de Sauvegarde manuelle vers Syn.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-03-04 07:00:30	2022-03-04 07:00:30
7616	Tâche nouvellement créee du nom de Sauvegarde manuelle vers Syn.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	70	2022-03-04 07:00:30	2022-03-04 07:00:30
7617	Tâche nouvellement créee du nom de Sauvegarde manuelle vers Syn.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-03-04 07:00:30	2022-03-04 07:00:30
7618	Tâche nouvellement créee du nom de Sauvegarde manuelle vers Syn.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-03-04 07:00:30	2022-03-04 07:00:30
7630	Vous avez été assigné à la sous-tâche Affichage des segments de vols d'un billet du projet SIGM - Application inter Amadeus et Odoo	t	73	73	2022-03-04 07:47:07	2022-03-04 07:47:07
7705	Tâche nouvellement créee du nom de Inventaire sur une période par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	53	2022-03-07 06:28:29	2022-03-07 06:28:29
7706	Tâche nouvellement créee du nom de Inventaire sur une période par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	57	2022-03-07 06:28:29	2022-03-07 06:28:29
7707	Tâche nouvellement créee du nom de Inventaire sur une période par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	70	2022-03-07 06:28:29	2022-03-07 06:28:29
7708	Tâche nouvellement créee du nom de Inventaire sur une période par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	71	2022-03-07 06:28:29	2022-03-07 06:28:29
7709	Tâche nouvellement créee du nom de Inventaire sur une période par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	85	2022-03-07 06:28:29	2022-03-07 06:28:29
7582	Elie vous a assigné à la tâche Validation des BL CHM/BL/21377, CHM/BL/21326,CHM/BL/19980,CHM/BL/21179,CHM/BL/19542,CHM/BL/16176 (démande de Mme Jeanne) dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-03 13:10:42	2022-03-03 13:10:42
7620	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	53	2022-03-04 07:00:36	2022-03-04 07:00:36
7621	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	57	2022-03-04 07:00:36	2022-03-04 07:00:36
7622	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	70	2022-03-04 07:00:36	2022-03-04 07:00:36
7623	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	71	2022-03-04 07:00:36	2022-03-04 07:00:36
7624	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En blocage " par Osé	f	74	85	2022-03-04 07:00:36	2022-03-04 07:00:36
7642	Tâche "Affichage des historiques d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	53	2022-03-04 08:19:42	2022-03-04 08:19:42
7643	Tâche "Affichage des historiques d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	57	2022-03-04 08:19:42	2022-03-04 08:19:42
7644	Tâche "Affichage des historiques d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	70	2022-03-04 08:19:42	2022-03-04 08:19:42
7645	Tâche "Affichage des historiques d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	71	2022-03-04 08:19:42	2022-03-04 08:19:42
7646	Tâche "Affichage des historiques d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En cours " par Famenontsoa	f	73	85	2022-03-04 08:19:42	2022-03-04 08:19:42
7641	Vous avez été assigné à la sous-tâche Affichage des historiques d'un billet du projet SIGM - Application inter Amadeus et Odoo	t	73	73	2022-03-04 08:19:32	2022-03-04 08:19:32
7647	Tâche "Affichage des segments de vols d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	53	2022-03-04 09:31:37	2022-03-04 09:31:37
7648	Tâche "Affichage des segments de vols d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	57	2022-03-04 09:31:37	2022-03-04 09:31:37
7649	Tâche "Affichage des segments de vols d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	70	2022-03-04 09:31:37	2022-03-04 09:31:37
7650	Tâche "Affichage des segments de vols d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	71	2022-03-04 09:31:37	2022-03-04 09:31:37
7651	Tâche "Affichage des segments de vols d'un billet"\n          du projet SIGM - Application inter Amadeus et Odoo mise dans " En contrôle " par Famenontsoa	f	73	85	2022-03-04 09:31:37	2022-03-04 09:31:37
7657	Tâche "Paramétrage sur les fiches CLIENTS"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-04 10:21:36	2022-03-04 10:21:36
7658	Tâche "Paramétrage sur les fiches CLIENTS"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-04 10:21:36	2022-03-04 10:21:36
7659	Tâche "Paramétrage sur les fiches CLIENTS"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-04 10:21:36	2022-03-04 10:21:36
7660	Tâche "Paramétrage sur les fiches CLIENTS"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-04 10:21:36	2022-03-04 10:21:36
7661	Tâche "Paramétrage sur les fiches CLIENTS"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-04 10:21:36	2022-03-04 10:21:36
7668	Tâche "Intégration inventaire RFI du 03/03/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-03-04 10:31:49	2022-03-04 10:31:49
7669	Tâche "Intégration inventaire RFI du 03/03/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-03-04 10:31:49	2022-03-04 10:31:49
7670	Tâche "Intégration inventaire RFI du 03/03/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	70	2022-03-04 10:31:49	2022-03-04 10:31:49
7671	Tâche "Intégration inventaire RFI du 03/03/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-03-04 10:31:49	2022-03-04 10:31:49
7672	Tâche "Intégration inventaire RFI du 03/03/2022"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-03-04 10:31:49	2022-03-04 10:31:49
7688	Elie vous a assigné à la tâche Validation BL CHM/BL/16176, CHM/BL/15175, CHM/BL/21054, CHM/BL/21065 dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-04 14:08:40	2022-03-04 14:08:40
7689	La tâche Validation BL CHM/BL/16176, CHM/BL/15175, CHM/BL/21054, CHM/BL/21065 a été achevée.	f	77	53	2022-03-04 14:09:09	2022-03-04 14:09:09
7690	La tâche Validation BL CHM/BL/16176, CHM/BL/15175, CHM/BL/21054, CHM/BL/21065 a été achevée.	f	77	57	2022-03-04 14:09:09	2022-03-04 14:09:09
7691	La tâche Validation BL CHM/BL/16176, CHM/BL/15175, CHM/BL/21054, CHM/BL/21065 a été achevée.	f	77	70	2022-03-04 14:09:09	2022-03-04 14:09:09
7692	La tâche Validation BL CHM/BL/16176, CHM/BL/15175, CHM/BL/21054, CHM/BL/21065 a été achevée.	f	77	71	2022-03-04 14:09:09	2022-03-04 14:09:09
7693	La tâche Validation BL CHM/BL/16176, CHM/BL/15175, CHM/BL/21054, CHM/BL/21065 a été achevée.	f	77	85	2022-03-04 14:09:09	2022-03-04 14:09:09
7711	Tâche nouvellement créee du nom de Création champ perso pour OF d'origine par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	53	2022-03-07 06:31:08	2022-03-07 06:31:08
7712	Tâche nouvellement créee du nom de Création champ perso pour OF d'origine par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	57	2022-03-07 06:31:08	2022-03-07 06:31:08
7713	Tâche nouvellement créee du nom de Création champ perso pour OF d'origine par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	70	2022-03-07 06:31:08	2022-03-07 06:31:08
7714	Tâche nouvellement créee du nom de Création champ perso pour OF d'origine par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	71	2022-03-07 06:31:08	2022-03-07 06:31:08
7715	Tâche nouvellement créee du nom de Création champ perso pour OF d'origine par Nicky dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	85	2022-03-07 06:31:08	2022-03-07 06:31:08
7716	Nicky vous a assigné à la tâche Création champ perso pour OF d'origine dans le projet MADAPLAST - Intervention / Accompagnement 2022.	f	92	92	2022-03-07 06:31:08	2022-03-07 06:31:08
7717	Tâche nouvellement créee du nom de Gestion des emplacements  par Nicky dans le projet NAJMI - Mise en place.	f	92	53	2022-03-07 07:01:12	2022-03-07 07:01:12
7718	Tâche nouvellement créee du nom de Gestion des emplacements  par Nicky dans le projet NAJMI - Mise en place.	f	92	57	2022-03-07 07:01:12	2022-03-07 07:01:12
7719	Tâche nouvellement créee du nom de Gestion des emplacements  par Nicky dans le projet NAJMI - Mise en place.	f	92	70	2022-03-07 07:01:12	2022-03-07 07:01:12
7720	Tâche nouvellement créee du nom de Gestion des emplacements  par Nicky dans le projet NAJMI - Mise en place.	f	92	71	2022-03-07 07:01:12	2022-03-07 07:01:12
7721	Tâche nouvellement créee du nom de Gestion des emplacements  par Nicky dans le projet NAJMI - Mise en place.	f	92	85	2022-03-07 07:01:12	2022-03-07 07:01:12
7722	Nicky vous a assigné à la tâche Gestion des emplacements  dans le projet NAJMI - Mise en place.	f	92	92	2022-03-07 07:01:12	2022-03-07 07:01:12
7723	Tâche nouvellement créee du nom de Mise en place des procédures par Nicky dans le projet NAJMI - Mise en place.	f	92	53	2022-03-07 07:02:26	2022-03-07 07:02:26
7724	Tâche nouvellement créee du nom de Mise en place des procédures par Nicky dans le projet NAJMI - Mise en place.	f	92	57	2022-03-07 07:02:26	2022-03-07 07:02:26
7725	Tâche nouvellement créee du nom de Mise en place des procédures par Nicky dans le projet NAJMI - Mise en place.	f	92	70	2022-03-07 07:02:26	2022-03-07 07:02:26
7726	Tâche nouvellement créee du nom de Mise en place des procédures par Nicky dans le projet NAJMI - Mise en place.	f	92	71	2022-03-07 07:02:26	2022-03-07 07:02:26
7727	Tâche nouvellement créee du nom de Mise en place des procédures par Nicky dans le projet NAJMI - Mise en place.	f	92	85	2022-03-07 07:02:26	2022-03-07 07:02:26
7728	Nicky vous a assigné à la tâche Mise en place des procédures dans le projet NAJMI - Mise en place.	f	92	92	2022-03-07 07:02:26	2022-03-07 07:02:26
7729	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL avec Mme Jeanne par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-07 09:34:41	2022-03-07 09:34:41
7730	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL avec Mme Jeanne par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-07 09:34:41	2022-03-07 09:34:41
7731	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL avec Mme Jeanne par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-07 09:34:41	2022-03-07 09:34:41
7732	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL avec Mme Jeanne par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-07 09:34:41	2022-03-07 09:34:41
7733	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL avec Mme Jeanne par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-07 09:34:41	2022-03-07 09:34:41
7734	Elie vous a assigné à la tâche Ajustement de stock pour validation BL avec Mme Jeanne dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-07 09:34:41	2022-03-07 09:34:41
7735	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	53	2022-03-07 09:34:43	2022-03-07 09:34:43
7736	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	57	2022-03-07 09:34:43	2022-03-07 09:34:43
7737	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	70	2022-03-07 09:34:43	2022-03-07 09:34:43
7738	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	71	2022-03-07 09:34:43	2022-03-07 09:34:43
7739	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	85	2022-03-07 09:34:43	2022-03-07 09:34:43
7740	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-03-07 09:34:52	2022-03-07 09:34:52
7741	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-03-07 09:34:52	2022-03-07 09:34:52
7742	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	70	2022-03-07 09:34:52	2022-03-07 09:34:52
7743	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-03-07 09:34:52	2022-03-07 09:34:52
7744	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-03-07 09:34:52	2022-03-07 09:34:52
7745	Tâche nouvellement créee du nom de Optimisation de la base de données pour améliorer la navigation sur le site par Fanantenana dans le projet CDC - Intervention Site web.	f	75	53	2022-03-07 11:35:07	2022-03-07 11:35:07
7746	Tâche nouvellement créee du nom de Optimisation de la base de données pour améliorer la navigation sur le site par Fanantenana dans le projet CDC - Intervention Site web.	f	75	57	2022-03-07 11:35:07	2022-03-07 11:35:07
7747	Tâche nouvellement créee du nom de Optimisation de la base de données pour améliorer la navigation sur le site par Fanantenana dans le projet CDC - Intervention Site web.	f	75	70	2022-03-07 11:35:07	2022-03-07 11:35:07
7748	Tâche nouvellement créee du nom de Optimisation de la base de données pour améliorer la navigation sur le site par Fanantenana dans le projet CDC - Intervention Site web.	f	75	71	2022-03-07 11:35:07	2022-03-07 11:35:07
7749	Tâche nouvellement créee du nom de Optimisation de la base de données pour améliorer la navigation sur le site par Fanantenana dans le projet CDC - Intervention Site web.	f	75	85	2022-03-07 11:35:07	2022-03-07 11:35:07
7750	Fanantenana vous a assigné à la tâche Optimisation de la base de données pour améliorer la navigation sur le site dans le projet CDC - Intervention Site web.	f	75	75	2022-03-07 11:35:07	2022-03-07 11:35:07
7751	Tâche "Optimisation de la base de données pour améliorer la navigation sur le site"\n          du projet CDC - Intervention Site web mise dans " En cours " par Fanantenana	f	75	53	2022-03-07 11:35:17	2022-03-07 11:35:17
7752	Tâche "Optimisation de la base de données pour améliorer la navigation sur le site"\n          du projet CDC - Intervention Site web mise dans " En cours " par Fanantenana	f	75	57	2022-03-07 11:35:17	2022-03-07 11:35:17
7753	Tâche "Optimisation de la base de données pour améliorer la navigation sur le site"\n          du projet CDC - Intervention Site web mise dans " En cours " par Fanantenana	f	75	70	2022-03-07 11:35:17	2022-03-07 11:35:17
7754	Tâche "Optimisation de la base de données pour améliorer la navigation sur le site"\n          du projet CDC - Intervention Site web mise dans " En cours " par Fanantenana	f	75	71	2022-03-07 11:35:17	2022-03-07 11:35:17
7755	Tâche "Optimisation de la base de données pour améliorer la navigation sur le site"\n          du projet CDC - Intervention Site web mise dans " En cours " par Fanantenana	f	75	85	2022-03-07 11:35:17	2022-03-07 11:35:17
7756	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-07 11:36:12	2022-03-07 11:36:12
7757	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-07 11:36:12	2022-03-07 11:36:12
7758	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-07 11:36:12	2022-03-07 11:36:12
7759	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-07 11:36:12	2022-03-07 11:36:12
7760	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-07 11:36:12	2022-03-07 11:36:12
7761	Tâche nouvellement créee du nom de Sauvegarde manuelle vers Syn.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-03-07 11:37:19	2022-03-07 11:37:19
7762	Tâche nouvellement créee du nom de Sauvegarde manuelle vers Syn.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-03-07 11:37:19	2022-03-07 11:37:19
7763	Tâche nouvellement créee du nom de Sauvegarde manuelle vers Syn.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	70	2022-03-07 11:37:19	2022-03-07 11:37:19
7764	Tâche nouvellement créee du nom de Sauvegarde manuelle vers Syn.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-03-07 11:37:19	2022-03-07 11:37:19
7765	Tâche nouvellement créee du nom de Sauvegarde manuelle vers Syn.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-03-07 11:37:19	2022-03-07 11:37:19
7767	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-03-07 11:37:28	2022-03-07 11:37:28
7768	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-03-07 11:37:28	2022-03-07 11:37:28
7769	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	70	2022-03-07 11:37:28	2022-03-07 11:37:28
7770	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-03-07 11:37:28	2022-03-07 11:37:28
7771	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	85	2022-03-07 11:37:28	2022-03-07 11:37:28
7772	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-03-07 13:15:55	2022-03-07 13:15:55
7773	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-03-07 13:15:55	2022-03-07 13:15:55
7774	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	70	2022-03-07 13:15:55	2022-03-07 13:15:55
7775	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-03-07 13:15:55	2022-03-07 13:15:55
7776	Tâche "Ajustement de stock pour validation BL avec Mme Jeanne"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-03-07 13:15:55	2022-03-07 13:15:55
7777	Tâche "Optimisation de la base de données pour améliorer la navigation sur le site"\n          du projet CDC - Intervention Site web mise dans " En contrôle " par Fanantenana	f	75	53	2022-03-07 13:39:24	2022-03-07 13:39:24
7778	Tâche "Optimisation de la base de données pour améliorer la navigation sur le site"\n          du projet CDC - Intervention Site web mise dans " En contrôle " par Fanantenana	f	75	57	2022-03-07 13:39:24	2022-03-07 13:39:24
7779	Tâche "Optimisation de la base de données pour améliorer la navigation sur le site"\n          du projet CDC - Intervention Site web mise dans " En contrôle " par Fanantenana	f	75	70	2022-03-07 13:39:24	2022-03-07 13:39:24
7780	Tâche "Optimisation de la base de données pour améliorer la navigation sur le site"\n          du projet CDC - Intervention Site web mise dans " En contrôle " par Fanantenana	f	75	71	2022-03-07 13:39:24	2022-03-07 13:39:24
7781	Tâche "Optimisation de la base de données pour améliorer la navigation sur le site"\n          du projet CDC - Intervention Site web mise dans " En contrôle " par Fanantenana	f	75	85	2022-03-07 13:39:24	2022-03-07 13:39:24
7782	La tâche Optimisation de la base de données pour améliorer la navigation sur le site a été achevée.	f	75	53	2022-03-07 13:40:10	2022-03-07 13:40:10
7783	La tâche Optimisation de la base de données pour améliorer la navigation sur le site a été achevée.	f	75	57	2022-03-07 13:40:10	2022-03-07 13:40:10
7784	La tâche Optimisation de la base de données pour améliorer la navigation sur le site a été achevée.	f	75	70	2022-03-07 13:40:10	2022-03-07 13:40:10
7785	La tâche Optimisation de la base de données pour améliorer la navigation sur le site a été achevée.	f	75	71	2022-03-07 13:40:10	2022-03-07 13:40:10
7786	La tâche Optimisation de la base de données pour améliorer la navigation sur le site a été achevée.	f	75	85	2022-03-07 13:40:10	2022-03-07 13:40:10
7787	Tâche nouvellement créee du nom de TEST par Michel dans le projet M-TEC - Mise en place d'un nouveau dossier.	f	71	53	2022-03-07 13:46:15	2022-03-07 13:46:15
7788	Tâche nouvellement créee du nom de TEST par Michel dans le projet M-TEC - Mise en place d'un nouveau dossier.	f	71	57	2022-03-07 13:46:15	2022-03-07 13:46:15
7789	Tâche nouvellement créee du nom de TEST par Michel dans le projet M-TEC - Mise en place d'un nouveau dossier.	f	71	70	2022-03-07 13:46:15	2022-03-07 13:46:15
7790	Tâche nouvellement créee du nom de TEST par Michel dans le projet M-TEC - Mise en place d'un nouveau dossier.	f	71	85	2022-03-07 13:46:15	2022-03-07 13:46:15
7791	Michel vous a assigné à la tâche TEST dans le projet M-TEC - Mise en place d'un nouveau dossier.	f	71	91	2022-03-07 13:46:15	2022-03-07 13:46:15
7792	Tâche nouvellement créee du nom de Modification droit des utilisateurs, Seul ZOHAR et KOULSOUM peuvent supprimer un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-07 13:46:56	2022-03-07 13:46:56
7793	Tâche nouvellement créee du nom de Modification droit des utilisateurs, Seul ZOHAR et KOULSOUM peuvent supprimer un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-07 13:46:56	2022-03-07 13:46:56
7794	Tâche nouvellement créee du nom de Modification droit des utilisateurs, Seul ZOHAR et KOULSOUM peuvent supprimer un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-07 13:46:56	2022-03-07 13:46:56
7795	Tâche nouvellement créee du nom de Modification droit des utilisateurs, Seul ZOHAR et KOULSOUM peuvent supprimer un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-07 13:46:56	2022-03-07 13:46:56
7796	Tâche nouvellement créee du nom de Modification droit des utilisateurs, Seul ZOHAR et KOULSOUM peuvent supprimer un BL par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-07 13:46:56	2022-03-07 13:46:56
7797	Miandrisoa vous a assigné à la tâche Modification droit des utilisateurs, Seul ZOHAR et KOULSOUM peuvent supprimer un BL dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-07 13:46:56	2022-03-07 13:46:56
7798	La tâche Modification droit des utilisateurs, Seul ZOHAR et KOULSOUM peuvent supprimer un BL a été achevée.	f	76	53	2022-03-07 13:47:14	2022-03-07 13:47:14
7799	La tâche Modification droit des utilisateurs, Seul ZOHAR et KOULSOUM peuvent supprimer un BL a été achevée.	f	76	57	2022-03-07 13:47:14	2022-03-07 13:47:14
7800	La tâche Modification droit des utilisateurs, Seul ZOHAR et KOULSOUM peuvent supprimer un BL a été achevée.	f	76	70	2022-03-07 13:47:14	2022-03-07 13:47:14
7801	La tâche Modification droit des utilisateurs, Seul ZOHAR et KOULSOUM peuvent supprimer un BL a été achevée.	f	76	71	2022-03-07 13:47:14	2022-03-07 13:47:14
7802	La tâche Modification droit des utilisateurs, Seul ZOHAR et KOULSOUM peuvent supprimer un BL a été achevée.	f	76	85	2022-03-07 13:47:14	2022-03-07 13:47:14
7803	Tâche nouvellement créee du nom de Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-07 13:48:04	2022-03-07 13:48:04
7804	Tâche nouvellement créee du nom de Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-07 13:48:04	2022-03-07 13:48:04
7805	Tâche nouvellement créee du nom de Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-07 13:48:04	2022-03-07 13:48:04
7806	Tâche nouvellement créee du nom de Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-07 13:48:04	2022-03-07 13:48:04
7807	Tâche nouvellement créee du nom de Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-07 13:48:04	2022-03-07 13:48:04
7808	Miandrisoa vous a assigné à la tâche Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-07 13:48:04	2022-03-07 13:48:04
7809	Tâche nouvellement créee du nom de Contre-inventaire Computek TANA,  par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-07 13:49:11	2022-03-07 13:49:11
7810	Tâche nouvellement créee du nom de Contre-inventaire Computek TANA,  par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-07 13:49:11	2022-03-07 13:49:11
7811	Tâche nouvellement créee du nom de Contre-inventaire Computek TANA,  par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-07 13:49:11	2022-03-07 13:49:11
7812	Tâche nouvellement créee du nom de Contre-inventaire Computek TANA,  par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-07 13:49:11	2022-03-07 13:49:11
7813	Tâche nouvellement créee du nom de Contre-inventaire Computek TANA,  par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-07 13:49:11	2022-03-07 13:49:11
7814	Miandrisoa vous a assigné à la tâche Contre-inventaire Computek TANA,  dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-07 13:49:11	2022-03-07 13:49:11
7815	Tâche "Contre-inventaire Computek TANA, "\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-07 13:49:19	2022-03-07 13:49:19
7816	Tâche "Contre-inventaire Computek TANA, "\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-07 13:49:19	2022-03-07 13:49:19
7820	La tâche Contre-inventaire Computek TANA,  a été achevée.	f	76	53	2022-03-07 13:49:43	2022-03-07 13:49:43
7817	Tâche "Contre-inventaire Computek TANA, "\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-07 13:49:19	2022-03-07 13:49:19
7818	Tâche "Contre-inventaire Computek TANA, "\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-07 13:49:19	2022-03-07 13:49:19
7819	Tâche "Contre-inventaire Computek TANA, "\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-07 13:49:19	2022-03-07 13:49:19
7862	Tâche "Débogage au niveau des filtres du tableau principale"\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	53	2022-03-08 04:38:07	2022-03-08 04:38:07
7863	Tâche "Débogage au niveau des filtres du tableau principale"\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	57	2022-03-08 04:38:07	2022-03-08 04:38:07
7864	Tâche "Débogage au niveau des filtres du tableau principale"\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	70	2022-03-08 04:38:07	2022-03-08 04:38:07
7865	Tâche "Débogage au niveau des filtres du tableau principale"\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	71	2022-03-08 04:38:07	2022-03-08 04:38:07
7866	Tâche "Débogage au niveau des filtres du tableau principale"\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	85	2022-03-08 04:38:07	2022-03-08 04:38:07
7766	Osé vous a assigné à la tâche Sauvegarde manuelle vers Syn.com dans le projet Sauvegarde FTP des clients .	t	74	74	2022-03-07 11:37:19	2022-03-07 11:37:19
7915	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	53	2022-03-08 10:17:23	2022-03-08 10:17:23
7916	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	57	2022-03-08 10:17:23	2022-03-08 10:17:23
7917	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	70	2022-03-08 10:17:23	2022-03-08 10:17:23
7918	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	71	2022-03-08 10:17:23	2022-03-08 10:17:23
7919	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En blocage " par Elie	f	77	85	2022-03-08 10:17:23	2022-03-08 10:17:23
7825	Tâche "Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-07 13:49:55	2022-03-07 13:49:55
7826	Tâche "Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-07 13:49:55	2022-03-07 13:49:55
7827	Tâche "Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-07 13:49:55	2022-03-07 13:49:55
7828	Tâche "Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-07 13:49:55	2022-03-07 13:49:55
7829	Tâche "Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-07 13:49:55	2022-03-07 13:49:55
7830	Tâche nouvellement créee du nom de Modification droit de validation Inventaire par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-07 13:50:36	2022-03-07 13:50:36
7831	Tâche nouvellement créee du nom de Modification droit de validation Inventaire par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-07 13:50:36	2022-03-07 13:50:36
7832	Tâche nouvellement créee du nom de Modification droit de validation Inventaire par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-07 13:50:36	2022-03-07 13:50:36
7833	Tâche nouvellement créee du nom de Modification droit de validation Inventaire par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-07 13:50:36	2022-03-07 13:50:36
7834	Tâche nouvellement créee du nom de Modification droit de validation Inventaire par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-07 13:50:36	2022-03-07 13:50:36
7841	Miandrisoa vous a assigné à la tâche Listes des BL non facturés dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-07 13:50:56	2022-03-07 13:50:56
7877	La tâche Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil a été achevée.	f	76	53	2022-03-08 05:05:26	2022-03-08 05:05:26
7878	La tâche Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil a été achevée.	f	76	57	2022-03-08 05:05:26	2022-03-08 05:05:26
7879	La tâche Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil a été achevée.	f	76	70	2022-03-08 05:05:26	2022-03-08 05:05:26
7880	La tâche Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil a été achevée.	f	76	71	2022-03-08 05:05:26	2022-03-08 05:05:26
7881	La tâche Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil a été achevée.	f	76	85	2022-03-08 05:05:26	2022-03-08 05:05:26
7892	Osé vous a assigné à la tâche Sauvegarde manuelle backup EBP vers Sync.com dans le projet Sauvegarde FTP des clients .	t	74	74	2022-03-08 06:09:30	2022-03-08 06:09:30
7835	Miandrisoa vous a assigné à la tâche Modification droit de validation Inventaire dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-07 13:50:36	2022-03-07 13:50:36
7842	Tâche "Listes des BL non facturés"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-07 13:51:03	2022-03-07 13:51:03
7843	Tâche "Listes des BL non facturés"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-07 13:51:03	2022-03-07 13:51:03
7844	Tâche "Listes des BL non facturés"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-07 13:51:03	2022-03-07 13:51:03
7845	Tâche "Listes des BL non facturés"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-07 13:51:03	2022-03-07 13:51:03
7846	Tâche "Listes des BL non facturés"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-07 13:51:03	2022-03-07 13:51:03
7836	Tâche nouvellement créee du nom de Listes des BL non facturés par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-07 13:50:56	2022-03-07 13:50:56
7837	Tâche nouvellement créee du nom de Listes des BL non facturés par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-07 13:50:56	2022-03-07 13:50:56
7838	Tâche nouvellement créee du nom de Listes des BL non facturés par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-07 13:50:56	2022-03-07 13:50:56
7839	Tâche nouvellement créee du nom de Listes des BL non facturés par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-07 13:50:56	2022-03-07 13:50:56
7840	Tâche nouvellement créee du nom de Listes des BL non facturés par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-07 13:50:56	2022-03-07 13:50:56
7022	Nasolo vous a assigné à la tâche Module de gestion d'avance salariale Odoo dans le projet QLM Intervention / Accompagnement 2022.	t	72	72	2022-02-28 12:15:37	2022-02-28 12:15:37
7903	Nasolo vous a assigné à la tâche configuration de la base de données SQL Server EDR dans le projet EDR - Application Web Réappro.	f	72	72	2022-03-08 08:37:06	2022-03-08 08:37:06
7904	Tâche "configuration de la base de données SQL Server EDR"\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	53	2022-03-08 08:37:13	2022-03-08 08:37:13
7905	Tâche "configuration de la base de données SQL Server EDR"\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	57	2022-03-08 08:37:13	2022-03-08 08:37:13
7906	Tâche "configuration de la base de données SQL Server EDR"\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	70	2022-03-08 08:37:13	2022-03-08 08:37:13
7907	Tâche "configuration de la base de données SQL Server EDR"\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	71	2022-03-08 08:37:13	2022-03-08 08:37:13
7908	Tâche "configuration de la base de données SQL Server EDR"\n          du projet EDR - Application Web Réappro mise dans " En cours " par Nasolo	f	72	85	2022-03-08 08:37:13	2022-03-08 08:37:13
7909	Tâche nouvellement créee du nom de STC Hasina .R Cheinmalt (salaire, solde de congé, préavis) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-08 10:16:30	2022-03-08 10:16:30
7910	Tâche nouvellement créee du nom de STC Hasina .R Cheinmalt (salaire, solde de congé, préavis) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-08 10:16:30	2022-03-08 10:16:30
7911	Tâche nouvellement créee du nom de STC Hasina .R Cheinmalt (salaire, solde de congé, préavis) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-08 10:16:30	2022-03-08 10:16:30
7912	Tâche nouvellement créee du nom de STC Hasina .R Cheinmalt (salaire, solde de congé, préavis) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-08 10:16:30	2022-03-08 10:16:30
7913	Tâche nouvellement créee du nom de STC Hasina .R Cheinmalt (salaire, solde de congé, préavis) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-08 10:16:30	2022-03-08 10:16:30
7857	La tâche Ajustement de stock pour validation BL avec Mme Jeanne a été achevée.	f	77	53	2022-03-07 14:54:11	2022-03-07 14:54:11
7858	La tâche Ajustement de stock pour validation BL avec Mme Jeanne a été achevée.	f	77	57	2022-03-07 14:54:11	2022-03-07 14:54:11
7859	La tâche Ajustement de stock pour validation BL avec Mme Jeanne a été achevée.	f	77	70	2022-03-07 14:54:11	2022-03-07 14:54:11
7860	La tâche Ajustement de stock pour validation BL avec Mme Jeanne a été achevée.	f	77	71	2022-03-07 14:54:11	2022-03-07 14:54:11
7861	La tâche Ajustement de stock pour validation BL avec Mme Jeanne a été achevée.	f	77	85	2022-03-07 14:54:11	2022-03-07 14:54:11
7893	Tâche "Sauvegarde manuelle backup EBP vers Sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-03-08 06:09:45	2022-03-08 06:09:45
7894	Tâche "Sauvegarde manuelle backup EBP vers Sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-03-08 06:09:45	2022-03-08 06:09:45
7895	Tâche "Sauvegarde manuelle backup EBP vers Sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	70	2022-03-08 06:09:45	2022-03-08 06:09:45
7896	Tâche "Sauvegarde manuelle backup EBP vers Sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-03-08 06:09:45	2022-03-08 06:09:45
7897	Tâche "Sauvegarde manuelle backup EBP vers Sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	85	2022-03-08 06:09:45	2022-03-08 06:09:45
7867	La tâche Paramétrage sur les fiches Clients a été achevée.	f	76	53	2022-03-08 04:43:39	2022-03-08 04:43:39
7868	La tâche Paramétrage sur les fiches Clients a été achevée.	f	76	57	2022-03-08 04:43:39	2022-03-08 04:43:39
7869	La tâche Paramétrage sur les fiches Clients a été achevée.	f	76	70	2022-03-08 04:43:39	2022-03-08 04:43:39
7870	La tâche Paramétrage sur les fiches Clients a été achevée.	f	76	71	2022-03-08 04:43:39	2022-03-08 04:43:39
7871	La tâche Paramétrage sur les fiches Clients a été achevée.	f	76	85	2022-03-08 04:43:39	2022-03-08 04:43:39
7872	La tâche Liste des articles sans code barre a été achevée.	f	76	53	2022-03-08 04:47:59	2022-03-08 04:47:59
7873	La tâche Liste des articles sans code barre a été achevée.	f	76	57	2022-03-08 04:47:59	2022-03-08 04:47:59
7874	La tâche Liste des articles sans code barre a été achevée.	f	76	70	2022-03-08 04:47:59	2022-03-08 04:47:59
7875	La tâche Liste des articles sans code barre a été achevée.	f	76	71	2022-03-08 04:47:59	2022-03-08 04:47:59
7876	La tâche Liste des articles sans code barre a été achevée.	f	76	85	2022-03-08 04:47:59	2022-03-08 04:47:59
7882	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-08 06:03:47	2022-03-08 06:03:47
7883	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-08 06:03:47	2022-03-08 06:03:47
7884	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-08 06:03:47	2022-03-08 06:03:47
7885	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-08 06:03:47	2022-03-08 06:03:47
7886	Tâche "Sauvegarde manuelle vers Syn.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-08 06:03:47	2022-03-08 06:03:47
7887	Tâche nouvellement créee du nom de Sauvegarde manuelle backup EBP vers Sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-03-08 06:09:30	2022-03-08 06:09:30
7888	Tâche nouvellement créee du nom de Sauvegarde manuelle backup EBP vers Sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-03-08 06:09:30	2022-03-08 06:09:30
7889	Tâche nouvellement créee du nom de Sauvegarde manuelle backup EBP vers Sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	70	2022-03-08 06:09:30	2022-03-08 06:09:30
7890	Tâche nouvellement créee du nom de Sauvegarde manuelle backup EBP vers Sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-03-08 06:09:30	2022-03-08 06:09:30
7891	Tâche nouvellement créee du nom de Sauvegarde manuelle backup EBP vers Sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-03-08 06:09:30	2022-03-08 06:09:30
7899	Tâche nouvellement créee du nom de configuration de la base de données SQL Server EDR par Nasolo dans le projet EDR - Application Web Réappro.	f	72	57	2022-03-08 08:37:06	2022-03-08 08:37:06
7900	Tâche nouvellement créee du nom de configuration de la base de données SQL Server EDR par Nasolo dans le projet EDR - Application Web Réappro.	f	72	70	2022-03-08 08:37:06	2022-03-08 08:37:06
7901	Tâche nouvellement créee du nom de configuration de la base de données SQL Server EDR par Nasolo dans le projet EDR - Application Web Réappro.	f	72	71	2022-03-08 08:37:06	2022-03-08 08:37:06
7902	Tâche nouvellement créee du nom de configuration de la base de données SQL Server EDR par Nasolo dans le projet EDR - Application Web Réappro.	f	72	85	2022-03-08 08:37:06	2022-03-08 08:37:06
7914	Elie vous a assigné à la tâche STC Hasina .R Cheinmalt (salaire, solde de congé, préavis) dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-08 10:16:30	2022-03-08 10:16:30
7920	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-03-08 10:17:30	2022-03-08 10:17:30
7921	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-03-08 10:17:30	2022-03-08 10:17:30
7922	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	70	2022-03-08 10:17:30	2022-03-08 10:17:30
7923	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-03-08 10:17:30	2022-03-08 10:17:30
7924	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-03-08 10:17:30	2022-03-08 10:17:30
7925	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	53	2022-03-08 12:40:22	2022-03-08 12:40:22
7926	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	57	2022-03-08 12:40:22	2022-03-08 12:40:22
7927	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	70	2022-03-08 12:40:22	2022-03-08 12:40:22
7928	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	71	2022-03-08 12:40:22	2022-03-08 12:40:22
7929	Tâche "STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En contrôle " par Elie	f	77	85	2022-03-08 12:40:22	2022-03-08 12:40:22
7930	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL demande de Mme Jeanne par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-08 13:33:44	2022-03-08 13:33:44
7931	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL demande de Mme Jeanne par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-08 13:33:44	2022-03-08 13:33:44
7932	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL demande de Mme Jeanne par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-08 13:33:44	2022-03-08 13:33:44
7933	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL demande de Mme Jeanne par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-08 13:33:44	2022-03-08 13:33:44
7934	Tâche nouvellement créee du nom de Ajustement de stock pour validation BL demande de Mme Jeanne par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-08 13:33:44	2022-03-08 13:33:44
7935	Elie vous a assigné à la tâche Ajustement de stock pour validation BL demande de Mme Jeanne dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-08 13:33:44	2022-03-08 13:33:44
7936	La tâche Ajustement de stock pour validation BL demande de Mme Jeanne a été achevée.	f	77	53	2022-03-08 13:33:49	2022-03-08 13:33:49
7937	La tâche Ajustement de stock pour validation BL demande de Mme Jeanne a été achevée.	f	77	57	2022-03-08 13:33:49	2022-03-08 13:33:49
7938	La tâche Ajustement de stock pour validation BL demande de Mme Jeanne a été achevée.	f	77	70	2022-03-08 13:33:49	2022-03-08 13:33:49
7939	La tâche Ajustement de stock pour validation BL demande de Mme Jeanne a été achevée.	f	77	71	2022-03-08 13:33:49	2022-03-08 13:33:49
7940	La tâche Ajustement de stock pour validation BL demande de Mme Jeanne a été achevée.	f	77	85	2022-03-08 13:33:49	2022-03-08 13:33:49
7941	La tâche STC Hasina .R Cheinmalt (salaire, solde de congé, préavis) a été achevée.	f	77	53	2022-03-08 13:33:57	2022-03-08 13:33:57
7942	La tâche STC Hasina .R Cheinmalt (salaire, solde de congé, préavis) a été achevée.	f	77	57	2022-03-08 13:33:57	2022-03-08 13:33:57
7943	La tâche STC Hasina .R Cheinmalt (salaire, solde de congé, préavis) a été achevée.	f	77	70	2022-03-08 13:33:57	2022-03-08 13:33:57
7944	La tâche STC Hasina .R Cheinmalt (salaire, solde de congé, préavis) a été achevée.	f	77	71	2022-03-08 13:33:57	2022-03-08 13:33:57
7945	La tâche STC Hasina .R Cheinmalt (salaire, solde de congé, préavis) a été achevée.	f	77	85	2022-03-08 13:33:57	2022-03-08 13:33:57
7946	Tâche "Modification droit de validation Inventaire"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-08 13:41:23	2022-03-08 13:41:23
7947	Tâche "Modification droit de validation Inventaire"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-08 13:41:23	2022-03-08 13:41:23
7948	Tâche "Modification droit de validation Inventaire"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-08 13:41:23	2022-03-08 13:41:23
7949	Tâche "Modification droit de validation Inventaire"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-08 13:41:23	2022-03-08 13:41:23
7950	Tâche "Modification droit de validation Inventaire"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-08 13:41:23	2022-03-08 13:41:23
7951	La tâche Modification droit de validation Inventaire a été achevée.	f	76	53	2022-03-08 13:41:38	2022-03-08 13:41:38
7952	La tâche Modification droit de validation Inventaire a été achevée.	f	76	57	2022-03-08 13:41:38	2022-03-08 13:41:38
7953	La tâche Modification droit de validation Inventaire a été achevée.	f	76	70	2022-03-08 13:41:38	2022-03-08 13:41:38
7954	La tâche Modification droit de validation Inventaire a été achevée.	f	76	71	2022-03-08 13:41:38	2022-03-08 13:41:38
7955	La tâche Modification droit de validation Inventaire a été achevée.	f	76	85	2022-03-08 13:41:38	2022-03-08 13:41:38
7956	Tâche "Sauvegarde manuelle backup EBP vers Sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-09 09:00:04	2022-03-09 09:00:04
7957	Tâche "Sauvegarde manuelle backup EBP vers Sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-09 09:00:04	2022-03-09 09:00:04
7958	Tâche "Sauvegarde manuelle backup EBP vers Sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-09 09:00:04	2022-03-09 09:00:04
7959	Tâche "Sauvegarde manuelle backup EBP vers Sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-09 09:00:04	2022-03-09 09:00:04
7960	Tâche "Sauvegarde manuelle backup EBP vers Sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-09 09:00:04	2022-03-09 09:00:04
7967	Tâche "Sauvegarde manuelle depuis 37 vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-03-09 09:01:09	2022-03-09 09:01:09
7968	Tâche "Sauvegarde manuelle depuis 37 vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-03-09 09:01:09	2022-03-09 09:01:09
7969	Tâche "Sauvegarde manuelle depuis 37 vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	70	2022-03-09 09:01:09	2022-03-09 09:01:09
7970	Tâche "Sauvegarde manuelle depuis 37 vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-03-09 09:01:09	2022-03-09 09:01:09
7971	Tâche "Sauvegarde manuelle depuis 37 vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	85	2022-03-09 09:01:09	2022-03-09 09:01:09
7982	Tâche nouvellement créee du nom de Inventaire Computek TANA, date date du document 28/02/2022 par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-09 12:21:15	2022-03-09 12:21:15
7983	Tâche nouvellement créee du nom de Inventaire Computek TANA, date date du document 28/02/2022 par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-09 12:21:15	2022-03-09 12:21:15
7984	Tâche nouvellement créee du nom de Inventaire Computek TANA, date date du document 28/02/2022 par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-09 12:21:15	2022-03-09 12:21:15
7985	Tâche nouvellement créee du nom de Inventaire Computek TANA, date date du document 28/02/2022 par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-09 12:21:15	2022-03-09 12:21:15
7986	Tâche nouvellement créee du nom de Inventaire Computek TANA, date date du document 28/02/2022 par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-09 12:21:15	2022-03-09 12:21:15
8003	Tâche nouvellement créee du nom de Mise en page des catégories sur le menu gauche du site par Fanantenana dans le projet Synchro du site Computek.	f	75	53	2022-03-09 13:35:41	2022-03-09 13:35:41
8004	Tâche nouvellement créee du nom de Mise en page des catégories sur le menu gauche du site par Fanantenana dans le projet Synchro du site Computek.	f	75	57	2022-03-09 13:35:41	2022-03-09 13:35:41
8005	Tâche nouvellement créee du nom de Mise en page des catégories sur le menu gauche du site par Fanantenana dans le projet Synchro du site Computek.	f	75	70	2022-03-09 13:35:41	2022-03-09 13:35:41
8006	Tâche nouvellement créee du nom de Mise en page des catégories sur le menu gauche du site par Fanantenana dans le projet Synchro du site Computek.	f	75	71	2022-03-09 13:35:41	2022-03-09 13:35:41
8007	Tâche nouvellement créee du nom de Mise en page des catégories sur le menu gauche du site par Fanantenana dans le projet Synchro du site Computek.	f	75	85	2022-03-09 13:35:41	2022-03-09 13:35:41
7961	Tâche nouvellement créee du nom de Sauvegarde manuelle depuis 37 vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-03-09 09:00:40	2022-03-09 09:00:40
7962	Tâche nouvellement créee du nom de Sauvegarde manuelle depuis 37 vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-03-09 09:00:40	2022-03-09 09:00:40
7963	Tâche nouvellement créee du nom de Sauvegarde manuelle depuis 37 vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	70	2022-03-09 09:00:40	2022-03-09 09:00:40
7964	Tâche nouvellement créee du nom de Sauvegarde manuelle depuis 37 vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-03-09 09:00:40	2022-03-09 09:00:40
7965	Tâche nouvellement créee du nom de Sauvegarde manuelle depuis 37 vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-03-09 09:00:40	2022-03-09 09:00:40
7972	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-03-09 12:13:12	2022-03-09 12:13:12
7973	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-03-09 12:13:12	2022-03-09 12:13:12
7974	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	70	2022-03-09 12:13:12	2022-03-09 12:13:12
7975	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-03-09 12:13:12	2022-03-09 12:13:12
7976	Tâche "Mise à jour des familles"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-03-09 12:13:12	2022-03-09 12:13:12
7966	Osé vous a assigné à la tâche Sauvegarde manuelle depuis 37 vers sync.com dans le projet Sauvegarde FTP des clients .	f	74	74	2022-03-09 09:00:40	2022-03-09 09:00:40
7977	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	53	2022-03-09 12:13:22	2022-03-09 12:13:22
7978	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	57	2022-03-09 12:13:22	2022-03-09 12:13:22
7979	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	70	2022-03-09 12:13:22	2022-03-09 12:13:22
7980	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	71	2022-03-09 12:13:22	2022-03-09 12:13:22
7981	Tâche "Mise à jour tarifs"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En contrôle " par Miandrisoa	f	76	85	2022-03-09 12:13:22	2022-03-09 12:13:22
7987	Miandrisoa vous a assigné à la tâche Inventaire Computek TANA, date date du document 28/02/2022 dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-09 12:21:15	2022-03-09 12:21:15
7988	Tâche "Inventaire Computek TANA, date date du document 28/02/2022"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-09 12:21:19	2022-03-09 12:21:19
7989	Tâche "Inventaire Computek TANA, date date du document 28/02/2022"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-09 12:21:19	2022-03-09 12:21:19
7990	Tâche "Inventaire Computek TANA, date date du document 28/02/2022"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-09 12:21:19	2022-03-09 12:21:19
7991	Tâche "Inventaire Computek TANA, date date du document 28/02/2022"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-09 12:21:19	2022-03-09 12:21:19
7992	Tâche "Inventaire Computek TANA, date date du document 28/02/2022"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-09 12:21:19	2022-03-09 12:21:19
7998	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	53	2022-03-09 13:31:55	2022-03-09 13:31:55
7999	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	57	2022-03-09 13:31:55	2022-03-09 13:31:55
8000	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	70	2022-03-09 13:31:55	2022-03-09 13:31:55
8001	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	71	2022-03-09 13:31:55	2022-03-09 13:31:55
8002	Tâche "Backup Site web/base de données et mise  en place WPAllimport"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	85	2022-03-09 13:31:55	2022-03-09 13:31:55
8008	Fanantenana vous a assigné à la tâche Mise en page des catégories sur le menu gauche du site dans le projet Synchro du site Computek.	f	75	75	2022-03-09 13:35:41	2022-03-09 13:35:41
7993	La tâche Inventaire Computek TANA, date date du document 28/02/2022 a été achevée.	f	76	53	2022-03-09 12:22:04	2022-03-09 12:22:04
7994	La tâche Inventaire Computek TANA, date date du document 28/02/2022 a été achevée.	f	76	57	2022-03-09 12:22:04	2022-03-09 12:22:04
7995	La tâche Inventaire Computek TANA, date date du document 28/02/2022 a été achevée.	f	76	70	2022-03-09 12:22:04	2022-03-09 12:22:04
7996	La tâche Inventaire Computek TANA, date date du document 28/02/2022 a été achevée.	f	76	71	2022-03-09 12:22:04	2022-03-09 12:22:04
7997	La tâche Inventaire Computek TANA, date date du document 28/02/2022 a été achevée.	f	76	85	2022-03-09 12:22:04	2022-03-09 12:22:04
8009	Tâche "Mise en page des catégories sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	53	2022-03-09 13:35:56	2022-03-09 13:35:56
8010	Tâche "Mise en page des catégories sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	57	2022-03-09 13:35:56	2022-03-09 13:35:56
8011	Tâche "Mise en page des catégories sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	70	2022-03-09 13:35:56	2022-03-09 13:35:56
8012	Tâche "Mise en page des catégories sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	71	2022-03-09 13:35:56	2022-03-09 13:35:56
8013	Tâche "Mise en page des catégories sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En cours " par Fanantenana	f	75	85	2022-03-09 13:35:56	2022-03-09 13:35:56
8014	Tâche "•\tPouvoir mettre une virgule dans Tâche > Durée estimée"\n          du projet Correction/Amélioration de l'application Project Monitoring MGBI mise dans " En cours " par Matthieu	f	81	53	2022-03-14 11:54:55	2022-03-14 11:54:55
8015	Tâche "•\tPouvoir mettre une virgule dans Tâche > Durée estimée"\n          du projet Correction/Amélioration de l'application Project Monitoring MGBI mise dans " En cours " par Matthieu	f	81	57	2022-03-14 11:54:55	2022-03-14 11:54:55
8016	Tâche "•\tPouvoir mettre une virgule dans Tâche > Durée estimée"\n          du projet Correction/Amélioration de l'application Project Monitoring MGBI mise dans " En cours " par Matthieu	f	81	70	2022-03-14 11:54:55	2022-03-14 11:54:55
8017	Tâche "•\tPouvoir mettre une virgule dans Tâche > Durée estimée"\n          du projet Correction/Amélioration de l'application Project Monitoring MGBI mise dans " En cours " par Matthieu	f	81	71	2022-03-14 11:54:55	2022-03-14 11:54:55
8018	Tâche "•\tPouvoir mettre une virgule dans Tâche > Durée estimée"\n          du projet Correction/Amélioration de l'application Project Monitoring MGBI mise dans " En cours " par Matthieu	f	81	85	2022-03-14 11:54:55	2022-03-14 11:54:55
8019	Tâche "•\tPouvoir mettre une virgule dans Tâche > Durée estimée"\n          du projet Correction/Amélioration de l'application Project Monitoring MGBI mise dans " A faire " par Matthieu	f	81	53	2022-03-14 12:00:12	2022-03-14 12:00:12
8020	Tâche "•\tPouvoir mettre une virgule dans Tâche > Durée estimée"\n          du projet Correction/Amélioration de l'application Project Monitoring MGBI mise dans " A faire " par Matthieu	f	81	57	2022-03-14 12:00:12	2022-03-14 12:00:12
8021	Tâche "•\tPouvoir mettre une virgule dans Tâche > Durée estimée"\n          du projet Correction/Amélioration de l'application Project Monitoring MGBI mise dans " A faire " par Matthieu	f	81	70	2022-03-14 12:00:12	2022-03-14 12:00:12
8022	Tâche "•\tPouvoir mettre une virgule dans Tâche > Durée estimée"\n          du projet Correction/Amélioration de l'application Project Monitoring MGBI mise dans " A faire " par Matthieu	f	81	71	2022-03-14 12:00:12	2022-03-14 12:00:12
8023	Tâche "•\tPouvoir mettre une virgule dans Tâche > Durée estimée"\n          du projet Correction/Amélioration de l'application Project Monitoring MGBI mise dans " A faire " par Matthieu	f	81	85	2022-03-14 12:00:12	2022-03-14 12:00:12
8024	Tâche nouvellement créee du nom de Validation BL, demande par Mme Jeanne du 14/03/22 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-16 06:28:24	2022-03-16 06:28:24
8025	Tâche nouvellement créee du nom de Validation BL, demande par Mme Jeanne du 14/03/22 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-16 06:28:24	2022-03-16 06:28:24
8026	Tâche nouvellement créee du nom de Validation BL, demande par Mme Jeanne du 14/03/22 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-16 06:28:24	2022-03-16 06:28:24
8027	Tâche nouvellement créee du nom de Validation BL, demande par Mme Jeanne du 14/03/22 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-16 06:28:24	2022-03-16 06:28:24
8028	Tâche nouvellement créee du nom de Validation BL, demande par Mme Jeanne du 14/03/22 par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-16 06:28:24	2022-03-16 06:28:24
8029	Elie vous a assigné à la tâche Validation BL, demande par Mme Jeanne du 14/03/22 dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-16 06:28:24	2022-03-16 06:28:24
8030	La tâche Validation BL, demande par Mme Jeanne du 14/03/22 a été achevée.	f	77	53	2022-03-16 06:28:32	2022-03-16 06:28:32
8031	La tâche Validation BL, demande par Mme Jeanne du 14/03/22 a été achevée.	f	77	57	2022-03-16 06:28:32	2022-03-16 06:28:32
8032	La tâche Validation BL, demande par Mme Jeanne du 14/03/22 a été achevée.	f	77	70	2022-03-16 06:28:32	2022-03-16 06:28:32
8033	La tâche Validation BL, demande par Mme Jeanne du 14/03/22 a été achevée.	f	77	71	2022-03-16 06:28:32	2022-03-16 06:28:32
8034	La tâche Validation BL, demande par Mme Jeanne du 14/03/22 a été achevée.	f	77	85	2022-03-16 06:28:32	2022-03-16 06:28:32
8035	Tâche nouvellement créee du nom de Mise en place Stock du PO26731 fichier INGCO 18H par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-16 06:29:32	2022-03-16 06:29:32
8036	Tâche nouvellement créee du nom de Mise en place Stock du PO26731 fichier INGCO 18H par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-16 06:29:32	2022-03-16 06:29:32
8037	Tâche nouvellement créee du nom de Mise en place Stock du PO26731 fichier INGCO 18H par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-16 06:29:32	2022-03-16 06:29:32
8038	Tâche nouvellement créee du nom de Mise en place Stock du PO26731 fichier INGCO 18H par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-16 06:29:32	2022-03-16 06:29:32
8039	Tâche nouvellement créee du nom de Mise en place Stock du PO26731 fichier INGCO 18H par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-16 06:29:32	2022-03-16 06:29:32
8040	Elie vous a assigné à la tâche Mise en place Stock du PO26731 fichier INGCO 18H dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-16 06:29:32	2022-03-16 06:29:32
8041	La tâche Mise en place Stock du PO26731 fichier INGCO 18H a été achevée.	f	77	53	2022-03-16 06:29:40	2022-03-16 06:29:40
8042	La tâche Mise en place Stock du PO26731 fichier INGCO 18H a été achevée.	f	77	57	2022-03-16 06:29:40	2022-03-16 06:29:40
8043	La tâche Mise en place Stock du PO26731 fichier INGCO 18H a été achevée.	f	77	70	2022-03-16 06:29:40	2022-03-16 06:29:40
8044	La tâche Mise en place Stock du PO26731 fichier INGCO 18H a été achevée.	f	77	71	2022-03-16 06:29:40	2022-03-16 06:29:40
8045	La tâche Mise en place Stock du PO26731 fichier INGCO 18H a été achevée.	f	77	85	2022-03-16 06:29:40	2022-03-16 06:29:40
8196	Elie vous a assigné à la tâche Ajustement de stock, demande de Mme Jeanne par Whatsapp dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-17 14:58:07	2022-03-17 14:58:07
8046	Tâche nouvellement créee du nom de Préparation fichier d'import famille articles Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-16 06:31:23	2022-03-16 06:31:23
8047	Tâche nouvellement créee du nom de Préparation fichier d'import famille articles Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-16 06:31:23	2022-03-16 06:31:23
8048	Tâche nouvellement créee du nom de Préparation fichier d'import famille articles Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-16 06:31:23	2022-03-16 06:31:23
8049	Tâche nouvellement créee du nom de Préparation fichier d'import famille articles Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-16 06:31:23	2022-03-16 06:31:23
8050	Tâche nouvellement créee du nom de Préparation fichier d'import famille articles Cheinmalt par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-16 06:31:23	2022-03-16 06:31:23
8051	Elie vous a assigné à la tâche Préparation fichier d'import famille articles Cheinmalt dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-16 06:31:23	2022-03-16 06:31:23
8104	Fanantenana vous a assigné à la tâche Mise en place de WP All Export(commandes et utilisateurs) sur le site computek  dans le projet Synchro du site Computek.	f	75	75	2022-03-16 13:16:43	2022-03-16 13:16:43
8120	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-03-17 13:55:46	2022-03-17 13:55:46
8121	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-03-17 13:55:46	2022-03-17 13:55:46
8122	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	70	2022-03-17 13:55:46	2022-03-17 13:55:46
8123	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-03-17 13:55:46	2022-03-17 13:55:46
8124	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-03-17 13:55:46	2022-03-17 13:55:46
8163	Osé vous a assigné à la tâche Sauvegarde des backups vers 37 puis vers sync.com dans le projet Sauvegarde FTP des clients .	f	74	74	2022-03-17 14:00:29	2022-03-17 14:00:29
8180	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-03-17 14:07:02	2022-03-17 14:07:02
8181	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-03-17 14:07:02	2022-03-17 14:07:02
8182	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	70	2022-03-17 14:07:02	2022-03-17 14:07:02
8183	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-03-17 14:07:02	2022-03-17 14:07:02
8184	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-03-17 14:07:02	2022-03-17 14:07:02
8052	Tâche "Préparation fichier d'import famille articles Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	53	2022-03-16 06:31:36	2022-03-16 06:31:36
8053	Tâche "Préparation fichier d'import famille articles Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	57	2022-03-16 06:31:36	2022-03-16 06:31:36
8054	Tâche "Préparation fichier d'import famille articles Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	70	2022-03-16 06:31:36	2022-03-16 06:31:36
8055	Tâche "Préparation fichier d'import famille articles Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	71	2022-03-16 06:31:36	2022-03-16 06:31:36
8056	Tâche "Préparation fichier d'import famille articles Cheinmalt"\n          du projet QLM Intervention / Accompagnement 2022 mise dans " En cours " par Elie	f	77	85	2022-03-16 06:31:36	2022-03-16 06:31:36
8110	La tâche Modèle d'impression FACTURE D'ACOMPTE a été achevée.	f	76	53	2022-03-16 13:45:43	2022-03-16 13:45:43
8111	La tâche Modèle d'impression FACTURE D'ACOMPTE a été achevée.	f	76	57	2022-03-16 13:45:43	2022-03-16 13:45:43
8112	La tâche Modèle d'impression FACTURE D'ACOMPTE a été achevée.	f	76	70	2022-03-16 13:45:43	2022-03-16 13:45:43
8113	La tâche Modèle d'impression FACTURE D'ACOMPTE a été achevée.	f	76	71	2022-03-16 13:45:43	2022-03-16 13:45:43
8114	La tâche Modèle d'impression FACTURE D'ACOMPTE a été achevée.	f	76	85	2022-03-16 13:45:43	2022-03-16 13:45:43
8131	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-17 13:57:15	2022-03-17 13:57:15
8132	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-17 13:57:15	2022-03-17 13:57:15
8133	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-17 13:57:15	2022-03-17 13:57:15
8134	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-17 13:57:15	2022-03-17 13:57:15
8135	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-17 13:57:15	2022-03-17 13:57:15
8169	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-03-17 14:01:15	2022-03-17 14:01:15
8170	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-03-17 14:01:15	2022-03-17 14:01:15
8171	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	70	2022-03-17 14:01:15	2022-03-17 14:01:15
8172	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-03-17 14:01:15	2022-03-17 14:01:15
8173	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-03-17 14:01:15	2022-03-17 14:01:15
8197	La tâche Ajustement de stock, demande de Mme Jeanne par Whatsapp a été achevée.	f	77	53	2022-03-17 14:58:20	2022-03-17 14:58:20
8198	La tâche Ajustement de stock, demande de Mme Jeanne par Whatsapp a été achevée.	f	77	57	2022-03-17 14:58:20	2022-03-17 14:58:20
8199	La tâche Ajustement de stock, demande de Mme Jeanne par Whatsapp a été achevée.	f	77	70	2022-03-17 14:58:20	2022-03-17 14:58:20
8200	La tâche Ajustement de stock, demande de Mme Jeanne par Whatsapp a été achevée.	f	77	71	2022-03-17 14:58:20	2022-03-17 14:58:20
8201	La tâche Ajustement de stock, demande de Mme Jeanne par Whatsapp a été achevée.	f	77	85	2022-03-17 14:58:20	2022-03-17 14:58:20
8202	Tâche nouvellement créee du nom de Intégration stock dépôt 3, demande de Mme Jeanne (Chein/INT/03214) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-17 15:01:15	2022-03-17 15:01:15
8203	Tâche nouvellement créee du nom de Intégration stock dépôt 3, demande de Mme Jeanne (Chein/INT/03214) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-17 15:01:15	2022-03-17 15:01:15
8204	Tâche nouvellement créee du nom de Intégration stock dépôt 3, demande de Mme Jeanne (Chein/INT/03214) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-17 15:01:15	2022-03-17 15:01:15
8205	Tâche nouvellement créee du nom de Intégration stock dépôt 3, demande de Mme Jeanne (Chein/INT/03214) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-17 15:01:15	2022-03-17 15:01:15
8206	Tâche nouvellement créee du nom de Intégration stock dépôt 3, demande de Mme Jeanne (Chein/INT/03214) par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-17 15:01:15	2022-03-17 15:01:15
8057	Tâche nouvellement créee du nom de Création utilisateur HAJA de l'équipe de TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-16 07:56:36	2022-03-16 07:56:36
8058	Tâche nouvellement créee du nom de Création utilisateur HAJA de l'équipe de TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-16 07:56:36	2022-03-16 07:56:36
8059	Tâche nouvellement créee du nom de Création utilisateur HAJA de l'équipe de TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-16 07:56:36	2022-03-16 07:56:36
8060	Tâche nouvellement créee du nom de Création utilisateur HAJA de l'équipe de TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-16 07:56:36	2022-03-16 07:56:36
8061	Tâche nouvellement créee du nom de Création utilisateur HAJA de l'équipe de TANA par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-16 07:56:36	2022-03-16 07:56:36
8062	Miandrisoa vous a assigné à la tâche Création utilisateur HAJA de l'équipe de TANA dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-16 07:56:36	2022-03-16 07:56:36
8063	Tâche "Création utilisateur HAJA de l'équipe de TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-16 07:56:42	2022-03-16 07:56:42
8064	Tâche "Création utilisateur HAJA de l'équipe de TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-16 07:56:42	2022-03-16 07:56:42
8065	Tâche "Création utilisateur HAJA de l'équipe de TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-16 07:56:42	2022-03-16 07:56:42
8066	Tâche "Création utilisateur HAJA de l'équipe de TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-16 07:56:42	2022-03-16 07:56:42
8067	Tâche "Création utilisateur HAJA de l'équipe de TANA"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-16 07:56:42	2022-03-16 07:56:42
8068	Tâche nouvellement créee du nom de Modèle d'impression FACTURE D'ACOMPTE par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	53	2022-03-16 07:57:31	2022-03-16 07:57:31
8069	Tâche nouvellement créee du nom de Modèle d'impression FACTURE D'ACOMPTE par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	57	2022-03-16 07:57:31	2022-03-16 07:57:31
8070	Tâche nouvellement créee du nom de Modèle d'impression FACTURE D'ACOMPTE par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	70	2022-03-16 07:57:31	2022-03-16 07:57:31
8071	Tâche nouvellement créee du nom de Modèle d'impression FACTURE D'ACOMPTE par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	71	2022-03-16 07:57:31	2022-03-16 07:57:31
8072	Tâche nouvellement créee du nom de Modèle d'impression FACTURE D'ACOMPTE par Miandrisoa dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	85	2022-03-16 07:57:31	2022-03-16 07:57:31
8073	Miandrisoa vous a assigné à la tâche Modèle d'impression FACTURE D'ACOMPTE dans le projet COMPUTEK - Intervention / Accompagnement 2022.	f	76	76	2022-03-16 07:57:31	2022-03-16 07:57:31
8074	Tâche "Modèle d'impression FACTURE D'ACOMPTE"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	53	2022-03-16 07:57:35	2022-03-16 07:57:35
8075	Tâche "Modèle d'impression FACTURE D'ACOMPTE"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	57	2022-03-16 07:57:35	2022-03-16 07:57:35
8076	Tâche "Modèle d'impression FACTURE D'ACOMPTE"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	70	2022-03-16 07:57:35	2022-03-16 07:57:35
8077	Tâche "Modèle d'impression FACTURE D'ACOMPTE"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	71	2022-03-16 07:57:35	2022-03-16 07:57:35
8078	Tâche "Modèle d'impression FACTURE D'ACOMPTE"\n          du projet COMPUTEK - Intervention / Accompagnement 2022 mise dans " En cours " par Miandrisoa	f	76	85	2022-03-16 07:57:35	2022-03-16 07:57:35
8079	La tâche Création utilisateur HAJA de l'équipe de TANA a été achevée.	f	76	53	2022-03-16 09:00:23	2022-03-16 09:00:23
8080	La tâche Création utilisateur HAJA de l'équipe de TANA a été achevée.	f	76	57	2022-03-16 09:00:23	2022-03-16 09:00:23
8081	La tâche Création utilisateur HAJA de l'équipe de TANA a été achevée.	f	76	70	2022-03-16 09:00:23	2022-03-16 09:00:23
8082	La tâche Création utilisateur HAJA de l'équipe de TANA a été achevée.	f	76	71	2022-03-16 09:00:23	2022-03-16 09:00:23
8083	La tâche Création utilisateur HAJA de l'équipe de TANA a été achevée.	f	76	85	2022-03-16 09:00:23	2022-03-16 09:00:23
8084	Tâche "configuration de la base de données SQL Server EDR"\n          du projet EDR - Application Web Réappro mise dans " En contrôle " par Nasolo	f	72	53	2022-03-16 10:42:03	2022-03-16 10:42:03
8085	Tâche "configuration de la base de données SQL Server EDR"\n          du projet EDR - Application Web Réappro mise dans " En contrôle " par Nasolo	f	72	57	2022-03-16 10:42:03	2022-03-16 10:42:03
8086	Tâche "configuration de la base de données SQL Server EDR"\n          du projet EDR - Application Web Réappro mise dans " En contrôle " par Nasolo	f	72	70	2022-03-16 10:42:03	2022-03-16 10:42:03
8087	Tâche "configuration de la base de données SQL Server EDR"\n          du projet EDR - Application Web Réappro mise dans " En contrôle " par Nasolo	f	72	71	2022-03-16 10:42:03	2022-03-16 10:42:03
8088	Tâche "configuration de la base de données SQL Server EDR"\n          du projet EDR - Application Web Réappro mise dans " En contrôle " par Nasolo	f	72	85	2022-03-16 10:42:03	2022-03-16 10:42:03
8089	Tâche "Débogage au niveau des filtres du tableau principale"\n          du projet EDR - Application Web Réappro mise dans " En blocage " par Nasolo	f	72	53	2022-03-16 12:14:00	2022-03-16 12:14:00
8090	Tâche "Débogage au niveau des filtres du tableau principale"\n          du projet EDR - Application Web Réappro mise dans " En blocage " par Nasolo	f	72	57	2022-03-16 12:14:00	2022-03-16 12:14:00
8091	Tâche "Débogage au niveau des filtres du tableau principale"\n          du projet EDR - Application Web Réappro mise dans " En blocage " par Nasolo	f	72	70	2022-03-16 12:14:00	2022-03-16 12:14:00
8092	Tâche "Débogage au niveau des filtres du tableau principale"\n          du projet EDR - Application Web Réappro mise dans " En blocage " par Nasolo	f	72	71	2022-03-16 12:14:00	2022-03-16 12:14:00
8093	Tâche "Débogage au niveau des filtres du tableau principale"\n          du projet EDR - Application Web Réappro mise dans " En blocage " par Nasolo	f	72	85	2022-03-16 12:14:00	2022-03-16 12:14:00
8094	Tâche "Mise en page des catégories sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	53	2022-03-16 13:03:29	2022-03-16 13:03:29
8095	Tâche "Mise en page des catégories sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	57	2022-03-16 13:03:29	2022-03-16 13:03:29
8096	Tâche "Mise en page des catégories sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	70	2022-03-16 13:03:29	2022-03-16 13:03:29
8097	Tâche "Mise en page des catégories sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	71	2022-03-16 13:03:29	2022-03-16 13:03:29
8098	Tâche "Mise en page des catégories sur le menu gauche du site"\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	85	2022-03-16 13:03:29	2022-03-16 13:03:29
8136	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-03-17 13:57:56	2022-03-17 13:57:56
8137	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-03-17 13:57:56	2022-03-17 13:57:56
8138	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	70	2022-03-17 13:57:56	2022-03-17 13:57:56
8139	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-03-17 13:57:56	2022-03-17 13:57:56
8140	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-03-17 13:57:56	2022-03-17 13:57:56
8147	Osé vous a assigné à la tâche Sauvegarde des backups vers 37 puis vers sync.com dans le projet Sauvegarde FTP des clients .	f	74	74	2022-03-17 13:58:16	2022-03-17 13:58:16
8174	Osé vous a assigné à la tâche Sauvegarde des backups vers 37 puis vers sync.com dans le projet Sauvegarde FTP des clients .	f	74	74	2022-03-17 14:01:15	2022-03-17 14:01:15
8185	Osé vous a assigné à la tâche Sauvegarde des backups vers 37 puis vers sync.com dans le projet Sauvegarde FTP des clients .	f	74	74	2022-03-17 14:07:02	2022-03-17 14:07:02
8099	Tâche nouvellement créee du nom de Mise en place de WP All Export(commandes et utilisateurs) sur le site computek  par Fanantenana dans le projet Synchro du site Computek.	f	75	53	2022-03-16 13:16:43	2022-03-16 13:16:43
8100	Tâche nouvellement créee du nom de Mise en place de WP All Export(commandes et utilisateurs) sur le site computek  par Fanantenana dans le projet Synchro du site Computek.	f	75	57	2022-03-16 13:16:43	2022-03-16 13:16:43
8101	Tâche nouvellement créee du nom de Mise en place de WP All Export(commandes et utilisateurs) sur le site computek  par Fanantenana dans le projet Synchro du site Computek.	f	75	70	2022-03-16 13:16:43	2022-03-16 13:16:43
8102	Tâche nouvellement créee du nom de Mise en place de WP All Export(commandes et utilisateurs) sur le site computek  par Fanantenana dans le projet Synchro du site Computek.	f	75	71	2022-03-16 13:16:43	2022-03-16 13:16:43
8103	Tâche nouvellement créee du nom de Mise en place de WP All Export(commandes et utilisateurs) sur le site computek  par Fanantenana dans le projet Synchro du site Computek.	f	75	85	2022-03-16 13:16:43	2022-03-16 13:16:43
8148	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-17 13:59:43	2022-03-17 13:59:43
8149	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-17 13:59:43	2022-03-17 13:59:43
8150	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-17 13:59:43	2022-03-17 13:59:43
8151	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-17 13:59:43	2022-03-17 13:59:43
8152	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-17 13:59:43	2022-03-17 13:59:43
8158	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-03-17 14:00:29	2022-03-17 14:00:29
8159	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-03-17 14:00:29	2022-03-17 14:00:29
8160	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	70	2022-03-17 14:00:29	2022-03-17 14:00:29
8161	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-03-17 14:00:29	2022-03-17 14:00:29
8162	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-03-17 14:00:29	2022-03-17 14:00:29
8164	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-17 14:01:04	2022-03-17 14:01:04
8165	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-17 14:01:04	2022-03-17 14:01:04
8166	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-17 14:01:04	2022-03-17 14:01:04
8167	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-17 14:01:04	2022-03-17 14:01:04
8168	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-17 14:01:04	2022-03-17 14:01:04
8175	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-17 14:06:41	2022-03-17 14:06:41
8176	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-17 14:06:41	2022-03-17 14:06:41
8177	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-17 14:06:41	2022-03-17 14:06:41
8178	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-17 14:06:41	2022-03-17 14:06:41
8179	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-17 14:06:41	2022-03-17 14:06:41
8105	Tâche "Mise en place de WP All Export(commandes et utilisateurs) sur le site computek "\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	53	2022-03-16 13:16:55	2022-03-16 13:16:55
8106	Tâche "Mise en place de WP All Export(commandes et utilisateurs) sur le site computek "\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	57	2022-03-16 13:16:55	2022-03-16 13:16:55
8107	Tâche "Mise en place de WP All Export(commandes et utilisateurs) sur le site computek "\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	70	2022-03-16 13:16:55	2022-03-16 13:16:55
8108	Tâche "Mise en place de WP All Export(commandes et utilisateurs) sur le site computek "\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	71	2022-03-16 13:16:55	2022-03-16 13:16:55
8109	Tâche "Mise en place de WP All Export(commandes et utilisateurs) sur le site computek "\n          du projet Synchro du site Computek mise dans " En contrôle " par Fanantenana	f	75	85	2022-03-16 13:16:55	2022-03-16 13:16:55
8115	Tâche "Sauvegarde manuelle depuis 37 vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-17 13:51:37	2022-03-17 13:51:37
8116	Tâche "Sauvegarde manuelle depuis 37 vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-17 13:51:37	2022-03-17 13:51:37
8117	Tâche "Sauvegarde manuelle depuis 37 vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-17 13:51:37	2022-03-17 13:51:37
8118	Tâche "Sauvegarde manuelle depuis 37 vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-17 13:51:37	2022-03-17 13:51:37
8119	Tâche "Sauvegarde manuelle depuis 37 vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-17 13:51:37	2022-03-17 13:51:37
8142	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	53	2022-03-17 13:58:16	2022-03-17 13:58:16
8143	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	57	2022-03-17 13:58:16	2022-03-17 13:58:16
8144	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	70	2022-03-17 13:58:16	2022-03-17 13:58:16
8145	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	71	2022-03-17 13:58:16	2022-03-17 13:58:16
8146	Tâche nouvellement créee du nom de Sauvegarde des backups vers 37 puis vers sync.com par Osé dans le projet Sauvegarde FTP des clients .	f	74	85	2022-03-17 13:58:16	2022-03-17 13:58:16
8191	Tâche nouvellement créee du nom de Ajustement de stock, demande de Mme Jeanne par Whatsapp par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	53	2022-03-17 14:58:07	2022-03-17 14:58:07
8192	Tâche nouvellement créee du nom de Ajustement de stock, demande de Mme Jeanne par Whatsapp par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	57	2022-03-17 14:58:07	2022-03-17 14:58:07
8193	Tâche nouvellement créee du nom de Ajustement de stock, demande de Mme Jeanne par Whatsapp par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	70	2022-03-17 14:58:07	2022-03-17 14:58:07
8194	Tâche nouvellement créee du nom de Ajustement de stock, demande de Mme Jeanne par Whatsapp par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	71	2022-03-17 14:58:07	2022-03-17 14:58:07
8195	Tâche nouvellement créee du nom de Ajustement de stock, demande de Mme Jeanne par Whatsapp par Elie dans le projet QLM Intervention / Accompagnement 2022.	f	77	85	2022-03-17 14:58:07	2022-03-17 14:58:07
8125	Osé vous a assigné à la tâche Sauvegarde des backups vers 37 puis vers sync.com dans le projet Sauvegarde FTP des clients .	f	74	74	2022-03-17 13:55:46	2022-03-17 13:55:46
8126	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	53	2022-03-17 13:56:09	2022-03-17 13:56:09
8127	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	57	2022-03-17 13:56:09	2022-03-17 13:56:09
8128	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	70	2022-03-17 13:56:09	2022-03-17 13:56:09
8129	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	71	2022-03-17 13:56:09	2022-03-17 13:56:09
8130	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En cours " par Osé	f	74	85	2022-03-17 13:56:09	2022-03-17 13:56:09
8141	Osé vous a assigné à la tâche Sauvegarde des backups vers 37 puis vers sync.com dans le projet Sauvegarde FTP des clients .	f	74	74	2022-03-17 13:57:56	2022-03-17 13:57:56
8153	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-17 13:59:46	2022-03-17 13:59:46
8154	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-17 13:59:46	2022-03-17 13:59:46
8155	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-17 13:59:46	2022-03-17 13:59:46
8156	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-17 13:59:46	2022-03-17 13:59:46
8157	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-17 13:59:46	2022-03-17 13:59:46
8207	Elie vous a assigné à la tâche Intégration stock dépôt 3, demande de Mme Jeanne (Chein/INT/03214) dans le projet QLM Intervention / Accompagnement 2022.	f	77	77	2022-03-17 15:01:15	2022-03-17 15:01:15
8186	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	53	2022-03-17 14:07:18	2022-03-17 14:07:18
8187	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	57	2022-03-17 14:07:18	2022-03-17 14:07:18
8188	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	70	2022-03-17 14:07:18	2022-03-17 14:07:18
8189	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	71	2022-03-17 14:07:18	2022-03-17 14:07:18
8190	Tâche "Sauvegarde des backups vers 37 puis vers sync.com"\n          du projet Sauvegarde FTP des clients  mise dans " En contrôle " par Osé	f	74	85	2022-03-17 14:07:18	2022-03-17 14:07:18
8208	La tâche Intégration stock dépôt 3, demande de Mme Jeanne (Chein/INT/03214) a été achevée.	f	77	53	2022-03-17 15:01:24	2022-03-17 15:01:24
8209	La tâche Intégration stock dépôt 3, demande de Mme Jeanne (Chein/INT/03214) a été achevée.	f	77	57	2022-03-17 15:01:24	2022-03-17 15:01:24
8210	La tâche Intégration stock dépôt 3, demande de Mme Jeanne (Chein/INT/03214) a été achevée.	f	77	70	2022-03-17 15:01:24	2022-03-17 15:01:24
8211	La tâche Intégration stock dépôt 3, demande de Mme Jeanne (Chein/INT/03214) a été achevée.	f	77	71	2022-03-17 15:01:24	2022-03-17 15:01:24
8212	La tâche Intégration stock dépôt 3, demande de Mme Jeanne (Chein/INT/03214) a été achevée.	f	77	85	2022-03-17 15:01:24	2022-03-17 15:01:24
\.


--
-- Data for Name: planified; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.planified (id, description, dt_start, period, inserted_at, updated_at, attributor_id, contributor_id, project_id, estimated_duration, without_control) FROM stdin;
\.


--
-- Data for Name: priorities; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.priorities (id, title, inserted_at, updated_at) FROM stdin;
1	Faible	2021-04-27 18:58:50	2021-04-27 18:58:50
2	Moyenne	2021-04-27 18:59:00	2021-04-27 18:59:09
3	Importante	2021-04-27 18:59:28	2021-04-27 18:59:28
4	Urgente	2021-04-27 18:59:40	2021-04-27 18:59:40
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.projects (id, title, description, progression, date_start, date_end, estimated_duration, performed_duration, deadline, active_client_id, status_id, inserted_at, updated_at, board_id) FROM stdin;
35	Synchro du site Computek	Synchronisation des données de EBP et du site Computek	5	2022-02-08	\N	80	0	2022-02-25	18	1	2022-02-08 14:11:41	2022-03-02 13:03:07	46
40	NAJMI - Mise en place	Mise en place	0	2022-02-28	\N	24	0	2022-03-06	22	1	2022-02-28 09:53:10	2022-03-07 07:02:26	54
37	M-TEC - Mise en place d'un nouveau dossier	Mise en place d'un nouveau dossier	0	2022-02-15	\N	24	0	2022-02-18	19	1	2022-02-14 22:56:37	2022-03-07 13:46:15	49
29	SIGM - Application inter Amadeus et Odoo	Synchronisation des données Amadeus vers Odoo	14	2022-02-03	\N	100	0	2022-02-11	17	1	2022-02-03 07:47:06	2022-03-01 07:17:29	35
38	EDR - Application Web Réappro	Application web pour gérer la réapprovisionnement des articles sur EDR	0	2022-02-24	\N	30	0	2022-03-04	20	1	2022-02-24 07:13:56	2022-03-08 08:37:06	50
31	Sauvegarde FTP des clients 	Programme et mise en place des sauvegardes des bases de données clients	4	2022-02-03	2022-02-04	80	0	2022-02-04	9	1	2022-02-03 09:50:50	2022-03-17 13:58:16	39
34	Correction/Amélioration de l'application Project Monitoring MGBI	Correction des anomalies et les amélioration sur l'application gestion de projet MGBI	0	2022-02-08	\N	200	0	2022-02-28	9	1	2022-02-08 13:11:06	2022-02-08 14:18:13	45
33	SIGM - Gestion  Agence de Voyage sur Odoo 15	Gestion des activités d'une agence de voyage , synchronisation des données depuis Granit et Amadeus	0	2022-02-07	\N	300	0	2022-02-28	17	1	2022-02-07 09:15:56	2022-03-01 09:47:20	43
30	Site web QLM	Développement et mise en place sur cheinmalt.mg du site web Odoo  13 	28	2022-02-03	\N	80	0	2022-02-04	16	1	2022-02-03 09:43:30	2022-03-01 11:53:36	37
36	COMPUTEK - Intervention / Accompagnement 2022	Computek	3	2022-02-14	\N	800	0	2022-12-31	18	1	2022-02-14 11:32:14	2022-03-16 13:45:43	48
32	QLM Intervention / Accompagnement 2022	Intervention / Accompagmement 2022	2	2022-02-04	\N	80	0	2022-02-28	16	1	2022-02-04 12:12:42	2022-03-17 15:01:24	42
41	MADAPLAST - Intervention / Accompagnement 2022	Intervention / Accompagnement 2022	0	2022-03-01	\N	400	0	2022-12-31	23	1	2022-03-01 09:07:34	2022-03-07 06:31:08	55
39	CDC - Intervention Site web	Les tâches d'interventions sur le site web comptoirdecambaie.re	100	2022-02-24	\N	50	0	2022-03-11	21	1	2022-02-24 07:31:14	2022-03-07 13:40:10	52
\.


--
-- Data for Name: rights; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.rights (id, title, inserted_at, updated_at) FROM stdin;
1	Admin	2021-03-24 07:25:41	2021-03-24 07:25:41
3	Contributeur	2021-03-28 20:23:20	2021-03-28 20:23:20
2	Attributeur	2021-04-13 07:55:29	2021-04-13 07:55:29
4	Client	2021-03-28 17:28:09	2021-03-28 17:28:09
5	Non attribué	2021-04-01 20:21:54	2021-04-01 20:21:54
100	Archivé(e)	2021-04-13 08:24:10	2021-04-13 08:24:10
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.schema_migrations (version, inserted_at) FROM stdin;
20210324072043	2021-03-24 07:21:45
20210324143626	2021-03-24 14:36:51
20210326102201	2021-03-26 10:24:36
20210413124124	2021-04-13 12:42:49
20210414120533	2021-04-14 12:06:36
20210414120935	2021-04-14 12:09:54
20210414132353	2021-04-14 13:24:22
20210414132720	2021-04-14 13:27:54
20210415065852	2021-04-15 06:59:48
20210415071440	2021-04-15 07:15:55
20210426095303	2021-04-26 09:54:09
20210426100413	2021-04-26 10:06:28
20210426101246	2021-04-26 10:13:17
20210426101752	2021-04-26 10:20:09
20210426102215	2021-04-26 10:24:28
20210428121839	2021-04-28 12:20:11
20210428122039	2021-04-28 12:21:49
20210428172927	2021-04-28 17:30:21
20210429061512	2021-04-29 06:17:16
20210514105447	2021-05-14 10:56:17
20210518110212	2021-05-18 11:04:23
20210527155705	2021-05-27 16:12:41
20210602180040	2021-06-02 18:03:01
20210602183517	2021-06-02 18:35:57
20210602190601	2021-06-02 19:06:19
20210602213717	2021-06-02 21:37:34
20210603161444	2021-06-03 16:17:57
20210603162215	2021-06-03 16:24:08
20210607111124	2021-06-07 11:16:10
20210608201833	2021-06-08 20:19:53
20210616083854	2021-06-16 08:40:13
20210831074824	2021-08-31 07:48:46
20210930165500	2021-09-30 16:55:29
20211001070528	2021-10-01 08:10:54
\.


--
-- Data for Name: softwares; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.softwares (id, title, company_id, inserted_at, updated_at) FROM stdin;
1	LOG+SOC	1	2021-06-02 21:41:47	2021-06-02 21:41:47
\.


--
-- Data for Name: stages; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.stages (id, name, board_id, status_id, "position", inserted_at, updated_at) FROM stdin;
166	A faire	35	1	0	2022-02-03 07:47:06	2022-02-03 07:47:06
167	En blocage	35	2	1	2022-02-03 07:47:06	2022-02-03 07:47:06
168	En cours	35	3	2	2022-02-03 07:47:06	2022-02-03 07:47:06
169	En contrôle	35	4	3	2022-02-03 07:47:06	2022-02-03 07:47:06
170	Achevée(s)	35	5	4	2022-02-03 07:47:06	2022-02-03 07:47:06
171	A faire	36	1	0	2022-02-03 09:43:17	2022-02-03 09:43:17
172	En blocage	36	2	1	2022-02-03 09:43:17	2022-02-03 09:43:17
173	En cours	36	3	2	2022-02-03 09:43:17	2022-02-03 09:43:17
174	En contrôle	36	4	3	2022-02-03 09:43:17	2022-02-03 09:43:17
175	Achevée(s)	36	5	4	2022-02-03 09:43:17	2022-02-03 09:43:17
176	A faire	37	1	0	2022-02-03 09:43:30	2022-02-03 09:43:30
177	En blocage	37	2	1	2022-02-03 09:43:30	2022-02-03 09:43:30
178	En cours	37	3	2	2022-02-03 09:43:30	2022-02-03 09:43:30
179	En contrôle	37	4	3	2022-02-03 09:43:30	2022-02-03 09:43:30
180	Achevée(s)	37	5	4	2022-02-03 09:43:30	2022-02-03 09:43:30
181	A faire	38	1	0	2022-02-03 09:49:57	2022-02-03 09:49:57
182	En blocage	38	2	1	2022-02-03 09:49:57	2022-02-03 09:49:57
183	En cours	38	3	2	2022-02-03 09:49:57	2022-02-03 09:49:57
184	En contrôle	38	4	3	2022-02-03 09:49:57	2022-02-03 09:49:57
185	Achevée(s)	38	5	4	2022-02-03 09:49:57	2022-02-03 09:49:57
186	A faire	39	1	0	2022-02-03 09:50:50	2022-02-03 09:50:50
187	En blocage	39	2	1	2022-02-03 09:50:50	2022-02-03 09:50:50
188	En cours	39	3	2	2022-02-03 09:50:50	2022-02-03 09:50:50
189	En contrôle	39	4	3	2022-02-03 09:50:50	2022-02-03 09:50:50
190	Achevée(s)	39	5	4	2022-02-03 09:50:50	2022-02-03 09:50:50
191	A faire	40	1	0	2022-02-04 12:08:55	2022-02-04 12:08:55
192	En blocage	40	2	1	2022-02-04 12:08:55	2022-02-04 12:08:55
193	En cours	40	3	2	2022-02-04 12:08:55	2022-02-04 12:08:55
194	En contrôle	40	4	3	2022-02-04 12:08:55	2022-02-04 12:08:55
195	Achevée(s)	40	5	4	2022-02-04 12:08:55	2022-02-04 12:08:55
196	A faire	41	1	0	2022-02-04 12:10:05	2022-02-04 12:10:05
197	En blocage	41	2	1	2022-02-04 12:10:05	2022-02-04 12:10:05
198	En cours	41	3	2	2022-02-04 12:10:05	2022-02-04 12:10:05
199	En contrôle	41	4	3	2022-02-04 12:10:05	2022-02-04 12:10:05
200	Achevée(s)	41	5	4	2022-02-04 12:10:05	2022-02-04 12:10:05
201	A faire	42	1	0	2022-02-04 12:12:42	2022-02-04 12:12:42
202	En blocage	42	2	1	2022-02-04 12:12:42	2022-02-04 12:12:42
203	En cours	42	3	2	2022-02-04 12:12:42	2022-02-04 12:12:42
204	En contrôle	42	4	3	2022-02-04 12:12:42	2022-02-04 12:12:42
205	Achevée(s)	42	5	4	2022-02-04 12:12:42	2022-02-04 12:12:42
206	A faire	43	1	0	2022-02-07 09:15:56	2022-02-07 09:15:56
207	En blocage	43	2	1	2022-02-07 09:15:56	2022-02-07 09:15:56
208	En cours	43	3	2	2022-02-07 09:15:56	2022-02-07 09:15:56
209	En contrôle	43	4	3	2022-02-07 09:15:56	2022-02-07 09:15:56
210	Achevée(s)	43	5	4	2022-02-07 09:15:56	2022-02-07 09:15:56
211	A faire	44	1	0	2022-02-08 13:09:38	2022-02-08 13:09:38
212	En blocage	44	2	1	2022-02-08 13:09:38	2022-02-08 13:09:38
213	En cours	44	3	2	2022-02-08 13:09:38	2022-02-08 13:09:38
214	En contrôle	44	4	3	2022-02-08 13:09:38	2022-02-08 13:09:38
215	Achevée(s)	44	5	4	2022-02-08 13:09:38	2022-02-08 13:09:38
216	A faire	45	1	0	2022-02-08 13:11:06	2022-02-08 13:11:06
217	En blocage	45	2	1	2022-02-08 13:11:06	2022-02-08 13:11:06
218	En cours	45	3	2	2022-02-08 13:11:06	2022-02-08 13:11:06
219	En contrôle	45	4	3	2022-02-08 13:11:06	2022-02-08 13:11:06
220	Achevée(s)	45	5	4	2022-02-08 13:11:06	2022-02-08 13:11:06
221	A faire	46	1	0	2022-02-08 14:11:40	2022-02-08 14:11:40
222	En blocage	46	2	1	2022-02-08 14:11:41	2022-02-08 14:11:41
223	En cours	46	3	2	2022-02-08 14:11:41	2022-02-08 14:11:41
224	En contrôle	46	4	3	2022-02-08 14:11:41	2022-02-08 14:11:41
225	Achevée(s)	46	5	4	2022-02-08 14:11:41	2022-02-08 14:11:41
226	A faire	47	1	0	2022-02-14 11:31:40	2022-02-14 11:31:40
227	En blocage	47	2	1	2022-02-14 11:31:40	2022-02-14 11:31:40
228	En cours	47	3	2	2022-02-14 11:31:40	2022-02-14 11:31:40
229	En contrôle	47	4	3	2022-02-14 11:31:40	2022-02-14 11:31:40
230	Achevée(s)	47	5	4	2022-02-14 11:31:40	2022-02-14 11:31:40
231	A faire	48	1	0	2022-02-14 11:32:14	2022-02-14 11:32:14
232	En blocage	48	2	1	2022-02-14 11:32:14	2022-02-14 11:32:14
233	En cours	48	3	2	2022-02-14 11:32:14	2022-02-14 11:32:14
234	En contrôle	48	4	3	2022-02-14 11:32:14	2022-02-14 11:32:14
235	Achevée(s)	48	5	4	2022-02-14 11:32:14	2022-02-14 11:32:14
236	A faire	49	1	0	2022-02-14 22:56:37	2022-02-14 22:56:37
237	En blocage	49	2	1	2022-02-14 22:56:37	2022-02-14 22:56:37
238	En cours	49	3	2	2022-02-14 22:56:37	2022-02-14 22:56:37
239	En contrôle	49	4	3	2022-02-14 22:56:37	2022-02-14 22:56:37
240	Achevée(s)	49	5	4	2022-02-14 22:56:37	2022-02-14 22:56:37
241	A faire	50	1	0	2022-02-24 07:13:56	2022-02-24 07:13:56
242	En blocage	50	2	1	2022-02-24 07:13:56	2022-02-24 07:13:56
243	En cours	50	3	2	2022-02-24 07:13:56	2022-02-24 07:13:56
244	En contrôle	50	4	3	2022-02-24 07:13:56	2022-02-24 07:13:56
245	Achevée(s)	50	5	4	2022-02-24 07:13:56	2022-02-24 07:13:56
246	A faire	51	1	0	2022-02-24 07:30:39	2022-02-24 07:30:39
247	En blocage	51	2	1	2022-02-24 07:30:39	2022-02-24 07:30:39
248	En cours	51	3	2	2022-02-24 07:30:39	2022-02-24 07:30:39
249	En contrôle	51	4	3	2022-02-24 07:30:39	2022-02-24 07:30:39
250	Achevée(s)	51	5	4	2022-02-24 07:30:39	2022-02-24 07:30:39
251	A faire	52	1	0	2022-02-24 07:31:14	2022-02-24 07:31:14
252	En blocage	52	2	1	2022-02-24 07:31:14	2022-02-24 07:31:14
253	En cours	52	3	2	2022-02-24 07:31:14	2022-02-24 07:31:14
254	En contrôle	52	4	3	2022-02-24 07:31:14	2022-02-24 07:31:14
255	Achevée(s)	52	5	4	2022-02-24 07:31:14	2022-02-24 07:31:14
256	A faire	53	1	0	2022-02-28 09:52:54	2022-02-28 09:52:54
257	En blocage	53	2	1	2022-02-28 09:52:54	2022-02-28 09:52:54
258	En cours	53	3	2	2022-02-28 09:52:54	2022-02-28 09:52:54
259	En contrôle	53	4	3	2022-02-28 09:52:54	2022-02-28 09:52:54
260	Achevée(s)	53	5	4	2022-02-28 09:52:54	2022-02-28 09:52:54
261	A faire	54	1	0	2022-02-28 09:53:10	2022-02-28 09:53:10
262	En blocage	54	2	1	2022-02-28 09:53:10	2022-02-28 09:53:10
263	En cours	54	3	2	2022-02-28 09:53:10	2022-02-28 09:53:10
264	En contrôle	54	4	3	2022-02-28 09:53:10	2022-02-28 09:53:10
265	Achevée(s)	54	5	4	2022-02-28 09:53:10	2022-02-28 09:53:10
266	A faire	55	1	0	2022-03-01 09:07:34	2022-03-01 09:07:34
267	En blocage	55	2	1	2022-03-01 09:07:34	2022-03-01 09:07:34
268	En cours	55	3	2	2022-03-01 09:07:34	2022-03-01 09:07:34
269	En contrôle	55	4	3	2022-03-01 09:07:34	2022-03-01 09:07:34
270	Achevée(s)	55	5	4	2022-03-01 09:07:34	2022-03-01 09:07:34
\.


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.statuses (id, title, inserted_at, updated_at) FROM stdin;
1	A faire	2021-04-27 18:47:25	2021-04-27 18:47:25
3	En cours	2021-04-27 18:47:50	2021-04-27 18:47:50
4	En contrôle	2021-04-27 18:48:15	2021-04-27 18:48:15
5	Achevée(s)	2021-04-27 18:49:44	2021-04-27 18:49:44
2	En blocage	2021-04-27 18:47:36	2021-04-27 18:47:36
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.tasks (id, title, progression, date_start, date_end, estimated_duration, performed_duration, deadline, parent_id, project_id, contributor_id, status_id, priority_id, inserted_at, updated_at, attributor_id, achieved_at, hidden, without_control) FROM stdin;
390	Rapprochement bancaire mai-juin BMOI Chainmalt	100	2022-02-21	\N	6	6	2022-02-23	\N	33	79	5	2	2022-02-21 09:07:07	2022-02-22 15:34:06	79	\N	f	t
323	Intégration inventaire QLM	0	2022-02-11	\N	32	0	2022-02-16	\N	32	77	2	2	2022-02-11 10:15:01	2022-03-07 12:34:46	77	\N	f	t
280	statu annulé => suppression du document achat	0	2022-02-07	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-07 15:47:28	2022-02-10 10:05:57	78	2022-02-10 10:05:57	f	f
233	Import photos des articles publié sur le site 	0	2022-02-04	\N	40	0	2022-02-07	\N	30	\N	3	2	2022-02-04 15:03:00	2022-02-04 15:50:54	70	\N	f	f
246	Impression 40 factures - ENAC	0	2022-02-04	\N	1	0	2022-02-03	\N	32	77	5	2	2022-02-04 15:50:51	2022-02-04 15:51:00	71	2022-02-04 15:51:00	f	f
345	Module pour bloquer le mouvement de stock quand on valide un BL daté avant l'inventaire	0	2022-02-15	\N	24	0	2022-02-18	\N	32	81	1	2	2022-02-15 10:35:19	2022-02-15 07:35:19	70	\N	f	f
237	Salaire QLM, Codigaz, Codimat janvier 2022	0	2022-02-03	\N	6	0	2022-02-03	\N	32	77	5	2	2022-02-04 15:17:55	2022-02-04 15:39:23	71	2022-02-04 15:39:23	f	f
389	Enlever les boutons créer une facture, envoyer la commande par courriel, annuler, bloquer dans le document d'achat	0	2022-02-18	\N	1	0	2022-02-18	\N	33	78	5	2	2022-02-18 17:23:35	2022-02-18 17:23:42	78	\N	f	t
234	Correspondance des articles et familles sur le site	0	2022-02-04	\N	16	0	2022-02-07	\N	30	\N	3	2	2022-02-04 15:05:32	2022-02-04 15:52:02	70	\N	f	f
236	Solde de congé 2021	0	2022-02-02	\N	4	0	2022-02-02	\N	32	77	5	2	2022-02-04 15:16:55	2022-02-04 15:52:40	71	2022-02-04 15:39:32	f	f
235	Salaire Cheinmalt janvier 2022	0	2022-02-04	\N	5	0	2022-02-02	\N	32	77	5	2	2022-02-04 15:15:23	2022-02-04 15:39:40	71	2022-02-04 15:39:40	f	f
273	Document travel order doit être non modifiable à partir de 'accepté'	0	2022-02-07	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-07 13:52:34	2022-02-08 15:36:17	78	2022-02-08 15:36:17	f	f
229	Programme de transfert des backup clients sur FTP	0	2022-02-04	\N	16	0	2022-02-04	\N	31	74	5	2	2022-02-04 11:22:24	2022-02-22 14:38:54	70	2022-02-22 14:38:54	f	f
272	Afficher les autres taxes dans les documents factures et achats	0	2022-02-07	\N	4	0	2022-02-11	\N	33	78	5	2	2022-02-07 13:51:20	2022-02-08 15:35:06	78	2022-02-08 15:35:06	f	f
274	Afficher les fournisseurs dans la facture client	0	2022-02-07	\N	2	0	2022-02-11	\N	33	78	5	2	2022-02-07 13:54:06	2022-02-08 16:16:16	78	2022-02-08 16:16:16	f	f
275	Gestion des droits de validations de devis	0	2022-02-07	\N	4	0	2022-02-11	\N	33	78	5	2	2022-02-07 13:55:05	2022-02-08 17:17:22	78	2022-02-08 17:17:22	f	f
247	Paramétrage paie - création structure solde de congé, min irsa sur 3000	0	2022-02-04	\N	2	0	2022-02-02	\N	32	77	5	2	2022-02-04 15:53:30	2022-02-04 15:53:49	71	2022-02-04 15:53:49	f	f
315	Pouvoir attribuer une tâche à un attributteur	0	2022-02-08	\N	2	0	2022-02-11	\N	34	81	1	2	2022-02-08 17:18:13	2022-02-08 14:18:13	71	\N	f	f
241	Intégration stock PO26294 - Francelec	0	2022-02-04	\N	3	0	2022-02-04	\N	32	77	5	2	2022-02-04 15:42:51	2022-02-04 15:44:14	71	2022-02-04 15:44:14	f	f
221	Rédirection port 80 vers 8069 sur 54 	0	2022-02-03	\N	16	0	2022-02-03	\N	30	72	5	2	2022-02-03 12:44:54	2022-02-04 15:00:48	70	2022-02-04 15:00:48	f	t
240	Intégration stock PO25899 - Ingco	0	2022-02-04	\N	3	0	2022-02-04	\N	32	77	5	2	2022-02-04 15:42:07	2022-02-04 15:44:23	71	2022-02-04 15:44:23	f	f
222	Description des familles publié sur le site	0	2022-02-03	\N	16	0	2022-02-04	\N	30	75	5	2	2022-02-03 12:48:08	2022-02-04 15:00:59	70	2022-02-04 15:00:59	f	f
278	statut accepté => génération de doc achat	0	2022-02-07	\N	3	0	2022-02-11	\N	33	78	5	2	2022-02-07 15:44:44	2022-02-08 17:25:05	78	2022-02-08 17:25:05	f	f
279	statut confirmé => génération de factures clients et fournisseurs	0	2022-02-07	\N	2	0	2022-02-11	\N	33	78	5	2	2022-02-07 15:45:57	2022-02-08 17:26:20	78	2022-02-08 17:26:20	f	f
242	Validation BL	0	2022-02-04	\N	8	0	2022-02-04	\N	32	77	5	2	2022-02-04 15:45:25	2022-02-04 15:45:57	71	2022-02-04 15:45:57	f	f
283	Copie de certains champs lors d'une duplication de document travel order	0	2022-02-07	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-07 15:50:50	2022-02-08 17:28:18	78	2022-02-08 17:28:18	f	f
284	Ajouter le numéro pnr dans la commande (nouveau champs)	0	2022-02-07	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-07 15:52:06	2022-02-08 17:28:28	78	2022-02-08 17:28:28	f	f
243	Notification mail d'une commande passée sur le site	0	2022-02-04	\N	16	0	2022-02-04	\N	30	81	5	2	2022-02-04 15:47:10	2022-02-04 15:47:17	70	2022-02-04 15:47:17	f	f
286	Création de la bande duplicata	0	2022-02-07	\N	1	0	2022-02-11	285	33	78	5	2	2022-02-07 15:53:56	2022-02-08 17:31:25	78	\N	f	f
244	Création banner d'accueil sur le site	0	2022-02-04	\N	16	0	2022-02-04	\N	30	75	5	2	2022-02-04 15:49:51	2022-02-04 15:49:53	70	2022-02-04 15:49:53	f	f
245	Amélioration du design de l'interface d'accueil 	0	2022-02-04	\N	16	0	2022-02-04	\N	30	75	5	2	2022-02-04 15:50:34	2022-02-04 15:50:37	70	2022-02-04 15:50:37	f	f
285	Mettre une bande duplicata après une première impression de la facture	100	2022-02-07	\N	6	0	2022-02-11	\N	33	78	5	2	2022-02-07 15:53:25	2022-02-08 14:31:25	78	2022-02-08 17:31:25	f	f
267	Description technique des familles 	0	2022-02-07	\N	4	0	2022-02-07	\N	30	72	5	2	2022-02-07 12:12:21	2022-02-15 10:19:11	72	2022-02-15 10:19:11	f	f
282	Ajouter un champs autre info dans travel order	0	2022-02-07	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-07 15:49:59	2022-02-10 10:06:00	78	2022-02-10 10:06:00	f	f
266	Modification de la page d'accueil	0	2022-02-07	\N	4	0	2022-02-08	\N	30	75	5	2	2022-02-07 12:00:42	2022-02-15 10:19:13	75	2022-02-15 10:19:13	f	t
223	Programme pour rapport mails des sauvegarde réussie du jours 	84	2022-02-03	\N	16	0	2022-02-04	\N	31	74	4	2	2022-02-03 12:52:01	2022-02-25 10:53:11	70	\N	f	f
238	Alert audio quand chèque arrivé à échéance	0	2022-02-04	\N	24	0	2022-02-09	\N	32	78	1	2	2022-02-04 15:23:41	2022-02-07 17:15:58	70	\N	f	f
270	Numérotation facture 1er Avril 2021 - 31 Mars : exercice 2021, exercice cfao	0	2022-02-07	\N	8	0	2022-02-11	\N	33	78	1	2	2022-02-07 13:42:49	2022-02-07 16:22:17	78	\N	f	f
268	Rajouter un statut Accepté pour les devis	0	2022-02-07	\N	5	0	2022-02-07	\N	33	78	5	2	2022-02-07 12:16:59	2022-02-07 13:34:49	70	\N	f	t
277	Création d'un champs selection (client en compte, client de passage (default))	0	2022-02-07	\N	1	0	2022-02-11	276	33	78	1	2	2022-02-07 13:58:48	2022-02-07 10:58:48	78	\N	f	f
330	Affichage dynamiquement des catégories et sous catégories de wocommerce avec l'arborescence sur le menu gauche du site	0	2022-02-14	\N	6	0	2022-02-14	\N	35	75	5	2	2022-02-14 12:18:12	2022-02-21 09:49:48	70	2022-02-21 09:49:48	f	f
287	Ajouter un bouton d'impression de la facture et enlever le menu d'impression	0	2022-02-07	\N	1	0	2022-02-11	285	33	78	5	2	2022-02-07 15:54:49	2022-02-08 17:31:25	78	\N	f	f
318	Intégration stock P025886	0	2022-02-09	\N	5	0	2022-02-10	\N	32	77	5	2	2022-02-09 15:33:06	2022-02-10 22:03:16	77	2022-02-10 22:03:16	f	f
316	Mise à jours totes les photos INGCO	0	2022-02-09	\N	5	0	2022-02-09	\N	32	77	5	2	2022-02-09 12:04:07	2022-02-10 22:03:27	77	2022-02-10 22:03:27	f	f
319	Mise en place des articles sans emplacement Odoo	0	2022-02-10	\N	6	0	2022-02-10	\N	32	77	5	2	2022-02-10 12:02:39	2022-02-10 22:03:45	77	2022-02-10 22:03:45	f	t
346	Création utilisateur EBP	0	2022-02-15	\N	1	0	2022-02-15	\N	36	76	4	2	2022-02-15 10:36:23	2022-02-21 09:52:25	76	\N	f	f
295	Ajouter un champs nombre (nombre x quantité joue le rôle de quantité)	0	2022-02-07	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-07 16:06:33	2022-02-08 12:24:14	78	2022-02-08 12:24:14	f	f
361	Création champ description technique des articles	0	2022-02-16	\N	1	0	2022-02-16	\N	32	78	5	2	2022-02-16 11:07:34	2022-02-21 14:52:26	70	2022-02-21 14:52:26	f	t
475	Enlever le champs numéro de dossier et considérer le numéro de document à sa place	0	2022-02-27	\N	1	0	2022-03-07	457	33	78	5	2	2022-02-27 18:46:59	2022-02-27 18:50:20	78	\N	f	t
375	Emincir le panneauu d'historique de la fiche commande ou le mettre en dessous	0	2022-02-17	\N	3	0	2022-02-25	\N	33	78	5	2	2022-02-17 10:04:15	2022-02-28 11:38:07	78	2022-02-28 11:38:07	f	f
348	Récupération de la tva sur Odoo de l'article pour le site	0	2022-02-15	\N	35	0	2022-02-21	\N	32	81	1	2	2022-02-15 10:40:39	2022-02-15 10:08:36	81	\N	t	f
301	Suppression backup ancienne	0	2022-02-08	\N	3	0	2022-02-08	\N	31	74	5	2	2022-02-08 12:05:09	2022-02-28 13:23:17	74	2022-02-28 13:23:17	f	t
421	Tester un module pour mettre les avances sur Odoo 	20	2022-02-21	\N	5	0	2022-02-22	\N	32	72	5	2	2022-02-21 17:26:18	2022-02-28 13:26:09	70	2022-02-28 13:26:09	f	f
331	création d'import produit et catégories, et correspondance des champs d'import sur le site	100	2022-02-14	\N	30	0	2022-02-18	\N	35	75	4	2	2022-02-14 12:19:58	2022-03-16 16:18:12	70	\N	f	f
322	Cacher le bouton confirmer dans travel order si l'utilisateur n'a pas le droit de confirmer	0	2022-02-10	\N	1	0	2022-02-11	\N	33	78	4	2	2022-02-10 12:24:40	2022-02-18 16:19:27	78	\N	f	t
427	Vue d'utilisateur TANA,Serez-t 'il possible de créer un vue pour TANA seulement pour le réglement.	0	2022-02-22	\N	1	0	2022-02-22	\N	36	76	5	2	2022-02-22 12:35:06	2022-02-22 15:37:15	76	\N	f	t
433	Intégration de stock du PO24141 et PO26463	0	2022-02-22	\N	3	0	2022-02-22	\N	32	77	5	2	2022-02-22 13:50:32	2022-02-22 16:10:10	77	\N	f	t
437	Intégration de stock du PO26335 et PO26713	0	2022-02-22	\N	2	0	2022-02-22	\N	32	77	5	2	2022-02-22 14:37:35	2022-02-22 15:36:25	77	\N	f	t
307	Ajouter une référence du document achat dans le document de commande	0	2022-02-08	\N	2	0	2022-02-11	\N	33	78	4	2	2022-02-08 16:23:48	2022-02-10 12:16:55	78	\N	f	f
321	Ajouter un label pour le champs autre infos dans travel order	0	2022-02-10	\N	1	0	2022-02-11	\N	33	78	4	2	2022-02-10 12:22:28	2022-02-10 12:22:38	78	\N	f	f
383	Mettre la total des Fees, la total des taxes (autres taxes) en dessous de s lignes de commande	0	2022-02-17	\N	2	0	2022-02-25	381	33	78	1	2	2022-02-17 10:12:12	2022-02-17 07:12:12	78	\N	f	f
416	Mise en place WPAllExport des clients et commandes 	100	2022-02-21	\N	8	0	2022-02-22	\N	35	75	4	2	2022-02-21 12:23:07	2022-03-01 16:50:37	70	\N	f	f
384	Ajuster la taille des colonnes	0	2022-02-17	\N	3	0	2022-02-25	\N	33	78	1	2	2022-02-17 10:13:24	2022-02-17 07:13:24	78	\N	f	f
336	Envoyer le fichier export de l’écriture comptable sous format LOCPRO à Mr Andy pour un test d’import sur Incadea 	0	2022-02-14	\N	1	0	2022-02-14	\N	33	\N	5	2	2022-02-14 16:17:28	2022-02-14 16:17:38	70	2022-02-14 16:17:38	f	f
412	Créer l'avoir fournisseur quand on confirme l'avoir client	0	2022-02-21	\N	2	0	2022-02-25	410	33	78	1	2	2022-02-21 10:13:52	2022-02-21 07:13:52	78	\N	f	t
324	Résolution des problèmes d'envoie des fichiers backup dans l'FTP	90	2022-02-11	\N	5	0	2022-02-11	\N	31	74	4	2	2022-02-11 10:33:42	2022-03-02 15:33:33	74	\N	f	t
326	Mise en place du site et intégration de 'wp all import'	0	2022-02-11	\N	6	0	2022-02-14	\N	35	75	5	2	2022-02-11 15:57:37	2022-02-21 12:15:46	75	2022-02-21 12:15:46	f	f
440	Intégration inventaire Showroom Cheinmalt	0	2022-02-23	\N	2	0	2022-02-23	\N	32	77	5	2	2022-02-23 17:38:33	2022-02-23 17:38:46	77	\N	f	t
371	Ajouter INF dans civilité dans la ligne de commande	0	2022-02-17	\N	1	0	2022-02-18	\N	33	78	5	2	2022-02-17 10:01:47	2022-02-18 16:24:47	78	\N	f	t
391	Renommer "Montant TVA" en "Montant TVA sur fees" dans le document travel order	0	2022-02-21	\N	1	0	2022-02-21	\N	33	78	4	2	2022-02-21 09:55:58	2022-02-21 12:31:27	78	\N	f	t
360	Envoi des anomalies d'enregistrement des PNRs sur email	0	2022-02-16	\N	1	0	2022-02-16	\N	29	73	5	2	2022-02-16 10:32:30	2022-02-21 12:33:20	73	2022-02-21 12:33:20	f	f
399	Renommer "Émis" en "émis" dans impression facture	0	2022-02-21	\N	1	0	2022-02-25	\N	33	78	5	2	2022-02-21 10:03:06	2022-02-21 17:26:00	78	\N	f	t
401	Dans la fiche facture, masquer le bouton "Remettre en brouillon"	0	2022-02-21	\N	2	0	2022-02-25	\N	33	78	5	2	2022-02-21 10:04:41	2022-02-21 17:26:11	78	\N	f	t
447	Intégration d'inventaire pour MOB+	0	2022-02-24	\N	1	0	2022-02-23	\N	36	76	1	2	2022-02-24 15:44:43	2022-02-24 12:44:43	76	\N	f	t
386	Afficher ou non bouton "Remettre en brouillon" dans doc factures/pièces comptable	0	2022-02-18	\N	1	0	2022-02-18	\N	32	78	5	2	2022-02-18 11:42:10	2022-02-22 14:18:42	78	2022-02-22 14:18:42	f	t
444	Mise à jour Code-barre articles Pointes	0	2022-02-24	\N	2	0	2022-02-24	\N	32	77	5	2	2022-02-24 11:00:31	2022-02-24 11:01:05	77	\N	f	t
398	Mettre le montant en lettre dans l'impression de facture	0	2022-02-21	\N	2	0	2022-02-25	\N	33	78	5	2	2022-02-21 10:01:40	2022-02-24 13:34:54	78	\N	f	t
379	Ajouter les champs obligatoires dans les lignes de commandes, les afficher sur la facture: N° du vol, la clase de réservation (à afficher dans la facture), status (liste déroulante: issued, reissued, refund)	0	2022-02-17	\N	4	0	2022-02-25	\N	33	78	4	2	2022-02-17 10:07:09	2022-02-24 12:36:09	78	\N	f	f
443	Modification du banner sur l'accueil	100	2022-02-24	\N	2	0	2022-02-24	\N	39	75	5	2	2022-02-24 10:31:39	2022-02-24 15:04:05	70	2022-02-24 12:24:43	f	f
288	Ajouter un champs pour savoir si la facture a déjà été imprimée ou pas	0	2022-02-07	\N	1	0	2022-02-11	285	33	78	5	2	2022-02-07 15:55:40	2022-02-08 17:31:25	78	\N	f	f
434	Mettre à jour import article depuis hfsql	0	2022-02-22	\N	2	0	2022-02-25	\N	33	78	1	2	2022-02-22 13:58:04	2022-02-27 18:50:53	78	\N	f	t
380	Ordre des colonnes des lignes de commandes: Type d'article (billet, fees, supplément/voucher), Article,... (Fournisseur  et numéro de billet côte à côte)	0	2022-02-17	\N	2	0	2022-02-18	\N	33	78	5	2	2022-02-17 10:08:41	2022-02-18 16:25:46	78	\N	f	t
376	Création utilisateur GESCOM de l'ancienne dossier pour ROLLANDCPT et JEANCOMPTA	0	2022-02-17	\N	1	0	2022-02-17	\N	36	76	5	2	2022-02-17 10:05:09	2022-02-21 09:01:01	76	2022-02-21 09:01:01	f	t
417	Rajouter sur l'historique quand il y a un ajustement de stock	0	2022-02-21	\N	16	0	2022-02-25	\N	32	81	5	2	2022-02-21 12:25:44	2022-02-22 15:13:23	70	2022-02-22 15:13:23	f	f
413	Vérification des articles avec doublons	0	2022-02-21	\N	5	0	2022-02-21	\N	36	76	5	2	2022-02-21 12:17:41	2022-02-22 15:37:38	76	\N	f	t
356	Droit des utilisateurS COMPUTEK TANA	0	2022-02-15	\N	2	0	2022-02-15	\N	36	76	4	2	2022-02-15 14:17:34	2022-02-22 15:36:33	76	2022-02-21 09:01:16	f	f
374	Paramétrage model d'impression	0	2022-02-17	\N	1	0	2022-02-17	\N	36	76	4	2	2022-02-17 10:03:30	2022-02-22 15:37:46	76	2022-02-21 09:03:29	f	f
372	Parétrage de VUE pour le compte de Direction Générale sur les BE,BS,OT	0	2022-02-17	\N	1	0	2022-02-17	\N	36	76	5	2	2022-02-17 10:02:29	2022-02-22 15:38:01	76	2022-02-21 09:52:13	f	t
363	Assistance pour les articles stock négatif	0	2022-02-16	\N	3	0	2022-02-16	\N	36	76	5	2	2022-02-16 11:28:53	2022-02-22 15:38:20	76	\N	f	t
357	Extraction Image EBP	0	2022-02-16	\N	5	0	2022-02-14	\N	35	74	5	2	2022-02-16 10:08:56	2022-02-21 09:49:26	74	2022-02-21 09:49:26	f	f
339	Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation	0	2022-02-14	\N	2	0	2022-02-15	\N	33	\N	1	2	2022-02-14 16:21:59	2022-02-14 13:22:11	70	\N	t	f
352	Modification de la catégories d'articles 	0	2022-02-15	\N	3	0	2022-02-15	\N	32	\N	5	2	2022-02-15 13:07:05	2022-02-15 13:07:34	70	2022-02-15 13:07:14	f	f
327	Envoyer la liste des articles, familles et sous famille à computek pour identifier ceux qui sont à afficher sur le site	0	2022-02-14	\N	4	0	2022-02-14	\N	35	\N	5	2	2022-02-14 12:15:47	2022-02-21 09:50:17	70	2022-02-21 09:50:17	f	f
340	Envoyer la liste finale des familles et sous​ familles modifié à QLM pour validation	0	2022-02-14	\N	2	0	2022-02-14	\N	36	\N	3	2	2022-02-14 16:24:18	2022-02-14 16:24:38	70	\N	f	f
365	Validation BL Cheinmalt	0	2022-02-16	\N	3	0	2022-02-16	\N	32	77	5	2	2022-02-16 15:45:55	2022-02-22 16:11:29	77	\N	f	t
387	Création STC de deux salariés	0	2022-02-18	\N	2	0	2022-02-18	\N	32	77	5	2	2022-02-18 12:24:00	2022-02-22 16:11:45	77	\N	f	t
400	Dans la ficher client, enlever tout dans les conditions de paiement et ne laisser que Paiement immédiat et 30 jours	0	2022-02-21	\N	2	0	2022-02-25	\N	33	78	1	2	2022-02-21 10:03:58	2022-02-21 07:03:58	78	\N	f	t
271	Ajout de colonne comptes auxiliaires dans les écritures comptables	0	2022-02-07	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-07 13:47:37	2022-02-08 15:07:25	78	2022-02-08 15:07:25	f	f
402	Mettre la même présentation dans la facture (lignes) que dans le document de commande	0	2022-02-21	\N	3	0	2022-02-25	\N	33	78	1	2	2022-02-21 10:05:21	2022-02-21 07:05:21	78	\N	f	t
302	Normalisation l'heure d'envoie backup	0	2022-02-08	\N	3	0	2022-02-08	\N	31	74	5	2	2022-02-08 12:07:00	2022-02-28 13:23:21	74	2022-02-28 13:23:21	f	t
347	Modification compte article	0	2022-02-15	\N	2	0	2022-02-15	\N	36	76	4	2	2022-02-15 10:38:32	2022-02-17 10:00:32	76	\N	f	f
408	Dans la fiche facture > Ajouter un avoir, le motif doit être obligatoire	0	2022-02-21	\N	3	0	2022-02-25	\N	33	78	1	2	2022-02-21 10:10:57	2022-02-21 07:10:57	78	\N	f	t
317	Ajout historique d'un billet	0	2022-02-09	\N	8	0	2022-02-10	\N	29	73	4	2	2022-02-09 12:52:22	2022-03-08 10:55:33	73	\N	f	f
410	Automatiser la création d'un avoir fournisseur lors de la création d'un avoir client ou vice versa	0	2022-02-21	\N	4	0	2022-02-25	\N	33	78	1	2	2022-02-21 10:12:16	2022-02-21 07:12:16	78	\N	f	t
366	Adaptation des requêtes qui génèrent les produits et les catégories du client dans un programme synchro 	0	2022-02-17	\N	8	0	2022-02-17	\N	35	74	5	2	2022-02-17 09:56:59	2022-02-21 12:11:49	74	2022-02-21 12:11:49	f	t
439	Modification du programme qui envoie une alerte e-mail les fichiers backup du jour manquantes.	80	2022-02-23	\N	5	0	2022-02-23	\N	31	74	4	2	2022-02-23 10:12:59	2022-02-25 10:53:47	74	\N	f	f
325	Mise à jour export vers Odoo	0	2022-02-11	\N	16	0	2022-02-13	\N	29	73	5	2	2022-02-11 10:43:24	2022-02-21 12:32:00	73	2022-02-21 12:32:00	f	f
344	Création d'un champ "publier sur le web"  sur les catégories	0	2022-02-15	\N	8	0	2022-02-16	\N	30	72	5	2	2022-02-15 10:11:45	2022-02-21 12:30:27	72	2022-02-21 12:30:27	f	f
354	Récupération de la tva sur Odoo de l'article pour le site	0	2022-02-15	\N	35	0	2022-02-21	\N	32	81	5	2	2022-02-15 13:54:22	2022-02-21 12:41:53	81	2022-02-21 12:41:53	f	f
349	Restriction sur la modifcation des catégories	0	2022-02-15	\N	35	0	2022-02-21	\N	32	81	5	2	2022-02-15 10:41:20	2022-02-21 13:15:17	81	2022-02-21 13:15:17	f	f
309	Cacher le bouton confirmer dans travel order si l'utilisateur n'en a pas le droit	0	2022-02-08	\N	1	0	2022-02-11	\N	33	78	4	2	2022-02-08 16:29:51	2022-02-18 16:04:18	78	\N	f	f
370	Afficher TVA en bas de la fiche commande même si c'est à 0	0	2022-02-17	\N	1	0	2022-02-18	\N	33	78	5	2	2022-02-17 10:01:11	2022-02-18 16:24:40	78	\N	f	t
392	Renommer "TVA" en "TVA sur fees" dans la facture	0	2022-02-21	\N	1	0	2022-02-22	\N	33	78	5	2	2022-02-21 09:56:36	2022-02-21 14:55:21	78	\N	f	t
373	Départ et Arrivée: des listes déroulantes (quand on a la liste)	0	2022-02-17	\N	1	0	2022-02-18	\N	33	78	2	2	2022-02-17 10:02:49	2022-02-22 09:33:50	78	\N	f	t
332	Achat plugin version pro wpallimport , wpallexport, wpai-woocommerce-add-on	0	2022-02-14	\N	12	0	2022-02-15	\N	35	\N	5	2	2022-02-14 12:20:37	2022-02-22 11:45:47	70	2022-02-22 11:45:47	f	f
355	Calcul automatique du montant du service fees	0	2022-02-15	\N	8	0	2022-02-15	\N	29	73	4	2	2022-02-15 14:14:04	2022-02-22 11:52:12	73	\N	f	f
335	Prise en compte des données Tour (en cas de modification du circuit)	0	2022-02-14	\N	24	0	2022-02-16	\N	33	79	4	2	2022-02-14 14:43:00	2022-02-22 13:29:12	71	\N	f	f
289	Changement de libellé: Usager => Passager, Partenaire => Client	0	2022-02-07	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-07 15:56:37	2022-02-08 17:32:35	78	2022-02-08 17:32:35	f	f
291	Créer des boutons d'impression de Devis/Commande/Pro Forma, ne les afficher qu'à l'état convenable de la commande	0	2022-02-07	\N	2	0	2022-02-11	\N	33	78	5	2	2022-02-07 15:59:55	2022-02-08 17:33:21	78	2022-02-08 17:33:21	f	f
353	Récupération de la tva sur Odoo de l'article pour le site	0	2022-02-15	\N	5	0	2022-02-15	\N	30	81	5	2	2022-02-15 13:09:11	2022-02-22 14:45:37	70	2022-02-22 14:45:37	f	f
423	Création modèle d'Import Client et Devis sur EBP. 	0	2022-02-22	\N	5	0	2022-02-22	\N	35	74	3	2	2022-02-22 11:52:55	2022-02-22 14:44:55	74	\N	f	f
477	Déblocage d'un problème de création d'un BL	0	2022-02-28	\N	1	0	2022-02-23	\N	36	76	1	2	2022-02-28 10:51:09	2022-02-28 07:51:09	76	\N	f	t
264	Vérification des sauvegardes sur les serveurs clients 	90	2022-02-07	\N	6	0	2022-02-07	\N	31	74	4	2	2022-02-07 11:52:08	2022-03-02 15:33:47	74	\N	f	t
298	Type du chams libellé global: Char => Text	0	2022-02-07	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-07 16:09:21	2022-02-08 12:23:37	78	2022-02-08 12:23:37	f	f
292	Filtrer articles sur le fournisseur selectionné ou le fournisseur sur l'article selectionné	100	2022-02-07	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-07 16:01:27	2022-02-08 09:24:33	78	2022-02-08 12:24:33	f	f
265	Amélioration de l'application	100	2022-02-07	\N	8	0	2022-02-08	\N	29	73	5	2	2022-02-07 11:53:36	2022-02-21 09:31:53	73	2022-02-21 12:31:53	f	f
328	Extraction Image EBP	0	2022-02-14	\N	5	0	2022-02-14	\N	31	74	5	2	2022-02-14 12:16:47	2022-02-28 13:23:13	74	2022-02-28 13:23:13	f	t
414	Adaptation/Vérification du programme Import Devis sur EBP	80	2022-02-21	\N	5	0	2022-02-21	\N	35	74	5	2	2022-02-21 12:21:02	2022-02-28 13:28:31	70	2022-02-28 13:28:31	f	f
425	Affichage des 'PNR AirSegments' dans la liste des vols effectués	0	2022-02-22	\N	4	0	2022-02-23	317	29	73	4	2	2022-02-22 11:56:16	2022-03-01 10:20:56	73	\N	f	f
310	L'application se récharge automatiquement après quelque moment	0	2022-02-08	\N	32	0	2022-02-28	\N	34	75	1	2	2022-02-08 16:44:53	2022-02-09 10:13:07	70	\N	f	f
305	Renommer "Sous-total" dans document facture en "Sous-total HT" et exclue tout taxe de sa valeur	0	2022-02-08	\N	3	0	2022-02-11	\N	33	78	2	2	2022-02-08 16:15:53	2022-02-10 12:16:41	78	\N	f	f
420	Ajustement des stocks de hhs6301	0	2022-02-21	\N	1	0	2022-02-21	\N	32	77	5	2	2022-02-21 17:23:34	2022-02-22 16:11:59	77	\N	f	t
341	Finir le rapprochement bancaire pour une banque	100	2022-02-14	\N	6	6	2022-02-18	\N	33	79	5	2	2022-02-14 16:25:13	2022-02-22 15:33:38	79	\N	f	t
385	synchronisation des categories odoo et site web	95	2022-02-18	\N	5	0	2022-02-18	\N	30	72	5	2	2022-02-18 11:25:18	2022-03-01 14:53:36	72	2022-03-01 14:53:36	f	f
312	Restauration du site sur le serveur de test	100	2022-02-08	\N	4	4	2022-02-09	\N	35	75	5	2	2022-02-08 17:12:35	2022-02-14 12:18:44	70	2022-02-14 12:18:44	f	f
436	Ajustement des stocks 2845 (HOT POT) et CONTRE PLAQUE BAKELISE 1220*2440*15MM	0	2022-02-22	\N	1	0	2022-02-22	\N	32	77	5	2	2022-02-22 14:32:55	2022-02-22 16:10:20	77	\N	f	t
358	Transfert Image To FTP	0	2022-02-16	\N	5	0	2022-02-15	\N	35	74	5	2	2022-02-16 10:09:37	2022-02-21 09:49:30	74	2022-02-21 09:49:30	f	f
338	Demander l'accès au serveur sftp à Mr Andy	0	2022-02-14	\N	1	0	2022-02-14	\N	33	\N	5	2	2022-02-14 16:18:42	2022-02-14 16:18:48	70	2022-02-14 16:18:48	f	f
362	Création nouvel utilisateur Odoo	0	2022-02-16	\N	2	0	2022-02-16	\N	32	77	5	2	2022-02-16 11:19:35	2022-02-22 16:11:04	77	\N	f	t
342	Envoyer de la liste des articles pour indiquer ceux qui sont à publier ou non sur le site	0	2022-02-14	\N	2	0	2022-02-15	\N	36	\N	1	2	2022-02-14 16:25:36	2022-02-14 13:25:36	70	\N	f	f
334	Mise à jour tarifs	80	2022-02-14	\N	16	14	2022-02-16	\N	36	76	4	2	2022-02-14 14:35:50	2022-03-09 15:13:22	71	\N	f	f
468	Baser toutes les politiques de facturations sur les quantités commandées	0	2022-02-25	\N	1	0	2022-03-07	\N	33	78	1	2	2022-02-25 10:27:36	2022-02-25 07:27:36	78	\N	f	t
382	Mettre total Billet en dessous des lignes de commande	0	2022-02-17	\N	2	0	2022-02-25	381	33	78	1	2	2022-02-17 10:10:57	2022-02-17 07:10:57	78	\N	f	f
403	Dans fiche facture > Ecriture comptable, les libellés doivent avoir la même valeur sur toutes les lignes	0	2022-02-21	\N	3	0	2022-02-25	\N	33	78	1	2	2022-02-21 10:06:17	2022-02-21 07:06:17	78	\N	f	t
404	Dans fiche facture > Ecriture comptable, mettre une ligne par billet	0	2022-02-21	\N	3	0	2022-02-25	\N	33	78	1	2	2022-02-21 10:06:47	2022-02-21 07:06:47	78	\N	f	t
311	•\tPouvoir mettre une virgule dans Tâche > Durée estimée	50	2022-02-08	\N	3	0	2022-02-11	\N	34	81	1	2	2022-02-08 17:07:42	2022-03-17 17:05:28	71	\N	f	f
367	Rendre le champs Numéro PNR dans le document de commande obligatoire	0	2022-02-17	\N	1	0	2022-02-18	\N	33	78	5	2	2022-02-17 09:58:35	2022-02-18 16:19:56	78	\N	f	t
381	Mettre un compteur du nombre de billet (en considérant les lignes contenant le même numéro de billet)	0	2022-02-17	\N	4	0	2022-02-25	\N	33	78	4	2	2022-02-17 10:09:34	2022-02-21 12:23:57	78	\N	f	f
350	IMPRESSION DES TICKETS DE CAISSE A MOB+	0	2022-02-15	\N	5	0	2022-02-08	\N	36	76	2	2	2022-02-15 10:42:10	2022-02-21 12:38:46	76	\N	f	f
418	Rajout catalogue FOSKA sur le site	0	2022-02-21	\N	16	0	2022-02-23	\N	32	\N	3	2	2022-02-21 12:29:30	2022-02-21 12:29:42	70	\N	f	f
364	Création compte utilisateur EBP COMPTA, FRANK	0	2022-02-16	\N	1	0	2022-02-16	\N	36	76	4	2	2022-02-16 13:22:21	2022-02-17 10:00:29	76	\N	f	t
377	Renommer "Date d'arrivé" en "Date d'arrivée"	0	2022-02-17	\N	1	0	2022-02-18	\N	33	78	5	2	2022-02-17 10:05:09	2022-02-18 16:25:09	78	\N	f	t
276	Gestion des clients en compte et client de passage	0	2022-02-07	\N	6	0	2022-02-11	\N	33	78	4	2	2022-02-07 13:56:48	2022-02-18 16:26:03	78	\N	f	f
446	Déblocage d'un problème de connexion à la base	0	2022-02-24	\N	1	0	2022-02-23	\N	36	76	1	2	2022-02-24 15:42:50	2022-02-24 12:42:50	76	\N	f	t
303	Gestion des threads	0	2022-02-08	\N	4	0	2022-02-08	265	29	73	5	2	2022-02-08 13:05:08	2022-02-21 12:31:53	73	\N	f	f
393	Renommer "Nombre d'achat" en "Achat" dans le document travel order	0	2022-02-21	\N	1	0	2022-02-21	\N	33	78	5	2	2022-02-21 09:57:25	2022-02-21 12:37:33	78	\N	f	t
396	Renommer "Agence de voyage" en "Agences de voyage"	0	2022-02-21	\N	1	0	2022-02-21	\N	33	78	5	2	2022-02-21 09:59:20	2022-02-21 17:25:47	78	\N	f	t
429	Préparation fichier d'inventaire	0	2022-02-22	\N	1	0	2022-02-21	\N	36	76	4	2	2022-02-22 12:38:25	2022-02-22 12:39:40	76	\N	f	t
304	Photos INGCO	0	2022-02-08	\N	16	0	2022-02-11	\N	32	77	5	2	2022-02-08 13:42:12	2022-02-10 22:02:14	77	2022-02-10 22:02:14	f	f
388	Rendre la référence de travel order obligatoire	0	2022-02-18	\N	1	0	2022-02-18	\N	33	78	4	2	2022-02-18 17:17:15	2022-02-18 17:18:50	78	\N	f	f
359	Envoyer fichier dans l'FTP du Site COMPUTEK	0	2022-02-16	\N	5	0	2022-02-16	\N	35	74	3	2	2022-02-16 10:11:44	2022-02-21 09:12:52	74	\N	t	f
368	Enlever User 01, User 02, User 03 de la liste des clients dans document de commande	0	2022-02-17	\N	1	0	2022-02-18	\N	33	78	5	2	2022-02-17 09:59:48	2022-02-28 12:00:09	78	2022-02-28 12:00:09	f	t
308	Définir la valeur de taxes_id dans le document achat à null lors de l'acceptation d'une commande	0	2022-02-08	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-08 16:24:47	2022-02-28 12:00:19	78	2022-02-28 12:00:19	f	f
232	Installation du nouveau programme sauvegarde sur les serveurs clients	0	2022-02-04	\N	24	0	2022-02-07	\N	31	74	5	2	2022-02-04 14:59:31	2022-02-22 14:39:23	70	2022-02-22 14:39:23	f	f
485	Module de gestion d'avance salariale Odoo	60	2022-02-28	\N	24	0	2022-03-03	\N	32	72	3	2	2022-02-28 15:15:36	2022-03-16 14:06:33	72	\N	f	f
297	Ne pas afficher les détails des lignes dans l'impression (facture, devis, commande, pro forma)	0	2022-02-07	\N	4	0	2022-02-11	\N	33	78	4	2	2022-02-07 16:08:38	2022-02-08 12:02:02	78	\N	f	f
294	Ajouter numéro de dossier dans la commande	0	2022-02-07	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-07 16:05:03	2022-02-08 12:24:22	78	2022-02-08 12:24:22	f	f
293	Ajouter les champs active product et active supplier pour filtrer les articles et les fournisseurs	0	2022-02-07	\N	1	0	2022-02-11	292	33	78	5	2	2022-02-07 16:02:41	2022-02-08 12:24:33	78	\N	f	f
281	Cacher le champs émission, sa valeur est toujour la même	0	2022-02-07	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-07 15:49:11	2022-02-08 12:42:30	78	2022-02-08 12:42:30	f	f
378	droit d'autorisation pour SABIR	0	2022-02-17	\N	1	0	2022-02-17	\N	36	76	5	2	2022-02-17 10:06:24	2022-02-21 09:01:09	76	2022-02-21 09:01:09	f	t
406	Dans impression facture, mettre les fournisseurs au niveau de la ligne	0	2022-02-21	\N	2	0	2022-02-25	\N	33	78	5	2	2022-02-21 10:08:43	2022-02-28 12:43:06	78	\N	f	t
337	Demander la liste de tous les clients Incadea à mettre en place sur le dossier de test	0	2022-02-14	\N	1	0	2022-02-14	\N	33	\N	5	2	2022-02-14 16:18:07	2022-02-14 16:18:14	70	2022-02-14 16:18:14	f	f
343	Analyser la problématique d'envoi automatique des messages whatsapp et mails	0	2022-02-14	\N	8	0	2022-02-18	\N	36	\N	1	2	2022-02-14 16:26:23	2022-02-14 13:26:23	70	\N	f	f
428	Modèle d'impression BON DE TRANSFERT	0	2022-02-22	\N	2	0	2022-02-22	\N	36	76	5	2	2022-02-22 12:36:04	2022-02-22 15:37:21	76	\N	f	t
419	Mise à jour compte de dépense pour le PO PO26496 sur CHEINMALT	0	2022-02-21	\N	1	0	2022-02-21	\N	32	\N	3	2	2022-02-21 15:42:42	2022-02-21 15:42:49	70	\N	f	f
424	Adaptation/vérification du programme import client	0	2022-02-22	\N	5	0	2022-02-22	\N	35	74	3	2	2022-02-22 11:55:03	2022-02-22 11:55:12	74	\N	f	f
314	•\tAjouter un champ description dans une tâche	0	2022-02-08	\N	2	0	2022-02-11	\N	34	81	1	2	2022-02-08 17:15:34	2022-02-08 14:15:34	71	\N	f	f
313	•\tNombre de tâches dans Kanban view devrait être selon utilisateur connecté (ne voir que le nombre de tâches de l’utilisateur connecté)	0	2022-02-08	\N	16	0	2022-02-11	\N	34	81	1	2	2022-02-08 17:14:34	2022-02-08 17:15:49	71	\N	f	f
329	Intégration des requêtes et adaptation des programmes synchro	0	2022-02-14	\N	30	0	2022-02-16	\N	35	74	5	2	2022-02-14 12:17:21	2022-02-21 09:50:40	70	2022-02-21 09:50:40	f	f
369	Mettre la liste de prix en mode lecture seule et/ou la masquer	0	2022-02-17	\N	1	0	2022-02-18	\N	33	78	5	2	2022-02-17 10:00:30	2022-02-18 16:24:18	78	\N	f	t
306	Désactiver certaines colonne dans travel order selon l'article selectionné	0	2022-02-08	\N	1	0	2022-02-11	\N	33	78	4	2	2022-02-08 16:16:43	2022-02-18 16:26:11	78	\N	f	f
432	Rapprochement bancaire juiller-aôut BMOI Chainmalt	100	2022-02-22	\N	8	8	2022-02-22	\N	33	79	4	2	2022-02-22 13:30:16	2022-02-22 15:35:33	79	\N	f	f
290	Définir le libellé des lignes 401 fournisseurs et 411 clients de l'écriture comptables (valeur: libellé global de la commande)	0	2022-02-07	\N	3	0	2022-02-11	\N	33	78	2	2	2022-02-07 15:58:27	2022-02-09 13:03:25	78	\N	f	f
296	Ajouter un champs pour le numéro de jour	0	2022-02-07	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-07 16:06:59	2022-02-10 10:06:05	78	2022-02-10 10:06:05	f	f
394	Renommer "Remboursement partiel" en "Avoir partiel" dans document facture > ajouter un avoir	0	2022-02-21	\N	2	0	2022-02-25	\N	33	78	1	2	2022-02-21 09:58:23	2022-02-21 06:58:23	78	\N	f	t
395	Renommer "Remboursement intégral" en "Avoir intégral" dans document facture > ajouter un avoir	0	2022-02-21	\N	1	0	2022-02-25	\N	33	78	1	2	2022-02-21 09:58:48	2022-02-21 06:58:48	78	\N	f	t
407	Dans la fiche facture > Ajouter un avoir, l'option date d'extourne doit être la date du jour et non la date de la pièce comptable	0	2022-02-21	\N	3	0	2022-02-25	\N	33	78	1	2	2022-02-21 10:10:24	2022-02-21 07:10:24	78	\N	f	t
409	Erreur lors de la confirmation d'un avoir	0	2022-02-21	\N	3	0	2022-02-25	\N	33	78	1	2	2022-02-21 10:11:28	2022-02-21 07:11:28	78	\N	f	t
411	Ajouter la compagnie/fournisseur dans l'avoir client	0	2022-02-21	\N	2	0	2022-02-25	410	33	78	1	2	2022-02-21 10:13:03	2022-02-21 07:13:03	78	\N	f	t
351	RESTRICTION D’ACCES SUR VALIDATION DE FACTURE FOURNISSEUR	0	2022-02-15	\N	10	0	2022-02-08	\N	36	76	2	2	2022-02-15 10:43:40	2022-02-21 10:17:25	76	\N	f	f
415	Préparation un fichier d'inventaire COMPUTEK	0	2022-02-21	\N	3	0	2022-02-22	\N	36	76	5	2	2022-02-21 12:21:15	2022-02-22 15:37:27	76	\N	f	t
431	Intégration de stock du PO26496 dépôt 3	0	2022-02-22	\N	3	0	2022-02-22	\N	32	77	5	2	2022-02-22 12:49:42	2022-02-22 16:12:09	77	\N	f	t
438	Liste des articles doublons avec stock > 0 et stock=0 mais article mouvementé	0	2022-02-23	\N	1	0	2022-02-22	\N	36	76	4	2	2022-02-23 08:50:20	2022-02-23 08:50:48	76	\N	f	t
422	Correction des conflits entre la version WP all import et Wordpress	20	2022-02-22	\N	6	0	2022-02-22	\N	35	75	5	2	2022-02-22 10:42:10	2022-02-22 14:23:49	75	2022-02-22 14:23:49	f	f
445	Mise en place E-mail "cheinmaltcompta2@groupe-qlm.com"	0	2022-02-24	\N	1	0	2022-02-24	\N	32	77	5	2	2022-02-24 11:50:40	2022-02-24 11:50:55	77	\N	f	t
456	Créer un manuel d'utilisation pour l'application	0	2022-02-25	\N	5	0	2022-03-07	\N	33	78	1	2	2022-02-25 10:11:20	2022-02-25 07:11:20	78	\N	f	t
426	Affichage des autres informations significatives d'un billet	0	2022-02-22	\N	4	0	2022-02-23	317	29	73	4	2	2022-02-22 11:57:11	2022-03-04 11:18:39	73	\N	f	f
487	Créer un champs dans res.partner pour y stocker GenBusPostingGroup_G	0	2022-02-28	\N	1	0	2022-02-28	\N	33	78	1	2	2022-02-28 15:51:25	2022-02-28 12:51:25	78	\N	f	t
486	Mise à jour emplacement Dépôt 2 du 25/02/2022	0	2022-02-28	\N	5	0	2022-02-28	\N	32	77	5	2	2022-02-28 15:39:27	2022-02-28 16:19:54	77	\N	f	t
530	Intégration inventaire RFI du 03/03/2022	0	2022-03-04	\N	5	0	2022-03-04	\N	32	77	5	2	2022-03-04 13:31:31	2022-03-04 14:32:08	77	\N	f	t
496	Ajustement des stocks pour reglement Avoir [TPN2]	0	2022-03-01	\N	1	0	2022-03-01	\N	32	77	5	2	2022-03-01 12:11:46	2022-03-01 12:11:52	77	\N	f	t
498	Définir la valeur de la colonne posting group dans l'export d'écriture comptable avec posting group des clients ou fournisseurs corrspondants	0	2022-03-01	\N	1	0	2022-03-01	\N	33	78	1	2	2022-03-01 12:14:19	2022-03-01 09:14:19	78	\N	f	t
300	module de notification odoo	25	2022-02-07	\N	18	0	2022-02-09	\N	30	72	3	2	2022-02-07 16:38:13	2022-02-25 09:56:58	72	\N	f	f
457	Générer automatiquement le numéro de dossier (to) à partir de certains champs déjà saisis ou dès qu'un document est ouvert	0	2022-02-25	\N	2	0	2022-02-07	\N	33	78	1	2	2022-02-25 10:12:35	2022-02-25 07:12:35	78	\N	f	t
478	Sauvegarde Manuel en attendant la mise en place d'un server ftp via windows	0	2022-02-28	\N	5	0	2022-02-28	\N	31	74	4	2	2022-02-28 10:52:30	2022-03-01 14:43:44	74	\N	f	f
511	Bébloquage utilisateur dans CRM	0	2022-03-02	\N	1	0	2022-03-01	\N	36	76	3	2	2022-03-02 14:18:07	2022-03-02 14:18:17	76	\N	f	t
460	Enlever le champs référence dans doc de type to	0	2022-02-25	\N	1	0	2022-03-07	\N	33	78	5	2	2022-02-25 10:16:04	2022-02-25 13:06:42	78	\N	f	t
455	Intégration d'inventaire pour Computek Tamatave	30	2022-02-25	\N	2	1	2022-02-25	\N	36	76	5	2	2022-02-25 09:05:24	2022-02-25 15:30:31	76	\N	f	t
531	Validation BL CHM/BL/16176, CHM/BL/15175, CHM/BL/21054, CHM/BL/21065	0	2022-03-04	\N	3	0	2022-03-04	\N	32	77	5	2	2022-03-04 17:08:40	2022-03-04 17:09:09	77	\N	f	t
448	Suppression des doublons des clients	100	2022-02-24	\N	12	12	2022-02-24	\N	36	76	5	2	2022-02-24 15:45:41	2022-02-25 16:28:36	76	\N	f	t
449	Suppression des Clients n'ayant pas d'échéance, ni de téléphone et d'adresse,commence par (mr,mm) 	0	2022-02-24	\N	3	0	2022-02-24	448	36	\N	5	2	2022-02-24 15:49:28	2022-02-25 16:28:36	76	\N	f	t
514	Contre inventaire pour COMPUTEK TANA	0	2022-03-02	\N	2	0	2022-03-02	\N	36	76	5	2	2022-03-02 14:22:04	2022-03-02 14:22:52	76	\N	f	t
536	Mise en place des procédures	0	2022-03-07	\N	96	0	2022-03-11	\N	40	92	1	2	2022-03-07 10:02:26	2022-03-07 07:02:26	92	\N	f	f
542	Modification du statut des articles qui n'ont pas de mouvement, mettre en sommeil	100	2022-03-07	\N	2	2	2022-03-07	\N	36	76	5	2	2022-03-07 16:48:04	2022-03-08 08:05:26	76	\N	f	t
453	Suppression des bases SQL EBP	0	2022-02-24	\N	1	0	2022-02-24	\N	36	76	1	2	2022-02-24 15:55:09	2022-03-16 10:58:13	76	\N	f	t
479	Inventaire TANA et TAMATAVE	0	2022-02-28	\N	3	0	2022-02-28	\N	36	76	5	2	2022-02-28 10:53:14	2022-02-28 10:53:25	76	\N	f	t
488	Mise à jour emplacement dépôt 2 du 23/02/2022	0	2022-02-28	\N	5	0	2022-02-24	\N	32	77	1	2	2022-02-28 16:33:44	2022-02-28 13:33:44	77	\N	f	t
452	Déblocage d'un problème de création d'un BL	100	2022-02-24	\N	1	1	2022-02-24	\N	36	76	5	2	2022-02-24 15:53:05	2022-02-24 15:54:30	76	\N	f	t
500	Ajouter un champs gen_bus_pg dans res.partner	0	2022-03-01	\N	1	0	2022-03-01	\N	33	78	5	2	2022-03-01 12:47:20	2022-03-01 12:59:24	78	\N	f	t
458	Lors de la sélection d'un client dans travel order, afficher le numéro de compte de celui-ci	0	2022-02-25	\N	2	0	2022-02-07	\N	33	78	3	2	2022-02-25 10:13:42	2022-02-25 10:13:53	78	\N	f	t
459	Synchronisation des clients odoo avec ceux dans Incadea	0	2022-02-25	\N	3	0	2022-02-07	\N	33	78	1	2	2022-02-25 10:15:13	2022-02-25 07:15:13	78	\N	f	t
501	Importer les GenBusPostingGroup des clients et fournisseurs	0	2022-03-01	\N	1	0	2022-03-01	\N	33	78	5	2	2022-03-01 12:48:30	2022-03-01 13:00:52	78	\N	f	t
450	Listes des articles déjà bloqués	0	2022-02-24	\N	2	0	2022-02-24	\N	36	76	5	2	2022-02-24 15:51:34	2022-02-25 16:28:58	76	\N	f	t
469	Créer un champas pour la référence fournisseur dans doc facture et afficher sa valeur dans l'impression	0	2022-02-25	\N	2	0	2022-02-07	\N	33	78	2	2	2022-02-25 10:32:31	2022-02-27 18:42:35	78	\N	f	t
528	Affichage des segments de vols d'un billet	0	2022-03-04	\N	8	0	2022-03-04	219	29	73	4	2	2022-03-04 10:47:07	2022-03-04 12:31:37	73	\N	f	f
533	Inventaire sur une période	0	2022-03-07	\N	96	0	2022-03-11	\N	41	92	1	2	2022-03-07 09:28:29	2022-03-07 06:28:29	92	\N	f	f
481	Bébloquage erreur de réconciliation de donnée GESCOM et CRM	100	2022-02-28	\N	2	1	2022-02-28	\N	36	76	5	2	2022-02-28 10:55:42	2022-03-01 16:44:58	76	\N	f	t
534	Création champ perso pour OF d'origine	0	2022-03-07	\N	96	0	2022-03-11	\N	41	92	1	2	2022-03-07 09:31:08	2022-03-07 06:31:08	92	\N	f	f
504	Bébloquage d'utilisateur dans CRM	100	2022-03-01	\N	1	1	2022-03-01	\N	36	76	5	2	2022-03-01 16:44:28	2022-03-01 16:45:25	76	\N	f	t
503	Ajustement de stock Chein/Stock pour validation BL	0	2022-03-01	\N	2	0	2022-03-01	\N	32	77	5	2	2022-03-01 14:52:25	2022-03-02 11:23:26	77	\N	f	t
548	STC Hasina .R Cheinmalt (salaire, solde de congé, préavis)	0	2022-03-08	\N	8	0	2022-03-08	\N	32	77	5	2	2022-03-08 13:16:30	2022-03-08 16:33:57	77	\N	f	t
543	Contre-inventaire Computek TANA, 	0	2022-03-07	\N	1	0	2022-03-07	\N	36	76	5	2	2022-03-07 16:49:10	2022-03-07 16:49:42	76	\N	f	t
537	Ajustement de stock pour validation BL avec Mme Jeanne	0	2022-03-07	\N	8	0	2022-03-07	\N	32	77	5	2	2022-03-07 12:34:41	2022-03-07 17:54:11	77	\N	f	t
546	Sauvegarde manuelle backup EBP vers Sync.com	90	2022-03-08	\N	5	0	2022-03-08	\N	31	74	4	2	2022-03-08 09:09:30	2022-03-09 12:00:04	74	\N	f	f
451	Paramétrage sur les fiches Clients	100	2022-02-24	\N	2	2	2022-02-24	\N	36	76	5	2	2022-02-24 15:52:21	2022-03-08 07:43:39	76	\N	f	t
551	Inventaire Computek TANA, date date du document 28/02/2022	100	2022-03-09	\N	1	1	2022-03-09	\N	36	76	5	2	2022-03-09 15:21:15	2022-03-09 15:22:03	76	\N	f	t
553	Validation BL, demande par Mme Jeanne du 14/03/22	0	2022-03-16	\N	3	0	2022-03-16	\N	32	77	5	2	2022-03-16 09:28:23	2022-03-16 09:28:32	77	\N	f	t
516	Backup Site web/base de données et mise  en place WPAllimport	90	2022-03-02	\N	6	0	2022-03-03	\N	35	75	4	2	2022-03-02 16:03:07	2022-03-16 16:18:02	75	\N	f	f
560	Sauvegarde des backups vers 37 puis vers sync.com	0	2022-03-17	\N	5	0	2022-03-11	\N	31	74	4	2	2022-03-17 16:57:56	2022-03-17 16:59:43	74	\N	f	f
561	Sauvegarde des backups vers 37 puis vers sync.com	0	2022-03-17	\N	5	0	2022-03-14	\N	31	74	4	2	2022-03-17 16:58:16	2022-03-17 16:59:46	74	\N	f	f
461	Déplacer la colonne fournisseur avant la colonne articles	0	2022-02-25	\N	1	0	2022-03-07	\N	33	78	3	2	2022-02-25 10:16:51	2022-02-25 10:17:35	78	\N	f	t
320	Annuler document achat lors d'une annulation d'un devis au lieu de le supprimer	0	2022-02-10	\N	1	0	2022-02-11	\N	33	78	5	2	2022-02-10 12:21:35	2022-02-28 11:37:56	78	2022-02-28 11:37:56	f	f
489	Ne pas afficher le champs "type de client" dans la fiche fournisseur	0	2022-03-01	\N	1	0	2022-03-01	\N	33	78	1	2	2022-03-01 09:56:48	2022-03-01 06:56:48	78	\N	f	t
552	Mise en page des catégories sur le menu gauche du site	80	2022-03-09	\N	4	0	2022-03-10	\N	35	75	4	2	2022-03-09 16:35:41	2022-03-16 16:18:20	75	\N	f	t
522	Listes des articles qui n'on pas de mouvement du 3 derniers mois	100	2022-03-03	\N	2	2	2022-03-03	\N	36	76	5	2	2022-03-03 09:23:19	2022-03-04 09:32:20	76	\N	f	t
333	Mise à jour des familles	70	2022-02-14	\N	5	5	2022-02-28	\N	36	76	4	2	2022-02-14 14:34:35	2022-03-09 15:13:12	71	\N	f	f
499	Ajustement de stock pour validation BL CHM/BL/21311	0	2022-03-01	\N	1	0	2022-03-01	\N	32	77	5	2	2022-03-01 12:15:06	2022-03-01 12:15:14	77	\N	f	t
518	Sauvegarde manuel backup ebp	90	2022-03-03	\N	5	0	2022-03-03	\N	31	74	4	2	2022-03-03 07:57:12	2022-03-04 09:59:29	74	\N	f	f
219	Lecture des données XML	0	2022-02-03	\N	8	8	2022-02-04	\N	29	73	5	2	2022-02-03 10:47:56	2022-03-04 07:47:07	70	\N	f	t
442	Installation des paquets 	100	2022-02-24	\N	5	0	2022-02-24	\N	38	72	4	2	2022-02-24 10:15:16	2022-03-01 23:29:32	70	\N	f	f
490	Gestion de paie mois de février 2022 - Cheinmalt	0	2022-03-01	\N	48	0	2022-03-02	\N	32	77	5	2	2022-03-01 10:11:15	2022-03-02 11:23:31	77	\N	f	t
532	Création Tableau pour les articles Bien	0	2022-03-07	\N	96	0	2022-03-11	\N	41	92	1	2	2022-03-07 09:27:10	2022-03-07 06:27:10	92	\N	f	f
512	Déblocage compte bloqué par ADM et MGBI2	100	2022-03-02	\N	1	1	2022-03-02	\N	36	76	5	2	2022-03-02 14:19:35	2022-03-02 14:19:54	76	\N	f	t
517	Envoie des fiches de salaire Cheinmalt, QLM, Codimat et Codigaz	0	2022-03-02	\N	1	0	2022-03-02	\N	32	77	5	2	2022-03-02 16:15:51	2022-03-02 16:16:00	77	\N	f	t
525	Validation des BL CHM/BL/21377, CHM/BL/21326,CHM/BL/19980,CHM/BL/21179,CHM/BL/19542,CHM/BL/16176 (démande de Mme Jeanne)	0	2022-03-03	\N	2	0	2022-03-03	\N	32	77	5	2	2022-03-03 16:10:42	2022-03-03 16:11:02	77	\N	f	t
527	Sauvegarde manuelle vers Syn.com	90	2022-03-04	\N	5	0	2022-03-04	\N	31	74	4	2	2022-03-04 10:00:30	2022-03-07 14:36:26	74	\N	f	f
538	Optimisation de la base de données pour améliorer la navigation sur le site	0	2022-03-07	\N	4	0	2022-03-07	\N	39	75	5	2	2022-03-07 14:35:06	2022-03-07 16:40:10	75	\N	f	t
523	Paramétrage des vues dans GESCOM, accès au filtrage d'une date	0	2022-03-03	\N	1	0	2022-03-04	\N	36	76	5	2	2022-03-03 09:24:32	2022-03-07 16:52:16	76	\N	f	t
480	Liste des articles sans code barre	100	2022-02-28	\N	2	2	2022-02-28	\N	36	76	5	2	2022-02-28 10:54:11	2022-03-08 07:47:59	76	\N	f	t
535	Gestion des emplacements 	0	2022-03-07	\N	96	0	2022-03-11	\N	40	92	1	2	2022-03-07 10:01:12	2022-03-15 14:54:47	92	\N	f	f
544	Modification droit de validation Inventaire	100	2022-03-07	\N	1	1	2022-03-08	\N	36	76	5	2	2022-03-07 16:50:36	2022-03-08 16:41:38	76	\N	f	t
554	Mise en place Stock du PO26731 fichier INGCO 18H	0	2022-03-16	\N	4	0	2022-03-16	\N	32	77	5	2	2022-03-16 09:29:32	2022-03-16 09:29:40	77	\N	f	t
555	Préparation fichier d'import famille articles Cheinmalt	0	2022-03-16	\N	72	0	2022-03-18	\N	32	77	3	2	2022-03-16 09:31:23	2022-03-16 09:31:36	77	\N	f	t
547	configuration de la base de données SQL Server EDR	0	2022-03-08	\N	3	0	2022-03-09	\N	38	72	4	2	2022-03-08 11:37:06	2022-03-16 13:42:03	72	\N	f	f
562	Sauvegarde des backups vers 37 puis vers sync.com	0	2022-03-17	\N	5	0	2022-03-15	\N	31	74	4	2	2022-03-17 17:00:29	2022-03-17 17:01:04	74	\N	f	f
558	Mise en place de WP All Export(commandes et utilisateurs) sur le site computek 	55	2022-03-16	\N	4	0	2022-03-16	\N	35	75	4	2	2022-03-16 16:16:43	2022-03-16 16:17:41	75	\N	f	f
559	Sauvegarde des backups vers 37 puis vers sync.com	0	2022-03-17	\N	5	0	2022-03-10	\N	31	74	4	2	2022-03-17 16:55:46	2022-03-17 16:57:19	74	\N	f	f
454	Intégration des Stocks dépôt 2 PO24141 et autres articles (carreaux)	0	2022-02-24	\N	3	0	2022-02-24	\N	32	77	5	2	2022-02-24 17:00:50	2022-02-24 17:00:56	77	\N	f	t
462	Filtrer les articles selon le fournisseur selectionné	0	2022-02-25	\N	2	0	2022-03-07	\N	33	78	1	2	2022-02-25 10:19:56	2022-02-25 07:19:56	78	\N	f	t
529	Affichage des historiques d'un billet	0	2022-03-04	\N	8	0	2022-03-04	317	29	73	3	2	2022-03-04 11:19:32	2022-03-04 11:19:42	73	\N	f	f
441	Repertorier les ecritures non rapprochées - BMOI Chainmalt	0	2022-02-24	\N	8	0	2022-02-28	\N	33	79	5	2	2022-02-24 09:34:50	2022-02-25 10:53:44	79	\N	f	t
463	Renommer "Quantité" en "Nombre de chambres/personnes"	0	2022-02-25	\N	1	0	2022-03-07	\N	33	78	2	2	2022-02-25 10:20:53	2022-02-27 18:20:02	78	\N	f	t
482	Finalisation de la requête Granit	0	2022-02-28	\N	2	0	2022-02-28	\N	33	79	1	2	2022-02-28 11:00:44	2022-02-28 11:00:57	79	\N	f	f
465	Prendre en compte "Nombre" dans le calcul du prix total et du total HT	0	2022-02-25	\N	2	0	2022-03-07	\N	33	78	5	2	2022-02-25 10:23:38	2022-02-28 11:16:09	78	\N	f	t
405	Afficher les autres taxes dans l'impression facture	0	2022-02-21	\N	3	0	2022-02-25	\N	33	78	5	2	2022-02-21 10:08:07	2022-02-28 12:35:57	78	\N	f	t
484	Adapter les fichiers de configurations Import/Export avec le nouveau sftp Incadea	0	2022-02-28	\N	3	0	2022-03-07	\N	33	78	3	2	2022-02-28 12:42:13	2022-02-28 15:39:03	78	\N	f	t
563	Sauvegarde des backups vers 37 puis vers sync.com	0	2022-03-17	\N	5	0	2022-03-16	\N	31	74	4	2	2022-03-17 17:01:15	2022-03-17 17:06:40	74	\N	f	f
545	Listes des BL non facturés	100	2022-03-07	\N	3	3	2022-03-08	\N	36	76	5	2	2022-03-07 16:50:56	2022-03-07 16:51:31	76	\N	f	t
491	Ajout autres détails d'un PNR: Affichage + Traitement	0	2022-03-01	\N	16	0	2022-03-03	\N	29	73	4	2	2022-03-01 10:17:29	2022-03-03 09:21:32	73	\N	f	f
524	Ajustement de stock ATG0601 et PEG60*18 pour validation BL	0	2022-03-03	\N	2	0	2022-03-03	\N	32	77	5	2	2022-03-03 11:21:27	2022-03-03 13:16:20	77	\N	f	t
565	Ajustement de stock, demande de Mme Jeanne par Whatsapp	0	2022-03-17	\N	3	0	2022-03-17	\N	32	77	5	2	2022-03-17 17:58:07	2022-03-17 17:58:20	77	\N	f	t
539	Sauvegarde manuelle vers Syn.com	0	2022-03-07	\N	5	0	2022-03-07	\N	31	74	4	2	2022-03-07 14:37:19	2022-03-08 09:03:47	74	\N	f	f
507	Gestion de paie fév 2022 - QLM/Codigaz/Codimat	0	2022-03-02	\N	8	0	2022-03-02	\N	32	77	5	2	2022-03-02 11:24:12	2022-03-03 13:16:53	77	\N	f	t
519	Insertion d'ARTICLE qui ne sont pas dans la nouvelle base	100	2022-03-03	\N	2	2	2022-03-03	\N	36	76	5	2	2022-03-03 09:20:49	2022-03-03 15:39:26	76	\N	f	t
549	Ajustement de stock pour validation BL demande de Mme Jeanne	0	2022-03-08	\N	3	0	2022-03-08	\N	32	77	5	2	2022-03-08 16:33:44	2022-03-08 16:33:49	77	\N	f	t
556	Création utilisateur HAJA de l'équipe de TANA	100	2022-03-16	\N	1	1	2022-03-17	\N	36	76	5	2	2022-03-16 10:56:36	2022-03-16 12:00:23	76	\N	f	t
505	Débogage au niveau des filtres du tableau principale	80	2022-03-01	\N	12	0	2022-03-04	\N	38	72	2	2	2022-03-01 23:30:59	2022-03-16 15:14:00	72	\N	f	f
494	Tâche 1	0	2022-03-01	\N	16	0	2022-03-04	\N	40	92	1	2	2022-03-01 12:03:49	2022-03-01 13:06:41	71	\N	f	f
550	Sauvegarde manuelle depuis 37 vers sync.com	90	2022-03-09	\N	5	0	2022-03-09	\N	31	74	4	2	2022-03-09 12:00:40	2022-03-17 16:51:56	74	\N	f	f
397	Ajouter dans le document d'achat le numéro du vol et les dates (dates de départ et d'arrivée)	0	2022-02-21	\N	1	0	2022-02-25	\N	33	78	5	2	2022-02-21 10:00:22	2022-02-28 11:16:34	78	\N	f	t
495	Tâche 1	0	2022-03-01	\N	16	0	2022-03-18	\N	41	92	1	2	2022-03-01 12:08:00	2022-03-01 09:08:00	71	\N	f	f
464	Renommer "Nombre" en "Nombre de nuitées"	0	2022-02-25	\N	1	0	2022-03-07	\N	33	78	5	2	2022-02-25 10:21:52	2022-02-27 18:19:43	78	\N	f	t
467	Relier la colonne référence fournisseur avec le champ référence fournisseur dans doc achat	0	2022-02-25	\N	2	0	2022-03-07	\N	33	78	5	2	2022-02-25 10:25:48	2022-02-27 18:45:16	78	\N	f	t
492	Ajouter un champs posting group dans res.partner	0	2022-03-01	\N	1	0	2022-03-01	\N	33	78	5	2	2022-03-01 11:34:18	2022-03-01 12:12:46	78	\N	f	t
506	Vérifier si modificaiton de rapport devis amadeus a impacté celui de to	0	2022-03-02	\N	1	0	2022-03-07	\N	33	78	1	2	2022-03-02 11:12:56	2022-03-02 08:12:56	78	\N	f	t
526	Creation d'un Bon de sortie pour régulariser un AVOIR	100	2022-03-04	\N	3	2	2022-03-07	\N	36	76	5	2	2022-03-04 09:34:38	2022-03-04 13:14:49	76	\N	f	t
509	Vérification stock des articles et validation des livraisons VCHD21123	0	2022-03-02	\N	2	0	2022-03-02	\N	32	77	5	2	2022-03-02 11:26:24	2022-03-02 11:26:42	77	\N	f	t
513	Droit d'utilisateur	0	2022-03-02	\N	1	0	2022-03-01	\N	36	76	3	2	2022-03-02 14:20:30	2022-03-02 14:21:00	76	\N	f	t
540	TEST2	0	2022-03-07	\N	5	0	2022-03-07	\N	37	91	1	2	2022-03-07 16:46:15	2022-03-07 16:46:50	71	\N	f	f
521	Accès dans OLAP pour les MANAGERS	100	2022-03-03	\N	1	1	2022-03-03	\N	36	76	3	2	2022-03-03 09:22:30	2022-03-07 16:49:28	76	\N	f	t
520	Béblocage des utilisateurs bloqué du CRM	0	2022-03-03	\N	0	0	2022-03-03	\N	36	76	5	2	2022-03-03 09:21:51	2022-03-03 15:14:08	76	\N	f	t
557	Modèle d'impression FACTURE D'ACOMPTE	90	2022-03-16	\N	2	2	2022-03-17	\N	36	76	5	2	2022-03-16 10:57:31	2022-03-16 16:45:43	76	\N	f	t
564	Sauvegarde des backups vers 37 puis vers sync.com	0	2022-03-17	\N	5	0	2022-03-17	\N	31	74	4	2	2022-03-17 17:07:02	2022-03-17 17:07:22	74	\N	f	f
566	Intégration stock dépôt 3, demande de Mme Jeanne (Chein/INT/03214)	0	2022-03-17	\N	4	0	2022-03-17	\N	32	77	5	2	2022-03-17 18:01:15	2022-03-17 18:01:24	77	\N	f	t
476	Paramétrage sur les fiches CLIENTS	0	2022-02-28	\N	2	0	2022-02-23	\N	36	76	3	2	2022-02-28 10:49:18	2022-03-04 13:21:36	76	\N	f	t
473	Préparation fichier d'import avoirs MOURTAZA VALIBHAY	0	2022-02-25	\N	72	0	2022-03-01	\N	32	77	5	2	2022-02-25 16:20:55	2022-02-28 11:45:09	77	\N	f	t
541	Modification droit des utilisateurs, Seul ZOHAR et KOULSOUM peuvent supprimer un BL	0	2022-03-07	\N	1	0	2022-03-08	\N	36	76	5	2	2022-03-07 16:46:55	2022-03-07 16:47:14	76	\N	f	t
471	Relier Travel Order et Account Move par des ids	0	2022-02-25	\N	2	0	2022-03-07	\N	33	78	1	2	2022-02-25 12:24:20	2022-02-25 09:24:20	78	\N	f	t
472	Intégration stock dépôt 2 du 24/02/2022	0	2022-02-25	\N	3	0	2022-02-25	\N	32	77	5	2	2022-02-25 16:18:52	2022-02-25 16:19:06	77	\N	f	t
515	Sauvegarde manuel backup EBP	90	2022-03-02	\N	5	0	2022-03-02	\N	31	74	4	2	2022-03-02 15:34:07	2022-03-03 07:56:43	74	\N	f	f
466	Ajouter une colonne pour la référence facture fournisseur à côté de la colonne fournisseur	0	2022-02-25	\N	1	0	2022-03-07	\N	33	78	5	2	2022-02-25 10:24:32	2022-02-27 18:45:26	78	\N	f	t
435	Correction erreurs sur le module Fabrication	0	2022-02-22	\N	6	0	2022-02-23	\N	32	81	5	2	2022-02-22 14:19:33	2022-02-28 13:28:00	70	2022-02-28 13:28:00	f	f
430	Fusion des comptes utilisateurs, Hasina01, Hasina02,Hasina03,Hasina04 => Hasina	100	2022-02-22	\N	1	1	2022-02-22	\N	36	76	5	2	2022-02-22 12:41:35	2022-02-28 15:38:43	76	\N	f	t
483	Ajustement de stock via Mme Jeanne (image whatsapp)	0	2022-02-28	\N	8	0	2022-02-28	\N	32	77	5	2	2022-02-28 11:50:35	2022-02-28 15:40:35	77	\N	f	t
497	Tâche 1	0	2022-03-01	\N	16	0	2022-03-18	\N	33	92	1	2	2022-03-01 12:12:18	2022-03-01 09:12:18	71	\N	f	f
493	Importer les postings group des clients et dans odoo	0	2022-03-01	\N	1	0	2022-03-01	\N	33	78	5	2	2022-03-01 11:35:11	2022-03-01 12:13:00	78	\N	f	t
508	Validation BL Cheinmalt CHM/BL/21868, CHM/BL/21828, CHM/BL/20587	0	2022-03-02	\N	4	0	2022-03-02	\N	32	77	5	2	2022-03-02 11:25:21	2022-03-02 11:25:27	77	\N	f	t
474	Import avoirs MOURTAZA VALIBHAY	100	2022-02-25	2022-02-28	48	0	2022-03-01	\N	32	77	4	2	2022-02-25 16:28:39	2022-03-02 11:29:15	77	\N	f	f
510	Mise en place d'une methode de validation pour sauvegarder les ecritures rapprochés	0	2022-03-02	\N	4	0	2022-03-02	\N	33	79	4	2	2022-03-02 13:54:47	2022-03-02 13:55:09	79	\N	f	f
502	Sauvegarde Manuel des backups	90	2022-03-01	\N	5	0	2022-03-01	\N	31	74	4	2	2022-03-01 14:43:39	2022-03-02 15:32:59	74	\N	f	f
470	Mise en place server FTP	80	2022-02-25	\N	5	0	2022-02-25	\N	31	74	4	2	2022-02-25 10:54:25	2022-03-02 15:33:13	74	\N	f	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.users (id, username, profile_picture, email, password, right_id, inserted_at, updated_at) FROM stdin;
64	client3	images/profiles/default_profile_pic.png	client3@gmail.com	$2b$12$c3diaef5qYrq/shcAB/SB.hV3FKJx7v4T/C96/mR6oAXlAoa4BhS.	5	2021-08-24 14:26:14	2021-08-24 14:26:14
65	client4	images/profiles/default_profile_pic.png	client4@gmail.com	$2b$12$W.7bN24lIxFz1VHryd31iuBfvg8rAl.9QwCXOA3z1DltEcw7HlOqi	4	2021-08-24 14:34:55	2021-08-24 14:34:55
66	client5	images/profiles/default_profile_pic.png	client5@gmail.com	$2b$12$MgZiOeNrcRt3hrAdUV6I/.f5qeI/S80R5gWXOGPLHrpItzvta385i	4	2021-08-24 14:37:57	2021-08-24 14:37:57
33	Eric	images/profiles/Eric-profile.png	eric@soc	$2b$12$aK2fjkTDZh6ULSz5GmZCh.vA0OOWhnSI0quNwDOavdCN831CNg7uq	4	2021-03-26 06:37:02	2021-06-08 07:45:45
25	Profilnonattribué	images/profiles/Profilnonattribué-profile.png	profilnonattribue@mgbi.com	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	5	2021-03-25 11:09:44	2021-06-08 14:45:27
53	Attributeur	images/profiles/Attributeur-profile.png	attributeur@mgbi	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	2	2021-04-13 11:30:16	2021-06-12 09:58:51
67	client6	images/profiles/default_profile_pic.png	client6@gmail.com	$2b$12$B3X0xy1H3gpZMYae6Hww2e/LOVG99mFscEkGGSTdYazp8y8OTIVPC	4	2021-08-24 14:41:14	2021-08-24 14:41:14
58	Marc	images/profiles/Marc-profile.png	marc@comp	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	4	2021-05-02 13:24:25	2021-06-04 15:06:15
54	Mgbi1	images/profiles/Mgbi1-profile.png	contributeur@mgbi	$2b$12$sxaYg4bRhFyE7RDn0gaXcOlDkEnhOoPFpB./8Ir.RDNKR85vsv6nK	3	2021-04-13 11:38:03	2021-06-04 15:06:48
56	Mgbi2	images/profiles/Mgbi2-profile.png	contributeur2@mgbi	$2b$12$xjnYOEvFZyi6ky2vB8HGCO//zHlN8lqg56hBeGE/ezDgqB/z01Z8a	3	2021-05-01 18:12:11	2021-06-04 15:07:05
68	client7	images/profiles/default_profile_pic.png	client7@gmail.com	$2b$12$bFZDNR2imYKkg1VFc2VikutKVNkRtkqQh/BhvHQLzb1H1JkRt.n32	4	2021-08-27 07:01:04	2021-08-27 07:01:04
57	Mgbi	images/profiles/Mgbi-profile.png	admin@admin.mgbi	$2b$12$ppF6QKRLMia3lvzr1XY3C.fXB0Qv5WB4M8a.o6Pe96TI3Sxw1ETbC	1	2021-05-01 21:28:30	2021-06-16 07:47:04
59	Nouveau	images/profiles/default_profile_pic.png	nouveau@mgbi	$2b$12$uLv4bNisBinwwPPtFBBOYu67tC3.X.ROPHzoLxQsggHo4YU8FtWc2	5	2021-06-08 17:54:58	2021-06-18 20:00:29
55	Jesuisarchivé	images/profiles/Jesuisarchivé-profile.png	archivé@mgbi	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	100	2021-04-13 11:46:26	2021-06-18 22:08:44
62	ContributeurMGBI	images/profiles/default_profile_pic.png	contrbuteur_mgbi@mgbi.com	$2b$12$UfFDknShAZ1iwKV2RdrS/eVAvU7YepyJ0.7SpGv00dNxaNMkC0VYi	3	2021-07-05 07:40:23	2021-07-05 07:40:52
63	client2	images/profiles/default_profile_pic.png	client@gmail.com	$2b$12$2hzENwFn7ZYFTKLMrCyD/uL/ko73chK7j9bxwqWpaYCrJISCgxgle	4	2021-08-24 14:15:16	2021-08-24 14:18:10
69	QLM	images/profiles/default_profile_pic.png	qlm@client.mg	$2b$12$z3shGh3GmIrP.UDBfj6j/e3wL7MipPN0QFPxPrkeYyKyIcwA/Guz2	4	2022-01-28 13:51:04	2022-01-28 13:51:48
41	Test	images/profiles/Test-profile.png	test@test	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	100	2021-03-30 18:00:03	2022-01-31 10:44:39
52	Admin	images/profiles/Admin-profile.png	admin@myadmin	$2b$12$3yngeegsjEEifTOEZDSfAeOXnuyBOkCfjGUN.7GdIW1A57mD6tKqO	100	2021-04-13 08:28:09	2022-01-31 10:44:44
70	Mihaja	images/profiles/default_profile_pic.png	mihaja@phidia.onmicrosoft.com	$2b$12$na9nKThDzzUwtgh.mf9joO4REW/iV7qcXnYTUmlBdiByO4aWZp5ma	2	2022-01-31 10:40:40	2022-01-31 11:04:02
81	Matthieu	images/profiles/default_profile_pic.png	matthieu@phidia.onmicrosoft.com	$2b$12$Rh6CARfNVajUWgK2FVRtUOF91zMNHKheXFnD/CIyekXzIFgHM/0Ui	3	2022-01-31 11:06:47	2022-01-31 11:07:24
75	Fanantenana	images/profiles/default_profile_pic.png	fanantenana@phidia.onmicrosoft.com	$2b$12$uqmfhy8jtvc4yHtjOSgqGeY2Tble8VX7/WdF4/9PrqhfOR3oNK17y	3	2022-01-31 10:53:44	2022-01-31 11:09:48
79	Haro	images/profiles/default_profile_pic.png	haro@phidia.onmicrosoft.com	$2b$12$oFnClXibjrzZTG/RmD/vCec6a1ni4j2eEwgimjER5akr6IRLIa7zW	3	2022-01-31 10:56:33	2022-01-31 11:10:24
87	M-TEC	images/profiles/default_profile_pic.png	m-tec@m-tec.mg	$2b$12$3aXG7vTOwe.Ry4k/OZJ9COcOLdKJav3HU2Kfp2jUjAdsf/YUT1w1G	4	2022-02-14 22:55:15	2022-02-14 22:55:15
80	Christiane	images/profiles/default_profile_pic.png	christianebillere@gmail.com	$2b$12$akMZYTfszQxNP/InOUkng.HFEeP54h84X9dr2x72iI2sOyak9MIDK	3	2022-01-31 10:57:09	2022-01-31 11:08:38
73	Famenontsoa	images/profiles/default_profile_pic.png	famenontsoa@outlook.com	$2b$12$HDiPnkrttSGndW1L0bViO.CvvB/UwwDTT9O2EElNhirIMOyBguM.2	3	2022-01-31 10:50:32	2022-01-31 11:09:21
76	Miandrisoa	images/profiles/default_profile_pic.png	miandrisoa.eric@outlook.fr	$2b$12$3yhMUNjoaGr4znOZdcbSMe0d/xTFi1rlfnqtBZvx7wdW/8qfunHZC	3	2022-01-31 10:54:34	2022-02-01 08:40:37
83	SIGM	images/profiles/default_profile_pic.png	sigm@cfao.com	$2b$12$/P90GO.HpZzgRtk.Bg9Vi.vYOgHm3y365ek14nuLw4vI.7GPB1jTy	4	2022-02-03 07:19:04	2022-02-03 07:19:04
77	Elie	images/profiles/Elie-profile.webp	elie.phidia@outlook.com	$2b$12$LlZED5T2Ngu3Y6Ipt0yWVufBO2hYNjvsi8xDVbcp/YkbLeTUMJQqe	3	2022-01-31 10:55:09	2022-02-04 13:35:53
72	Nasolo	images/profiles/default_profile_pic.png	nasolo@phidia.onmicrosoft.com	$2b$12$MALC18N40L7vu1x/IaOpDexnSgwspFmdcbxNjR.Tywl.obC4mzrE6	3	2022-01-31 10:43:47	2022-02-07 10:13:00
78	Rémi	images/profiles/default_profile_pic.png	remi@phidia.onmicrosoft.com	$2b$12$cSNKv8tmj91.Eqayy7ezXeWMclAkt/ZsGJzHG459b3BNzD3LqaYTW	3	2022-01-31 10:56:07	2022-02-07 10:27:51
84	COMPUTEK	images/profiles/default_profile_pic.png	jejoumtahinason@gmail.com	$2b$12$oTD8.6BEp0/XjT.Og3kx9el.8AHwVI5s69JFPJUdIu2dilcGZDbDy	4	2022-02-08 14:10:27	2022-02-08 14:10:27
71	Michel	images/profiles/Michel-profile.jpg	michel@phidia.onmicrosoft.com	$2b$12$9GzLDJT9Ha89hZSwJawpq.IfuJdevVwJoCnv58qouGvmwg.r0CgKK	2	2022-01-31 10:42:34	2022-02-08 14:13:12
85	Philippe PREVOST	images/profiles/default_profile_pic.png	pp@phidia.onmicrosoft.com	$2b$12$hUKH8Fh8y85RYTbLFo.ThOtpNdT4iIIsEI8aIOeXKQj41J3uKjfpK	1	2022-02-08 14:13:20	2022-02-08 14:36:18
88	EDR	images/profiles/default_profile_pic.png	edr@edr.com	$2b$12$VOX6DXt0gQfmRujlaP.IB.spsJ8wqInA2EBAgxgnaRq9MJoDBhsK6	4	2022-02-24 07:13:03	2022-02-24 07:13:03
89	CDC	images/profiles/default_profile_pic.png	cdc@cdc.com	$2b$12$C4nDSP43/0OpZg5oApm0IuZ0/d34ln0UhIJxpq7Or4wnVqCcuPSbu	4	2022-02-24 07:30:15	2022-02-24 07:30:15
90	NAJMI	images/profiles/default_profile_pic.png	najmi@najmi.mg	$2b$12$SiZDRuhRyDoYM416rc8KXunvqUVEOvZ.GXmf3EzDeQuaH.W1M2Lly	4	2022-02-28 09:51:30	2022-02-28 09:51:30
91	Tino	images/profiles/default_profile_pic.png	ramitsirihajaharifetra@gmail.com	$2b$12$IihZpgn.xA1GboklQhba/e.0OaPlnvLFEewmemISqFL8r62Rs1uVK	3	2022-03-01 08:45:44	2022-03-01 09:00:59
92	Nicky	images/profiles/default_profile_pic.png	nicky.mgbi@gmail.mg	$2b$12$bW3//bTnxmK4YCxDB1jjDOGX8bzUKIyF4rMKgOmWa1XmM2lmANp2e	3	2022-03-01 08:47:38	2022-03-01 09:01:36
93	MADAPLAST	images/profiles/default_profile_pic.png	madaplast@madaplast.mg	$2b$12$LgLQC2LsJVh3T8q4wKprdudojSKQ9dqW3NlIN6k5ALtjoGp9zuIB.	4	2022-03-01 09:05:44	2022-03-01 09:05:44
74	Osé	images/profiles/Osé-profile.jpg	ose.phidia@outlook.com	$2b$12$Mm.EV387GSeI7ih1xPvPhehJkUkulMufKYEiEYJrzXRk4mzQ9ALsO	3	2022-01-31 10:52:35	2022-03-18 05:49:11
94	Alain	images/profiles/default_profile_pic.png	nambinintsoa.dev@gmail.com	$2b$12$8L1Q1lTvs2XgzESt6nwyCenwak699s5IWLUJUpZpp0zeaTVxFKdH6	3	2022-03-07 11:21:22	2022-03-07 11:48:45
95	Hasimbola	images/profiles/Hasimbola-profile.jpg	rakotosonhasina00@gmail.com	$2b$12$BFhEdZDEqLLw.Oes52lMgOpyldB6EV6ox4NEKHi4Wcx8qcfuKkE0i	3	2022-03-07 11:26:59	2022-03-07 11:55:48
\.


--
-- Name: active_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.active_clients_id_seq', 23, true);


--
-- Name: assist_contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.assist_contracts_id_seq', 11, true);


--
-- Name: base_cache_signaling; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_cache_signaling', 1, true);


--
-- Name: base_registry_signaling; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_registry_signaling', 1, true);


--
-- Name: boards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.boards_id_seq', 55, true);


--
-- Name: cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.cards_id_seq', 544, true);


--
-- Name: clients_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.clients_requests_id_seq', 29, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.comments_id_seq', 135, true);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.companies_id_seq', 9, true);


--
-- Name: editors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.editors_id_seq', 13, true);


--
-- Name: licenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.licenses_id_seq', 6, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.notifications_id_seq', 8212, true);


--
-- Name: planified_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.planified_id_seq', 17, true);


--
-- Name: priorities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.priorities_id_seq', 4, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.projects_id_seq', 41, true);


--
-- Name: rights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.rights_id_seq', 31, true);


--
-- Name: softwares_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.softwares_id_seq', 4, true);


--
-- Name: stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.stages_id_seq', 270, true);


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.statuses_id_seq', 5, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.tasks_id_seq', 566, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.users_id_seq', 96, true);


--
-- Name: active_clients active_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.active_clients
    ADD CONSTRAINT active_clients_pkey PRIMARY KEY (id);


--
-- Name: assist_contracts assist_contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.assist_contracts
    ADD CONSTRAINT assist_contracts_pkey PRIMARY KEY (id);


--
-- Name: boards boards_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.boards
    ADD CONSTRAINT boards_pkey PRIMARY KEY (id);


--
-- Name: cards cards_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (id);


--
-- Name: clients_requests clients_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.clients_requests
    ADD CONSTRAINT clients_requests_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: editors editors_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.editors
    ADD CONSTRAINT editors_pkey PRIMARY KEY (id);


--
-- Name: licenses licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: planified planified_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.planified
    ADD CONSTRAINT planified_pkey PRIMARY KEY (id);


--
-- Name: priorities priorities_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.priorities
    ADD CONSTRAINT priorities_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: rights rights_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.rights
    ADD CONSTRAINT rights_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: softwares softwares_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.softwares
    ADD CONSTRAINT softwares_pkey PRIMARY KEY (id);


--
-- Name: stages stages_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.stages
    ADD CONSTRAINT stages_pkey PRIMARY KEY (id);


--
-- Name: statuses statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: active_clients_company_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX active_clients_company_id_index ON public.active_clients USING btree (company_id);


--
-- Name: active_clients_user_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX active_clients_user_id_index ON public.active_clients USING btree (user_id);


--
-- Name: assist_contracts_company_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX assist_contracts_company_id_index ON public.assist_contracts USING btree (company_id);


--
-- Name: assist_contracts_title_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE UNIQUE INDEX assist_contracts_title_index ON public.assist_contracts USING btree (title);


--
-- Name: cards_position_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX cards_position_index ON public.cards USING btree ("position");


--
-- Name: clients_requests_active_client_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX clients_requests_active_client_id_index ON public.clients_requests USING btree (active_client_id);


--
-- Name: clients_requests_title_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE UNIQUE INDEX clients_requests_title_index ON public.clients_requests USING btree (title);


--
-- Name: comments_poster_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX comments_poster_id_index ON public.comments USING btree (poster_id);


--
-- Name: comments_task_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX comments_task_id_index ON public.comments USING btree (task_id);


--
-- Name: editors_company_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX editors_company_id_index ON public.editors USING btree (company_id);


--
-- Name: editors_title_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE UNIQUE INDEX editors_title_index ON public.editors USING btree (title);


--
-- Name: licenses_company_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX licenses_company_id_index ON public.licenses USING btree (company_id);


--
-- Name: licenses_title_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE UNIQUE INDEX licenses_title_index ON public.licenses USING btree (title);


--
-- Name: notifications_receiver_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX notifications_receiver_id_index ON public.notifications USING btree (receiver_id);


--
-- Name: notifications_sender_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX notifications_sender_id_index ON public.notifications USING btree (sender_id);


--
-- Name: projects_active_client_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX projects_active_client_id_index ON public.projects USING btree (active_client_id);


--
-- Name: projects_status_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX projects_status_id_index ON public.projects USING btree (status_id);


--
-- Name: rights_title_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE UNIQUE INDEX rights_title_index ON public.rights USING btree (title);


--
-- Name: softwares_company_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX softwares_company_id_index ON public.softwares USING btree (company_id);


--
-- Name: softwares_title_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE UNIQUE INDEX softwares_title_index ON public.softwares USING btree (title);


--
-- Name: stages_position_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX stages_position_index ON public.stages USING btree ("position");


--
-- Name: tasks_contributor_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX tasks_contributor_id_index ON public.tasks USING btree (contributor_id);


--
-- Name: tasks_parent_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX tasks_parent_id_index ON public.tasks USING btree (parent_id);


--
-- Name: tasks_priority_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX tasks_priority_id_index ON public.tasks USING btree (priority_id);


--
-- Name: tasks_project_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX tasks_project_id_index ON public.tasks USING btree (project_id);


--
-- Name: tasks_status_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX tasks_status_id_index ON public.tasks USING btree (status_id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: users_right_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX users_right_id_index ON public.users USING btree (right_id);


--
-- Name: users_username_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE UNIQUE INDEX users_username_index ON public.users USING btree (username);


--
-- Name: active_clients active_clients_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.active_clients
    ADD CONSTRAINT active_clients_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: active_clients active_clients_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.active_clients
    ADD CONSTRAINT active_clients_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: assist_contracts assist_contracts_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.assist_contracts
    ADD CONSTRAINT assist_contracts_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: cards cards_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_stage_id_fkey FOREIGN KEY (stage_id) REFERENCES public.stages(id) ON DELETE CASCADE;


--
-- Name: cards cards_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: clients_requests clients_requests_active_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.clients_requests
    ADD CONSTRAINT clients_requests_active_client_id_fkey FOREIGN KEY (active_client_id) REFERENCES public.active_clients(id);


--
-- Name: comments comments_poster_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_poster_id_fkey FOREIGN KEY (poster_id) REFERENCES public.users(id);


--
-- Name: comments comments_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- Name: editors editors_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.editors
    ADD CONSTRAINT editors_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: licenses licenses_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: notifications notifications_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public.users(id);


--
-- Name: notifications notifications_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: projects projects_active_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_active_client_id_fkey FOREIGN KEY (active_client_id) REFERENCES public.active_clients(id);


--
-- Name: projects projects_board_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_board_id_fkey FOREIGN KEY (board_id) REFERENCES public.boards(id);


--
-- Name: projects projects_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.statuses(id);


--
-- Name: softwares softwares_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.softwares
    ADD CONSTRAINT softwares_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: stages stages_board_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.stages
    ADD CONSTRAINT stages_board_id_fkey FOREIGN KEY (board_id) REFERENCES public.boards(id) ON DELETE CASCADE;


--
-- Name: stages stages_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.stages
    ADD CONSTRAINT stages_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.statuses(id);


--
-- Name: tasks tasks_attributor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_attributor_id_fkey FOREIGN KEY (attributor_id) REFERENCES public.users(id);


--
-- Name: tasks tasks_contributor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_contributor_id_fkey FOREIGN KEY (contributor_id) REFERENCES public.users(id);


--
-- Name: tasks tasks_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- Name: tasks tasks_priority_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_priority_id_fkey FOREIGN KEY (priority_id) REFERENCES public.priorities(id);


--
-- Name: tasks tasks_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: tasks tasks_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.statuses(id);


--
-- Name: users users_right_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_right_id_fkey FOREIGN KEY (right_id) REFERENCES public.rights(id);


--
-- PostgreSQL database dump complete
--

