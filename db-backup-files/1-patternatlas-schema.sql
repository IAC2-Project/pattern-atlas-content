--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2 (Debian 12.2-2.pgdg100+1)
-- Dumped by pg_dump version 12.3

-- Started on 2020-08-27 16:36:51

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
-- TOC entry 1 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3156 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 3 (class 3079 OID 16393)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 3157 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 204 (class 1259 OID 16404)
-- Name: candidate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidate (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    uri character varying(255) NOT NULL,
    content character varying(255),
    icon_url character varying(255),
    rating integer NOT NULL,
    version character varying(255),
    pattern_language_id uuid
);


ALTER TABLE public.candidate OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16410)
-- Name: candidate_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidate_comment (
    id uuid NOT NULL,
    rating integer NOT NULL,
    text character varying(255),
    candidate_id uuid,
    user_id uuid
);


ALTER TABLE public.candidate_comment OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16413)
-- Name: candidate_comment_rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidate_comment_rating (
    rating integer NOT NULL,
    candidate_comment_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.candidate_comment_rating OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16416)
-- Name: candidate_rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidate_rating (
    rating integer NOT NULL,
    candidate_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.candidate_rating OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16419)
-- Name: directed_edge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directed_edge (
    id uuid NOT NULL,
    description jsonb,
    type character varying(255),
    pattern_language_id uuid,
    source_id uuid NOT NULL,
    target_id uuid NOT NULL
);


ALTER TABLE public.directed_edge OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16425)
-- Name: directed_hyperedge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directed_hyperedge (
    id uuid NOT NULL,
    description jsonb,
    type character varying(255),
    label character varying(255)
);


ALTER TABLE public.directed_hyperedge OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16431)
-- Name: directed_hyperedge_source_set; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directed_hyperedge_source_set (
    directed_hyperedge_id uuid NOT NULL,
    source_set_id uuid NOT NULL
);


ALTER TABLE public.directed_hyperedge_source_set OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16434)
-- Name: directed_hyperedge_target_set; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directed_hyperedge_target_set (
    directed_hyperedge_id uuid NOT NULL,
    target_set_id uuid NOT NULL
);


ALTER TABLE public.directed_hyperedge_target_set OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16437)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16439)
-- Name: issue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.issue (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    uri character varying(255) NOT NULL,
    description character varying(255),
    rating integer NOT NULL,
    version character varying(255)
);


ALTER TABLE public.issue OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16445)
-- Name: issue_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.issue_comment (
    id uuid NOT NULL,
    rating integer NOT NULL,
    text character varying(255),
    issue_id uuid,
    user_id uuid
);


ALTER TABLE public.issue_comment OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16448)
-- Name: issue_comment_rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.issue_comment_rating (
    rating integer NOT NULL,
    issue_comment_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.issue_comment_rating OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16451)
-- Name: issue_rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.issue_rating (
    rating integer NOT NULL,
    issue_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.issue_rating OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16454)
-- Name: pattern; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pattern (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    uri character varying(255) NOT NULL,
    content jsonb NOT NULL,
    icon_url character varying(255),
    pattern_language_id uuid
);


ALTER TABLE public.pattern OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16460)
-- Name: pattern_language; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pattern_language (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    uri character varying(255) NOT NULL,
    graph jsonb,
    creative_commons_reference character varying(255),
    logo character varying(255)
);


ALTER TABLE public.pattern_language OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16466)
-- Name: pattern_schema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pattern_schema (
    pattern_language_id uuid NOT NULL
);


ALTER TABLE public.pattern_schema OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16469)
-- Name: pattern_section; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pattern_section (
    id bigint NOT NULL,
    value text,
    pattern_section_schema_id uuid
);


ALTER TABLE public.pattern_section OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16475)
-- Name: pattern_section_schema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pattern_section_schema (
    id uuid NOT NULL,
    label character varying(255),
    name character varying(255),
    "position" integer,
    type character varying(255),
    pattern_schema_pattern_language_id uuid
);


ALTER TABLE public.pattern_section_schema OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16481)
-- Name: pattern_section_schema_pattern_sections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pattern_section_schema_pattern_sections (
    pattern_section_schema_id uuid NOT NULL,
    pattern_sections_id bigint NOT NULL
);


