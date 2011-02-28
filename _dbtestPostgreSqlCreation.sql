--
-- PostgreSQL database dump
--

-- Dumped from database version 9.0.2
-- Dumped by pg_dump version 9.0.2
-- Started on 2011-02-28 10:46:55

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 7 (class 2615 OID 18042)
-- Name: dbtest; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA dbtest;


ALTER SCHEMA dbtest OWNER TO postgres;

SET search_path = dbtest, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1607 (class 1259 OID 18043)
-- Dependencies: 7
-- Name: access; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE access (
    access_id integer NOT NULL,
    access_permission character varying(50) NOT NULL
);


ALTER TABLE dbtest.access OWNER TO postgres;

--
-- TOC entry 1644 (class 1259 OID 18442)
-- Dependencies: 7
-- Name: seq_admin_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_admin_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_admin_id OWNER TO postgres;

--
-- TOC entry 2169 (class 0 OID 0)
-- Dependencies: 1644
-- Name: seq_admin_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_admin_id', 1, false);


--
-- TOC entry 1608 (class 1259 OID 18046)
-- Dependencies: 1951 7
-- Name: admin; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE admin (
    admin_id integer DEFAULT nextval('seq_admin_id'::regclass) NOT NULL,
    admin_user integer NOT NULL,
    admin_table character varying(20) NOT NULL,
    admin_permission integer NOT NULL
);


ALTER TABLE dbtest.admin OWNER TO postgres;

--
-- TOC entry 2170 (class 0 OID 0)
-- Dependencies: 1608
-- Name: COLUMN admin.admin_table; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN admin.admin_table IS 'Available tables<br /><br />admin<br />board<br />department<br />entry<br />equip<br />institute<br />parameter<br />permissions<br />resource<br />type<br />user';


--
-- TOC entry 2171 (class 0 OID 0)
-- Dependencies: 1608
-- Name: COLUMN admin.admin_permission; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN admin.admin_permission IS '0 - View<br />1 - Update<br />2 - Delete<br/>3 - Update, Delete<br />4 - Add<br />5 - Add, Update<br />6 - Add, Delete<br />7 - Add, Update, Delete';


--
-- TOC entry 1649 (class 1259 OID 19268)
-- Dependencies: 7
-- Name: seq_announcement_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_announcement_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_announcement_id OWNER TO postgres;

--
-- TOC entry 2172 (class 0 OID 0)
-- Dependencies: 1649
-- Name: seq_announcement_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_announcement_id', 1, false);


--
-- TOC entry 1609 (class 1259 OID 18049)
-- Dependencies: 1952 7
-- Name: announcement; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE announcement (
    announcement_id integer DEFAULT nextval('seq_announcement_id'::regclass) NOT NULL,
    announcement_title character varying(100) NOT NULL,
    announcement_message character varying(200),
    announcement_object integer NOT NULL,
    announcement_date date NOT NULL,
    announcement_end_date date
);


ALTER TABLE dbtest.announcement OWNER TO postgres;

--
-- TOC entry 2173 (class 0 OID 0)
-- Dependencies: 1609
-- Name: COLUMN announcement.announcement_object; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN announcement.announcement_object IS 'Main object of the announcement.';


--
-- TOC entry 2174 (class 0 OID 0)
-- Dependencies: 1609
-- Name: COLUMN announcement.announcement_date; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN announcement.announcement_date IS 'Announcement date.';


--
-- TOC entry 2175 (class 0 OID 0)
-- Dependencies: 1609
-- Name: COLUMN announcement.announcement_end_date; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN announcement.announcement_end_date IS 'The announcement will no longer be available after the end date.';


--
-- TOC entry 1650 (class 1259 OID 19270)
-- Dependencies: 7
-- Name: seq_board_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_board_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_board_id OWNER TO postgres;

--
-- TOC entry 2176 (class 0 OID 0)
-- Dependencies: 1650
-- Name: seq_board_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_board_id', 1, false);


--
-- TOC entry 1610 (class 1259 OID 18052)
-- Dependencies: 1953 7
-- Name: board; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE board (
    board_id integer DEFAULT nextval('seq_board_id'::regclass) NOT NULL,
    board_address character varying(20) NOT NULL,
    board_type character varying(20) NOT NULL
);


ALTER TABLE dbtest.board OWNER TO postgres;

--
-- TOC entry 2177 (class 0 OID 0)
-- Dependencies: 1610
-- Name: COLUMN board.board_id; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN board.board_id IS 'Table used with monitoring system only';


--
-- TOC entry 1611 (class 1259 OID 18055)
-- Dependencies: 7
-- Name: bool; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE bool (
    bool_id integer NOT NULL,
    bool_type character varying(6) NOT NULL
);


ALTER TABLE dbtest.bool OWNER TO postgres;

--
-- TOC entry 1612 (class 1259 OID 18058)
-- Dependencies: 7
-- Name: confidentiality; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE confidentiality (
    confidentiality_id integer NOT NULL,
    confidentiality_name character varying(10) NOT NULL
);


ALTER TABLE dbtest.confidentiality OWNER TO postgres;

--
-- TOC entry 1673 (class 1259 OID 19340)
-- Dependencies: 7
-- Name: seq_country_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_country_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_country_id OWNER TO postgres;

--
-- TOC entry 2178 (class 0 OID 0)
-- Dependencies: 1673
-- Name: seq_country_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_country_id', 1, false);


--
-- TOC entry 1613 (class 1259 OID 18061)
-- Dependencies: 1954 7
-- Name: country; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE country (
    country_id integer DEFAULT nextval('seq_country_id'::regclass) NOT NULL,
    country_name character varying(50),
    country_tel_id character(3)
);


ALTER TABLE dbtest.country OWNER TO postgres;

--
-- TOC entry 1651 (class 1259 OID 19272)
-- Dependencies: 7
-- Name: seq_department_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_department_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_department_id OWNER TO postgres;

--
-- TOC entry 2179 (class 0 OID 0)
-- Dependencies: 1651
-- Name: seq_department_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_department_id', 1, false);


--
-- TOC entry 1614 (class 1259 OID 18064)
-- Dependencies: 1955 7
-- Name: department; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE department (
    department_id integer DEFAULT nextval('seq_department_id'::regclass) NOT NULL,
    department_name character varying(40) NOT NULL,
    department_inst smallint NOT NULL
);


ALTER TABLE dbtest.department OWNER TO postgres;

--
-- TOC entry 1646 (class 1259 OID 18448)
-- Dependencies: 7
-- Name: seq_entry_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_entry_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_entry_id OWNER TO postgres;

--
-- TOC entry 2180 (class 0 OID 0)
-- Dependencies: 1646
-- Name: seq_entry_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_entry_id', 23, true);


--
-- TOC entry 1615 (class 1259 OID 18067)
-- Dependencies: 1956 1957 7
-- Name: entry; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE entry (
    entry_id bigint DEFAULT nextval('seq_entry_id'::regclass) NOT NULL,
    entry_user integer NOT NULL,
    entry_datetime timestamp without time zone NOT NULL,
    entry_slots smallint NOT NULL,
    entry_assistance smallint DEFAULT 0::smallint NOT NULL,
    entry_repeat integer NOT NULL,
    entry_status smallint NOT NULL,
    entry_resource integer NOT NULL,
    entry_action timestamp without time zone NOT NULL,
    entry_comments text
);


ALTER TABLE dbtest.entry OWNER TO postgres;

--
-- TOC entry 1652 (class 1259 OID 19274)
-- Dependencies: 7
-- Name: seq_equip_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_equip_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_equip_id OWNER TO postgres;

--
-- TOC entry 2181 (class 0 OID 0)
-- Dependencies: 1652
-- Name: seq_equip_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_equip_id', 1, false);


--
-- TOC entry 1616 (class 1259 OID 18074)
-- Dependencies: 1958 7
-- Name: equip; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE equip (
    equip_id integer DEFAULT nextval('seq_equip_id'::regclass) NOT NULL,
    equip_resourceid integer NOT NULL,
    "equip_boardID" integer NOT NULL,
    equip_para integer NOT NULL,
    equip_min integer NOT NULL,
    equip_max integer NOT NULL,
    equip_user integer NOT NULL,
    equip_desc character varying(32) NOT NULL,
    equip_alarm_period integer NOT NULL,
    equip_calibration character varying(300) NOT NULL
);


ALTER TABLE dbtest.equip OWNER TO postgres;

--
-- TOC entry 2182 (class 0 OID 0)
-- Dependencies: 1616
-- Name: COLUMN equip.equip_id; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN equip.equip_id IS 'Table used with monitoring system only';


--
-- TOC entry 2183 (class 0 OID 0)
-- Dependencies: 1616
-- Name: COLUMN equip.equip_alarm_period; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN equip.equip_alarm_period IS 'minute';


--
-- TOC entry 1672 (class 1259 OID 19335)
-- Dependencies: 7
-- Name: seq_help_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_help_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_help_id OWNER TO postgres;

--
-- TOC entry 2184 (class 0 OID 0)
-- Dependencies: 1672
-- Name: seq_help_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_help_id', 1, false);


--
-- TOC entry 1617 (class 1259 OID 18077)
-- Dependencies: 1959 1960 1961 1962 1963 7
-- Name: help; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE help (
    help_id integer DEFAULT nextval('seq_help_id'::regclass) NOT NULL,
    help_name character varying(45),
    help_text character varying(2000),
    help_parentid integer DEFAULT 0 NOT NULL,
    help_showorder integer DEFAULT (-1) NOT NULL,
    help_mediaurl character varying(100),
    help_mediaposition integer DEFAULT 1 NOT NULL,
    help_mediatype integer DEFAULT 1 NOT NULL
);


ALTER TABLE dbtest.help OWNER TO postgres;

--
-- TOC entry 1618 (class 1259 OID 18087)
-- Dependencies: 7
-- Name: hmediaposition; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE hmediaposition (
    hmediaposition_id integer NOT NULL,
    hmediaposition_name character varying(45) NOT NULL
);


ALTER TABLE dbtest.hmediaposition OWNER TO postgres;

--
-- TOC entry 1619 (class 1259 OID 18090)
-- Dependencies: 7
-- Name: hmediatype; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE hmediatype (
    hmediatype_id integer NOT NULL,
    hmediatype_name character varying(45) NOT NULL
);


ALTER TABLE dbtest.hmediatype OWNER TO postgres;

--
-- TOC entry 1653 (class 1259 OID 19276)
-- Dependencies: 7
-- Name: seq_institute_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_institute_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_institute_id OWNER TO postgres;

--
-- TOC entry 2185 (class 0 OID 0)
-- Dependencies: 1653
-- Name: seq_institute_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_institute_id', 1, false);


--
-- TOC entry 1620 (class 1259 OID 18093)
-- Dependencies: 1964 7
-- Name: institute; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE institute (
    institute_id smallint DEFAULT nextval('seq_institute_id'::regclass) NOT NULL,
    institute_name character varying(64) NOT NULL,
    institute_address character varying(64) NOT NULL,
    institute_phone integer NOT NULL,
    institute_country integer NOT NULL,
    institute_vat integer NOT NULL
);


ALTER TABLE dbtest.institute OWNER TO postgres;

--
-- TOC entry 1621 (class 1259 OID 18096)
-- Dependencies: 7
-- Name: level; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE level (
    level_id integer NOT NULL,
    level_name character varying(15) NOT NULL
);


ALTER TABLE dbtest.level OWNER TO postgres;

--
-- TOC entry 1654 (class 1259 OID 19278)
-- Dependencies: 7
-- Name: seq_mainconfig_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_mainconfig_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_mainconfig_id OWNER TO postgres;

--
-- TOC entry 2186 (class 0 OID 0)
-- Dependencies: 1654
-- Name: seq_mainconfig_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_mainconfig_id', 1, false);


--
-- TOC entry 1622 (class 1259 OID 18099)
-- Dependencies: 1965 7
-- Name: mainconfig; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE mainconfig (
    mainconfig_id integer DEFAULT nextval('seq_mainconfig_id'::regclass) NOT NULL,
    mainconfig_institute character varying(100) NOT NULL,
    mainconfig_shortname character varying(10) NOT NULL,
    mainconfig_url character varying(50) NOT NULL,
    mainconfig_email character varying(50) NOT NULL,
    mainconfig_password character varying(50) NOT NULL,
    mainconfig_host character varying(50) NOT NULL,
    mainconfig_port integer NOT NULL,
    mainconfig_smtpsecure character varying(10) NOT NULL,
    mainconfig_smtpauth smallint NOT NULL
);


ALTER TABLE dbtest.mainconfig OWNER TO postgres;

--
-- TOC entry 1655 (class 1259 OID 19280)
-- Dependencies: 7
-- Name: seq_measure_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_measure_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_measure_id OWNER TO postgres;

--
-- TOC entry 2187 (class 0 OID 0)
-- Dependencies: 1655
-- Name: seq_measure_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_measure_id', 1, false);


--
-- TOC entry 1623 (class 1259 OID 18102)
-- Dependencies: 1966 7
-- Name: measure; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE measure (
    measure_id integer DEFAULT nextval('seq_measure_id'::regclass) NOT NULL,
    measure_equip integer NOT NULL,
    measure_value integer NOT NULL,
    measure_date timestamp without time zone NOT NULL
);


ALTER TABLE dbtest.measure OWNER TO postgres;

--
-- TOC entry 2188 (class 0 OID 0)
-- Dependencies: 1623
-- Name: COLUMN measure.measure_id; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN measure.measure_id IS 'Table used with monitoring system only';


--
-- TOC entry 1656 (class 1259 OID 19282)
-- Dependencies: 7
-- Name: seq_media_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_media_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_media_id OWNER TO postgres;

