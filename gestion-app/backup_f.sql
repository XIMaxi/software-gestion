--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-12-10 01:13:55

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

--
-- TOC entry 2 (class 3079 OID 25810)
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 232 (class 1259 OID 25791)
-- Name: academic_year; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.academic_year (
    academic_year_id integer NOT NULL,
    year_name integer,
    semester_name character varying
);


ALTER TABLE public.academic_year OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25790)
-- Name: academic_year_year_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.academic_year_year_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.academic_year_year_id_seq OWNER TO postgres;

--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 231
-- Name: academic_year_year_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.academic_year_year_id_seq OWNED BY public.academic_year.academic_year_id;


--
-- TOC entry 219 (class 1259 OID 17412)
-- Name: course_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_requests (
    request_id integer NOT NULL,
    request_status character varying(50),
    school_id integer NOT NULL,
    course_id integer NOT NULL,
    "group" integer,
    assignment_id integer,
    academic_year_id integer,
    CONSTRAINT course_requests_request_status_check CHECK (((request_status)::text = ANY (ARRAY['pending'::text, 'approved'::text, 'rejected'::text])))
);


ALTER TABLE public.course_requests OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17555)
-- Name: course_requests_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_requests_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_requests_course_id_seq OWNER TO postgres;

--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 228
-- Name: course_requests_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_requests_course_id_seq OWNED BY public.course_requests.course_id;


--
-- TOC entry 218 (class 1259 OID 17411)
-- Name: course_requests_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_requests_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_requests_request_id_seq OWNER TO postgres;

--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 218
-- Name: course_requests_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_requests_request_id_seq OWNED BY public.course_requests.request_id;


--
-- TOC entry 221 (class 1259 OID 17431)
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    course_id integer NOT NULL,
    course_name character varying(255) NOT NULL,
    credits integer NOT NULL,
    semester_id integer NOT NULL,
    code character varying,
    CONSTRAINT courses_credits_check CHECK ((credits > 0))
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17430)
-- Name: courses_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.courses_course_id_seq OWNER TO postgres;

--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 220
-- Name: courses_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_course_id_seq OWNED BY public.courses.course_id;


--
-- TOC entry 217 (class 1259 OID 17400)
-- Name: schools; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schools (
    school_id integer NOT NULL,
    school_name character varying(255) NOT NULL
);


ALTER TABLE public.schools OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17399)
-- Name: schools_school_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schools_school_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schools_school_id_seq OWNER TO postgres;

--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 216
-- Name: schools_school_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schools_school_id_seq OWNED BY public.schools.school_id;


--
-- TOC entry 225 (class 1259 OID 17461)
-- Name: semesters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.semesters (
    semester_id integer NOT NULL,
    semester_num integer,
    semester_name character varying
);


ALTER TABLE public.semesters OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17460)
-- Name: semesters_semester_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.semesters_semester_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.semesters_semester_id_seq OWNER TO postgres;

--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 224
-- Name: semesters_semester_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.semesters_semester_id_seq OWNED BY public.semesters.semester_id;


--
-- TOC entry 227 (class 1259 OID 17474)
-- Name: teacher_course_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher_course_assignments (
    assignment_id integer NOT NULL,
    teacher_id integer NOT NULL,
    assigned_date date NOT NULL,
    course_request_id integer,
    academic_year_id integer
);


ALTER TABLE public.teacher_course_assignments OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17473)
-- Name: teacher_course_assignments_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teacher_course_assignments_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teacher_course_assignments_assignment_id_seq OWNER TO postgres;

--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 226
-- Name: teacher_course_assignments_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teacher_course_assignments_assignment_id_seq OWNED BY public.teacher_course_assignments.assignment_id;


--
-- TOC entry 223 (class 1259 OID 17449)
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teachers (
    teacher_id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone_number character varying(20),
    max_credits integer NOT NULL,
    rut_login character varying,
    password character varying,
    contract character varying,
    status boolean,
    CONSTRAINT teachers_max_credits_check CHECK ((max_credits > 0))
);