ALTER TABLE public.pattern_section_schema_pattern_sections OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16484)
-- Name: pattern_view; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pattern_view (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    uri character varying(255) NOT NULL,
    graph jsonb
);


ALTER TABLE public.pattern_view OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16490)
-- Name: pattern_view_directed_edge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pattern_view_directed_edge (
    directed_edge_id uuid NOT NULL,
    pattern_view_id uuid NOT NULL
);


ALTER TABLE public.pattern_view_directed_edge OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16493)
-- Name: pattern_view_pattern; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pattern_view_pattern (
    pattern_id uuid NOT NULL,
    pattern_view_id uuid NOT NULL
);


ALTER TABLE public.pattern_view_pattern OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16496)
-- Name: pattern_view_undirected_edge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pattern_view_undirected_edge (
    pattern_view_id uuid NOT NULL,
    undirected_edge_id uuid NOT NULL
);


ALTER TABLE public.pattern_view_undirected_edge OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16499)
-- Name: undirected_edge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.undirected_edge (
    id uuid NOT NULL,
    description jsonb,
    type character varying(255),
    p1_id uuid NOT NULL,
    p2_id uuid NOT NULL,
    pattern_language_id uuid
);


ALTER TABLE public.undirected_edge OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16505)
-- Name: undirected_hyperedge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.undirected_hyperedge (
    id uuid NOT NULL,
    description jsonb,
    type character varying(255),
    label character varying(255)
);


ALTER TABLE public.undirected_hyperedge OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16511)
-- Name: undirected_hyperedge_patterns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.undirected_hyperedge_patterns (
    undirected_hyperedge_id uuid NOT NULL,
    patterns_id uuid NOT NULL
);


ALTER TABLE public.undirected_hyperedge_patterns OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16514)
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id uuid NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255),
    password character varying(255)
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16520)
-- Name: user_entity_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity_roles (
    user_entity_id uuid NOT NULL,
    roles character varying(255)
);


ALTER TABLE public.user_entity_roles OWNER TO postgres;

--
-- TOC entry 2912 (class 2606 OID 16524)
-- Name: candidate_comment candidate_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_comment
    ADD CONSTRAINT candidate_comment_pkey PRIMARY KEY (id);


--
-- TOC entry 2914 (class 2606 OID 16526)
-- Name: candidate_comment_rating candidate_comment_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_comment_rating
    ADD CONSTRAINT candidate_comment_rating_pkey PRIMARY KEY (candidate_comment_id, user_id);


--
-- TOC entry 2906 (class 2606 OID 16528)
-- Name: candidate candidate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate
    ADD CONSTRAINT candidate_pkey PRIMARY KEY (id);


--
-- TOC entry 2916 (class 2606 OID 16530)
-- Name: candidate_rating candidate_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_rating
    ADD CONSTRAINT candidate_rating_pkey PRIMARY KEY (candidate_id, user_id);


--
-- TOC entry 2918 (class 2606 OID 16532)
-- Name: directed_edge directed_edge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directed_edge
    ADD CONSTRAINT directed_edge_pkey PRIMARY KEY (id);


--
-- TOC entry 2922 (class 2606 OID 16534)
-- Name: directed_hyperedge directed_hyperedge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directed_hyperedge
    ADD CONSTRAINT directed_hyperedge_pkey PRIMARY KEY (id);


--
-- TOC entry 2924 (class 2606 OID 16536)
-- Name: directed_hyperedge_source_set directed_hyperedge_source_set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directed_hyperedge_source_set
    ADD CONSTRAINT directed_hyperedge_source_set_pkey PRIMARY KEY (directed_hyperedge_id, source_set_id);


--
-- TOC entry 2928 (class 2606 OID 16538)
-- Name: directed_hyperedge_target_set directed_hyperedge_target_set_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directed_hyperedge_target_set
    ADD CONSTRAINT directed_hyperedge_target_set_pkey PRIMARY KEY (directed_hyperedge_id, target_set_id);


--
-- TOC entry 2938 (class 2606 OID 16540)
-- Name: issue_comment issue_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issue_comment
    ADD CONSTRAINT issue_comment_pkey PRIMARY KEY (id);