--
-- TOC entry 2189 (class 0 OID 0)
-- Dependencies: 1656
-- Name: seq_media_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_media_id', 1, false);


--
-- TOC entry 1624 (class 1259 OID 18105)
-- Dependencies: 1967 7
-- Name: media; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE media (
    media_id integer DEFAULT nextval('seq_media_id'::regclass) NOT NULL,
    media_name character varying(30) NOT NULL,
    media_description character varying(100) NOT NULL,
    media_link character varying(100) NOT NULL
);


ALTER TABLE dbtest.media OWNER TO postgres;

--
-- TOC entry 1657 (class 1259 OID 19284)
-- Dependencies: 7
-- Name: seq_menu_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_menu_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_menu_id OWNER TO postgres;

--
-- TOC entry 2190 (class 0 OID 0)
-- Dependencies: 1657
-- Name: seq_menu_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_menu_id', 1, false);


--
-- TOC entry 1625 (class 1259 OID 18108)
-- Dependencies: 1968 7
-- Name: menu; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE menu (
    menu_id integer DEFAULT nextval('seq_menu_id'::regclass) NOT NULL,
    menu_name character varying(20) NOT NULL,
    menu_description character varying(50) NOT NULL,
    menu_plugin integer NOT NULL,
    menu_url character varying(50) NOT NULL
);


ALTER TABLE dbtest.menu OWNER TO postgres;

--
-- TOC entry 1658 (class 1259 OID 19286)
-- Dependencies: 7
-- Name: seq_param_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_param_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_param_id OWNER TO postgres;

--
-- TOC entry 2191 (class 0 OID 0)
-- Dependencies: 1658
-- Name: seq_param_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_param_id', 1, false);


--
-- TOC entry 1626 (class 1259 OID 18111)
-- Dependencies: 1969 7
-- Name: param; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE param (
    param_id integer DEFAULT nextval('seq_param_id'::regclass) NOT NULL,
    param_report integer NOT NULL,
    param_name character varying(25) NOT NULL,
    param_datatype character varying(25) NOT NULL,
    param_reference character varying(25)
);


ALTER TABLE dbtest.param OWNER TO postgres;

--
-- TOC entry 1659 (class 1259 OID 19288)
-- Dependencies: 7
-- Name: seq_parameter_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_parameter_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_parameter_id OWNER TO postgres;

--
-- TOC entry 2192 (class 0 OID 0)
-- Dependencies: 1659
-- Name: seq_parameter_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_parameter_id', 1, false);


--
-- TOC entry 1627 (class 1259 OID 18114)
-- Dependencies: 1970 7
-- Name: parameter; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE parameter (
    parameter_id integer DEFAULT nextval('seq_parameter_id'::regclass) NOT NULL,
    parameter_type character varying(10) NOT NULL
);


ALTER TABLE dbtest.parameter OWNER TO postgres;

--
-- TOC entry 2193 (class 0 OID 0)
-- Dependencies: 1627
-- Name: COLUMN parameter.parameter_id; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN parameter.parameter_id IS 'Table used with monitoring system only';


--
-- TOC entry 1660 (class 1259 OID 19290)
-- Dependencies: 7
-- Name: seq_permissions_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_permissions_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_permissions_id OWNER TO postgres;

--
-- TOC entry 2194 (class 0 OID 0)
-- Dependencies: 1660
-- Name: seq_permissions_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_permissions_id', 1, false);


--
-- TOC entry 1628 (class 1259 OID 18117)
-- Dependencies: 1971 7
-- Name: permissions; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE permissions (
    permissions_id integer DEFAULT nextval('seq_permissions_id'::regclass) NOT NULL,
    permissions_user integer NOT NULL,
    permissions_resource integer NOT NULL,
    permissions_level smallint NOT NULL
);


ALTER TABLE dbtest.permissions OWNER TO postgres;

--
-- TOC entry 1629 (class 1259 OID 18120)
-- Dependencies: 7
-- Name: permlevel; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE permlevel (
    permlevel_id smallint NOT NULL,
    permlevel_desc character varying(128) NOT NULL
);


ALTER TABLE dbtest.permlevel OWNER TO postgres;

--
-- TOC entry 1661 (class 1259 OID 19292)
-- Dependencies: 7
-- Name: seq_plugin_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_plugin_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_plugin_id OWNER TO postgres;

--
-- TOC entry 2195 (class 0 OID 0)
-- Dependencies: 1661
-- Name: seq_plugin_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_plugin_id', 1, false);


--
-- TOC entry 1630 (class 1259 OID 18123)
-- Dependencies: 1972 7
-- Name: plugin; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE plugin (
    plugin_id integer DEFAULT nextval('seq_plugin_id'::regclass) NOT NULL,
    plugin_name character varying(20) NOT NULL
);


ALTER TABLE dbtest.plugin OWNER TO postgres;

--
-- TOC entry 1647 (class 1259 OID 18450)
-- Dependencies: 7
-- Name: seq_repetition_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_repetition_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_repetition_id OWNER TO postgres;

--
-- TOC entry 2196 (class 0 OID 0)
-- Dependencies: 1647
-- Name: seq_repetition_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_repetition_id', 8, true);


--
-- TOC entry 1631 (class 1259 OID 18126)
-- Dependencies: 1973 7
-- Name: repetition; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE repetition (
    repetition_id integer DEFAULT nextval('seq_repetition_id'::regclass) NOT NULL,
    repetition_code character varying(20) NOT NULL
);


ALTER TABLE dbtest.repetition OWNER TO postgres;

--
-- TOC entry 1662 (class 1259 OID 19294)
-- Dependencies: 7
-- Name: seq_report_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_report_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_report_id OWNER TO postgres;

--
-- TOC entry 2197 (class 0 OID 0)
-- Dependencies: 1662
-- Name: seq_report_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_report_id', 1, false);


--
-- TOC entry 1632 (class 1259 OID 18129)
-- Dependencies: 1974 7
-- Name: report; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE report (
    report_id integer DEFAULT nextval('seq_report_id'::regclass) NOT NULL,
    report_name character varying(20) NOT NULL,
    report_description character varying(150) NOT NULL,
    report_query character varying(1000) NOT NULL,
    report_user integer NOT NULL,
    report_conf integer NOT NULL
);


ALTER TABLE dbtest.report OWNER TO postgres;

--
-- TOC entry 1663 (class 1259 OID 19296)
-- Dependencies: 7
-- Name: seq_resaccess_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_resaccess_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_resaccess_id OWNER TO postgres;

--
-- TOC entry 2198 (class 0 OID 0)
-- Dependencies: 1663
-- Name: seq_resaccess_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_resaccess_id', 1, false);


--
-- TOC entry 1633 (class 1259 OID 18135)
-- Dependencies: 1975 7
-- Name: resaccess; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE resaccess (
    resaccess_id integer DEFAULT nextval('seq_resaccess_id'::regclass) NOT NULL,
    resaccess_user integer NOT NULL,
    resaccess_table character varying(30) NOT NULL,
    resaccess_column character varying(30) NOT NULL,
    resaccess_value character varying(50) NOT NULL
);


ALTER TABLE dbtest.resaccess OWNER TO postgres;

--
-- TOC entry 1664 (class 1259 OID 19298)
-- Dependencies: 7
-- Name: seq_resource_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_resource_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_resource_id OWNER TO postgres;

--
-- TOC entry 2199 (class 0 OID 0)
-- Dependencies: 1664
-- Name: seq_resource_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_resource_id', 1, false);


--
-- TOC entry 1634 (class 1259 OID 18138)
-- Dependencies: 1976 1977 7
-- Name: resource; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE resource (
    resource_id integer DEFAULT nextval('seq_resource_id'::regclass) NOT NULL,
    resource_name character varying(32) NOT NULL,
    resource_type smallint NOT NULL,
    resource_status smallint NOT NULL,
    resource_maxdays smallint NOT NULL,
    resource_starttime smallint NOT NULL,
    resource_stoptime smallint NOT NULL,
    resource_resp integer NOT NULL,
    resource_wikilink character varying(128),
    resource_price smallint NOT NULL,
    resource_resolution smallint NOT NULL,
    resource_maxslots smallint NOT NULL,
    "resource_confIP" character varying(15) DEFAULT '0.0.0.0'::character varying NOT NULL,
    resource_confirmtol smallint NOT NULL,
    resource_delhour integer NOT NULL
);


ALTER TABLE dbtest.resource OWNER TO postgres;

--
-- TOC entry 2200 (class 0 OID 0)
-- Dependencies: 1634
-- Name: COLUMN resource.resource_maxdays; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN resource.resource_maxdays IS 'In days, sets the maximum number of days a user can reserve ahead.';


--
-- TOC entry 2201 (class 0 OID 0)
-- Dependencies: 1634
-- Name: COLUMN resource.resource_starttime; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN resource.resource_starttime IS 'Hour, Starting time of day for reservations.';


--
-- TOC entry 2202 (class 0 OID 0)
-- Dependencies: 1634
-- Name: COLUMN resource.resource_stoptime; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN resource.resource_stoptime IS 'Hour, Above this time reservations are no longer available.';


--
-- TOC entry 2203 (class 0 OID 0)
-- Dependencies: 1634
-- Name: COLUMN resource.resource_resolution; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN resource.resource_resolution IS 'In minutes, sets the time duration in minutes of  each slot.';


--
-- TOC entry 2204 (class 0 OID 0)
-- Dependencies: 1634
-- Name: COLUMN resource.resource_maxslots; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN resource.resource_maxslots IS 'In slots, Maximum time of usage per user per day.';


--
-- TOC entry 2205 (class 0 OID 0)
-- Dependencies: 1634
-- Name: COLUMN resource."resource_confIP"; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN resource."resource_confIP" IS 'IP address of computer to be used to confirm reservation.';


--
-- TOC entry 2206 (class 0 OID 0)
-- Dependencies: 1634
-- Name: COLUMN resource.resource_confirmtol; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN resource.resource_confirmtol IS 'In slots, Number of time slots of tolerance allowed before and after reservation time to confirm presence or equipment usage.';


--
-- TOC entry 2207 (class 0 OID 0)
-- Dependencies: 1634
-- Name: COLUMN resource.resource_delhour; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN resource.resource_delhour IS 'In hours, minimum time before an entry starts.to delete it.';


--
-- TOC entry 1635 (class 1259 OID 18145)
-- Dependencies: 7
-- Name: resstatus; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE resstatus (
    resstatus_id smallint NOT NULL,
    resstatus_name character varying(40) NOT NULL
);


ALTER TABLE dbtest.resstatus OWNER TO postgres;

--
-- TOC entry 1665 (class 1259 OID 19300)
-- Dependencies: 7
-- Name: seq_restree_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_restree_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_restree_id OWNER TO postgres;

--
-- TOC entry 2208 (class 0 OID 0)
-- Dependencies: 1665
-- Name: seq_restree_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_restree_id', 1, false);


--
-- TOC entry 1636 (class 1259 OID 18148)
-- Dependencies: 1978 7
-- Name: restree; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE restree (
    restree_id integer DEFAULT nextval('seq_restree_id'::regclass) NOT NULL,
    restree_user integer NOT NULL,
    restree_name integer NOT NULL,
    restree_access integer NOT NULL
);


ALTER TABLE dbtest.restree OWNER TO postgres;

--
-- TOC entry 1666 (class 1259 OID 19302)
-- Dependencies: 7
-- Name: seq_resxfields_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_resxfields_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_resxfields_id OWNER TO postgres;

--
-- TOC entry 2209 (class 0 OID 0)
-- Dependencies: 1666
-- Name: seq_resxfields_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_resxfields_id', 1, false);


--
-- TOC entry 1637 (class 1259 OID 18151)
-- Dependencies: 1979 7
-- Name: resxfields; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE resxfields (
    resxfields_id integer DEFAULT nextval('seq_resxfields_id'::regclass) NOT NULL,
    resxfields_field smallint NOT NULL,
    resxfields_resource integer NOT NULL
);


ALTER TABLE dbtest.resxfields OWNER TO postgres;

--
-- TOC entry 1667 (class 1259 OID 19304)
-- Dependencies: 7
-- Name: seq_search_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_search_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_search_id OWNER TO postgres;

--
-- TOC entry 2210 (class 0 OID 0)
-- Dependencies: 1667
-- Name: seq_search_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_search_id', 1, false);


--
-- TOC entry 1638 (class 1259 OID 18154)
-- Dependencies: 1980 7
-- Name: search; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE search (
    search_id integer DEFAULT nextval('seq_search_id'::regclass) NOT NULL,
    search_table character varying(20) NOT NULL,
    search_query character varying(1000) NOT NULL
);


ALTER TABLE dbtest.search OWNER TO postgres;

--
-- TOC entry 1668 (class 1259 OID 19306)
-- Dependencies: 7
-- Name: seq_treeview_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_treeview_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_treeview_id OWNER TO postgres;

--
-- TOC entry 2211 (class 0 OID 0)
-- Dependencies: 1668
-- Name: seq_treeview_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_treeview_id', 1, false);


--
-- TOC entry 1669 (class 1259 OID 19308)
-- Dependencies: 7
-- Name: seq_type_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_type_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_type_id OWNER TO postgres;

--
-- TOC entry 2212 (class 0 OID 0)
-- Dependencies: 1669
-- Name: seq_type_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_type_id', 1, false);


--
-- TOC entry 1670 (class 1259 OID 19310)
-- Dependencies: 7
-- Name: seq_user_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_user_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_user_id OWNER TO postgres;

--
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 1670
-- Name: seq_user_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_user_id', 1, false);


--
-- TOC entry 1671 (class 1259 OID 19312)
-- Dependencies: 7
-- Name: seq_xfields_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_xfields_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_xfields_id OWNER TO postgres;