ALTER TABLE public.teachers OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17448)
-- Name: teachers_teacher_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teachers_teacher_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teachers_teacher_id_seq OWNER TO postgres;

--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 222
-- Name: teachers_teacher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teachers_teacher_id_seq OWNED BY public.teachers.teacher_id;


--
-- TOC entry 229 (class 1259 OID 17573)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role character varying(100)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17581)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 230
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4685 (class 2604 OID 25794)
-- Name: academic_year academic_year_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_year ALTER COLUMN academic_year_id SET DEFAULT nextval('public.academic_year_year_id_seq'::regclass);


--
-- TOC entry 4678 (class 2604 OID 17415)
-- Name: course_requests request_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests ALTER COLUMN request_id SET DEFAULT nextval('public.course_requests_request_id_seq'::regclass);


--
-- TOC entry 4679 (class 2604 OID 17556)
-- Name: course_requests course_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests ALTER COLUMN course_id SET DEFAULT nextval('public.course_requests_course_id_seq'::regclass);


--
-- TOC entry 4680 (class 2604 OID 17434)
-- Name: courses course_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN course_id SET DEFAULT nextval('public.courses_course_id_seq'::regclass);


--
-- TOC entry 4677 (class 2604 OID 17403)
-- Name: schools school_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schools ALTER COLUMN school_id SET DEFAULT nextval('public.schools_school_id_seq'::regclass);


--
-- TOC entry 4682 (class 2604 OID 17464)
-- Name: semesters semester_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semesters ALTER COLUMN semester_id SET DEFAULT nextval('public.semesters_semester_id_seq'::regclass);


--
-- TOC entry 4683 (class 2604 OID 17477)
-- Name: teacher_course_assignments assignment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments ALTER COLUMN assignment_id SET DEFAULT nextval('public.teacher_course_assignments_assignment_id_seq'::regclass);


--
-- TOC entry 4681 (class 2604 OID 17452)
-- Name: teachers teacher_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers ALTER COLUMN teacher_id SET DEFAULT nextval('public.teachers_teacher_id_seq'::regclass);


--
-- TOC entry 4684 (class 2604 OID 17582)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 4879 (class 0 OID 25791)
-- Dependencies: 232
-- Data for Name: academic_year; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.academic_year (academic_year_id, year_name, semester_name) FROM stdin;
1	2024	Primero
2	2024	Segundo
3	2025	Primero
4	2025	Segundo
5	2026	Primero
6	2026	Segundo
7	2027	Primero
8	2027	Segundo
\.


--
-- TOC entry 4866 (class 0 OID 17412)
-- Dependencies: 219
-- Data for Name: course_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_requests (request_id, request_status, school_id, course_id, "group", assignment_id, academic_year_id) FROM stdin;
\.