--
-- TOC entry 2940 (class 2606 OID 16542)
-- Name: issue_comment_rating issue_comment_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issue_comment_rating
    ADD CONSTRAINT issue_comment_rating_pkey PRIMARY KEY (issue_comment_id, user_id);


--
-- TOC entry 2932 (class 2606 OID 16544)
-- Name: issue issue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issue
    ADD CONSTRAINT issue_pkey PRIMARY KEY (id);


--
-- TOC entry 2942 (class 2606 OID 16546)
-- Name: issue_rating issue_rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issue_rating
    ADD CONSTRAINT issue_rating_pkey PRIMARY KEY (issue_id, user_id);


--
-- TOC entry 2950 (class 2606 OID 16548)
-- Name: pattern_language pattern_language_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_language
    ADD CONSTRAINT pattern_language_pkey PRIMARY KEY (id);


--
-- TOC entry 2944 (class 2606 OID 16550)
-- Name: pattern pattern_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern
    ADD CONSTRAINT pattern_pkey PRIMARY KEY (id);


--
-- TOC entry 2954 (class 2606 OID 16552)
-- Name: pattern_schema pattern_schema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_schema
    ADD CONSTRAINT pattern_schema_pkey PRIMARY KEY (pattern_language_id);


--
-- TOC entry 2956 (class 2606 OID 16554)
-- Name: pattern_section pattern_section_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_section
    ADD CONSTRAINT pattern_section_pkey PRIMARY KEY (id);


--
-- TOC entry 2958 (class 2606 OID 16556)
-- Name: pattern_section_schema pattern_section_schema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_section_schema
    ADD CONSTRAINT pattern_section_schema_pkey PRIMARY KEY (id);


--
-- TOC entry 2966 (class 2606 OID 16558)
-- Name: pattern_view_directed_edge pattern_view_directed_edge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_view_directed_edge
    ADD CONSTRAINT pattern_view_directed_edge_pkey PRIMARY KEY (directed_edge_id, pattern_view_id);


--
-- TOC entry 2968 (class 2606 OID 16560)
-- Name: pattern_view_pattern pattern_view_pattern_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_view_pattern
    ADD CONSTRAINT pattern_view_pattern_pkey PRIMARY KEY (pattern_id, pattern_view_id);


--
-- TOC entry 2962 (class 2606 OID 16562)
-- Name: pattern_view pattern_view_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_view
    ADD CONSTRAINT pattern_view_pkey PRIMARY KEY (id);


--
-- TOC entry 2970 (class 2606 OID 16564)
-- Name: pattern_view_undirected_edge pattern_view_undirected_edge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_view_undirected_edge
    ADD CONSTRAINT pattern_view_undirected_edge_pkey PRIMARY KEY (pattern_view_id, undirected_edge_id);


--
-- TOC entry 2908 (class 2606 OID 16566)
-- Name: candidate uk_2nnar9yvwxvggs1ymw99br8fq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate
    ADD CONSTRAINT uk_2nnar9yvwxvggs1ymw99br8fq UNIQUE (uri);


--
-- TOC entry 2910 (class 2606 OID 16568)
-- Name: candidate uk_3y29gxrn8rruyc1gmq6jj6uqs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate
    ADD CONSTRAINT uk_3y29gxrn8rruyc1gmq6jj6uqs UNIQUE (uri);


--
-- TOC entry 2982 (class 2606 OID 16570)
-- Name: user_entity uk_4xad1enskw4j1t2866f7sodrx; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_4xad1enskw4j1t2866f7sodrx UNIQUE (email);


--
-- TOC entry 2946 (class 2606 OID 16572)
-- Name: pattern uk_6vocvcw50hujfwn66kt7s5fly; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern
    ADD CONSTRAINT uk_6vocvcw50hujfwn66kt7s5fly UNIQUE (uri);


--
-- TOC entry 2934 (class 2606 OID 16574)
-- Name: issue uk_8063id79236r47vy0x6k3ek9n; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issue
    ADD CONSTRAINT uk_8063id79236r47vy0x6k3ek9n UNIQUE (uri);


--
-- TOC entry 2960 (class 2606 OID 16576)
-- Name: pattern_section_schema_pattern_sections uk_a5dhcqp5e8908x217tkb3ic31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_section_schema_pattern_sections
    ADD CONSTRAINT uk_a5dhcqp5e8908x217tkb3ic31 UNIQUE (pattern_sections_id);