--
-- TOC entry 2214 (class 0 OID 0)
-- Dependencies: 1671
-- Name: seq_xfields_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_xfields_id', 1, false);


--
-- TOC entry 1648 (class 1259 OID 18452)
-- Dependencies: 7
-- Name: seq_xfieldsval_id; Type: SEQUENCE; Schema: dbtest; Owner: postgres
--

CREATE SEQUENCE seq_xfieldsval_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtest.seq_xfieldsval_id OWNER TO postgres;

--
-- TOC entry 2215 (class 0 OID 0)
-- Dependencies: 1648
-- Name: seq_xfieldsval_id; Type: SEQUENCE SET; Schema: dbtest; Owner: postgres
--

SELECT pg_catalog.setval('seq_xfieldsval_id', 1, false);


--
-- TOC entry 1639 (class 1259 OID 18160)
-- Dependencies: 7
-- Name: status; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE status (
    status_id smallint NOT NULL,
    status_name character varying(16) NOT NULL
);


ALTER TABLE dbtest.status OWNER TO postgres;

--
-- TOC entry 1640 (class 1259 OID 18163)
-- Dependencies: 1981 7
-- Name: treeview; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE treeview (
    treeview_id integer DEFAULT nextval('seq_treeview_id'::regclass) NOT NULL,
    treeview_name character varying(20) NOT NULL,
    treeview_description character varying(70) NOT NULL,
    treeview_table1 character varying(30) NOT NULL,
    treeview_table2 character varying(30) NOT NULL,
    treeview_table3 character varying(30) NOT NULL
);


ALTER TABLE dbtest.treeview OWNER TO postgres;

--
-- TOC entry 1641 (class 1259 OID 18166)
-- Dependencies: 1982 7
-- Name: type; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE type (
    type_id smallint DEFAULT nextval('seq_type_id'::regclass) NOT NULL,
    type_name character varying(64) NOT NULL
);


ALTER TABLE dbtest.type OWNER TO postgres;

--
-- TOC entry 1645 (class 1259 OID 18444)
-- Dependencies: 1985 1986 7
-- Name: user; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE "user" (
    user_id integer DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
    user_login character varying(32) NOT NULL,
    user_passwd character varying(64) NOT NULL,
    user_firstname character varying(16) NOT NULL,
    user_lastname character varying(16) NOT NULL,
    user_dep integer NOT NULL,
    user_phone character varying(32) NOT NULL,
    user_phonext character varying(8),
    user_mobile character varying(16),
    user_email character varying(64) NOT NULL,
    user_alert integer NOT NULL,
    user_level integer DEFAULT 2 NOT NULL
);


ALTER TABLE dbtest."user" OWNER TO postgres;

--
-- TOC entry 2216 (class 0 OID 0)
-- Dependencies: 1645
-- Name: COLUMN "user".user_passwd; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN "user".user_passwd IS 'pwd';


--
-- TOC entry 2217 (class 0 OID 0)
-- Dependencies: 1645
-- Name: COLUMN "user".user_alert; Type: COMMENT; Schema: dbtest; Owner: postgres
--

COMMENT ON COLUMN "user".user_alert IS '1 - Alert by email<br />2 - Alert by SMS';


--
-- TOC entry 1642 (class 1259 OID 18172)
-- Dependencies: 1983 7
-- Name: xfields; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE xfields (
    xfields_id smallint DEFAULT nextval('seq_xfields_id'::regclass) NOT NULL,
    xfields_name character varying(8) NOT NULL,
    xfields_label character varying(32) NOT NULL
);


ALTER TABLE dbtest.xfields OWNER TO postgres;

--
-- TOC entry 1643 (class 1259 OID 18175)
-- Dependencies: 1984 7
-- Name: xfieldsval; Type: TABLE; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE TABLE xfieldsval (
    xfieldsval_id bigint DEFAULT nextval('seq_xfieldsval_id'::regclass) NOT NULL,
    xfieldsval_entry bigint NOT NULL,
    xfieldsval_field smallint NOT NULL,
    xfieldsval_value character varying(32) NOT NULL
);


ALTER TABLE dbtest.xfieldsval OWNER TO postgres;

--
-- TOC entry 2129 (class 0 OID 18043)
-- Dependencies: 1607
-- Data for Name: access; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO access (access_id, access_permission) VALUES (0, 'View');
INSERT INTO access (access_id, access_permission) VALUES (1, 'Update');
INSERT INTO access (access_id, access_permission) VALUES (2, 'Delete');
INSERT INTO access (access_id, access_permission) VALUES (3, 'Update, Delete');
INSERT INTO access (access_id, access_permission) VALUES (4, 'Add');
INSERT INTO access (access_id, access_permission) VALUES (5, 'Add, Update');
INSERT INTO access (access_id, access_permission) VALUES (6, 'Add, Delete');
INSERT INTO access (access_id, access_permission) VALUES (7, 'Add, Update, Delete');


--
-- TOC entry 2130 (class 0 OID 18046)
-- Dependencies: 1608
-- Data for Name: admin; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO admin (admin_id, admin_user, admin_table, admin_permission) VALUES (22, 1, 'resource', 5);
INSERT INTO admin (admin_id, admin_user, admin_table, admin_permission) VALUES (24, 1, 'permissions', 5);
INSERT INTO admin (admin_id, admin_user, admin_table, admin_permission) VALUES (25, 1, 'type', 7);
INSERT INTO admin (admin_id, admin_user, admin_table, admin_permission) VALUES (26, 1, 'department', 7);
INSERT INTO admin (admin_id, admin_user, admin_table, admin_permission) VALUES (27, 1, 'user', 7);
INSERT INTO admin (admin_id, admin_user, admin_table, admin_permission) VALUES (28, 1, 'entry', 7);
INSERT INTO admin (admin_id, admin_user, admin_table, admin_permission) VALUES (34, 1, 'admin', 7);
INSERT INTO admin (admin_id, admin_user, admin_table, admin_permission) VALUES (35, 1, 'help', 7);
INSERT INTO admin (admin_id, admin_user, admin_table, admin_permission) VALUES (36, 1, 'treeview', 5);
INSERT INTO admin (admin_id, admin_user, admin_table, admin_permission) VALUES (37, 1, 'restree', 7);


--
-- TOC entry 2131 (class 0 OID 18049)
-- Dependencies: 1609
-- Data for Name: announcement; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 2132 (class 0 OID 18052)
-- Dependencies: 1610
-- Data for Name: board; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 2133 (class 0 OID 18055)
-- Dependencies: 1611
-- Data for Name: bool; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO bool (bool_id, bool_type) VALUES (0, 'FALSE');
INSERT INTO bool (bool_id, bool_type) VALUES (1, 'TRUE');


--
-- TOC entry 2134 (class 0 OID 18058)
-- Dependencies: 1612
-- Data for Name: confidentiality; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO confidentiality (confidentiality_id, confidentiality_name) VALUES (1, 'Public');
INSERT INTO confidentiality (confidentiality_id, confidentiality_name) VALUES (2, 'Private');
INSERT INTO confidentiality (confidentiality_id, confidentiality_name) VALUES (3, 'Undefined');