--
-- TOC entry 4868 (class 0 OID 17431)
-- Dependencies: 221
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (course_id, course_name, credits, semester_id, code) FROM stdin;
153	HIDRÁULICA	4	38	IOCC157-18
154	TOPOGRAFÍA GENERAL	4	38	IOCC165-18
155	ANÁLISIS DE ESTRUCTURAS ISOSTÁTICAS	4	38	IOCC166-18
156	TALLER DE REDES DE AGUA POTABLE Y ALCANTARILLADO	4	38	IOCC168-18
171	MECÁNICA DE SUELOS APLICADA	6	39	IOCC255-18
141	TALLER DE URBANIZACIÓN	6	32	IOCC088-18
142	TALLER DE DIBUJO EN INGENIERÍA	6	32	IOCC104-18
143	MECÁNICA RACIONAL ESTÁTICA	6	32	IOCC109-18
144	MECÁNICA RACIONAL ESTÁTICA	6	32	IOCC109-18
145	TALLER DE INTRODUCCIÓN A LOS PROCESOS CONSTRUCTIVOS	6	32	IOCC119-18
146	TALLER DE INTRODUCCIÓN A LOS PROCESOS CONSTRUCTIVOS	6	32	IOCC119-18
147	TALLER DE INTRODUCCIÓN A LOS PROCESOS CONSTRUCTIVOS	6	32	IOCC119-18
148	TALLER DE INTRODUCCIÓN A LOS PROCESOS CONSTRUCTIVOS	6	32	IOCC119-18
166	DISEÑO DE ELEMENTOS DE HORMIGÓN ARMADO	4	39	IOCC248-18
167	CONSTRUCCIÓN DE OBRAS VIALES	4	39	IOCC251-18
168	DETERIORO Y REPARACIÓN DE MATERIALES DE CONSTRUCCIÓN	4	39	IOCC252-21
169	ESTRATEGIA COMPETITIVA EN CONTEXTO DE OBRAS CIVILES	4	39	IOCC253-22
186	TRABAJO DE TÍTULO	11	40	IOCC297-18
175	PROGRAMACIÓN DE OBRAS	6	40	IOCC259-18
187	PROYECTO DE TÍTULO	11	41	IOCC298-22
185	PRÁCTICA PROFESIONAL	9	41	IOCC295-18
149	ANÁLISIS DE ESTRUCTURAS	6	37	IOCC129-18
152	GESTIÓN DE OPERACIONES EN LA CONSTRUCCIÓN	5	37	IOCC156-13
163	ESTRUCTURAS METÁLICAS Y DE MADERA	6	32	IOCC241-18
189	ESTRUCTURAS DE PUENTES	6	32	IOCC301-11
190	SISMOLOGÍA APLICADA	6	32	IOCC302-11
191	MODELACIÓN DEL COMPORTAMIENTO DE MATERIALES EN EL CONTEXTO DE OBRAS CIVILES	6	32	IOCC315-22
136	TALLER DE INGENIERÍA II	6	31	IOCC038-17
137	TALLER DE MATERIALES DE CONSTRUCCIÓN	6	31	IOCC075-18
138	TALLER DE GEOMETRÍA DESCRIPTIVA	6	31	IOCC079-18
139	TALLER DE GEOMETRÍA DESCRIPTIVA	6	31	IOCC079-18
183	GIRA DE ESTUDIOS	6	40	IOCC290-18
176	INGENIERÍA SISMO RESISTENTE	6	35	IOCC269-18
177	DISEÑO ESTRUCTURAL DE PAVIMENTO	6	35	IOCC279-18
178	DISEÑO AVANZADO DE ESTRUCTURAS DE ACERO	6	35	IOCC280-18
179	INGENIERÍA AMBIENTAL	6	35	IOCC285-18
180	DISEÑO Y CONTROL DE MEZCLAS BITUMINOSAS	6	35	IOCC287-22
181	DISEÑO Y CONTROL DE MEZCLAS BITUMINOSAS	6	35	IOCC287-22
140	MECÁNICA RACIONAL	6	33	IOCC085-18
184	SEMINARIO DE CONSTRUCCIÓN	6	41	IOCC295-08
164	DINÁMICA DE ESTRUCTURAS	6	33	IOCC244-18
165	HORMIGÓN ARMADO	6	33	IOCC245-18
170	SUSTENTABILIDAD DE MATERIALES DE CONSTRUCCIÓN	6	33	IOCC254-21
157	SISTEMAS ESTRUCTURALES	6	34	IOCC178-17
158	DISEÑO ESTRUCTURAL AVANZADO	6	34	IOCC195-17
159	MÉTODOS MATEMÁTICOS PARA INGENIERÍA	6	34	IOCC204-18
160	ESTRATEGIA COMPETITIVA	6	34	IOCC207-21
161	SISTEMAS Y PROCESOS CONSTRUCTIVOS	6	34	IOCC209-18
162	TOPOGRAFÍA GENERAL	6	34	IOCC219-18
188	TESIS	10	41	IOCC298-90
150	MECÁNICA DE SUELOS Y LABORATORIO	4	37	IOCC146-18
151	EDIFICACIÓN EN OBRA GRUESA	4	37	IOCC153-18
182	TALLER DE DISEÑO ESTRUCTURAL	6	36	IOCC288-18
172	EVALUACIÓN DE PROYECTOS	4	36	IOCC256-18
173	DETERIORO Y REPARACIÓN DE MATERIALES DE CONSTRUCCIÓN EN OBRAS CIVILES	4	36	IOCC257-22
174	TALLER DE INSTALACIONES SANITARIAS	4	36	IOCC258-18
\.


