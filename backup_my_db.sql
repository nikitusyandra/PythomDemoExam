--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-02-13 11:33:56

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS mydb;
--
-- TOC entry 4825 (class 1262 OID 147719)
-- Name: mydb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE mydb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE mydb OWNER TO postgres;

\connect mydb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 223 (class 1259 OID 147749)
-- Name: expenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expenses (
    expence_id integer NOT NULL,
    purchase_date date NOT NULL,
    member_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer,
    CONSTRAINT expenses_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.expenses OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 147748)
-- Name: expenses_expence_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.expenses_expence_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.expenses_expence_id_seq OWNER TO postgres;

--
-- TOC entry 4826 (class 0 OID 0)
-- Dependencies: 222
-- Name: expenses_expence_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.expenses_expence_id_seq OWNED BY public.expenses.expence_id;


--
-- TOC entry 218 (class 1259 OID 147721)
-- Name: family_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.family_members (
    member_id integer NOT NULL,
    full_name text NOT NULL,
    date_of_birth date NOT NULL
);


ALTER TABLE public.family_members OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 147720)
-- Name: family_members_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.family_members_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.family_members_member_id_seq OWNER TO postgres;

--
-- TOC entry 4827 (class 0 OID 0)
-- Dependencies: 217
-- Name: family_members_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.family_members_member_id_seq OWNED BY public.family_members.member_id;


--
-- TOC entry 219 (class 1259 OID 147729)
-- Name: member_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.member_jobs (
    member_id integer NOT NULL,
    "position" text NOT NULL,
    company text NOT NULL,
    salary numeric(10,2) NOT NULL,
    start_date date NOT NULL
);


ALTER TABLE public.member_jobs OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 147740)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    product_name text NOT NULL,
    category text NOT NULL,
    price numeric(10,2) NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 147739)
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO postgres;

--
-- TOC entry 4828 (class 0 OID 0)
-- Dependencies: 220
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- TOC entry 4657 (class 2604 OID 147752)
-- Name: expenses expence_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses ALTER COLUMN expence_id SET DEFAULT nextval('public.expenses_expence_id_seq'::regclass);


--
-- TOC entry 4655 (class 2604 OID 147724)
-- Name: family_members member_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members ALTER COLUMN member_id SET DEFAULT nextval('public.family_members_member_id_seq'::regclass);


--
-- TOC entry 4656 (class 2604 OID 147743)
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- TOC entry 4819 (class 0 OID 147749)
-- Dependencies: 223
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.expenses VALUES (1, '2025-02-01', 1, 1, 2);
INSERT INTO public.expenses VALUES (2, '2025-02-01', 1, 2, 3);
INSERT INTO public.expenses VALUES (3, '2025-02-01', 1, 2, 1);
INSERT INTO public.expenses VALUES (4, '2025-02-06', 2, 5, 1);
INSERT INTO public.expenses VALUES (5, '2025-02-09', 5, 3, 30);
INSERT INTO public.expenses VALUES (6, '2025-02-12', 4, 7, 5);
INSERT INTO public.expenses VALUES (7, '2025-02-18', 1, 8, 1);
INSERT INTO public.expenses VALUES (8, '2025-02-22', 2, 9, 1);
INSERT INTO public.expenses VALUES (9, '2025-02-22', 3, 4, 1);


--
-- TOC entry 4814 (class 0 OID 147721)
-- Dependencies: 218
-- Data for Name: family_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.family_members VALUES (1, 'Иванов Иван Петрович', '1985-06-15');
INSERT INTO public.family_members VALUES (2, 'Иванова Мария Сергеевна', '1987-09-20');
INSERT INTO public.family_members VALUES (3, 'Иванов Алексей Иванович', '2010-02-05');
INSERT INTO public.family_members VALUES (4, 'Иванова Елена Викторовна', '1959-03-10');
INSERT INTO public.family_members VALUES (5, 'Петров Сергей Александрович', '1982-12-05');


--
-- TOC entry 4815 (class 0 OID 147729)
-- Dependencies: 219
-- Data for Name: member_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.member_jobs VALUES (1, 'Инженер', 'ООО ТехноСервис', 85000.00, '2015-03-01');
INSERT INTO public.member_jobs VALUES (2, 'Бухгалтер', 'АО ФинансГрупп', 75000.00, '2012-04-15');
INSERT INTO public.member_jobs VALUES (4, 'Репетитор', 'Частная практика', 15000.00, '2020-01-10');
INSERT INTO public.member_jobs VALUES (5, 'Таксист', 'Индивидуальная работа', 30000.00, '2020-09-01');


--
-- TOC entry 4817 (class 0 OID 147740)
-- Dependencies: 221
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products VALUES (1, 'Хлеб', 'Продукты', 50.00);
INSERT INTO public.products VALUES (2, 'Молоко', 'Продукты', 80.00);
INSERT INTO public.products VALUES (3, 'Бензин', 'Транспорт', 80.00);
INSERT INTO public.products VALUES (4, 'Билет в кино', 'Развлечения', 300.00);
INSERT INTO public.products VALUES (5, 'Зимнее пальто', 'Одежда', 8500.00);
INSERT INTO public.products VALUES (6, 'Учебники', 'Образование', 400.00);
INSERT INTO public.products VALUES (7, 'Лекарства', 'Здоровье', 25000.00);
INSERT INTO public.products VALUES (8, 'Погашение кредита', 'Кредиты', 89000.00);
INSERT INTO public.products VALUES (9, 'Смартфон в подарок', 'Подарки', 99900.00);


--
-- TOC entry 4829 (class 0 OID 0)
-- Dependencies: 222
-- Name: expenses_expence_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.expenses_expence_id_seq', 1, false);


--
-- TOC entry 4830 (class 0 OID 0)
-- Dependencies: 217
-- Name: family_members_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.family_members_member_id_seq', 1, false);


--
-- TOC entry 4831 (class 0 OID 0)
-- Dependencies: 220
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 1, false);


--
-- TOC entry 4664 (class 2606 OID 147755)
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (expence_id);


--
-- TOC entry 4660 (class 2606 OID 147728)
-- Name: family_members family_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_pkey PRIMARY KEY (member_id);


--
-- TOC entry 4662 (class 2606 OID 147747)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 4666 (class 2606 OID 147756)
-- Name: expenses expenses_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.family_members(member_id) ON DELETE CASCADE;


--
-- TOC entry 4667 (class 2606 OID 147761)
-- Name: expenses expenses_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- TOC entry 4665 (class 2606 OID 147734)
-- Name: member_jobs member_jobs_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member_jobs
    ADD CONSTRAINT member_jobs_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.family_members(member_id) ON DELETE CASCADE;


-- Completed on 2025-02-13 11:33:57

--
-- PostgreSQL database dump complete
--