--
-- TOC entry 2135 (class 0 OID 18061)
-- Dependencies: 1613
-- Data for Name: country; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO country (country_id, country_name, country_tel_id) VALUES (1, 'Not Specified', '0  ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (2, 'Albania', '355');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (3, 'Algeria', '213');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (4, 'American Samoa', '684');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (5, 'Andorra', '376');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (6, 'Angola', '244');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (7, 'Anguilla', '264');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (8, 'Antarctica', '672');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (9, 'Antigua', '268');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (10, 'Argentina', '54 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (11, 'Armenia', '374');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (12, 'Aruba', '297');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (13, 'Ascension Island', '247');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (14, 'Australia', '61 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (15, 'Austria', '43 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (16, 'Austria', '43 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (17, 'Azberbaijan', '994');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (18, 'Bahamas', '242');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (19, 'Bahrain', '973');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (20, 'Bangladesh', '880');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (21, 'Barbados', '246');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (22, 'Barbuda', '268');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (23, 'Belarus', '375');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (24, 'Belgium', '32 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (25, 'Belize', '501');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (26, 'Benin', '229');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (27, 'Bermuda', '441');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (28, 'Bhutan', '975');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (29, 'Bolivia', '591');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (30, 'Bosnia', '387');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (31, 'Botswana', '267');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (32, 'Brazil', '55 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (33, 'British Virgin Islands', '284');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (34, 'Brunei', '673');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (35, 'Bulgaria', '359');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (36, 'Burkina Faso', '226');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (37, 'Burma (Myanmar)', '95 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (38, 'Burundi', '257');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (39, 'Cambodia', '855');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (40, 'Cameroon', '237');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (41, 'Canada', '1  ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (42, 'Cape Verde Islands', '238');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (43, 'Cayman Islands', '345');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (44, 'Central African Rep.', '236');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (45, 'Chad', '235');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (46, 'Chile', '56 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (47, 'China', '86 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (48, 'Christmas Island', '61 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (49, 'Cocos Islands', '61 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (50, 'Colombia', '57 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (51, 'Comoros', '269');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (52, 'Congo', '242');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (53, 'Congo (Dem.Rep.)', '243');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (54, 'Cook Islands', '682');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (55, 'Costa Rica', '506');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (56, 'Croatia', '385');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (57, 'Cuba', '53 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (58, 'Cyprus', '357');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (59, 'Czech Republic', '420');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (60, 'Denmark', '45 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (61, 'Diego Garcia', '246');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (62, 'Djibouti', '253');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (63, 'Dominica', '767');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (64, 'Dominican Rep.', '809');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (65, 'Ecuador', '593');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (66, 'Egypt', '20 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (67, 'El Salvador', '503');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (68, 'Equatorial Guinea', '240');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (69, 'Eritrea', '291');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (70, 'Estonia', '372');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (71, 'Ethiopia', '251');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (72, 'Faeroe Islands', '298');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (73, 'Falkland Islands', '500');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (74, 'Fiji Islands', '679');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (75, 'Finland', '358');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (76, 'France', '33 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (77, 'French Antilles', '596');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (78, 'French Guiana', '594');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (79, 'French Polynesia', '689');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (80, 'Gabon', '241');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (81, 'Gambia', '220');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (82, 'Georgia', '995');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (83, 'Germany', '49 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (84, 'Ghana', '233');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (85, 'Gibraltar', '350');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (86, 'Greece', '30 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (87, 'Greenland', '299');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (88, 'Grenada', '473');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (89, 'Guadeloupe', '590');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (90, 'Guam', '671');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (91, 'Guantanamo Bay', '539');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (92, 'Guatemala', '502');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (93, 'Guinea', '224');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (94, 'Guinea Bissau', '245');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (95, 'Guyana', '592');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (96, 'Haiti', '509');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (97, 'Honduras', '504');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (98, 'Hong Kong', '852');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (99, 'Hungary', '36 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (100, 'Iceland', '354');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (101, 'India', '91 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (102, 'Indonesia', '62 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (103, 'Iran', '98 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (104, 'Iraq', '964');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (105, 'Ireland', '353');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (106, 'Israel', '972');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (107, 'Italy', '39 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (108, 'Ivory Coast', '225');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (109, 'Jamaica', '876');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (110, 'Japan', '81 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (111, 'Jordan', '962');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (112, 'Kazakhstan', '7  ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (113, 'Kenya', '254');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (114, 'Kiribati', '686');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (115, 'Korea (North)', '850');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (116, 'Korea (South)', '82 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (117, 'Kuwait', '965');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (118, 'Kyrgyzstan', '996');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (119, 'Laos', '856');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (120, 'Latvia', '371');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (121, 'Lebanon', '961');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (122, 'Lesotho', '266');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (123, 'Liberia', '231');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (124, 'Libya', '218');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (125, 'Liechtenstein', '423');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (126, 'Lithuania', '370');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (127, 'Luxembourg', '352');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (128, 'Macau', '853');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (129, 'Macedonia', '389');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (130, 'Madagascar', '261');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (131, 'Malawi', '265');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (132, 'Malaysia', '60 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (133, 'Maldives', '960');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (134, 'Mali', '223');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (135, 'Malta', '356');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (136, 'Mariana Islands', '670');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (137, 'Marshall Islands', '692');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (138, 'Martinique', '596');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (139, 'Mauritania', '222');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (140, 'Mauritius', '230');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (141, 'Mayotte Islands', '269');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (142, 'Mexico', '52 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (143, 'Micronesia', '691');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (144, 'Midway Island', '808');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (145, 'Moldova', '373');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (146, 'Monaco', '377');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (147, 'Mongolia', '976');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (148, 'Montserrat', '664');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (149, 'Morocco', '212');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (150, 'Mozambique', '258');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (151, 'Myanmar (Burma)', '95 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (152, 'Namibia', '264');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (153, 'Nauru', '674');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (154, 'Nepal', '977');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (155, 'Netherlands', '31 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (156, 'Netherlands Antilles', '599');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (157, 'Nevis', '869');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (158, 'New Caledonia', '687');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (159, 'New Zealand', '64 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (160, 'Nicaragua', '505');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (161, 'Niger', '227');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (162, 'Nigeria', '234');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (163, 'Niue', '683');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (164, 'Norfolk Island', '672');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (165, 'Norway', '47 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (166, 'Oman', '968');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (167, 'Pakistan', '92 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (168, 'Palau', '680');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (169, 'Palestine', '970');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (170, 'Panama', '507');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (171, 'Papua New Guinea', '675');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (172, 'Paraguay', '595');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (173, 'Peru', '51 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (174, 'Philippines', '63 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (175, 'Poland', '48 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (176, 'Portugal', '351');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (177, 'Puerto Rico', '787');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (178, 'Qatar', '974');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (179, 'Reunion Island', '262');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (180, 'Romania', '40 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (181, 'Russia', '7  ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (182, 'Rwanda', '250');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (183, 'San Marino', '378');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (184, 'Sao Tome & Principe', '239');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (185, 'Saudi Arabia', '966');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (186, 'Senegal', '221');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (187, 'Serbia', '381');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (188, 'Seychelles', '248');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (189, 'Sierra Leone', '232');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (190, 'Singapore', '65 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (191, 'Slovakia', '421');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (192, 'Slovenia', '386');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (193, 'Solomon Islands', '677');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (194, 'Somalia', '252');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (195, 'South Africa', '27 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (196, 'Spain', '34 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (197, 'Sri Lanka', '94 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (198, 'St. Helena', '290');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (199, 'St. Kitts', '869');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (200, 'St. Lucia', '758');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (201, 'St. Perre & Miquelon', '508');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (202, 'St. Vincent', '784');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (203, 'Sudan', '249');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (204, 'Suriname', '597');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (205, 'Swaziland', '268');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (206, 'Sweden', '46 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (207, 'Switzerland', '41 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (208, 'Syria', '963');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (209, 'Taiwan', '886');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (210, 'Tajikistan', '992');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (211, 'Tanzania', '255');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (212, 'Thailand', '66 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (213, 'Togo', '228');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (214, 'Tonga', '676');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (215, 'Trinidad & Tobago', '868');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (216, 'Tunisia', '216');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (217, 'Turkey', '90 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (218, 'Turkmenistan', '993');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (219, 'Turks & Caicos', '649');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (220, 'Tuvalu', '688');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (221, 'Uganda', '256');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (222, 'Ukraine', '380');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (223, 'United Arab Emirates', '971');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (224, 'United Kingdom (UK)', '44 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (225, 'United States (USA)', '1  ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (226, 'Uruguay', '598');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (227, 'US Virgin Islands', '1  ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (228, 'Uzbekistan', '998');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (229, 'Vanuatu', '678');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (230, 'Vatican City', '39 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (231, 'Venezuela', '58 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (232, 'Vietnam', '84 ');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (233, 'Wake Island', '808');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (234, 'Wallis & Futuna', '681');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (235, 'Western Samoa', '685');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (236, 'Yemen', '967');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (237, 'Yugoslavia', '381');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (238, 'Zambia', '260');
INSERT INTO country (country_id, country_name, country_tel_id) VALUES (239, 'Zimbabwe', '263');


--
-- TOC entry 2136 (class 0 OID 18064)
-- Dependencies: 1614
-- Data for Name: department; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO department (department_id, department_name, department_inst) VALUES (1, 'Cirklo', 1);


--
-- TOC entry 2137 (class 0 OID 18067)
-- Dependencies: 1615
-- Data for Name: entry; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (8, 1, '2011-02-24 14:30:00', 3, 0, 4, 3, 1, '2011-02-25 16:14:27', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (7, 1, '2011-02-23 13:00:00', 4, 0, 4, 3, 1, '2011-02-25 16:14:27', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (5, 1, '2011-02-25 10:30:00', 1, 0, 3, 3, 1, '2011-02-25 16:14:23', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (6, 1, '2011-02-26 11:00:00', 2, 0, 3, 3, 1, '2011-02-25 16:14:23', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (9, 1, '2011-02-23 10:00:00', 2, 0, 5, 3, 1, '2011-02-25 16:28:09', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (10, 1, '2011-02-24 11:00:00', 3, 0, 5, 3, 1, '2011-02-25 16:28:09', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (11, 1, '2011-02-26 10:30:00', 4, 0, 5, 3, 1, '2011-02-25 16:28:09', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (12, 1, '2011-02-23 09:00:00', 1, 0, 5, 3, 1, '2011-02-25 16:28:09', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (13, 1, '2011-02-25 12:00:00', 1, 0, 5, 3, 1, '2011-02-25 16:28:09', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (14, 1, '2011-02-24 13:30:00', 5, 0, 6, 3, 1, '2011-02-25 16:33:14', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (15, 1, '2011-02-25 16:00:00', 3, 0, 6, 3, 1, '2011-02-25 16:33:14', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (16, 1, '2011-02-23 11:00:00', 5, 0, 6, 3, 1, '2011-02-25 16:33:14', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (17, 1, '2011-02-26 16:30:00', 2, 0, 6, 3, 1, '2011-02-25 16:33:14', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (18, 1, '2011-02-25 13:30:00', 1, 0, 7, 1, 1, '2011-02-25 16:35:37', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (19, 1, '2011-02-25 16:00:00', 4, 0, 7, 1, 1, '2011-02-25 16:35:37', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (20, 1, '2011-02-25 14:30:00', 2, 0, 7, 1, 1, '2011-02-25 16:35:37', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (21, 1, '2011-02-23 11:30:00', 4, 0, 8, 1, 1, '2011-02-25 16:35:44', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (22, 1, '2011-02-26 17:00:00', 3, 0, 8, 1, 1, '2011-02-25 16:35:44', NULL);
INSERT INTO entry (entry_id, entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) VALUES (23, 1, '2011-02-26 15:30:00', 1, 0, 8, 1, 1, '2011-02-25 16:35:44', NULL);


--
-- TOC entry 2138 (class 0 OID 18074)
-- Dependencies: 1616
-- Data for Name: equip; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 2139 (class 0 OID 18077)
-- Dependencies: 1617
-- Data for Name: help; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (1, 'Agendo', NULL, 0, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (2, 'Datumo', NULL, 0, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (3, 'Homepage Layout', NULL, 1, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (4, 'Your Profile', NULL, 1, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (5, 'Resources', NULL, 1, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (8, 'Creating a new user profile', NULL, 4, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (9, NULL, 'Open the Agendo Resource Scheduling system homepage.', 8, 1, 'media/agendo_.png', 2, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (10, NULL, 'Open the user menu by clicking:', 8, 2, 'media/agendo_.png', 4, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (11, NULL, 'Selecting New User will make a pop-up window appear.Fill out all the fields selecting the resource you intend to use at the moment. All other resources can be added later by selecting New Permission. For each resource a new permission must be requested. ', 8, 3, 'media/addentry.swf', 1, 2);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (12, NULL, 'A new window will appear. After administrator approval an email will be sent to your account with your password.', 8, 4, 'media/agendo_.png', 2, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (13, 'Changing/Updating your profile', NULL, 4, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (14, 'Recovering the password', NULL, 4, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (15, 'Scheduling a resource', NULL, 5, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (16, 'Reservation without logging in', NULL, 5, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (17, 'Reservation while logged in', NULL, 5, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (18, 'Deleting Resource Reservations', NULL, 5, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (19, 'Updating Resource Reservations', NULL, 5, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (20, 'Monitoring Resources', NULL, 5, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (21, 'Permissions', NULL, 1, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (22, 'Permission Levels', NULL, 21, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (23, 'Requesting a New Permission', NULL, 21, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (25, 'Installation', NULL, 1, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (26, 'Xampp', NULL, 25, 2, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (28, 'PhP', NULL, 25, 4, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (29, NULL, 'Run the installer and follow the instructions given.', 26, 2, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (30, NULL, 'After installing Xampp download all Agendo source files listed <a class=''link'' href="https://github.com/Cirklo/Agendo" target=''_blank''>Here</a> to a folder in the htdocs folder inside the installation directory of Xampp. The name of that folder is part of the address to connect to Agendo.', 26, 3, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (31, NULL, 'If you have already covered the PhP and Xampp section you should be ready to go, all you need now is to put in your browser address bar the server address followed by the name of the folder mentioned above and you should see the Agendo startup page.', 39, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (32, 'Introduction', NULL, 25, 1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (33, NULL, 'Its recommended to install Xampp first and do the SQL and PhP configurations later.', 32, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (34, NULL, 'Xampp is a package containing Apache and MySql (and more, but this is all we need) that we recommend to use due to its easy installation.', 32, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (35, NULL, 'In the folder where you downloaded the Agendo source files (in the Xampp/htdocs/YourFolder) you need to find the .htconnect.php file and edit it using notepad (or equivalent text reader program).', 28, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (36, NULL, 'Alter "$caldb = "dbtest";" to "$caldb = "YourDatabaseName";" on line 2.', 28, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (37, NULL, 'Alter "$link = mysql_connect("localhost", "root", "")" to "$link = mysql_connect("YourHost", "NameOfYourRootUser", "YourRootUserPassword")" on line 3.', 28, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (38, NULL, 'Alter "case 1: $db = "dbtest";" to "case 1: $db = "YourDatabaseName";" on line 14.', 28, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (39, 'Conclusion', NULL, 25, 5, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (40, NULL, 'Xampp''s Official site is <a class=''link'' href="http://www.apachefriends.org/en/xampp.html" target=''_blank''>Here</a>. In that page you will find an installation tutorial for differente platforms (Windows, Mac, Linux), choose yours and follow the steps indicated.', 26, 1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (41, 'SQL', NULL, 25, 3, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (42, NULL, 'If you have already installed Xampp on your system and have pressed "start" for Mysql and Apache in the Xampp Panel you should be able to access on your browser <a class=''link'' href="http://localhost/phpmyadmin/" target=''_blank''>Here</a>', 41, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (43, NULL, 'Your default user should be "root" and no password necessary. For security reasons you should change this eventually.', 41, -1, NULL, 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (44, NULL, 'Create a new database with a name to your choosing.', 41, -1, 'media/createDB.png', 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (45, NULL, 'Select "Import". ', 41, -1, 'media/importDB.png', 4, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (46, NULL, 'Browse to the location of the Sql file named "database.sql" in your "Xampp/htdocs/YourFolder/" folder.', 41, -1, 'media/browseDB.png', 1, 1);
INSERT INTO help (help_id, help_name, help_text, help_parentid, help_showorder, help_mediaurl, help_mediaposition, help_mediatype) VALUES (47, NULL, ' Press "Go".', 41, -1, 'media/goDB.png', 4, 1);


--
-- TOC entry 2140 (class 0 OID 18087)
-- Dependencies: 1618
-- Data for Name: hmediaposition; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO hmediaposition (hmediaposition_id, hmediaposition_name) VALUES (1, 'Up');
INSERT INTO hmediaposition (hmediaposition_id, hmediaposition_name) VALUES (2, 'Down');
INSERT INTO hmediaposition (hmediaposition_id, hmediaposition_name) VALUES (3, 'Left');
INSERT INTO hmediaposition (hmediaposition_id, hmediaposition_name) VALUES (4, 'Right');


--
-- TOC entry 2141 (class 0 OID 18090)
-- Dependencies: 1619
-- Data for Name: hmediatype; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO hmediatype (hmediatype_id, hmediatype_name) VALUES (1, 'Image');
INSERT INTO hmediatype (hmediatype_id, hmediatype_name) VALUES (2, 'Video');
INSERT INTO hmediatype (hmediatype_id, hmediatype_name) VALUES (3, 'Audio');


--
-- TOC entry 2142 (class 0 OID 18093)
-- Dependencies: 1620
-- Data for Name: institute; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO institute (institute_id, institute_name, institute_address, institute_phone, institute_country, institute_vat) VALUES (1, 'IGC', 'Rua da Quinta Grande', 12345678, 34, 323232323);


--
-- TOC entry 2143 (class 0 OID 18096)
-- Dependencies: 1621
-- Data for Name: level; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO level (level_id, level_name) VALUES (0, 'Administrator');
INSERT INTO level (level_id, level_name) VALUES (1, 'Manager');
INSERT INTO level (level_id, level_name) VALUES (2, 'Regular User');


--
-- TOC entry 2144 (class 0 OID 18099)
-- Dependencies: 1622
-- Data for Name: mainconfig; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO mainconfig (mainconfig_id, mainconfig_institute, mainconfig_shortname, mainconfig_url, mainconfig_email, mainconfig_password, mainconfig_host, mainconfig_port, mainconfig_smtpsecure, mainconfig_smtpauth) VALUES (1, 'FCUL', 'ICAT', 'www.fc.ul.pt', 'mail@mail.com', 'pass', 'host', 25, 'stmp', 0);


--
-- TOC entry 2145 (class 0 OID 18102)
-- Dependencies: 1623
-- Data for Name: measure; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 2146 (class 0 OID 18105)
-- Dependencies: 1624
-- Data for Name: media; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO media (media_id, media_name, media_description, media_link) VALUES (1, 'Recover Password', 'Shows how to recover a user''s password', 'videos/recoverpwd.swf');
INSERT INTO media (media_id, media_name, media_description, media_link) VALUES (2, 'New User', 'Shows how to create users', 'videos/askfor.swf');
INSERT INTO media (media_id, media_name, media_description, media_link) VALUES (3, 'Entry Confirmation', 'Shows how to confirm entries', 'videos/confirm.swf');
INSERT INTO media (media_id, media_name, media_description, media_link) VALUES (4, 'New Permission', 'Shows how to give a user permission for a certain resource', 'videos/newperm.swf');
INSERT INTO media (media_id, media_name, media_description, media_link) VALUES (5, 'Waiting Lists', 'Shows how waiting lists work', 'videos/waitlist.swf');


--
-- TOC entry 2147 (class 0 OID 18108)
-- Dependencies: 1625
-- Data for Name: menu; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 2148 (class 0 OID 18111)
-- Dependencies: 1626
-- Data for Name: param; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 2149 (class 0 OID 18114)
-- Dependencies: 1627
-- Data for Name: parameter; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 2150 (class 0 OID 18117)
-- Dependencies: 1628
-- Data for Name: permissions; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO permissions (permissions_id, permissions_user, permissions_resource, permissions_level) VALUES (3, 1, 1, 0);
INSERT INTO permissions (permissions_id, permissions_user, permissions_resource, permissions_level) VALUES (4, 1, 1, 0);


--
-- TOC entry 2151 (class 0 OID 18120)
-- Dependencies: 1629
-- Data for Name: permlevel; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO permlevel (permlevel_id, permlevel_desc) VALUES (0, 'No permission');
INSERT INTO permlevel (permlevel_id, permlevel_desc) VALUES (1, 'Regular reservation');
INSERT INTO permlevel (permlevel_id, permlevel_desc) VALUES (3, 'Add ahead');
INSERT INTO permlevel (permlevel_id, permlevel_desc) VALUES (5, 'Add Back');
INSERT INTO permlevel (permlevel_id, permlevel_desc) VALUES (7, 'Add Back+Ahead');
INSERT INTO permlevel (permlevel_id, permlevel_desc) VALUES (9, 'Extra reservation');


--
-- TOC entry 2152 (class 0 OID 18123)
-- Dependencies: 1630
-- Data for Name: plugin; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 2153 (class 0 OID 18126)
-- Dependencies: 1631
-- Data for Name: repetition; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO repetition (repetition_id, repetition_code) VALUES (2696, '0.3675832701846957');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2697, '0.017621592187696544');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2698, '0.6862780676683656');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2699, '0.6982184126973152');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2700, '0.8513427340425639');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2701, '0.5896274500495222');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2702, '0.025795976445453395');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2703, '0.38730017754930424');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2704, '0.7032740802771097');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2705, '0.8533240327124143');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2706, '0.39958571697409684');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2707, '0.39958571697409684');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2708, '0.05963373389391058');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2709, '0.8214578392570908');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2710, '0.6000409805564257');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2711, '0.6215863731306146');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2712, '0.9987993745563952');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2713, '0.15921501559205353');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2714, '0.15921501559205353');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2715, '0.15921501559205353');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2716, '0.9612334193661809');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2717, '0.6444077333435416');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2718, '0.9807606072968367');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2719, '0.9807606072968367');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2720, '0.8576669187711994');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2721, '0.8576669187711994');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2722, '0.8576669187711994');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2723, '0.8576669187711994');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2724, '0.8353372820917344');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2725, '0.01754695812517404');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2726, '0.7185245704331436');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2727, '0.33541206610312135');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2728, '0.4357561143115163');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2729, '0.95038575027138');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2730, '0.28283585980534554');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2731, '0.001494931988418102');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2732, '0.44154273718595505');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2733, '0.42543522268533707');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2734, '0.41764748468995094');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2735, '0.28052559308707714');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2736, '0.1885738493874669');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2737, '0.07204780913889408');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2738, '0.609054310247302');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2739, '0.1795775108039379');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2740, '0.18978260532950475');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2741, '0.10494153667241335');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2742, '0.7108604255004627');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2743, '0.09577725806806414');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2744, '0.02350144812331545');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2745, '0.4988046406992841');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2746, '0.1387323419624341');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2747, '0.3952355009930075');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2748, '0.19534019864761487');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2749, '0.3116872596571124');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2750, '0.42030264117256333');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2751, '0.7985997221733607');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2752, '0.9741928809827168');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2753, '0.4607510336943087');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2754, '0.5567538349776469');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2755, '0.5567538349776469');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2756, '0.08775657242286039');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2757, '0.9049888750918763');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2758, '0.9049888750918763');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2759, '0.9049888750918763');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2760, '0.8537513087478524');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2761, '0.48072498571127653');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2762, '0.48072498571127653');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2763, '0.5678867595270276');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2764, '0.05527157931061266');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2765, '0.14672838927686171');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2766, '0.7191254810022009');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2767, '0.5304566764683853');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2768, '0.8920068607489003');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2769, '0.09191632932233051');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2770, '0.38027974385188124');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2771, '0.3271952279142871');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2772, '0.3271952279142871');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2773, '0.3144091886480753');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2774, '0.13964345345963114');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2775, '0.5600366673165657');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2776, '0.5301203239213972');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2777, '0.706052035997419');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2778, '0.706052035997419');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2779, '0.706052035997419');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2780, '0.706052035997419');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2781, '0.14734552221830222');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2782, '0.20455952713454273');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2783, '0.4862733092601932');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2784, '0.8862018498086812');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2785, '0.8862018498086812');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2786, '0.8862018498086812');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2787, '0.7318310452806833');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2788, '0.34556389608922755');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2789, '0.9017161087353327');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2790, '0.9017161087353327');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2791, '0.23695603113771657');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2792, '0.23695603113771657');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2793, '0.20085629774507885');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2794, '0.7340589841917569');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2795, '0.7340589841917569');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2796, '0.7340589841917569');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2797, '0.7340589841917569');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2798, '0.7340589841917569');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2799, '0.7340589841917569');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2800, '0.1202725763107616');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2801, '0.6449130661208664');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2802, '0.6449130661208664');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2803, '0.5971177889646438');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2804, '0.7722379639744759');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2805, '0.9461287455633283');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2806, '0.9320506602525711');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2807, '0.9605070062733749');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2808, '0.1875932959294413');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2809, '0.6753098501337962');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2810, '0.6753098501337962');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2811, '0.6753098501337962');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2812, '0.6753098501337962');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2813, '0.8369904384056698');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2814, '0.6661292740175396');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2815, '0.5732071356486671');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2816, '0.5732071356486671');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2817, '0.5732071356486671');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2818, '0.5732071356486671');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2819, '0.5732071356486671');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2820, '0.15050140108284338');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2821, '0.15050140108284338');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2822, '0.15050140108284338');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2823, '0.7532336121467794');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2824, '0.15648076473882244');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2825, '0.0630244844993858');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2826, '0.8457914276514202');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2827, '0.8457914276514202');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2828, '0.8490819903090596');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2829, '0.22548726061359048');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2830, '0.22548726061359048');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2831, '0.9461897620931268');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2832, '0.9248343659564853');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2833, '0.732575196035268');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2834, '0.732575196035268');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2835, '0.732575196035268');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2836, '0.732575196035268');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2837, '0.5009563760831952');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2838, '0.8316240606363863');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2839, '0.4385878557804972');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2840, '0.4385878557804972');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2841, '0.4385878557804972');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2842, '0.13287866627797484');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2843, '0.8285347381606698');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2844, '0.670389057835564');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2845, '0.8971197681967169');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2846, '0.37637964729219675');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2847, '0.26964115793816745');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2848, '0.11123052099719644');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2849, '0.23955149482935667');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2850, '0.2584679863836976');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2851, '0.5337724770002125');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2852, '0.27552777945189155');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2853, '0.36833046906347655');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2854, '0.4300520120894784');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2855, '0.7902539727462029');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2856, '0.5327354278200555');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2857, '0.47294899451138994');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2858, '0.143031645077355');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2859, '0.25691296852139756');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2860, '0.2010851935815673');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2861, '0.8843469984273252');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2862, '0.8314904565905242');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2863, '0.009494163922774579');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2864, '0.6551504023334128');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2865, '0.3831993202086311');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2866, '0.7536637510839764');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2867, '0.26172945476386344');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2868, '0.4250504935590599');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2869, '0.6186757801408195');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2870, '0.15129746356588614');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2871, '0.018354428014841773');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2872, '0.8290897069674765');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2873, '0.8389040374337449');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2874, '0.8295701066877584');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2875, '0.1357737639329567');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2876, '0.8673880857090456');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2877, '0.7708265410227819');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2878, '0.4623005317605726');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2879, '0.003554511473090049');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2880, '0.8530828602265017');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2881, '0.753730022774808');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2882, '0.9951695588604793');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2883, '0.6673914636878956');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2884, '0.0371078923643865');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2885, '0.7326245032125749');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2886, '0.5136417231317635');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2887, '0.08777206423189365');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2888, '0.6337163762099901');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2889, '0.48296527137531886');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2890, '0.9260488287609744');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2891, '0.16074682140660246');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2892, '0.6877034664421421');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2893, '0.36764006724717047');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2894, '0.6067833639619448');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2895, '0.06769004015265356');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2896, '0.4809501453192032');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2897, '0.16168227380260825');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2898, '0.12353487548430031');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2899, '0.4188774190190805');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2900, '0.520914115377832');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2901, '0.5432341450769786');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2902, '0.14496266681932735');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2903, '0.7137890991834912');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2904, '0.12846466061915318');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2905, '0.1966503341698277');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2906, '0.2898184946849317');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2907, '0.5159146412296536');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2908, '0.9986720217155481');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2909, '0.6757558975922403');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2910, '0.27908976232074056');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2911, '0.43968096125539746');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2912, '0.8941320113199162');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2913, '0.9100396656184493');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2914, '0.12583410616960533');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2915, '0.7594372592404822');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2916, '0.34677249751213857');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2917, '0.8059331590081996');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2918, '0.5870106384499297');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2919, '0.3738070636833799');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2920, '0.525561420098473');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2921, '0.9405846003514868');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2922, '0.9801498755112187');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2923, '0.3599493512146855');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2924, '0.31585916534894953');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2925, '0.9810854201927978');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2926, '0.5780888185002084');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2927, '0.5248251115679001');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2928, '0.615742896301123');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2929, '0.9625003205028518');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2930, '0.6726489927027935');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2931, '0.9416404766222376');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2932, '0.35871279858544947');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2933, '0.5983711397596523');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2934, '0.7560809343603377');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2935, '0.7926796847582668');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2936, '0.33752764363045107');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2937, '0.47336148519740884');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2938, '0.10957168151119956');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2939, '0.9582688133150615');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2940, '0.388518380647378');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2941, '0.08123072285359378');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2942, '0.682332568037683');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2943, '0.7175416050582328');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2944, '0.27994748697446326');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2945, '0.9414402635905131');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2946, '0.5460606172646307');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2947, '0.19349320737643727');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2948, '0.8786183773523325');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2949, '0.8120523195160466');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2950, '0.980583889926908');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2951, '0.048252854437778936');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2952, '0.5031987568980307');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2953, '0.6564848659905264');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2954, '0.5799966820165948');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2955, '0.1235255143593954');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2956, '0.7819732726125045');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2957, '0.7130887969703574');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2958, '0.5995963867443211');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2959, '0.9059433764162417');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2960, '0.7818519365614268');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2961, '0.3673374131039938');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2962, '0.01164182131675362');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2963, '0.9419951545151968');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2964, '0.36259052410709625');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2965, '0.35997110935096277');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2966, '0.09505375829732643');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2967, '0.9016369575096402');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2968, '0.7359191293953402');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2969, '0.9280639481871509');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2970, '0.5553156310379138');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2971, '0.59937944806253');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2972, '0.270139513979354');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2973, '0.7464506011255818');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2974, '0.7860241341821479');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2975, '0.057469469542089646');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2976, '0.3520913836941246');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2977, '0.12124741812370043');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2978, '0.9913544891764223');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2979, '0.7647980970909926');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2980, '0.7267156938761989');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2981, '0.3110657321420459');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2982, '0.7761467416285972');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2983, '0.8638936429722455');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2984, '0.150365566676115');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2985, '0.26310607803626496');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2986, '0.3925590896472033');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2987, '0.8414705904769931');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2988, '0.08951908285633514');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2989, '0.12148194521454714');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2990, '0.4108539748378882');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2991, '0.7844876767702752');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2992, '0.22146472406272222');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2993, '0.7970191188948867');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2994, '0.9479565310886671');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2995, '0.5452245931001237');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2996, '0.5830585646710031');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2997, '0.9384582960488481');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2998, '0.16864701879609278');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (2999, '0.8086325342677505');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3000, '0.697761333191354');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3001, '0.7704617399199666');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3002, '0.25583299475191457');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3003, '0.7733800339526469');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3004, '0.591633770045506');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3005, '0.8278930087118906');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3006, '0.035739178088617485');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3007, '0.06943959770991981');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3008, '0.8915528598671448');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3009, '0.8628257905562735');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3010, '0.7169766723908483');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3011, '0.625912853659212');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3012, '0.5837953417097337');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3013, '0.7729732984507959');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3014, '0.6523139804035089');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3015, '0.5629321986229956');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3016, '0.010537633001288182');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3017, '0.8199299472628766');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3018, '0.9486623269401522');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3019, '0.6556107223178549');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3020, '0.2796485654878822');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3021, '0.1035847813080989');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3022, '0.009192955970992345');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3023, '0.42672198640544634');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3024, '0.0565754860529365');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3025, '0.8135306218822749');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3026, '0.04816884209169492');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3027, '0.6580854899655816');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3028, '0.4494509133206368');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3029, '0.08933038293690132');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3030, '0.5749277245057904');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3031, '0.1487964641040047');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3032, '0.1998288945386104');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3033, '0.3944066790070311');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3034, '0.4185651077377712');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3035, '0.8334951268606501');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3036, '0.4773443440632319');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3037, '0.23806902833755583');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3038, '0.5638721987718258');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3039, '0.19554420469203004');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3040, '0.8469653905898541');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3041, '0.13108171184602235');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3042, '0.20991271068242168');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3043, '0.7567596032512528');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3044, '0.5213937606881913');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3045, '0.7777755261401198');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3046, '0.3218101201489214');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3047, '0.6991731857140747');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3048, '0.6283107970710415');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3049, '0.37946098469438505');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3050, '0.9129027958515192');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3051, '0.899917062943212');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3052, '0.39890522809672235');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3053, '0.8784091342279251');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3054, '0.8109750422340353');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3055, '0.06216109470039766');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3056, '0.404332869190849');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3057, '0.5183770427783521');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3058, '0.48152399058871576');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3059, '0.6231021249919516');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3060, '0.7968256938769235');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3061, '0.9013590530092921');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3062, '0.4835913435783423');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3063, '0.8453279103185364');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3064, '0.6182334267171361');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3065, '0.22153158727330213');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3066, '0.5680393421456181');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3067, '0.09133742215015206');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3068, '0.13587004769007327');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3069, '0.20059734044991273');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3070, '0.27006122707533065');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3071, '0.4836013612440725');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3072, '0.11698459042242138');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3073, '0.18397573783422005');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3074, '0.36776807997151584');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3075, '0.27219193477950676');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3076, '0.824575045138879');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3077, '0.8201102441580286');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3078, '0.7572780454955552');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3079, '0.8323222319757481');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3080, '0.7194591798312314');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3081, '0.6289463625690337');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3082, '0.7723732084281557');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3083, '0.9055628108608506');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3084, '0.7465805401110982');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3085, '0.6520829257411566');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3086, '0.35992965163574353');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3087, '0.7517691241831264');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3088, '0.12593250175430049');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3089, '0.48929503632923155');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3090, '0.17327389119980463');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3091, '0.5805106457891686');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3092, '0.8883228034384787');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3093, '0.4862101531901234');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3094, '0.7705127669042395');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3095, '0.22487285971160864');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3096, '0.8007984007126072');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3097, '0.91263157545146');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3098, '0.7591423084603625');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3099, '0.20354817588615648');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3100, '0.029344969172931057');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3101, '0.784881084276388');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3102, '0.37442652970234414');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3103, '0.7157314128732338');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3104, '0.7022577703850926');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3105, '0.5651123121483032');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3106, '0.8307379245865184');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3107, '0.310345304272149');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3108, '0.4970042631200039');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3109, '0.7581441749230886');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3110, '0.8038342196869753');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3111, '0.03102280373714872');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3112, '0.55460429763371');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3113, '0.14520332268435088');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3114, '0.739124123261594');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3115, '0.20361405543934052');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3116, '0.49770956817562784');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3117, '0.7847316785597909');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3118, '0.23917702679056774');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3119, '0.8347640707270518');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3120, '0.41740043017585415');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3121, '0.43382986039842286');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3122, '0.9885174818802722');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3123, '0.73893317814097');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3124, '0.8037290319772538');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3125, '0.4694518938020139');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3126, '0.8906347848930736');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3127, '0.7466090311389767');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3128, '0.7753573133092938');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3129, '0.13547160709466188');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3130, '0.9671461777188031');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3131, '0.06376361183771417');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3132, '0.24456279223733635');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3133, '0.3182256980397469');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3134, '0.8124530651211632');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3135, '0.3544158525499713');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3136, '0.6169187926598148');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3137, '0.7955402251213711');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3138, '0.2774630167919866');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3139, '0.4173137038497087');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3140, '0.9067240699923145');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3141, '0.7897135916733372');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3142, '0.45135083856299507');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3143, '0.7007096110175686');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3144, '0.6784791630906268');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3145, '0.747589565864678');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3146, '0.6931589577766496');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3147, '0.8241317112278403');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3148, '0.2982581563461536');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3149, '0.10074670623277482');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3150, '0.4821144616645515');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3151, '0.9887943824686812');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3152, '0.8923338897181188');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3153, '0.3253486589502891');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3154, '0.8684014030204439');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3155, '0.7445532262921263');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3156, '0.9852697411786481');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3157, '0.7164968243645902');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3158, '0.002451148805176606');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3159, '0.4418226147036475');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3160, '0.8662472500813689');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3161, '0.48749098302006455');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3162, '0.7265615489942231');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3163, '0.09805201801276853');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3164, '0.7157438578868022');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3165, '0.5313926085733405');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3166, '0.7925221930509713');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3167, '0.32963492233611613');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3168, '0.6482995417873663');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3169, '0.14852875190464188');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3170, '0.22511758105701807');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3171, '0.7833884585259052');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3172, '0.03082203784025972');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3173, '0.04846422352435786');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3174, '0.6412274613267878');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3175, '0.21390423526790592');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3176, '0.7939433641733117');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3177, '0.3546012056233432');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3178, '0.932996529509006');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3179, '0.8801522197277296');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3180, '0.5849137520343684');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3181, '0.8631549042813993');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3182, '0.08845351227735454');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3183, '0.40313883653043425');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3184, '0.9597972570007931');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3185, '0.6402463525381851');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3186, '0.31837706007203825');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3187, '0.04406832131461447');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3188, '0.8086414275346608');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3189, '0.3527584445998072');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3190, '0.868138856722979');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3191, '0.5845818086878295');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3192, '0.01510970484119667');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3193, '0.5285003379528107');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3194, '0.7546000489543017');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3195, '0.9017821854313334');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3196, '0.36947881347511635');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3197, '0.18386272598047826');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3198, '0.42124255176161296');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3199, '0.02985813188995401');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3200, '0.6165227176794364');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3201, '0.20748721363359635');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3202, '0.14504546687434694');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3203, '0.6058518381202215');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3204, '0.1642122973613136');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3205, '0.4402088170623948');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3206, '0.29355309690227194');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3207, '0.768961222511751');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3208, '0.7799440614194671');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3209, '0.633560636131567');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3210, '0.08173605200234646');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3211, '0.9775493931106757');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3212, '0.4242019337551318');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3213, '0.6357930366219922');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3214, '0.7807320643371306');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3215, '0.2362531557263955');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3216, '0.6976758911062368');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3217, '0.6622877054424383');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3218, '0.11243390540056597');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3219, '0.961127472747659');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3220, '0.864734368433176');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3221, '0.48096436939661724');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3222, '0.11682810463225979');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3223, '0.6315624494257872');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3224, '0.9022736743690974');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3225, '0.19126305589202375');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3226, '0.3451602161241758');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3227, '0.7932099949067244');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3228, '0.9679831831124368');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3229, '0.9952123432955285');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3230, '0.7887237922840991');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3231, '0.04716237403997292');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3232, '0.6521946981812764');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3233, '0.7835173710270651');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3234, '0.3966048810497945');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3235, '0.3390005201872912');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3236, '0.3610339524836559');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3237, '0.12306274356825941');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3238, '0.16767067815214864');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3239, '0.2673711195200329');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3240, '0.8167734462441114');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3241, '0.5950485735052519');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3242, '0.8074047464448888');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3243, '0.16315817347604977');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3244, '0.6942648873815205');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3245, '0.3233283285374736');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3246, '0.7561530307686337');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3247, '0.48717380769626795');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3248, '0.16520027061161546');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3249, '0.6310303500145064');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3250, '0.5221302150252487');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3251, '0.5912259641250486');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3252, '0.11993144132113798');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3253, '0.8166629283510929');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3254, '0.23729407098184696');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3255, '0.9544750936672732');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3256, '0.11269320258143611');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3257, '0.8065616671599233');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3258, '0.3657597103720748');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3259, '0.20510112884216125');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3260, '0.2398828967514327');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3261, '0.5983731180504729');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3262, '0.7589246615691897');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3263, '0.7721434505229388');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3264, '0.8902457957297607');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3265, '0.9305414852953422');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3266, '0.404251136590857');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3267, '0.11183484333979077');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3268, '0.7781257885569063');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3269, '0.03059491223662647');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3270, '0.1333959063736091');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3271, '0.03984801712791031');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3272, '0.5756375385382468');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3273, '0.7041831913468426');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3274, '0.2648691973073338');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3275, '0.19376022688148886');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3276, '0.34853535274952363');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3277, '0.885371324871007');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3278, '0.9137793059198391');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3279, '0.44371749648270087');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3280, '0.24177045531825447');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3281, '0.7135885918743333');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3282, '0.08984089566269582');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3283, '0.16918141294963596');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3284, '0.5054661673214395');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3285, '0.9277525702342716');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3286, '0.5352789261702384');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3287, '0.6249427041990417');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3288, '0.6105740058808792');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3289, '0.5425028951021147');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3290, '0.5484116829073903');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3291, '0.6092195859274977');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3292, '0.5326850001790774');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3293, '0.9364962457828776');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3294, '0.5352757277583224');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3295, '0.9389256619038798');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3296, '0.2855804555062016');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3297, '0.7986091821710657');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3298, '0.3662072126160931');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3299, '0.18417794556526168');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3300, '0.9113706654912253');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3301, '0.475715221581561');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3302, '0.5378775445550498');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3303, '0.5378775445550498');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3304, '0.5816471332758513');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3305, '0.7017039640702332');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3306, '0.3618945684083965');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3307, '0.5587011889104735');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3308, '0.8500856822042324');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3309, '0.7643313773380438');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3310, '0.316854763558737');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3311, '0.9016417263910063');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3312, '0.43803333920707255');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3313, '0.31637475968563034');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3314, '0.5493900745295877');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3315, '0.9342326332138794');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3316, '0.6282228043789756');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3317, '0.022015208927539498');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3318, '0.4512822123025133');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3319, '0.11612631679704022');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3320, '0.27349931405901906');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3321, '0.3205748668929683');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3322, '0.2581331201337189');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3323, '0.877860359768762');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3324, '0.5852916825627422');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3325, '0.2729112503781539');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3326, '0.19385449812693267');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3327, '0.4425144386877111');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3328, '0.2914921669176984');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3329, '0.6441703110972058');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3330, '0.4379540698591602');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3331, '0.038417768321493684');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3332, '0.33021026980020773');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3333, '0.7227920095719019');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3334, '0.40566732281838025');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3335, '0.045887282338458624');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3336, '0.17864324863836567');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3337, '0.01303986225449505');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3338, '0.6968106122770089');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3339, '0.17034111492927495');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3340, '0.7959913565793216');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3341, '0.892041607889773');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3342, '0.22537375803790383');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3343, '0.2156058251142765');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3344, '0.41158480802473385');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3345, '0.4682862073504883');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3346, '0.1510033926494786');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3347, '0.3148476493496679');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3348, '0.46113041854904224');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3349, '0.982407752466818');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3350, '0.044125731036050886');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3351, '0.4723030994703139');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3352, '0.45597728739433774');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3353, '0.859979817959109');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3354, '0.7629473179445085');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3355, '0.9182377709119699');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3356, '0.2462672762036573');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3357, '0.26575281400664885');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3358, '0.14182932823436334');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3359, '0.5044006614797149');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3360, '0.052414923361479016');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3361, '0.898001674137872');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3362, '0.8923394383130857');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3363, '0.1464781248054433');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3364, '0.892035018626459');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3365, '0.7459920832423728');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3366, '0.6813072277212301');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3367, '0.11774711009178895');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3368, '0.06463161847400989');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3369, '0.27881270192924823');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3370, '0.6371986728806711');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3371, '0.9178280827906917');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3372, '0.2034133718709903');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3373, '0.5741620846707104');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3374, '0.22927039595717524');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3375, '0.0452342746018084');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3376, '0.9768802782764507');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3377, '0.5428018738465862');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3378, '0.006588465845327018');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3379, '0.8983847074207021');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3380, '0.9266340585345516');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3381, '0.07605572441554642');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3382, '0.3970042330610998');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3383, '0.696517440512074');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3384, '0.7289205459941039');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3385, '0.8040757158882766');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3386, '0.33527123477276277');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3387, '0.08432497141820483');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3388, '0.4764977900547025');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3389, '0.629136998936255');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3390, '0.9487093050406379');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3391, '0.9422986972626165');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3392, '0.873707552089614');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3393, '0.009605232537043595');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3394, '0.6564441430566358');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3395, '0.8620475697163223');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3396, '0.2671307973159981');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3397, '0.05161594855828611');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3398, '0.17544551130840835');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3399, '0.14168404047021388');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3400, '0.44098880683059827');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3401, '0.5079962854649188');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3402, '0.07550613402295614');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3403, '0.46333789437623063');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (3, '0.3668553873574353');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (4, '0.029044178401378296');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (5, '0.4868916132560994');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (6, '0.8597541122312323');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (7, '0.6932184569621107');
INSERT INTO repetition (repetition_id, repetition_code) VALUES (8, '0.9665311028549729');


