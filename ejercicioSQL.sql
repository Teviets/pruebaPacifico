--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-1.pgdg22.04+2)
-- Dumped by pg_dump version 17.0 (Ubuntu 17.0-1.pgdg22.04+1)

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

--
-- Name: calculate_subtotal(); Type: FUNCTION; Schema: public; Owner: sestradat
--

CREATE FUNCTION public.calculate_subtotal() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.subtotal = (SELECT price FROM Products WHERE product_id = NEW.product_id) * NEW.quantity;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.calculate_subtotal() OWNER TO sestradat;

--
-- Name: total_revenue(integer); Type: FUNCTION; Schema: public; Owner: sestradat
--

CREATE FUNCTION public.total_revenue(customer_idp integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    total DECIMAL(10,2);
BEGIN
    SELECT SUM(subtotal) INTO total FROM OrderItems oi
    JOIN Orders o ON oi.order_id = o.order_id
    WHERE o.customer_id = customer_idP;
    RETURN total;
END;
$$;


ALTER FUNCTION public.total_revenue(customer_idp integer) OWNER TO sestradat;

--
-- Name: update_stock(); Type: FUNCTION; Schema: public; Owner: sestradat
--

CREATE FUNCTION public.update_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Products SET stock_quantity = stock_quantity - NEW.quantity WHERE product_id = NEW.product_id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_stock() OWNER TO sestradat;

--
-- Name: update_stock_quantity(); Type: FUNCTION; Schema: public; Owner: sestradat
--

CREATE FUNCTION public.update_stock_quantity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_stock_quantity() OWNER TO sestradat;

--
-- Name: update_subtotal(); Type: FUNCTION; Schema: public; Owner: sestradat
--

CREATE FUNCTION public.update_subtotal() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE OrderItems
    SET subtotal = NEW.quantity * (SELECT price FROM Products WHERE product_id = NEW.product_id)
    WHERE order_item_id = NEW.order_item_id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_subtotal() OWNER TO sestradat;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: sestradat
--

CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    email character varying(100),
    phone character varying(25)
);


ALTER TABLE public.customers OWNER TO sestradat;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: sestradat
--

CREATE SEQUENCE public.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_customer_id_seq OWNER TO sestradat;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sestradat
--

ALTER SEQUENCE public.customers_customer_id_seq OWNED BY public.customers.customer_id;


--
-- Name: orderitems; Type: TABLE; Schema: public; Owner: sestradat
--

CREATE TABLE public.orderitems (
    order_item_id integer NOT NULL,
    order_id integer,
    product_id integer,
    quantity numeric(10,2),
    subtotal numeric(10,2)
);


ALTER TABLE public.orderitems OWNER TO sestradat;

--
-- Name: orderitems_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: sestradat
--

CREATE SEQUENCE public.orderitems_order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orderitems_order_item_id_seq OWNER TO sestradat;

--
-- Name: orderitems_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sestradat
--

ALTER SEQUENCE public.orderitems_order_item_id_seq OWNED BY public.orderitems.order_item_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: sestradat
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    customer_id integer,
    order_date date
);


ALTER TABLE public.orders OWNER TO sestradat;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: sestradat
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO sestradat;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sestradat
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: sestradat
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    product_name character varying(100),
    price numeric(10,2),
    stock_quantity numeric(10,2)
);


ALTER TABLE public.products OWNER TO sestradat;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: sestradat
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO sestradat;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sestradat
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- Name: customers customer_id; Type: DEFAULT; Schema: public; Owner: sestradat
--

ALTER TABLE ONLY public.customers ALTER COLUMN customer_id SET DEFAULT nextval('public.customers_customer_id_seq'::regclass);


--
-- Name: orderitems order_item_id; Type: DEFAULT; Schema: public; Owner: sestradat
--