--
-- TOC entry 4864 (class 0 OID 17400)
-- Dependencies: 217
-- Data for Name: schools; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schools (school_id, school_name) FROM stdin;
2	BACHILLERATO EN CIENCIAS DE LA INGENIERÍA PLAN COMÚN 
3	INGENIERÍA EN CONSTRUCCIÓN 
4	INGENIERÍA CIVIL EN OBRAS CIVILES 
5	PROGRAMA ESPECIAL DE PREGRADO DE INTERCAMBIO 
6	BACHILLERATO EN CIENCIAS DE LA INGENIERÍA (COY)
7	ARQUITECTURA
\.


--
-- TOC entry 4872 (class 0 OID 17461)
-- Dependencies: 225
-- Data for Name: semesters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.semesters (semester_id, semester_num, semester_name) FROM stdin;
31	1	Semestral
32	2	Semestral
33	3	Semestral
34	4	Semestral
35	5	Anual
36	6	Anual
37	7	Anual
38	8	Anual
39	9	Anual
40	10	Anual
41	11	Anual
\.


--
-- TOC entry 4874 (class 0 OID 17474)
-- Dependencies: 227
-- Data for Name: teacher_course_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher_course_assignments (assignment_id, teacher_id, assigned_date, course_request_id, academic_year_id) FROM stdin;
\.