--
-- TOC entry 2154 (class 0 OID 18129)
-- Dependencies: 1632
-- Data for Name: report; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 2155 (class 0 OID 18135)
-- Dependencies: 1633
-- Data for Name: resaccess; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 2156 (class 0 OID 18138)
-- Dependencies: 1634
-- Data for Name: resource; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO resource (resource_id, resource_name, resource_type, resource_status, resource_maxdays, resource_starttime, resource_stoptime, resource_resp, resource_wikilink, resource_price, resource_resolution, resource_maxslots, "resource_confIP", resource_confirmtol, resource_delhour) VALUES (1, 'Demo Resource', 1, 1, 7, 7, 22, 1, '', 1, 30, 8, '0.0.0.0', 2, 2);
INSERT INTO resource (resource_id, resource_name, resource_type, resource_status, resource_maxdays, resource_starttime, resource_stoptime, resource_resp, resource_wikilink, resource_price, resource_resolution, resource_maxslots, "resource_confIP", resource_confirmtol, resource_delhour) VALUES (2, 'Technician operated resource', 3, 4, 7, 5, 22, 1, '', 30, 60, 4, '0.0.0.0', 2, 2);
INSERT INTO resource (resource_id, resource_name, resource_type, resource_status, resource_maxdays, resource_starttime, resource_stoptime, resource_resp, resource_wikilink, resource_price, resource_resolution, resource_maxslots, "resource_confIP", resource_confirmtol, resource_delhour) VALUES (3, 'FACSARIAII', 3, 3, 4, 2, 5, 1, '', 20, 30, 4, '0.0.0.0', 1, 0);
INSERT INTO resource (resource_id, resource_name, resource_type, resource_status, resource_maxdays, resource_starttime, resource_stoptime, resource_resp, resource_wikilink, resource_price, resource_resolution, resource_maxslots, "resource_confIP", resource_confirmtol, resource_delhour) VALUES (4, 'Influx', 3, 4, 7, 9, 18, 1, '', 70, 60, 8, '0.0.0.0', 1, 18);