ALTER TABLE ONLY public.orderitems ALTER COLUMN order_item_id SET DEFAULT nextval('public.orderitems_order_item_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: sestradat
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: sestradat
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: sestradat
--

COPY public.customers (customer_id, first_name, last_name, email, phone) FROM stdin;
1	Jacqueline	Roy	alexis99@example.com	7392796608
2	Joanna	Calhoun	jake03@example.net	650.590.6227
3	Kelsey	Burgess	bmiller@example.org	687.605.2919x72060
4	Jason	Kelley	rebeccasimon@example.com	294.220.3088x5522
5	Michael	Hayes	amanda87@example.net	(378)263-9842
6	Ricky	Dudley	yhenderson@example.net	581-903-4092x560
7	Angela	Byrd	hudsonjennifer@example.net	793-494-9059
8	Annette	Villarreal	hilljessica@example.net	+1-266-613-6364
9	Louis	Johnson	perezshannon@example.com	308-906-3052x5585
10	Ann	Herring	deckerstephen@example.net	3879400938
11	Thomas	Keller	pierceangela@example.com	001-460-565-6901x1726
12	Lisa	Williams	garrett42@example.com	001-783-988-3715x89203
13	Kathy	Salas	maddenkimberly@example.net	(505)489-3145
14	James	Rodriguez	jimenezalexander@example.org	901.505.1180x62018
15	Amanda	Aguirre	xblack@example.net	(948)875-4786x4857
16	James	Crawford	xroth@example.com	666.642.4412
17	Kristen	Day	weberalbert@example.org	(244)429-6944x61593
18	Colleen	Lee	rubenmoran@example.com	(292)889-6580x8130
19	Taylor	Brown	gainespatrick@example.net	(537)511-6107
20	Diane	Ward	ruizchelsea@example.org	(277)604-7774x104
21	Patrick	Lopez	douglasjohnson@example.net	001-883-892-5246x371
22	Megan	Poole	tjordan@example.com	+1-857-298-7774
23	John	Guerra	brucemacdonald@example.com	+1-886-724-0787x6114
24	Brittany	Hanson	gmurray@example.com	356.635.9924x28375
25	Kristi	Bush	jonathan44@example.net	837-534-1515x5801
26	Kevin	Gutierrez	ellenrodriguez@example.org	001-295-245-4551x0285
27	Lonnie	Swanson	lcruz@example.org	527.360.2587
28	Brenda	Andrade	vreed@example.com	+1-779-299-7973
29	Robert	Glover	reedrandall@example.net	+1-355-362-2261
30	Kristen	Patterson	ghenry@example.net	+1-733-423-5208x811
31	Douglas	Sanders	dwilliamson@example.com	001-379-454-6907
32	Lisa	Brooks	mark25@example.net	711.658.5501x99245
33	Tara	Burns	hutchinsonamber@example.org	(691)651-0166x2932
34	Carolyn	Crawford	anita93@example.org	483.936.8820
35	Janet	Smith	courtneyho@example.com	+1-394-475-4859x9764
36	Kristen	Haley	drew61@example.net	001-838-378-3093x855
37	Annette	Torres	michael35@example.net	9257201963
38	Bryan	Allen	brianavang@example.com	001-456-850-4496x24433
39	Gregory	Smith	everettaudrey@example.net	(405)963-7454
40	Erika	Roberts	cnixon@example.org	+1-346-519-3362
41	Alexis	Roth	klopez@example.org	(304)410-6686x6449
42	Wendy	Price	samuel38@example.com	(223)673-7579
43	Diana	Hayes	vavery@example.net	990.279.2149
44	Mary	Rogers	morrisongary@example.com	902.497.9875
45	Ashley	Price	wilkinsonbrandy@example.com	532.763.8907x55127
46	Emily	Cox	bshields@example.org	(498)862-1273x91122
47	Thomas	Herrera	romerokevin@example.net	(911)456-7026
48	Brian	Carter	mmorris@example.com	001-266-465-9707x1108
49	Donna	Alvarez	ygarcia@example.com	+1-800-647-0899x596
50	Paula	Hill	melissaberry@example.com	001-356-759-0262x49121
51	Alexis	Hernandez	oweeks@example.net	461.885.2668
52	Tyler	Rivera	nicholasbaker@example.org	+1-779-865-5196x676
53	Janice	Johnson	ashley37@example.org	001-281-720-5007
54	Eric	Blankenship	ashleygraham@example.org	396.967.4769
55	Cynthia	Atkinson	makayla13@example.com	001-493-772-6653x9945
56	Taylor	Smith	gbarnes@example.com	751.870.6748
57	Holly	Stevens	masseybrenda@example.org	967-602-0909
58	David	Carter	hollowaywhitney@example.net	(202)236-0089x20927
59	Jill	Hooper	jasonflores@example.org	937.203.4923
60	Megan	Morales	jerrywright@example.net	(275)621-7655x092
61	Ashley	Moreno	dwaynegates@example.org	+1-344-200-4276x036
62	Danielle	Holland	audreyhancock@example.com	001-333-822-7471
63	Carl	Wilson	burnsevan@example.net	(974)621-0730x673
64	Samuel	Lewis	fdavis@example.com	+1-784-490-1384
65	Beth	Young	fosterharold@example.org	001-591-944-9935x4210
66	Maurice	Carter	nicholsrobert@example.com	290-556-3456x312
67	Cathy	Love	jasongardner@example.net	238.888.9968
68	Joseph	Hill	christopherfuentes@example.com	273-564-5501x058
69	Matthew	Johnson	tmiller@example.com	(844)831-8553x270
70	Cheryl	Cline	yperkins@example.net	001-862-216-6793
71	David	Lowe	lance92@example.org	001-380-369-6865x112
72	Jacob	Rogers	carolynbailey@example.com	460-812-4649x71518
73	Charles	Duran	sabrina80@example.org	(906)732-5911
74	Susan	Adams	markperez@example.net	+1-414-538-0846x13667
75	Jessica	Davis	jesse70@example.org	(769)616-8790x83671
76	Christopher	Martin	ortegaalice@example.org	(667)789-6384x905
77	Kathleen	Griffin	melissa31@example.org	+1-604-958-0391x2717
78	Paige	Miller	robinprice@example.com	896.756.4845
79	Brenda	Shaw	amandahuerta@example.com	(805)844-0299x5804
80	Harry	Watts	monicaedwards@example.com	(620)809-9179x9016
81	Elizabeth	Brown	sandersmichael@example.com	409.674.6048x7298
82	Marc	Lucas	palmermichael@example.net	(205)677-9188
83	Andres	Kelley	sweber@example.net	(662)565-7661x8728
84	Andre	Barton	mblake@example.com	+1-896-937-5739x40713
85	Derrick	Bryant	rhondahayes@example.com	9252439479
86	Brandon	Thompson	aharrison@example.net	203.326.4989
87	Michelle	Monroe	murphyrobin@example.org	+1-536-853-2362x665
88	Colleen	Edwards	monica61@example.com	+1-642-523-5224
89	Brenda	Patel	allen68@example.com	740-316-1833x7256
90	Steven	Taylor	qfritz@example.org	900.819.9998x533
91	Brian	Moore	jonesgina@example.net	+1-734-600-4521x521
92	Brett	Harris	aprilweeks@example.com	545.534.7742
93	Andrew	Dennis	lynchjustin@example.net	997.939.3038x3837
94	Nicole	Oneill	schwartzdenise@example.org	+1-968-848-6009
95	Steven	Jenkins	joselopez@example.org	+1-244-320-2276x6211
96	Christina	Parker	rthompson@example.net	409.593.2902x04746
97	Anita	Fields	william60@example.org	630.772.6974x5089
98	Arthur	Frye	james09@example.net	001-301-463-7057x312
99	Tyler	Adams	levyjulie@example.org	(390)501-5877x642
100	Jeffrey	Dorsey	johnsonmatthew@example.com	+1-840-548-7273x5197
101	Sebastian	Estrada	sestradat.37@gmail.com	41669282
102	Sebastian	Estrada	sestradat.37@gmail.com	41669282
103	Juan	Estrada	je@gmail.com	41669282
104	Manuel	Rodas	rd@gmail.com	41669282
105	DIEGO	VALDEZ	DG@gmail.com	41669282
106	Sebastian	SOlorzano	sol@gmail.com	41669282
107	prueba	1	pt@gmail.com	41669282
108	hola	1	h@gmail.com	4166928
\.


--
-- Data for Name: orderitems; Type: TABLE DATA; Schema: public; Owner: sestradat
--

COPY public.orderitems (order_item_id, order_id, product_id, quantity, subtotal) FROM stdin;
1	85	22	1.00	826.00
2	87	32	8.00	4960.00
3	4	78	6.00	1548.00
4	86	85	3.00	2517.00
5	15	64	8.00	6400.00
6	33	84	4.00	880.00
7	89	60	3.00	2673.00
8	78	83	4.00	3660.00
9	68	48	9.00	4833.00
10	74	32	3.00	1860.00
11	89	65	9.00	3267.00
12	97	1	10.00	6430.00
13	33	77	4.00	1988.00
14	28	71	1.00	124.00
15	58	13	1.00	935.00
16	34	73	10.00	8010.00
17	64	14	6.00	2118.00
18	7	81	8.00	2504.00
19	38	27	5.00	3455.00
20	69	90	2.00	1868.00
21	50	5	8.00	5896.00
22	71	18	2.00	702.00
23	21	89	10.00	1130.00
24	77	49	10.00	3480.00
25	15	47	9.00	5526.00
26	25	44	9.00	3114.00
27	58	43	1.00	761.00
28	32	65	1.00	363.00
29	54	87	2.00	1874.00
30	79	50	2.00	392.00
31	16	53	8.00	4344.00
32	27	27	7.00	4837.00
33	75	93	2.00	876.00
34	78	48	5.00	2685.00
35	71	51	2.00	1478.00
36	47	57	9.00	2367.00
37	93	99	4.00	424.00
38	96	53	2.00	1086.00
39	22	47	7.00	4298.00
40	37	40	6.00	3918.00
41	34	67	2.00	1894.00
42	25	26	9.00	2214.00
43	39	44	4.00	1384.00
44	35	24	4.00	1500.00
45	50	98	2.00	1972.00
46	66	5	2.00	1474.00
47	29	44	10.00	3460.00
48	59	46	6.00	4212.00
49	50	89	1.00	113.00
50	49	75	1.00	200.00
51	2	11	1.00	314.00
52	23	68	6.00	3864.00
53	41	51	7.00	5173.00
54	47	25	3.00	2781.00
55	84	84	8.00	1760.00
56	37	68	1.00	644.00
57	98	70	3.00	867.00
58	39	15	1.00	961.00
59	74	30	5.00	4925.00
60	49	31	2.00	848.00
61	41	42	7.00	1897.00
62	83	95	3.00	2994.00
63	45	13	6.00	5610.00
64	19	99	2.00	212.00
65	88	88	8.00	2632.00
66	18	15	8.00	7688.00
67	54	74	9.00	5364.00
68	51	14	4.00	1412.00
69	48	62	4.00	1892.00
70	3	78	5.00	1290.00
71	20	91	6.00	3552.00
72	43	33	8.00	4592.00
73	58	32	7.00	4340.00
74	6	70	2.00	578.00
75	38	64	4.00	3200.00
76	52	24	1.00	375.00
77	85	55	8.00	6704.00
78	84	17	4.00	2376.00
79	54	43	7.00	5327.00
80	41	6	5.00	3655.00
81	51	1	3.00	1929.00
82	61	46	1.00	702.00
83	70	77	3.00	1491.00
84	9	56	2.00	1328.00
85	100	44	9.00	3114.00
86	12	89	4.00	452.00
87	19	98	3.00	2958.00
88	65	84	5.00	1100.00
89	89	98	7.00	6902.00
90	93	26	8.00	1968.00
91	61	92	3.00	2127.00
92	67	48	4.00	2148.00
93	94	68	7.00	4508.00
94	21	49	10.00	3480.00
95	1	9	9.00	5175.00
96	35	37	3.00	696.00
97	89	95	6.00	5988.00
98	75	27	9.00	6219.00
99	52	51	6.00	4434.00
100	100	96	4.00	2068.00
101	17	82	10.00	4040.00
102	44	59	7.00	1491.00
103	86	80	8.00	1480.00
104	41	53	10.00	5430.00
105	92	42	7.00	1897.00
106	92	17	8.00	4752.00
107	78	67	9.00	8523.00
108	21	54	5.00	1725.00
109	3	45	7.00	4375.00
110	96	26	10.00	2460.00
111	63	73	4.00	3204.00
113	26	37	9.00	2088.00
114	8	96	2.00	1034.00
115	2	36	3.00	1248.00
116	89	69	4.00	1504.00
117	66	85	6.00	5034.00
118	79	51	7.00	5173.00
119	41	92	3.00	2127.00
120	60	7	8.00	5928.00
121	16	9	6.00	3450.00
122	59	69	10.00	3760.00
123	3	35	4.00	3164.00
124	96	98	6.00	5916.00
125	43	11	10.00	3140.00
126	68	77	7.00	3479.00
127	9	67	10.00	9470.00
128	23	22	1.00	826.00
129	27	67	5.00	4735.00
130	27	40	5.00	3265.00
131	1	6	8.00	5848.00
132	29	72	2.00	1934.00
133	75	38	5.00	830.00
134	74	28	1.00	454.00
135	21	15	9.00	8649.00
136	25	70	4.00	1156.00
137	17	75	10.00	2000.00
138	39	50	8.00	1568.00
139	52	6	4.00	2924.00
140	84	11	3.00	942.00
141	75	76	3.00	1812.00
142	71	99	10.00	1060.00
143	51	54	1.00	345.00
144	71	20	6.00	2718.00
145	79	23	7.00	3836.00
146	46	49	3.00	1044.00
147	20	58	6.00	4332.00
148	73	60	5.00	4455.00
149	73	41	6.00	5916.00
150	34	85	7.00	5873.00
151	100	44	6.00	2076.00
152	72	16	5.00	2115.00
153	50	88	4.00	1316.00
154	48	19	8.00	2168.00
155	47	26	9.00	2214.00
156	84	64	5.00	4000.00
157	56	37	6.00	1392.00
158	24	23	10.00	5480.00
159	62	7	8.00	5928.00
160	88	24	4.00	1500.00
161	47	54	6.00	2070.00
162	65	73	5.00	4005.00
163	20	87	1.00	937.00
164	16	82	8.00	3232.00
165	37	91	5.00	2960.00
166	94	76	9.00	5436.00
167	36	43	6.00	4566.00
168	8	30	2.00	1970.00
169	61	80	2.00	370.00
170	40	69	3.00	1128.00
171	86	73	4.00	3204.00
172	40	29	9.00	8784.00
173	41	20	2.00	906.00
174	33	32	5.00	3100.00
175	74	28	5.00	2270.00
176	39	76	10.00	6040.00
177	31	81	2.00	626.00
178	90	53	9.00	4887.00
179	70	78	7.00	1806.00
180	76	46	3.00	2106.00
181	89	51	8.00	5912.00
182	14	56	9.00	5976.00
183	51	85	5.00	4195.00
184	98	74	6.00	3576.00
185	67	67	6.00	5682.00
186	71	51	9.00	6651.00
187	81	71	4.00	496.00
188	90	38	9.00	1494.00
189	92	5	5.00	3685.00
190	65	89	9.00	1017.00
191	62	66	6.00	1614.00
192	54	28	6.00	2724.00
193	42	61	3.00	2022.00
194	69	57	8.00	2104.00
195	89	60	3.00	2673.00
196	75	38	4.00	664.00
198	8	49	8.00	2784.00
199	59	35	6.00	4746.00
200	21	72	7.00	6769.00
201	107	1	1.00	643.00
202	108	1	1.00	643.00
203	109	1	1.00	643.00
204	112	11	1.00	314.00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: sestradat
--

COPY public.orders (order_id, customer_id, order_date) FROM stdin;
1	64	2024-06-30
2	6	2024-05-11
3	81	2024-01-16
4	53	2024-07-25
5	89	2024-08-04
6	31	2024-08-02
7	55	2024-07-30
8	36	2024-03-16
9	52	2024-06-30
11	26	2024-01-01
12	44	2024-02-19
13	10	2024-04-17
14	3	2024-05-01
15	14	2024-01-28
16	24	2024-08-27
17	47	2024-01-01
18	83	2024-01-02
19	95	2024-02-16
20	26	2024-04-15
21	85	2024-08-26
22	45	2024-07-11
23	84	2024-02-01
24	46	2024-03-13
25	50	2024-02-16
26	29	2024-09-22
27	34	2024-07-27
28	5	2024-02-26
29	81	2024-02-01
30	85	2024-07-03
31	46	2024-05-09
32	15	2024-06-04
33	6	2024-03-08
34	80	2024-09-07
35	49	2024-01-11
36	14	2024-05-28
37	81	2024-07-14
38	81	2024-07-03
39	94	2024-07-29
40	12	2024-01-01
41	3	2024-06-05
42	61	2024-07-01
43	83	2024-01-11
44	72	2024-09-07
45	78	2024-04-04
46	2	2024-08-17
47	82	2024-05-28
48	10	2024-08-17
49	37	2024-05-12
50	27	2024-06-22
51	34	2024-09-25
52	4	2024-07-10
53	94	2024-09-17
54	58	2024-08-08
55	34	2024-04-24
56	85	2024-01-30
57	96	2024-07-06
58	74	2024-04-22
59	93	2024-01-19
60	26	2024-08-24
61	67	2024-06-12
62	61	2024-07-22
63	28	2024-07-29
64	13	2024-01-13
65	15	2024-01-06
66	3	2024-09-05
67	41	2024-02-05
68	26	2024-05-16
69	69	2024-05-31
70	64	2024-09-23
71	5	2024-06-24
72	97	2024-02-20
73	75	2024-04-30
74	13	2024-08-19
75	59	2024-03-20
76	11	2024-05-15
77	17	2024-09-13
78	90	2024-03-15
79	19	2024-06-21
80	11	2024-02-16
81	57	2024-02-22
82	83	2024-03-31
83	1	2024-09-07
84	2	2024-09-02
85	38	2024-08-07
86	25	2024-02-27
87	48	2024-03-31
88	72	2024-03-30
89	72	2024-02-21
90	25	2024-02-25
91	65	2024-09-07
92	57	2024-09-05
93	49	2024-02-24
94	85	2024-03-17
95	26	2024-03-07
96	2	2024-05-03
97	29	2024-01-18
98	9	2024-04-12
99	80	2024-02-22
100	63	2024-06-30
101	1	2024-09-29
102	101	2024-09-29
103	102	2024-09-29
104	103	2024-09-29
105	104	2024-09-29
106	104	2024-09-29
107	104	2024-09-29
108	104	2024-09-29
109	104	2024-09-29
110	106	2024-09-29
111	107	2024-09-29
112	107	2024-09-29
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: sestradat
--

COPY public.products (product_id, product_name, price, stock_quantity) FROM stdin;
2	indeed Gamepad	805.00	24.00
4	create Memory	836.00	99.00
5	agency Cooler	737.00	33.00
6	plant Fan	731.00	59.00
7	up Case	741.00	68.00
8	do Motherboard	300.00	98.00
9	traditional Adapter	575.00	56.00
10	Democrat Heatsink	969.00	87.00
12	agent Dock	478.00	17.00
13	side Adapter	935.00	64.00
14	mouth Speaker	353.00	25.00
15	treatment Fan	961.00	26.00
16	conference Storage	423.00	83.00
17	activity Smartphone	594.00	46.00
18	morning Webcam	351.00	48.00
19	majority Mouse	271.00	12.00
20	recognize Gamepad	453.00	28.00
21	leader Motherboard	940.00	86.00
22	better Fan	826.00	39.00
23	experience Router	548.00	56.00
24	but Battery	375.00	57.00
25	open Adapter	927.00	71.00
26	officer Adapter	246.00	47.00
27	worker Thermal Paste	691.00	17.00
28	or Cooler	454.00	19.00
29	movement Router	976.00	67.00
30	each Fan	985.00	100.00
31	idea Cable	424.00	24.00
32	but Memory	620.00	26.00
33	card Storage	574.00	9.00
34	whether Monitor	266.00	42.00
35	weight Microphone	791.00	77.00
36	today Headphones	416.00	92.00
37	player Monitor	232.00	38.00
38	other Graphics Card	166.00	95.00
39	question Smartwatch	299.00	64.00
40	plan Fan	653.00	11.00
41	near Motherboard	986.00	8.00
42	perhaps Laptop	271.00	28.00
43	seek Cable	761.00	28.00
44	buy Tablet	346.00	3.00
45	eye Case	625.00	74.00
46	movie Smartwatch	702.00	26.00
47	want Power Supply	614.00	42.00
48	cup Cable	537.00	84.00
49	receive Keyboard	348.00	72.00
50	fish Charger	196.00	59.00
51	indicate Thermal Paste	739.00	55.00
52	lay Cooler	978.00	4.00
53	natural Tablet	543.00	7.00
54	practice Power Supply	345.00	60.00
55	type Speaker	838.00	52.00
56	standard Console	664.00	88.00
57	never Battery	263.00	14.00
58	common Storage	722.00	46.00
59	man Webcam	213.00	4.00
60	visit Thermal Paste	891.00	56.00
61	write Power Supply	674.00	35.00
62	me Router	473.00	72.00
63	teach Charger	299.00	44.00
64	rise Cooler	800.00	45.00
65	step Power Supply	363.00	51.00
66	car Router	269.00	60.00
67	source Charger	947.00	94.00
68	foreign Tablet	644.00	7.00
69	need Gamepad	376.00	65.00
70	really Processor	289.00	58.00
71	defense Motherboard	124.00	59.00
72	face Tablet	967.00	28.00
73	unit Speaker	801.00	9.00
74	yet Adapter	596.00	100.00
75	movement Microphone	200.00	98.00
76	skill Charger	604.00	3.00
77	live Speaker	497.00	41.00
78	bed Motherboard	258.00	41.00
79	land Speaker	212.00	40.00
80	process Adapter	185.00	3.00
81	mother Motherboard	313.00	22.00
82	black Cable	404.00	37.00
83	huge Adapter	915.00	37.00
84	begin Router	220.00	92.00
85	reach Mouse	839.00	35.00
86	forward Processor	636.00	0.00
87	billion Memory	937.00	100.00
88	address Smartphone	329.00	83.00
89	eight Thermal Paste	113.00	43.00
90	station Cooler	934.00	60.00
91	across Adapter	592.00	84.00
92	still Webcam	709.00	39.00
93	including Gamepad	438.00	79.00
94	today Storage	338.00	61.00
95	address Dock	998.00	65.00
96	high Console	517.00	58.00
97	value Graphics Card	588.00	45.00
98	beyond Battery	986.00	16.00
99	community Memory	106.00	57.00
100	move Speaker	311.00	79.00
101	Laptop	1000.00	50.00
3	idea Motherboard	776.00	75.00
1	Mr Router	643.00	18.00
11	throw Battery	314.00	47.00
\.


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sestradat
--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 108, true);