--
-- TOC entry 2926 (class 2606 OID 16578)
-- Name: directed_hyperedge_source_set uk_bevke13de29vkx6hixr9h9vei; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directed_hyperedge_source_set
    ADD CONSTRAINT uk_bevke13de29vkx6hixr9h9vei UNIQUE (source_set_id);


--
-- TOC entry 2936 (class 2606 OID 16580)
-- Name: issue uk_c56ot98f5n1mpxjncwej48s8h; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issue
    ADD CONSTRAINT uk_c56ot98f5n1mpxjncwej48s8h UNIQUE (uri);


--
-- TOC entry 2978 (class 2606 OID 16582)
-- Name: undirected_hyperedge_patterns uk_e61v2oikejer2v1dtcqbbc02l; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.undirected_hyperedge_patterns
    ADD CONSTRAINT uk_e61v2oikejer2v1dtcqbbc02l UNIQUE (patterns_id);


--
-- TOC entry 2964 (class 2606 OID 16584)
-- Name: pattern_view uk_gcd5mwq1kb8jn6jvwg192u3cd; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_view
    ADD CONSTRAINT uk_gcd5mwq1kb8jn6jvwg192u3cd UNIQUE (uri);


--
-- TOC entry 2930 (class 2606 OID 16586)
-- Name: directed_hyperedge_target_set uk_i7fjt85n23bduccj52sy5m7kl; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directed_hyperedge_target_set
    ADD CONSTRAINT uk_i7fjt85n23bduccj52sy5m7kl UNIQUE (target_set_id);


--
-- TOC entry 2984 (class 2606 OID 16588)
-- Name: user_entity uk_l6ltic8jtbw6kty72cqdqxs00; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_l6ltic8jtbw6kty72cqdqxs00 UNIQUE (email);


--
-- TOC entry 2948 (class 2606 OID 16590)
-- Name: pattern uk_plmwg77e7f62fbvydxohxn4v9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern
    ADD CONSTRAINT uk_plmwg77e7f62fbvydxohxn4v9 UNIQUE (uri);


--
-- TOC entry 2952 (class 2606 OID 16592)
-- Name: pattern_language uk_qd35crdvw857tcrg5topnhslc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_language
    ADD CONSTRAINT uk_qd35crdvw857tcrg5topnhslc UNIQUE (uri);


--
-- TOC entry 2974 (class 2606 OID 16594)
-- Name: undirected_edge undirected_edge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.undirected_edge
    ADD CONSTRAINT undirected_edge_pkey PRIMARY KEY (id);


--
-- TOC entry 2980 (class 2606 OID 16596)
-- Name: undirected_hyperedge_patterns undirected_hyperedge_patterns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.undirected_hyperedge_patterns
    ADD CONSTRAINT undirected_hyperedge_patterns_pkey PRIMARY KEY (undirected_hyperedge_id, patterns_id);


--
-- TOC entry 2976 (class 2606 OID 16598)
-- Name: undirected_hyperedge undirected_hyperedge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.undirected_hyperedge
    ADD CONSTRAINT undirected_hyperedge_pkey PRIMARY KEY (id);


--
-- TOC entry 2986 (class 2606 OID 16600)
-- Name: user_entity user_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT user_entity_pkey PRIMARY KEY (id);


--
-- TOC entry 2971 (class 1259 OID 16601)
-- Name: p1patternidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX p1patternidx ON public.undirected_edge USING btree (p1_id);


--
-- TOC entry 2972 (class 1259 OID 16602)
-- Name: p2patternidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX p2patternidx ON public.undirected_edge USING btree (p2_id);


--
-- TOC entry 2919 (class 1259 OID 16603)
-- Name: sourcepatternidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sourcepatternidx ON public.directed_edge USING btree (source_id);


--
-- TOC entry 2920 (class 1259 OID 16604)
-- Name: targetpatternidx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX targetpatternidx ON public.directed_edge USING btree (target_id);


--
-- TOC entry 3013 (class 2606 OID 16605)
-- Name: pattern_view_directed_edge fk3b7r2oi11ur1t7ugi1477imrp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_view_directed_edge
    ADD CONSTRAINT fk3b7r2oi11ur1t7ugi1477imrp FOREIGN KEY (directed_edge_id) REFERENCES public.directed_edge(id);