--
-- TOC entry 2157 (class 0 OID 18145)
-- Dependencies: 1635
-- Data for Name: resstatus; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO resstatus (resstatus_id, resstatus_name) VALUES (0, 'Inactive');
INSERT INTO resstatus (resstatus_id, resstatus_name) VALUES (1, 'Regular reservation');
INSERT INTO resstatus (resstatus_id, resstatus_name) VALUES (2, 'Invisible');
INSERT INTO resstatus (resstatus_id, resstatus_name) VALUES (3, 'Pre-reservation with user confirmation');
INSERT INTO resstatus (resstatus_id, resstatus_name) VALUES (4, 'Pre-reservation with admin confirmation');


--
-- TOC entry 2158 (class 0 OID 18148)
-- Dependencies: 1636
-- Data for Name: restree; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO restree (restree_id, restree_user, restree_name, restree_access) VALUES (1, 1, 1, 3);


--
-- TOC entry 2159 (class 0 OID 18151)
-- Dependencies: 1637
-- Data for Name: resxfields; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 2160 (class 0 OID 18154)
-- Dependencies: 1638
-- Data for Name: search; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 2161 (class 0 OID 18160)
-- Dependencies: 1639
-- Data for Name: status; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO status (status_id, status_name) VALUES (1, 'Regular');
INSERT INTO status (status_id, status_name) VALUES (2, 'Pre-reserve');
INSERT INTO status (status_id, status_name) VALUES (3, 'Deleted');
INSERT INTO status (status_id, status_name) VALUES (4, 'Monitor');