--
-- TOC entry 4870 (class 0 OID 17449)
-- Dependencies: 223
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teachers (teacher_id, first_name, last_name, email, phone_number, max_credits, rut_login, password, contract, status) FROM stdin;
30	Nadia	Cardenas	nadia.cardenas@uach.cl	(56) 63222 1862	30	xxxxxx-x	pswxxxxx	ADJ	t
1	A	Castro	a.castro@uach.cl  \n	123456789	20	12345678-9	password1	ACA	t
2	A	Garcia	a.garcia@uach.cl  \n	987654321	25	98765432-1	password2	ADJ	t
3	Aitor	Rasposeiras	aitor.rasposeiras@uach.cl  \n	456123789	15	45678912-3	password3	ACA	f
4	Carolina	Zuñiga	carolina.zuniga@uach.cl  \n	321654987	30	32165498-7	password4	HON	t
5	David	Alvarado	david.alvarado@uach.cl  \n	654321987	10	65432112-5	password5	HON	t
18	Gustavo	Lacrampe	gustavo.lacrampe@uach.cl  \n	951753456	17	95175345-6	password14	ACA	f
20	Jorge	Alvial	jorge.alvial@uach.cl  \n	456951753	20	45695175-3	password16	ACA	f
21	Jose	Arrey	jose.arrey@uach.cl  \n	852147963	14	85214796-3	password17	ACA	f
24	Jose	Soto	jose.soto@uach.cl  \n	123456789	23	12345678-5	password20	ACA	f
29	Manuel	Lagos	manuel.lagos@uach.cl  \n\n\n\n\n\n	456123789	20	45612378-9	password25	PAD	f
31	Osvaldo	Muñoz	osvaldo.munoz@uach.cl	123456789	20	osvaldom	password123	PAD	t
32	Pablo	Oyarzun	pablo.oyarzun@uach.cl	123456789	20	pabloo	password123	ACA	t
33	Pablo	Vergara	pablo.vergara@uach.cl	123456789	20	pablov	password123	HON	t
34	Ricardo	Larsen	ricardo.larsen@uach.cl	123456789	20	ricardol	password123	ACA	t
35	Simon	Bustos	simon.bustos@uach.cl	123456789	20	simonb	password123	HON	t
36	Uwe	Muhlich	uwe.muhlich@uach.cl	123456789	20	uwem	password123	ACA	t
37	Valerio	Andres	valerio.andres@uach.cl	123456789	20	valerioa	password123	ACA	f
7	David	Peña	david.pena@uach.cl  \n	123456789	15	11111111-1	password1	ADJ	t
10	David	Peña(HON)	david.pena2@uach.cl  \n	123789456	18	12378945-6	password6	HON	t
11	Eduardo	Peldoza	eduardo.peldoza@uach.cl  \n	789456123	22	78945612-3	password7	ACA	t
12	Fabian	Guzman	fabian.guzman@uach.cl  \n	147258369	20	14725836-9	password8	HON	t
13	Fernando	Huenchullanca	fernando.huenchullanca@uach.cl  \n	258369147	12	25836914-7	password9	HON	t
14	Fabiola	Ojeda	fabiola.ojeda@uach.cl  \n	369147258	24	36914725-8	password10	ADJ	t
15	Frank	Schanack	frank.schanack@uach.cl  \n	741852963	15	74185296-3	password11	ACA	t
16	Felipe	Vargas	felipe.vargas@uach.cl  \n	852963741	28	85296374-1	password12	ACA	t
17	Gloria	Barria	gloria.barria@uach.cl  \n	963741852	19	96374185-2	password13	HON	t
19	Galo	Valdebenito	galo.valdebenito@uach.cl  \n	753951456	21	75395145-6	password15	ACA	t
22	Juan Francisco	Carrasco	juanfrancisco.carrasco@uach.cl  \n	741963852	25	74196385-2	password18	HON	t
23	Juan Patricio	Reyes	juanpatricio.reyes@uach.cl  \n	369852147	18	36985214-7	password19	ADJ	t
25	Konstantin	Verichev	konstantin.verichev@uach.cl  \n	789123456	27	78912345-6	password21	ACA	t
26	Loreto	Cerda	loreto.cerda@uach.cl  \n	147852369	16	14785236-9	password22	HON	t
27	Loreto	Troncoso	loreto.troncoso@uach.cl  \n	258741369	29	25874136-9	password23	ACA	t
28	Marco	Amaya	marco.amaya@uach.cl  \n	369258147	13	36925814-5	password24	HON	t
\.


--
-- TOC entry 4876 (class 0 OID 17573)
-- Dependencies: 229
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, email, password, role) FROM stdin;
\.


--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 231
-- Name: academic_year_year_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.academic_year_year_id_seq', 1, false);


--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 228
-- Name: course_requests_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_requests_course_id_seq', 5, true);


--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 218
-- Name: course_requests_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_requests_request_id_seq', 1, false);


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 220
-- Name: courses_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_course_id_seq', 191, true);


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 216
-- Name: schools_school_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schools_school_id_seq', 7, true);


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 224
-- Name: semesters_semester_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.semesters_semester_id_seq', 41, true);


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 226
-- Name: teacher_course_assignments_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teacher_course_assignments_assignment_id_seq', 1, false);


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 222
-- Name: teachers_teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teachers_teacher_id_seq', 30, true);


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 230
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- TOC entry 4711 (class 2606 OID 25798)
-- Name: academic_year academic_year_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_year
    ADD CONSTRAINT academic_year_pkey PRIMARY KEY (academic_year_id);