--
-- TOC entry 3009 (class 2606 OID 16610)
-- Name: pattern_section fk3cvo9f0idatua01yg1n112wkq; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_section
    ADD CONSTRAINT fk3cvo9f0idatua01yg1n112wkq FOREIGN KEY (pattern_section_schema_id) REFERENCES public.pattern_section_schema(id);


--
-- TOC entry 3003 (class 2606 OID 16615)
-- Name: issue_comment_rating fk3o0axm0t08m1p1fb94ucksys1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issue_comment_rating
    ADD CONSTRAINT fk3o0axm0t08m1p1fb94ucksys1 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3001 (class 2606 OID 16620)
-- Name: issue_comment fk3qe8erpdobc1yb6dk26nbhojp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issue_comment
    ADD CONSTRAINT fk3qe8erpdobc1yb6dk26nbhojp FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3005 (class 2606 OID 16625)
-- Name: issue_rating fk3qnwbh69l8ihd5ms33nvo0n83; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issue_rating
    ADD CONSTRAINT fk3qnwbh69l8ihd5ms33nvo0n83 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3007 (class 2606 OID 16630)
-- Name: pattern fk77ttqbiemowpyaxy1cc5k9is5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern
    ADD CONSTRAINT fk77ttqbiemowpyaxy1cc5k9is5 FOREIGN KEY (pattern_language_id) REFERENCES public.pattern_language(id);


--
-- TOC entry 3015 (class 2606 OID 16635)
-- Name: pattern_view_pattern fk7gjr0y7vsqmnnsgohqgb5l7ac; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_view_pattern
    ADD CONSTRAINT fk7gjr0y7vsqmnnsgohqgb5l7ac FOREIGN KEY (pattern_view_id) REFERENCES public.pattern_view(id);


--
-- TOC entry 2997 (class 2606 OID 16640)
-- Name: directed_hyperedge_source_set fk8guwfrj62or1u8rwdwtf7y5yn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directed_hyperedge_source_set
    ADD CONSTRAINT fk8guwfrj62or1u8rwdwtf7y5yn FOREIGN KEY (source_set_id) REFERENCES public.pattern(id);


--
-- TOC entry 2987 (class 2606 OID 16645)
-- Name: candidate fk8s7x8de0d0upup60hkuggb86q; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate
    ADD CONSTRAINT fk8s7x8de0d0upup60hkuggb86q FOREIGN KEY (pattern_language_id) REFERENCES public.pattern_language(id);


--
-- TOC entry 3019 (class 2606 OID 16650)
-- Name: undirected_edge fk8sqyicdi1e8n3neu2kueocol3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.undirected_edge
    ADD CONSTRAINT fk8sqyicdi1e8n3neu2kueocol3 FOREIGN KEY (p1_id) REFERENCES public.pattern(id);


--
-- TOC entry 3002 (class 2606 OID 16655)
-- Name: issue_comment fk8wy5rxggrte2ntcq80g7o7210; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issue_comment
    ADD CONSTRAINT fk8wy5rxggrte2ntcq80g7o7210 FOREIGN KEY (issue_id) REFERENCES public.issue(id);


--
-- TOC entry 3017 (class 2606 OID 16660)
-- Name: pattern_view_undirected_edge fkd1qjwyn88gn4jtpygu1kna7ht; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_view_undirected_edge
    ADD CONSTRAINT fkd1qjwyn88gn4jtpygu1kna7ht FOREIGN KEY (pattern_view_id) REFERENCES public.pattern_view(id);


--
-- TOC entry 3004 (class 2606 OID 16665)
-- Name: issue_comment_rating fkdpod2iog9jj6y5mitrw318sqj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issue_comment_rating
    ADD CONSTRAINT fkdpod2iog9jj6y5mitrw318sqj FOREIGN KEY (issue_comment_id) REFERENCES public.issue_comment(id);


--
-- TOC entry 2994 (class 2606 OID 16670)
-- Name: directed_edge fkdvt319vj8sqqs5q8cxa2mqam2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directed_edge
    ADD CONSTRAINT fkdvt319vj8sqqs5q8cxa2mqam2 FOREIGN KEY (source_id) REFERENCES public.pattern(id);


