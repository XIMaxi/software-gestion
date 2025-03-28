PGDMP      *                |        	   soft-tech    16.3    16.3 @    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                        1262    17391 	   soft-tech    DATABASE     ~   CREATE DATABASE "soft-tech" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Chile.1252';
    DROP DATABASE "soft-tech";
                postgres    false            �            1259    17412    course_requests    TABLE       CREATE TABLE public.course_requests (
    request_id integer NOT NULL,
    course_name character varying(255) NOT NULL,
    credits integer NOT NULL,
    request_status character varying(50),
    school_id integer NOT NULL,
    year_id integer NOT NULL,
    CONSTRAINT course_requests_credits_check CHECK ((credits > 0)),
    CONSTRAINT course_requests_request_status_check CHECK (((request_status)::text = ANY ((ARRAY['pendiente'::character varying, 'aprobado'::character varying, 'rechazado'::character varying])::text[])))
);
 #   DROP TABLE public.course_requests;
       public         heap    postgres    false            �            1259    17411    course_requests_request_id_seq    SEQUENCE     �   CREATE SEQUENCE public.course_requests_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.course_requests_request_id_seq;
       public          postgres    false    220                       0    0    course_requests_request_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.course_requests_request_id_seq OWNED BY public.course_requests.request_id;
          public          postgres    false    219            �            1259    17431    courses    TABLE       CREATE TABLE public.courses (
    course_id integer NOT NULL,
    course_name character varying(255) NOT NULL,
    credits integer NOT NULL,
    school_id integer NOT NULL,
    semester_id integer NOT NULL,
    CONSTRAINT courses_credits_check CHECK ((credits > 0))
);
    DROP TABLE public.courses;
       public         heap    postgres    false            �            1259    17430    courses_course_id_seq    SEQUENCE     �   CREATE SEQUENCE public.courses_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.courses_course_id_seq;
       public          postgres    false    222                       0    0    courses_course_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.courses_course_id_seq OWNED BY public.courses.course_id;
          public          postgres    false    221            �            1259    17400    schools    TABLE     �   CREATE TABLE public.schools (
    school_id integer NOT NULL,
    school_name character varying(255) NOT NULL,
    year_id integer NOT NULL
);
    DROP TABLE public.schools;
       public         heap    postgres    false            �            1259    17399    schools_school_id_seq    SEQUENCE     �   CREATE SEQUENCE public.schools_school_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.schools_school_id_seq;
       public          postgres    false    218                       0    0    schools_school_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.schools_school_id_seq OWNED BY public.schools.school_id;
          public          postgres    false    217            �            1259    17461 	   semesters    TABLE     6  CREATE TABLE public.semesters (
    semester_id integer NOT NULL,
    semester_name character varying(20) NOT NULL,
    year_id integer NOT NULL,
    CONSTRAINT semesters_semester_name_check CHECK (((semester_name)::text = ANY ((ARRAY['Primero'::character varying, 'Segundo'::character varying])::text[])))
);
    DROP TABLE public.semesters;
       public         heap    postgres    false            �            1259    17460    semesters_semester_id_seq    SEQUENCE     �   CREATE SEQUENCE public.semesters_semester_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.semesters_semester_id_seq;
       public          postgres    false    226                       0    0    semesters_semester_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.semesters_semester_id_seq OWNED BY public.semesters.semester_id;
          public          postgres    false    225            �            1259    17474    teacher_course_assignments    TABLE     �   CREATE TABLE public.teacher_course_assignments (
    assignment_id integer NOT NULL,
    teacher_id integer NOT NULL,
    course_id integer NOT NULL,
    assigned_date date NOT NULL,
    semester_id integer NOT NULL
);
 .   DROP TABLE public.teacher_course_assignments;
       public         heap    postgres    false            �            1259    17473 ,   teacher_course_assignments_assignment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.teacher_course_assignments_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 C   DROP SEQUENCE public.teacher_course_assignments_assignment_id_seq;
       public          postgres    false    228                       0    0 ,   teacher_course_assignments_assignment_id_seq    SEQUENCE OWNED BY     }   ALTER SEQUENCE public.teacher_course_assignments_assignment_id_seq OWNED BY public.teacher_course_assignments.assignment_id;
          public          postgres    false    227            �            1259    17449    teachers    TABLE     �  CREATE TABLE public.teachers (
    teacher_id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone_number character varying(20),
    max_credits integer NOT NULL,
    rut_login character varying,
    password character varying,
    contract character varying,
    CONSTRAINT teachers_max_credits_check CHECK ((max_credits > 0))
);
    DROP TABLE public.teachers;
       public         heap    postgres    false            �            1259    17448    teachers_teacher_id_seq    SEQUENCE     �   CREATE SEQUENCE public.teachers_teacher_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.teachers_teacher_id_seq;
       public          postgres    false    224                       0    0    teachers_teacher_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.teachers_teacher_id_seq OWNED BY public.teachers.teacher_id;
          public          postgres    false    223            �            1259    17393    years    TABLE     i   CREATE TABLE public.years (
    year_id integer NOT NULL,
    year_name character varying(4) NOT NULL
);
    DROP TABLE public.years;
       public         heap    postgres    false            �            1259    17392    years_year_id_seq    SEQUENCE     �   CREATE SEQUENCE public.years_year_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.years_year_id_seq;
       public          postgres    false    216                       0    0    years_year_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.years_year_id_seq OWNED BY public.years.year_id;
          public          postgres    false    215            :           2604    17415    course_requests request_id    DEFAULT     �   ALTER TABLE ONLY public.course_requests ALTER COLUMN request_id SET DEFAULT nextval('public.course_requests_request_id_seq'::regclass);
 I   ALTER TABLE public.course_requests ALTER COLUMN request_id DROP DEFAULT;
       public          postgres    false    220    219    220            ;           2604    17434    courses course_id    DEFAULT     v   ALTER TABLE ONLY public.courses ALTER COLUMN course_id SET DEFAULT nextval('public.courses_course_id_seq'::regclass);
 @   ALTER TABLE public.courses ALTER COLUMN course_id DROP DEFAULT;
       public          postgres    false    221    222    222            9           2604    17403    schools school_id    DEFAULT     v   ALTER TABLE ONLY public.schools ALTER COLUMN school_id SET DEFAULT nextval('public.schools_school_id_seq'::regclass);
 @   ALTER TABLE public.schools ALTER COLUMN school_id DROP DEFAULT;
       public          postgres    false    218    217    218            =           2604    17464    semesters semester_id    DEFAULT     ~   ALTER TABLE ONLY public.semesters ALTER COLUMN semester_id SET DEFAULT nextval('public.semesters_semester_id_seq'::regclass);
 D   ALTER TABLE public.semesters ALTER COLUMN semester_id DROP DEFAULT;
       public          postgres    false    226    225    226            >           2604    17477 (   teacher_course_assignments assignment_id    DEFAULT     �   ALTER TABLE ONLY public.teacher_course_assignments ALTER COLUMN assignment_id SET DEFAULT nextval('public.teacher_course_assignments_assignment_id_seq'::regclass);
 W   ALTER TABLE public.teacher_course_assignments ALTER COLUMN assignment_id DROP DEFAULT;
       public          postgres    false    228    227    228            <           2604    17452    teachers teacher_id    DEFAULT     z   ALTER TABLE ONLY public.teachers ALTER COLUMN teacher_id SET DEFAULT nextval('public.teachers_teacher_id_seq'::regclass);
 B   ALTER TABLE public.teachers ALTER COLUMN teacher_id DROP DEFAULT;
       public          postgres    false    224    223    224            8           2604    17396    years year_id    DEFAULT     n   ALTER TABLE ONLY public.years ALTER COLUMN year_id SET DEFAULT nextval('public.years_year_id_seq'::regclass);
 <   ALTER TABLE public.years ALTER COLUMN year_id DROP DEFAULT;
       public          postgres    false    216    215    216            �          0    17412    course_requests 
   TABLE DATA           o   COPY public.course_requests (request_id, course_name, credits, request_status, school_id, year_id) FROM stdin;
    public          postgres    false    220   /R       �          0    17431    courses 
   TABLE DATA           Z   COPY public.courses (course_id, course_name, credits, school_id, semester_id) FROM stdin;
    public          postgres    false    222   LR       �          0    17400    schools 
   TABLE DATA           B   COPY public.schools (school_id, school_name, year_id) FROM stdin;
    public          postgres    false    218   �R       �          0    17461 	   semesters 
   TABLE DATA           H   COPY public.semesters (semester_id, semester_name, year_id) FROM stdin;
    public          postgres    false    226   "S       �          0    17474    teacher_course_assignments 
   TABLE DATA           v   COPY public.teacher_course_assignments (assignment_id, teacher_id, course_id, assigned_date, semester_id) FROM stdin;
    public          postgres    false    228   ^S       �          0    17449    teachers 
   TABLE DATA           �   COPY public.teachers (teacher_id, first_name, last_name, email, phone_number, max_credits, rut_login, password, contract) FROM stdin;
    public          postgres    false    224   �S       �          0    17393    years 
   TABLE DATA           3   COPY public.years (year_id, year_name) FROM stdin;
    public          postgres    false    216   T                  0    0    course_requests_request_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.course_requests_request_id_seq', 1, false);
          public          postgres    false    219            	           0    0    courses_course_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.courses_course_id_seq', 4, true);
          public          postgres    false    221            
           0    0    schools_school_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.schools_school_id_seq', 6, true);
          public          postgres    false    217                       0    0    semesters_semester_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.semesters_semester_id_seq', 4, true);
          public          postgres    false    225                       0    0 ,   teacher_course_assignments_assignment_id_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.teacher_course_assignments_assignment_id_seq', 2, true);
          public          postgres    false    227                       0    0    teachers_teacher_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.teachers_teacher_id_seq', 2, true);
          public          postgres    false    223                       0    0    years_year_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.years_year_id_seq', 2, true);
          public          postgres    false    215            I           2606    17419 $   course_requests course_requests_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.course_requests
    ADD CONSTRAINT course_requests_pkey PRIMARY KEY (request_id);
 N   ALTER TABLE ONLY public.course_requests DROP CONSTRAINT course_requests_pkey;
       public            postgres    false    220            K           2606    17437    courses courses_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);
 >   ALTER TABLE ONLY public.courses DROP CONSTRAINT courses_pkey;
       public            postgres    false    222            G           2606    17405    schools schools_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (school_id);
 >   ALTER TABLE ONLY public.schools DROP CONSTRAINT schools_pkey;
       public            postgres    false    218            R           2606    17467    semesters semesters_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.semesters
    ADD CONSTRAINT semesters_pkey PRIMARY KEY (semester_id);
 B   ALTER TABLE ONLY public.semesters DROP CONSTRAINT semesters_pkey;
       public            postgres    false    226            T           2606    17479 :   teacher_course_assignments teacher_course_assignments_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT teacher_course_assignments_pkey PRIMARY KEY (assignment_id);
 d   ALTER TABLE ONLY public.teacher_course_assignments DROP CONSTRAINT teacher_course_assignments_pkey;
       public            postgres    false    228            N           2606    17459    teachers teachers_email_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_email_key UNIQUE (email);
 E   ALTER TABLE ONLY public.teachers DROP CONSTRAINT teachers_email_key;
       public            postgres    false    224            P           2606    17457    teachers teachers_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (teacher_id);
 @   ALTER TABLE ONLY public.teachers DROP CONSTRAINT teachers_pkey;
       public            postgres    false    224            E           2606    17398    years years_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.years
    ADD CONSTRAINT years_pkey PRIMARY KEY (year_id);
 :   ALTER TABLE ONLY public.years DROP CONSTRAINT years_pkey;
       public            postgres    false    216            L           1259    17500    fki_semester_id    INDEX     J   CREATE INDEX fki_semester_id ON public.courses USING btree (semester_id);
 #   DROP INDEX public.fki_semester_id;
       public            postgres    false    222            V           2606    17420 .   course_requests course_requests_school_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.course_requests
    ADD CONSTRAINT course_requests_school_id_fkey FOREIGN KEY (school_id) REFERENCES public.schools(school_id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.course_requests DROP CONSTRAINT course_requests_school_id_fkey;
       public          postgres    false    4679    218    220            W           2606    17425 ,   course_requests course_requests_year_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.course_requests
    ADD CONSTRAINT course_requests_year_id_fkey FOREIGN KEY (year_id) REFERENCES public.years(year_id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.course_requests DROP CONSTRAINT course_requests_year_id_fkey;
       public          postgres    false    220    216    4677            X           2606    17438    courses courses_school_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_school_id_fkey FOREIGN KEY (school_id) REFERENCES public.schools(school_id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.courses DROP CONSTRAINT courses_school_id_fkey;
       public          postgres    false    4679    222    218            U           2606    17406    schools schools_year_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.schools
    ADD CONSTRAINT schools_year_id_fkey FOREIGN KEY (year_id) REFERENCES public.years(year_id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.schools DROP CONSTRAINT schools_year_id_fkey;
       public          postgres    false    218    4677    216            Y           2606    17495    courses semester_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT semester_id FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id) NOT VALID;
 =   ALTER TABLE ONLY public.courses DROP CONSTRAINT semester_id;
       public          postgres    false    4690    226    222            Z           2606    17468     semesters semesters_year_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.semesters
    ADD CONSTRAINT semesters_year_id_fkey FOREIGN KEY (year_id) REFERENCES public.years(year_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.semesters DROP CONSTRAINT semesters_year_id_fkey;
       public          postgres    false    4677    216    226            [           2606    17485 D   teacher_course_assignments teacher_course_assignments_course_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT teacher_course_assignments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(course_id) ON DELETE CASCADE;
 n   ALTER TABLE ONLY public.teacher_course_assignments DROP CONSTRAINT teacher_course_assignments_course_id_fkey;
       public          postgres    false    228    222    4683            \           2606    17490 F   teacher_course_assignments teacher_course_assignments_semester_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT teacher_course_assignments_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(semester_id) ON DELETE CASCADE;
 p   ALTER TABLE ONLY public.teacher_course_assignments DROP CONSTRAINT teacher_course_assignments_semester_id_fkey;
       public          postgres    false    226    4690    228            ]           2606    17480 E   teacher_course_assignments teacher_course_assignments_teacher_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.teacher_course_assignments
    ADD CONSTRAINT teacher_course_assignments_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teachers(teacher_id) ON DELETE CASCADE;
 o   ALTER TABLE ONLY public.teacher_course_assignments DROP CONSTRAINT teacher_course_assignments_teacher_id_fkey;
       public          postgres    false    228    4688    224            �      x������ � �      �   g   x�3��M,I�=��$39��ӔӐӐˈ����b� �	�o�e��Y�zxc��kqIQirIiQb��P�	�s~X49���<����Լ̤�T�a�@�1z\\\ �"�      �   O   x�3�tJL����I-J,��4�2��O*J,Vp�,��I-�s:����&'gޜ1A�d�e��Ɉ�M�W� ±#      �   ,   x�3�(��M-��4�2�NM/�K����F\&pq#�=... ��      �   (   x�3�4B##c]C]CSNC.#N0Y����b���� ��h      �   ^   x�3��*M��H-J���* Q���9�z���������F�&����1~�e��Xtxm"�{~^��9@���@fbݦf����1z\\\ � $      �      x�3�4202�2Q&\1z\\\ ;�     