--
-- Name: orderitems_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sestradat
--

SELECT pg_catalog.setval('public.orderitems_order_item_id_seq', 204, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sestradat
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 112, true);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sestradat
--

SELECT pg_catalog.setval('public.products_product_id_seq', 101, true);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: sestradat
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: orderitems orderitems_pkey; Type: CONSTRAINT; Schema: public; Owner: sestradat
--

ALTER TABLE ONLY public.orderitems
    ADD CONSTRAINT orderitems_pkey PRIMARY KEY (order_item_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: sestradat
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: sestradat
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: orderitems calculate_subtotal_trigger; Type: TRIGGER; Schema: public; Owner: sestradat
--

CREATE TRIGGER calculate_subtotal_trigger BEFORE INSERT ON public.orderitems FOR EACH ROW EXECUTE FUNCTION public.calculate_subtotal();


--
-- Name: orderitems update_stock_trigger; Type: TRIGGER; Schema: public; Owner: sestradat
--

CREATE TRIGGER update_stock_trigger BEFORE INSERT ON public.orderitems FOR EACH ROW EXECUTE FUNCTION public.update_stock();


--
-- Name: orderitems orderitems_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sestradat
--

ALTER TABLE ONLY public.orderitems
    ADD CONSTRAINT orderitems_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;


--
-- Name: orderitems orderitems_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sestradat
--

ALTER TABLE ONLY public.orderitems
    ADD CONSTRAINT orderitems_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sestradat
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- PostgreSQL database dump complete
--