--
-- TOC entry 3016 (class 2606 OID 16675)
-- Name: pattern_view_pattern fke118qe89rm1swbs0f6ffs3wo8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_view_pattern
    ADD CONSTRAINT fke118qe89rm1swbs0f6ffs3wo8 FOREIGN KEY (pattern_id) REFERENCES public.pattern(id);


--
-- TOC entry 3011 (class 2606 OID 16680)
-- Name: pattern_section_schema_pattern_sections fkegwj4doqcp1wipgwb2l3komdn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_section_schema_pattern_sections
    ADD CONSTRAINT fkegwj4doqcp1wipgwb2l3komdn FOREIGN KEY (pattern_sections_id) REFERENCES public.pattern_section(id);


--
-- TOC entry 2995 (class 2606 OID 16685)
-- Name: directed_edge fken29l6v8wmkqxaiaks7pe8rwu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directed_edge
    ADD CONSTRAINT fken29l6v8wmkqxaiaks7pe8rwu FOREIGN KEY (pattern_language_id) REFERENCES public.pattern_language(id);


--
-- TOC entry 3012 (class 2606 OID 16690)
-- Name: pattern_section_schema_pattern_sections fkfafffrkwjwkpm4rus99ao5gvm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_section_schema_pattern_sections
    ADD CONSTRAINT fkfafffrkwjwkpm4rus99ao5gvm FOREIGN KEY (pattern_section_schema_id) REFERENCES public.pattern_section_schema(id);


--
-- TOC entry 3008 (class 2606 OID 16695)
-- Name: pattern_schema fkfuru8632bnda9yj6he9aqffme; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_schema
    ADD CONSTRAINT fkfuru8632bnda9yj6he9aqffme FOREIGN KEY (pattern_language_id) REFERENCES public.pattern_language(id);


--
-- TOC entry 2990 (class 2606 OID 16700)
-- Name: candidate_comment_rating fkg7qo3nvneqg1ivvlt50123ss2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_comment_rating
    ADD CONSTRAINT fkg7qo3nvneqg1ivvlt50123ss2 FOREIGN KEY (candidate_comment_id) REFERENCES public.candidate_comment(id);


--
-- TOC entry 2991 (class 2606 OID 16705)
-- Name: candidate_comment_rating fkg8j63smj6n8rh6kr8tp3nfdix; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_comment_rating
    ADD CONSTRAINT fkg8j63smj6n8rh6kr8tp3nfdix FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 2988 (class 2606 OID 16710)
-- Name: candidate_comment fkgl0y3i6y5dd9c8psdu7mp7xqy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_comment
    ADD CONSTRAINT fkgl0y3i6y5dd9c8psdu7mp7xqy FOREIGN KEY (candidate_id) REFERENCES public.candidate(id);


--
-- TOC entry 2999 (class 2606 OID 16715)
-- Name: directed_hyperedge_target_set fkhl9yorn5wev3m5ooqrlq3ufxg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directed_hyperedge_target_set
    ADD CONSTRAINT fkhl9yorn5wev3m5ooqrlq3ufxg FOREIGN KEY (target_set_id) REFERENCES public.pattern(id);


--
-- TOC entry 3018 (class 2606 OID 16720)
-- Name: pattern_view_undirected_edge fki4vnsjoalbiwx4yr4thn4ya87; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_view_undirected_edge
    ADD CONSTRAINT fki4vnsjoalbiwx4yr4thn4ya87 FOREIGN KEY (undirected_edge_id) REFERENCES public.undirected_edge(id);


--
-- TOC entry 3000 (class 2606 OID 16725)
-- Name: directed_hyperedge_target_set fkjoimrxph588139toilxf57uy2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directed_hyperedge_target_set
    ADD CONSTRAINT fkjoimrxph588139toilxf57uy2 FOREIGN KEY (directed_hyperedge_id) REFERENCES public.directed_hyperedge(id);


--
-- TOC entry 3020 (class 2606 OID 16730)
-- Name: undirected_edge fkjos3a1eebvu6hbrbls6wpoygt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.undirected_edge
    ADD CONSTRAINT fkjos3a1eebvu6hbrbls6wpoygt FOREIGN KEY (p2_id) REFERENCES public.pattern(id);