--
-- TOC entry 2162 (class 0 OID 18163)
-- Dependencies: 1640
-- Data for Name: treeview; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO treeview (treeview_id, treeview_name, treeview_description, treeview_table1, treeview_table2, treeview_table3) VALUES (1, 'users', 'users per department', 'institute', 'department', 'user');


--
-- TOC entry 2163 (class 0 OID 18166)
-- Dependencies: 1641
-- Data for Name: type; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO type (type_id, type_name) VALUES (1, 'Microscopes - Optical Sectioning');
INSERT INTO type (type_id, type_name) VALUES (2, 'Microscopes - Wide fields');
INSERT INTO type (type_id, type_name) VALUES (3, 'Flow Cytometry - Cell sorters');
INSERT INTO type (type_id, type_name) VALUES (4, 'Real Time PCRs');
INSERT INTO type (type_id, type_name) VALUES (5, 'Flow Cytometry - Analyzers');
INSERT INTO type (type_id, type_name) VALUES (6, 'Phys-Chem Measurements');
INSERT INTO type (type_id, type_name) VALUES (7, 'Stereoscopes');
INSERT INTO type (type_id, type_name) VALUES (8, 'Histology');
INSERT INTO type (type_id, type_name) VALUES (9, 'Computers');
INSERT INTO type (type_id, type_name) VALUES (10, 'Environment Control');


--
-- TOC entry 2166 (class 0 OID 18444)
-- Dependencies: 1645
-- Data for Name: user; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--

INSERT INTO "user" (user_id, user_login, user_passwd, user_firstname, user_lastname, user_dep, user_phone, user_phonext, user_mobile, user_email, user_alert, user_level) VALUES (1, 'admin', '2127f97535023818d7add4a3c2428e06d382160daab440a9183690f18e285010', 'The', 'Admin', 1, '123456789', '123', '987654321', 'admin@mail.com', 1, 0);


--
-- TOC entry 2164 (class 0 OID 18172)
-- Dependencies: 1642
-- Data for Name: xfields; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 2165 (class 0 OID 18175)
-- Dependencies: 1643
-- Data for Name: xfieldsval; Type: TABLE DATA; Schema: dbtest; Owner: postgres
--



--
-- TOC entry 1988 (class 2606 OID 18179)
-- Dependencies: 1607 1607
-- Name: access_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY access
    ADD CONSTRAINT access_pkey PRIMARY KEY (access_id);


--
-- TOC entry 1991 (class 2606 OID 18181)
-- Dependencies: 1608 1608
-- Name: admin_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (admin_id);


--
-- TOC entry 1995 (class 2606 OID 18183)
-- Dependencies: 1609 1609
-- Name: announcement_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY announcement
    ADD CONSTRAINT announcement_pkey PRIMARY KEY (announcement_id);


--
-- TOC entry 1997 (class 2606 OID 18185)
-- Dependencies: 1610 1610
-- Name: board_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY board
    ADD CONSTRAINT board_pkey PRIMARY KEY (board_id);


--
-- TOC entry 1999 (class 2606 OID 18187)
-- Dependencies: 1611 1611
-- Name: bool_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bool
    ADD CONSTRAINT bool_pkey PRIMARY KEY (bool_id);


--
-- TOC entry 2001 (class 2606 OID 18189)
-- Dependencies: 1612 1612
-- Name: confidentiality_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY confidentiality
    ADD CONSTRAINT confidentiality_pkey PRIMARY KEY (confidentiality_id);


--
-- TOC entry 2003 (class 2606 OID 18191)
-- Dependencies: 1613 1613
-- Name: country_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);


--
-- TOC entry 2006 (class 2606 OID 18193)
-- Dependencies: 1614 1614
-- Name: department_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- TOC entry 2008 (class 2606 OID 18195)
-- Dependencies: 1615 1615
-- Name: entry_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY entry
    ADD CONSTRAINT entry_pkey PRIMARY KEY (entry_id);


--
-- TOC entry 2016 (class 2606 OID 18197)
-- Dependencies: 1616 1616
-- Name: equip_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY equip
    ADD CONSTRAINT equip_pkey PRIMARY KEY (equip_id);


--
-- TOC entry 2022 (class 2606 OID 18199)
-- Dependencies: 1617 1617
-- Name: help_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY help
    ADD CONSTRAINT help_pkey PRIMARY KEY (help_id);


--
-- TOC entry 2024 (class 2606 OID 18201)
-- Dependencies: 1618 1618
-- Name: hmediaposition_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hmediaposition
    ADD CONSTRAINT hmediaposition_pkey PRIMARY KEY (hmediaposition_id);


--
-- TOC entry 2026 (class 2606 OID 18203)
-- Dependencies: 1619 1619
-- Name: hmediatype_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY hmediatype
    ADD CONSTRAINT hmediatype_pkey PRIMARY KEY (hmediatype_id);


--
-- TOC entry 2030 (class 2606 OID 18205)
-- Dependencies: 1620 1620
-- Name: institute_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY institute
    ADD CONSTRAINT institute_pkey PRIMARY KEY (institute_id);


--
-- TOC entry 2032 (class 2606 OID 18207)
-- Dependencies: 1621 1621
-- Name: level_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY level
    ADD CONSTRAINT level_pkey PRIMARY KEY (level_id);


--
-- TOC entry 2034 (class 2606 OID 18209)
-- Dependencies: 1622 1622
-- Name: mainconfig_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mainconfig
    ADD CONSTRAINT mainconfig_pkey PRIMARY KEY (mainconfig_id);


--
-- TOC entry 2037 (class 2606 OID 18211)
-- Dependencies: 1623 1623
-- Name: measure_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY measure
    ADD CONSTRAINT measure_pkey PRIMARY KEY (measure_id);


--
-- TOC entry 2039 (class 2606 OID 18215)
-- Dependencies: 1624 1624 1624 1624
-- Name: media_name; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY media
    ADD CONSTRAINT media_name UNIQUE (media_name, media_description, media_link);


--
-- TOC entry 2041 (class 2606 OID 18213)
-- Dependencies: 1624 1624
-- Name: media_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY media
    ADD CONSTRAINT media_pkey PRIMARY KEY (media_id);


--
-- TOC entry 2043 (class 2606 OID 18217)
-- Dependencies: 1625 1625
-- Name: menu_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (menu_id);


--
-- TOC entry 2046 (class 2606 OID 18219)
-- Dependencies: 1626 1626
-- Name: param_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY param
    ADD CONSTRAINT param_pkey PRIMARY KEY (param_id);


--
-- TOC entry 2049 (class 2606 OID 18221)
-- Dependencies: 1627 1627
-- Name: parameter_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY parameter
    ADD CONSTRAINT parameter_pkey PRIMARY KEY (parameter_id);


--
-- TOC entry 2052 (class 2606 OID 18223)
-- Dependencies: 1628 1628
-- Name: permissions_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (permissions_id);


--
-- TOC entry 2056 (class 2606 OID 18225)
-- Dependencies: 1629 1629
-- Name: permlevel_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY permlevel
    ADD CONSTRAINT permlevel_pkey PRIMARY KEY (permlevel_id);


--
-- TOC entry 2058 (class 2606 OID 18227)
-- Dependencies: 1630 1630
-- Name: plugin_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY plugin
    ADD CONSTRAINT plugin_pkey PRIMARY KEY (plugin_id);


--
-- TOC entry 2062 (class 2606 OID 18229)
-- Dependencies: 1632 1632
-- Name: report_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY report
    ADD CONSTRAINT report_pkey PRIMARY KEY (report_id);


--
-- TOC entry 2065 (class 2606 OID 18231)
-- Dependencies: 1633 1633
-- Name: resaccess_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY resaccess
    ADD CONSTRAINT resaccess_pkey PRIMARY KEY (resaccess_id);


--
-- TOC entry 2069 (class 2606 OID 18233)
-- Dependencies: 1634 1634
-- Name: resource_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (resource_id);


--
-- TOC entry 2074 (class 2606 OID 18237)
-- Dependencies: 1635 1635
-- Name: resstatus_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY resstatus
    ADD CONSTRAINT resstatus_pkey PRIMARY KEY (resstatus_id);


--
-- TOC entry 2078 (class 2606 OID 18239)
-- Dependencies: 1636 1636
-- Name: restree_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY restree
    ADD CONSTRAINT restree_pkey PRIMARY KEY (restree_id);


--
-- TOC entry 2083 (class 2606 OID 18241)
-- Dependencies: 1638 1638
-- Name: search_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY search
    ADD CONSTRAINT search_pkey PRIMARY KEY (search_id);


--
-- TOC entry 2086 (class 2606 OID 18243)
-- Dependencies: 1639 1639
-- Name: status_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY status
    ADD CONSTRAINT status_pkey PRIMARY KEY (status_id);


--
-- TOC entry 2088 (class 2606 OID 18245)
-- Dependencies: 1640 1640
-- Name: treeview_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY treeview
    ADD CONSTRAINT treeview_pkey PRIMARY KEY (treeview_id);


--
-- TOC entry 2090 (class 2606 OID 18247)
-- Dependencies: 1641 1641
-- Name: type_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY type
    ADD CONSTRAINT type_pkey PRIMARY KEY (type_id);


--
-- TOC entry 2092 (class 2606 OID 18253)
-- Dependencies: 1642 1642
-- Name: xfields_name; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY xfields
    ADD CONSTRAINT xfields_name UNIQUE (xfields_name);


--
-- TOC entry 2094 (class 2606 OID 18251)
-- Dependencies: 1642 1642
-- Name: xfields_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY xfields
    ADD CONSTRAINT xfields_pkey PRIMARY KEY (xfields_id);


--
-- TOC entry 2100 (class 2606 OID 18255)
-- Dependencies: 1643 1643
-- Name: xfieldsval_pkey; Type: CONSTRAINT; Schema: dbtest; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY xfieldsval
    ADD CONSTRAINT xfieldsval_pkey PRIMARY KEY (xfieldsval_id);


--
-- TOC entry 1989 (class 1259 OID 18392)
-- Dependencies: 1608
-- Name: admin_permission; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX admin_permission ON admin USING btree (admin_permission);


--
-- TOC entry 1992 (class 1259 OID 18391)
-- Dependencies: 1608
-- Name: admin_user; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX admin_user ON admin USING btree (admin_user);


--
-- TOC entry 1993 (class 1259 OID 18393)
-- Dependencies: 1609
-- Name: announcement_object; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX announcement_object ON announcement USING btree (announcement_object);


--
-- TOC entry 2004 (class 1259 OID 18394)
-- Dependencies: 1614
-- Name: department_inst; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX department_inst ON department USING btree (department_inst);


--
-- TOC entry 2009 (class 1259 OID 18397)
-- Dependencies: 1615
-- Name: entry_repeat; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX entry_repeat ON entry USING btree (entry_repeat);


--
-- TOC entry 2010 (class 1259 OID 18396)
-- Dependencies: 1615
-- Name: entry_resource; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX entry_resource ON entry USING btree (entry_resource);


--
-- TOC entry 2011 (class 1259 OID 18398)
-- Dependencies: 1615
-- Name: entry_status; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX entry_status ON entry USING btree (entry_status);


--
-- TOC entry 2012 (class 1259 OID 18395)
-- Dependencies: 1615
-- Name: entry_user; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX entry_user ON entry USING btree (entry_user);


--
-- TOC entry 2013 (class 1259 OID 18399)
-- Dependencies: 1616
-- Name: equip_boardID; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX "equip_boardID" ON equip USING btree ("equip_boardID");


--
-- TOC entry 2014 (class 1259 OID 18400)
-- Dependencies: 1616
-- Name: equip_para; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX equip_para ON equip USING btree (equip_para);


--
-- TOC entry 2017 (class 1259 OID 18401)
-- Dependencies: 1616
-- Name: equip_resourceid; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX equip_resourceid ON equip USING btree (equip_resourceid);


--
-- TOC entry 2018 (class 1259 OID 18402)
-- Dependencies: 1616
-- Name: equip_user; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX equip_user ON equip USING btree (equip_user);


--
-- TOC entry 2019 (class 1259 OID 18403)
-- Dependencies: 1617
-- Name: help_mediaposition; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX help_mediaposition ON help USING btree (help_mediaposition);