--
-- TOC entry 4692 (class 2606 OID 17419)
-- Name: course_requests course_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests
    ADD CONSTRAINT course_requests_pkey PRIMARY KEY (request_id);


--
-- TOC entry 4697 (class 2606 OID 17437)
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);


--
-- TOC entry 4690 (class 2606 OID 17405)
-- Name: schools schools_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (school_id);


--
-- TOC entry 4704 (class 2606 OID 17467)
-- Name: semesters semesters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semesters
    ADD CONSTRAINT semesters_pkey PRIMARY KEY (semester_id);


--
-- TOC entry 4707 (class 2606 OID 17479)
-- Name: teacher_course_assignments teacher_course_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT teacher_course_assignments_pkey PRIMARY KEY (assignment_id);


--
-- TOC entry 4700 (class 2606 OID 17459)
-- Name: teachers teachers_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_email_key UNIQUE (email);


--
-- TOC entry 4702 (class 2606 OID 17457)
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (teacher_id);


--
-- TOC entry 4709 (class 2606 OID 17587)
-- Name: users user_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_id PRIMARY KEY (user_id) INCLUDE (user_id);


--
-- TOC entry 4693 (class 1259 OID 25804)
-- Name: fki_academic_year_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_academic_year_id ON public.course_requests USING btree (academic_year_id);


--
-- TOC entry 4694 (class 1259 OID 17572)
-- Name: fki_assignment_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_assignment_id ON public.course_requests USING btree (assignment_id);


--
-- TOC entry 4695 (class 1259 OID 17566)
-- Name: fki_course_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_course_id ON public.course_requests USING btree (course_id);


--
-- TOC entry 4705 (class 1259 OID 25787)
-- Name: fki_course_request_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_course_request_id ON public.teacher_course_assignments USING btree (course_request_id);


--
-- TOC entry 4698 (class 1259 OID 17500)
-- Name: fki_semester_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_semester_id ON public.courses USING btree (semester_id);


--
-- TOC entry 4712 (class 2606 OID 25799)
-- Name: course_requests academic_year_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests
    ADD CONSTRAINT academic_year_id FOREIGN KEY (academic_year_id) REFERENCES public.academic_year(academic_year_id) NOT VALID;


--
-- TOC entry 4717 (class 2606 OID 25805)
-- Name: teacher_course_assignments academic_year_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT academic_year_id FOREIGN KEY (academic_year_id) REFERENCES public.academic_year(academic_year_id) NOT VALID;


--
-- TOC entry 4713 (class 2606 OID 17567)
-- Name: course_requests assignment_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests
    ADD CONSTRAINT assignment_id FOREIGN KEY (assignment_id) REFERENCES public.teacher_course_assignments(assignment_id) NOT VALID;


--
-- TOC entry 4714 (class 2606 OID 17561)
-- Name: course_requests course_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests
    ADD CONSTRAINT course_id FOREIGN KEY (course_id) REFERENCES public.courses(course_id) NOT VALID;


--
-- TOC entry 4718 (class 2606 OID 25782)
-- Name: teacher_course_assignments course_request_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT course_request_id FOREIGN KEY (course_request_id) REFERENCES public.course_requests(request_id) NOT VALID;


--
-- TOC entry 4715 (class 2606 OID 17420)
-- Name: course_requests course_requests_school_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_requests
    ADD CONSTRAINT course_requests_school_id_fkey FOREIGN KEY (school_id) REFERENCES public.schools(school_id) ON DELETE CASCADE;


--
-- TOC entry 4716 (class 2606 OID 17495)
-- Name: courses semester_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT semester_id FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id) NOT VALID;


--
-- TOC entry 4719 (class 2606 OID 17480)
-- Name: teacher_course_assignments teacher_course_assignments_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT teacher_course_assignments_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teachers(teacher_id) ON DELETE CASCADE;


-- Completed on 2024-12-10 01:13:56

--
-- PostgreSQL database dump complete
--