--
-- TOC entry 3024 (class 2606 OID 16735)
-- Name: user_entity_roles fkjvvinok3stf32dvgie3vr73s0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity_roles
    ADD CONSTRAINT fkjvvinok3stf32dvgie3vr73s0 FOREIGN KEY (user_entity_id) REFERENCES public.user_entity(id);


--
-- TOC entry 2989 (class 2606 OID 16740)
-- Name: candidate_comment fkjwq8pmpyru6a87cukgmvo0q93; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_comment
    ADD CONSTRAINT fkjwq8pmpyru6a87cukgmvo0q93 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3006 (class 2606 OID 16745)
-- Name: issue_rating fkky82wgp632e04u03hksxeg1ww; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issue_rating
    ADD CONSTRAINT fkky82wgp632e04u03hksxeg1ww FOREIGN KEY (issue_id) REFERENCES public.issue(id);


--
-- TOC entry 3014 (class 2606 OID 16750)
-- Name: pattern_view_directed_edge fkl97vn4so04u3ab22i5nv72q6e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_view_directed_edge
    ADD CONSTRAINT fkl97vn4so04u3ab22i5nv72q6e FOREIGN KEY (pattern_view_id) REFERENCES public.pattern_view(id);


--
-- TOC entry 2992 (class 2606 OID 16755)
-- Name: candidate_rating fkp3b3ukrra2u0sysqcwlv4klkn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_rating
    ADD CONSTRAINT fkp3b3ukrra2u0sysqcwlv4klkn FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 2996 (class 2606 OID 16760)
-- Name: directed_edge fkq14jnn8mw3w8t1qo9lgtcpk9e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directed_edge
    ADD CONSTRAINT fkq14jnn8mw3w8t1qo9lgtcpk9e FOREIGN KEY (target_id) REFERENCES public.pattern(id);


--
-- TOC entry 2993 (class 2606 OID 16765)
-- Name: candidate_rating fkqbpga562vdylosfny7pjviddq; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidate_rating
    ADD CONSTRAINT fkqbpga562vdylosfny7pjviddq FOREIGN KEY (candidate_id) REFERENCES public.candidate(id);


--
-- TOC entry 3010 (class 2606 OID 16770)
-- Name: pattern_section_schema fkrie76ldgkhkbs3cug3kkvmkcd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pattern_section_schema
    ADD CONSTRAINT fkrie76ldgkhkbs3cug3kkvmkcd FOREIGN KEY (pattern_schema_pattern_language_id) REFERENCES public.pattern_schema(pattern_language_id);


--
-- TOC entry 3022 (class 2606 OID 16775)
-- Name: undirected_hyperedge_patterns fksv0r49fdkcsiv4gg4qgg5t6w0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.undirected_hyperedge_patterns
    ADD CONSTRAINT fksv0r49fdkcsiv4gg4qgg5t6w0 FOREIGN KEY (undirected_hyperedge_id) REFERENCES public.undirected_hyperedge(id);


--
-- TOC entry 2998 (class 2606 OID 16780)
-- Name: directed_hyperedge_source_set fksyqyvo4dr6pj2mdofd5drosdm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directed_hyperedge_source_set
    ADD CONSTRAINT fksyqyvo4dr6pj2mdofd5drosdm FOREIGN KEY (directed_hyperedge_id) REFERENCES public.directed_hyperedge(id);


--
-- TOC entry 3023 (class 2606 OID 16785)
-- Name: undirected_hyperedge_patterns fkt25wk8gkit4hr7oyee2prm48; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.undirected_hyperedge_patterns
    ADD CONSTRAINT fkt25wk8gkit4hr7oyee2prm48 FOREIGN KEY (patterns_id) REFERENCES public.pattern(id);


--
-- TOC entry 3021 (class 2606 OID 16790)
-- Name: undirected_edge fkt73wgqcqh5u6ro109oq15dh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.undirected_edge
    ADD CONSTRAINT fkt73wgqcqh5u6ro109oq15dh9v FOREIGN KEY (pattern_language_id) REFERENCES public.pattern_language(id);


-- Completed on 2020-08-27 16:36:51

--
-- PostgreSQL database dump complete
--