--
-- TOC entry 2020 (class 1259 OID 18404)
-- Dependencies: 1617
-- Name: help_mediatype; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX help_mediatype ON help USING btree (help_mediatype);


--
-- TOC entry 2027 (class 1259 OID 18405)
-- Dependencies: 1620
-- Name: institute_country; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX institute_country ON institute USING btree (institute_country);


--
-- TOC entry 2028 (class 1259 OID 18406)
-- Dependencies: 1620
-- Name: institute_country_2; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX institute_country_2 ON institute USING btree (institute_country);


--
-- TOC entry 2035 (class 1259 OID 18407)
-- Dependencies: 1623
-- Name: measure_equip; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX measure_equip ON measure USING btree (measure_equip);


--
-- TOC entry 2044 (class 1259 OID 18408)
-- Dependencies: 1625
-- Name: menu_plugin; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX menu_plugin ON menu USING btree (menu_plugin);


--
-- TOC entry 2047 (class 1259 OID 18409)
-- Dependencies: 1626
-- Name: param_report; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX param_report ON param USING btree (param_report);


--
-- TOC entry 2050 (class 1259 OID 18412)
-- Dependencies: 1628
-- Name: permissions_level; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX permissions_level ON permissions USING btree (permissions_level);


--
-- TOC entry 2053 (class 1259 OID 18411)
-- Dependencies: 1628
-- Name: permissions_resource; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX permissions_resource ON permissions USING btree (permissions_resource);


--
-- TOC entry 2054 (class 1259 OID 18410)
-- Dependencies: 1628
-- Name: permissions_user; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX permissions_user ON permissions USING btree (permissions_user);


--
-- TOC entry 2059 (class 1259 OID 18413)
-- Dependencies: 1631
-- Name: repetition_id; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX repetition_id ON repetition USING btree (repetition_id);


--
-- TOC entry 2060 (class 1259 OID 18415)
-- Dependencies: 1632
-- Name: report_conf; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX report_conf ON report USING btree (report_conf);


--
-- TOC entry 2063 (class 1259 OID 18414)
-- Dependencies: 1632
-- Name: report_user; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX report_user ON report USING btree (report_user);


--
-- TOC entry 2066 (class 1259 OID 18416)
-- Dependencies: 1633
-- Name: resaccess_user; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX resaccess_user ON resaccess USING btree (resaccess_user);


--
-- TOC entry 2067 (class 1259 OID 18419)
-- Dependencies: 1634
-- Name: resource_id; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX resource_id ON resource USING btree (resource_id);


--
-- TOC entry 2070 (class 1259 OID 18420)
-- Dependencies: 1634
-- Name: resource_resp; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX resource_resp ON resource USING btree (resource_resp);


--
-- TOC entry 2071 (class 1259 OID 18418)
-- Dependencies: 1634
-- Name: resource_status; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX resource_status ON resource USING btree (resource_status);


--
-- TOC entry 2072 (class 1259 OID 18417)
-- Dependencies: 1634
-- Name: resource_type; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX resource_type ON resource USING btree (resource_type);


--
-- TOC entry 2075 (class 1259 OID 18425)
-- Dependencies: 1636
-- Name: restree_access; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX restree_access ON restree USING btree (restree_access);


--
-- TOC entry 2076 (class 1259 OID 18424)
-- Dependencies: 1636
-- Name: restree_name; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX restree_name ON restree USING btree (restree_name);


--
-- TOC entry 2079 (class 1259 OID 18423)
-- Dependencies: 1636
-- Name: restree_user; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX restree_user ON restree USING btree (restree_user);


--
-- TOC entry 2080 (class 1259 OID 18426)
-- Dependencies: 1637
-- Name: resxfields_id; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX resxfields_id ON resxfields USING btree (resxfields_field);


--
-- TOC entry 2081 (class 1259 OID 18427)
-- Dependencies: 1637
-- Name: resxfields_resource; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX resxfields_resource ON resxfields USING btree (resxfields_resource);


--
-- TOC entry 2084 (class 1259 OID 18428)
-- Dependencies: 1639
-- Name: status_id; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX status_id ON status USING btree (status_id);


--
-- TOC entry 2095 (class 1259 OID 18435)
-- Dependencies: 1643
-- Name: xfieldsval_entry; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX xfieldsval_entry ON xfieldsval USING btree (xfieldsval_entry);


--
-- TOC entry 2096 (class 1259 OID 18437)
-- Dependencies: 1643
-- Name: xfieldsval_field; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX xfieldsval_field ON xfieldsval USING btree (xfieldsval_field);


--
-- TOC entry 2097 (class 1259 OID 18433)
-- Dependencies: 1643
-- Name: xfieldsval_id; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX xfieldsval_id ON xfieldsval USING btree (xfieldsval_id);


--
-- TOC entry 2098 (class 1259 OID 18434)
-- Dependencies: 1643
-- Name: xfieldsval_id_2; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX xfieldsval_id_2 ON xfieldsval USING btree (xfieldsval_id);


--
-- TOC entry 2101 (class 1259 OID 18431)
-- Dependencies: 1643 1643 1643
-- Name: xfieldval_entry; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX xfieldval_entry ON xfieldsval USING btree (xfieldsval_entry, xfieldsval_field, xfieldsval_value);


--
-- TOC entry 2102 (class 1259 OID 18432)
-- Dependencies: 1643
-- Name: xfieldval_fieldid; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX xfieldval_fieldid ON xfieldsval USING btree (xfieldsval_field);


--
-- TOC entry 2103 (class 1259 OID 18436)
-- Dependencies: 1643
-- Name: xfieldvals_field; Type: INDEX; Schema: dbtest; Owner: postgres; Tablespace: 
--

CREATE INDEX xfieldvals_field ON xfieldsval USING btree (xfieldsval_field);


--
-- TOC entry 2104 (class 2606 OID 18256)
-- Dependencies: 1987 1608 1607
-- Name: admin_ibfk_4; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY admin
    ADD CONSTRAINT admin_ibfk_4 FOREIGN KEY (admin_permission) REFERENCES access(access_id) MATCH FULL ON DELETE CASCADE;


--
-- TOC entry 2105 (class 2606 OID 18261)
-- Dependencies: 1634 2068 1609
-- Name: announcement_ibfk_1; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY announcement
    ADD CONSTRAINT announcement_ibfk_1 FOREIGN KEY (announcement_object) REFERENCES resource(resource_id) MATCH FULL;


--
-- TOC entry 2106 (class 2606 OID 18266)
-- Dependencies: 1614 1620 2029
-- Name: department_ibfk_1; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY department
    ADD CONSTRAINT department_ibfk_1 FOREIGN KEY (department_inst) REFERENCES institute(institute_id) MATCH FULL;


--
-- TOC entry 2108 (class 2606 OID 18276)
-- Dependencies: 1615 2085 1639
-- Name: entry_ibfk_12; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY entry
    ADD CONSTRAINT entry_ibfk_12 FOREIGN KEY (entry_status) REFERENCES status(status_id) MATCH FULL;


--
-- TOC entry 2107 (class 2606 OID 18271)
-- Dependencies: 1634 2068 1615
-- Name: entry_ibfk_13; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY entry
    ADD CONSTRAINT entry_ibfk_13 FOREIGN KEY (entry_resource) REFERENCES resource(resource_id) MATCH FULL;


--
-- TOC entry 2109 (class 2606 OID 18281)
-- Dependencies: 2068 1634 1616
-- Name: equip_ibfk_14; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY equip
    ADD CONSTRAINT equip_ibfk_14 FOREIGN KEY (equip_resourceid) REFERENCES resource(resource_id) MATCH FULL;


--
-- TOC entry 2110 (class 2606 OID 18286)
-- Dependencies: 1616 1996 1610
-- Name: equip_ibfk_15; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY equip
    ADD CONSTRAINT equip_ibfk_15 FOREIGN KEY ("equip_boardID") REFERENCES board(board_id) MATCH FULL;


--
-- TOC entry 2111 (class 2606 OID 18291)
-- Dependencies: 2048 1627 1616
-- Name: equip_ibfk_16; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY equip
    ADD CONSTRAINT equip_ibfk_16 FOREIGN KEY (equip_para) REFERENCES parameter(parameter_id) MATCH FULL;


--
-- TOC entry 2112 (class 2606 OID 18296)
-- Dependencies: 1617 2023 1618
-- Name: help_ibfk_1; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY help
    ADD CONSTRAINT help_ibfk_1 FOREIGN KEY (help_mediaposition) REFERENCES hmediaposition(hmediaposition_id) MATCH FULL ON DELETE CASCADE;


--
-- TOC entry 2113 (class 2606 OID 18301)
-- Dependencies: 2025 1619 1617
-- Name: help_ibfk_2; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY help
    ADD CONSTRAINT help_ibfk_2 FOREIGN KEY (help_mediatype) REFERENCES hmediatype(hmediatype_id) MATCH FULL ON DELETE CASCADE;


--
-- TOC entry 2114 (class 2606 OID 18306)
-- Dependencies: 2002 1613 1620
-- Name: institute_ibfk_1; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY institute
    ADD CONSTRAINT institute_ibfk_1 FOREIGN KEY (institute_country) REFERENCES country(country_id) MATCH FULL;


--
-- TOC entry 2115 (class 2606 OID 18311)
-- Dependencies: 2015 1616 1623
-- Name: measure_ibfk_1; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY measure
    ADD CONSTRAINT measure_ibfk_1 FOREIGN KEY (measure_equip) REFERENCES equip(equip_id) MATCH FULL;


--
-- TOC entry 2116 (class 2606 OID 18316)
-- Dependencies: 2057 1630 1625
-- Name: menu_ibfk_1; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_ibfk_1 FOREIGN KEY (menu_plugin) REFERENCES plugin(plugin_id) MATCH FULL ON DELETE CASCADE;


--
-- TOC entry 2117 (class 2606 OID 18321)
-- Dependencies: 1626 1632 2061
-- Name: param_ibfk_1; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY param
    ADD CONSTRAINT param_ibfk_1 FOREIGN KEY (param_report) REFERENCES report(report_id) MATCH FULL;


--
-- TOC entry 2118 (class 2606 OID 18326)
-- Dependencies: 2068 1634 1628
-- Name: permissions_ibfk_5; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_ibfk_5 FOREIGN KEY (permissions_resource) REFERENCES resource(resource_id) MATCH FULL;


--
-- TOC entry 2119 (class 2606 OID 18331)
-- Dependencies: 2055 1629 1628
-- Name: permissions_ibfk_6; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_ibfk_6 FOREIGN KEY (permissions_level) REFERENCES permlevel(permlevel_id) MATCH FULL;


--
-- TOC entry 2120 (class 2606 OID 18336)
-- Dependencies: 2000 1612 1632
-- Name: report_ibfk_2; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY report
    ADD CONSTRAINT report_ibfk_2 FOREIGN KEY (report_conf) REFERENCES confidentiality(confidentiality_id) MATCH FULL;


--
-- TOC entry 2121 (class 2606 OID 18341)
-- Dependencies: 1641 2089 1634
-- Name: resource_ibfk_8; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_ibfk_8 FOREIGN KEY (resource_type) REFERENCES type(type_id) MATCH FULL;


--
-- TOC entry 2122 (class 2606 OID 18346)
-- Dependencies: 1635 1634 2073
-- Name: resource_ibfk_9; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_ibfk_9 FOREIGN KEY (resource_status) REFERENCES resstatus(resstatus_id) MATCH FULL;


--
-- TOC entry 2123 (class 2606 OID 18356)
-- Dependencies: 1640 2087 1636
-- Name: restree_ibfk_2; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY restree
    ADD CONSTRAINT restree_ibfk_2 FOREIGN KEY (restree_name) REFERENCES treeview(treeview_id) MATCH FULL;


--
-- TOC entry 2124 (class 2606 OID 18361)
-- Dependencies: 1636 1987 1607
-- Name: restree_ibfk_3; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY restree
    ADD CONSTRAINT restree_ibfk_3 FOREIGN KEY (restree_access) REFERENCES access(access_id) MATCH FULL;


--
-- TOC entry 2125 (class 2606 OID 18366)
-- Dependencies: 2068 1637 1634
-- Name: resxfields_ibfk_2; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY resxfields
    ADD CONSTRAINT resxfields_ibfk_2 FOREIGN KEY (resxfields_resource) REFERENCES resource(resource_id) MATCH FULL;


--
-- TOC entry 2126 (class 2606 OID 18371)
-- Dependencies: 1637 2093 1642
-- Name: resxfields_ibfk_3; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY resxfields
    ADD CONSTRAINT resxfields_ibfk_3 FOREIGN KEY (resxfields_field) REFERENCES xfields(xfields_id) MATCH FULL;


--
-- TOC entry 2127 (class 2606 OID 18381)
-- Dependencies: 1643 1642 2093
-- Name: xfieldsval_ibfk_2; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY xfieldsval
    ADD CONSTRAINT xfieldsval_ibfk_2 FOREIGN KEY (xfieldsval_field) REFERENCES xfields(xfields_id) MATCH FULL;


--
-- TOC entry 2128 (class 2606 OID 18386)
-- Dependencies: 2007 1643 1615
-- Name: xfieldsval_ibfk_3; Type: FK CONSTRAINT; Schema: dbtest; Owner: postgres
--

ALTER TABLE ONLY xfieldsval
    ADD CONSTRAINT xfieldsval_ibfk_3 FOREIGN KEY (xfieldsval_entry) REFERENCES entry(entry_id) MATCH FULL ON DELETE CASCADE;


-- Completed on 2011-02-28 10:46:56

--
-- PostgreSQL database dump complete
--

