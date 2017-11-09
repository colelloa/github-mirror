--
-- PostgreSQL database dump
--

-- Dumped from database version 10.0
-- Dumped by pg_dump version 10.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: commit_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE commit_comments (
    id integer NOT NULL,
    commit_id integer NOT NULL,
    user_id integer NOT NULL,
    body character varying(256),
    line integer,
    "position" integer,
    comment_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE commit_comments OWNER TO postgres;

--
-- Name: commit_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE commit_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE commit_comments_id_seq OWNER TO postgres;

--
-- Name: commit_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE commit_comments_id_seq OWNED BY commit_comments.id;


--
-- Name: commit_parents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE commit_parents (
    commit_id integer NOT NULL,
    parent_id integer NOT NULL
);


ALTER TABLE commit_parents OWNER TO postgres;

--
-- Name: commits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE commits (
    id integer NOT NULL,
    sha character varying(40),
    author_id integer,
    committer_id integer,
    project_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE commits OWNER TO postgres;

--
-- Name: commits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE commits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE commits_id_seq OWNER TO postgres;

--
-- Name: commits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE commits_id_seq OWNED BY commits.id;


--
-- Name: followers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE followers (
    user_id integer NOT NULL,
    follower_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE followers OWNER TO postgres;

--
-- Name: issue_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE issue_comments (
    issue_id integer NOT NULL,
    user_id integer NOT NULL,
    comment_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE issue_comments OWNER TO postgres;

--
-- Name: issue_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE issue_events (
    event_id integer NOT NULL,
    issue_id integer NOT NULL,
    actor_id integer NOT NULL,
    action text NOT NULL,
    action_specific character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE issue_events OWNER TO postgres;

--
-- Name: issue_labels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE issue_labels (
    label_id integer NOT NULL,
    issue_id integer NOT NULL
);


ALTER TABLE issue_labels OWNER TO postgres;

--
-- Name: issues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE issues (
    id integer NOT NULL,
    repo_id integer,
    reporter_id integer,
    assignee_id integer,
    issue_id integer NOT NULL,
    pull_request boolean NOT NULL,
    pull_request_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE issues OWNER TO postgres;

--
-- Name: issues_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE issues_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE issues_id_seq OWNER TO postgres;

--
-- Name: issues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE issues_id_seq OWNED BY issues.id;


--
-- Name: organization_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organization_members (
    org_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE organization_members OWNER TO postgres;

--
-- Name: project_commits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_commits (
    project_id integer NOT NULL,
    commit_id integer NOT NULL
);


ALTER TABLE project_commits OWNER TO postgres;

--
-- Name: project_languages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_languages (
    project_id integer NOT NULL,
    language text NOT NULL,
    bytes integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE project_languages OWNER TO postgres;

--
-- Name: project_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_members (
    repo_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ext_ref_id character varying(24) DEFAULT '0'::character varying NOT NULL
);


ALTER TABLE project_members OWNER TO postgres;

--
-- Name: project_topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project_topics (
    project_id integer NOT NULL,
    topic_name character varying(36) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE project_topics OWNER TO postgres;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projects (
    id integer NOT NULL,
    url text,
    owner_id integer,
    name text NOT NULL,
    description text,
    language text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    forked_from integer,
    deleted boolean DEFAULT false NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    forked_commit_id integer
);


ALTER TABLE projects OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projects_id_seq OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: pull_request_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pull_request_comments (
    pull_request_id integer NOT NULL,
    user_id integer NOT NULL,
    comment_id integer NOT NULL,
    "position" integer,
    body character varying(256),
    commit_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE pull_request_comments OWNER TO postgres;

--
-- Name: pull_request_commits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pull_request_commits (
    pull_request_id integer NOT NULL,
    commit_id integer NOT NULL
);


ALTER TABLE pull_request_commits OWNER TO postgres;

--
-- Name: pull_request_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pull_request_history (
    id integer NOT NULL,
    pull_request_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    action text NOT NULL,
    actor_id integer,
    CONSTRAINT pull_request_history_action_check CHECK ((action = ANY (ARRAY['opened'::text, 'closed'::text, 'merged'::text, 'synchronize'::text, 'reopened'::text])))
);


ALTER TABLE pull_request_history OWNER TO postgres;

--
-- Name: pull_request_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pull_request_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pull_request_history_id_seq OWNER TO postgres;

--
-- Name: pull_request_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pull_request_history_id_seq OWNED BY pull_request_history.id;


--
-- Name: pull_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pull_requests (
    id integer NOT NULL,
    head_repo_id integer,
    base_repo_id integer NOT NULL,
    head_commit_id integer,
    base_commit_id integer NOT NULL,
    pullreq_id integer NOT NULL,
    intra_branch boolean NOT NULL
);


ALTER TABLE pull_requests OWNER TO postgres;

--
-- Name: pull_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pull_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pull_requests_id_seq OWNER TO postgres;

--
-- Name: pull_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pull_requests_id_seq OWNED BY pull_requests.id;


--
-- Name: repo_labels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE repo_labels (
    id integer NOT NULL,
    repo_id integer,
    name character varying(24) NOT NULL
);


ALTER TABLE repo_labels OWNER TO postgres;

--
-- Name: repo_labels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE repo_labels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE repo_labels_id_seq OWNER TO postgres;

--
-- Name: repo_labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE repo_labels_id_seq OWNED BY repo_labels.id;


--
-- Name: repo_milestones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE repo_milestones (
    id integer NOT NULL,
    repo_id integer,
    name character varying(24) NOT NULL
);


ALTER TABLE repo_milestones OWNER TO postgres;

--
-- Name: repo_milestones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE repo_milestones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE repo_milestones_id_seq OWNER TO postgres;

--
-- Name: repo_milestones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE repo_milestones_id_seq OWNED BY repo_milestones.id;


--
-- Name: schema_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schema_info (
    version integer DEFAULT 0 NOT NULL
);


ALTER TABLE schema_info OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id integer NOT NULL,
    login text NOT NULL,
    name text,
    company text,
    email text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type text DEFAULT 'USR'::text NOT NULL,
    fake boolean DEFAULT false NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    long numeric(11,8),
    lat numeric(10,8),
    country_code character(3),
    state text,
    city text,
    location text,
    CONSTRAINT type_allowed_values CHECK ((type = ANY (ARRAY['USR'::text, 'ORG'::text])))
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: watchers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE watchers (
    repo_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE watchers OWNER TO postgres;

--
-- Name: commit_comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commit_comments ALTER COLUMN id SET DEFAULT nextval('commit_comments_id_seq'::regclass);


--
-- Name: commits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commits ALTER COLUMN id SET DEFAULT nextval('commits_id_seq'::regclass);


--
-- Name: issues id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issues ALTER COLUMN id SET DEFAULT nextval('issues_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: pull_request_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_history ALTER COLUMN id SET DEFAULT nextval('pull_request_history_id_seq'::regclass);


--
-- Name: pull_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_requests ALTER COLUMN id SET DEFAULT nextval('pull_requests_id_seq'::regclass);


--
-- Name: repo_labels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repo_labels ALTER COLUMN id SET DEFAULT nextval('repo_labels_id_seq'::regclass);


--
-- Name: repo_milestones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repo_milestones ALTER COLUMN id SET DEFAULT nextval('repo_milestones_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: commit_comments commit_comments_comment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commit_comments
    ADD CONSTRAINT commit_comments_comment_id_key UNIQUE (comment_id);


--
-- Name: commit_comments commit_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commit_comments
    ADD CONSTRAINT commit_comments_pkey PRIMARY KEY (id);


--
-- Name: commit_parents commit_parents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commit_parents
    ADD CONSTRAINT commit_parents_pkey PRIMARY KEY (commit_id, parent_id);


--
-- Name: commits commits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commits
    ADD CONSTRAINT commits_pkey PRIMARY KEY (id);


--
-- Name: commits commits_sha_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commits
    ADD CONSTRAINT commits_sha_key UNIQUE (sha);


--
-- Name: followers followers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY followers
    ADD CONSTRAINT followers_pkey PRIMARY KEY (user_id, follower_id);


--
-- Name: issue_events issue_events_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issue_events
    ADD CONSTRAINT issue_events_pk PRIMARY KEY (event_id, issue_id);


--
-- Name: issue_labels issue_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issue_labels
    ADD CONSTRAINT issue_labels_pkey PRIMARY KEY (issue_id, label_id);


--
-- Name: issues issues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (id);


--
-- Name: organization_members organization_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_members
    ADD CONSTRAINT organization_members_pkey PRIMARY KEY (org_id, user_id);


--
-- Name: project_commits project_commits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_commits
    ADD CONSTRAINT project_commits_pkey PRIMARY KEY (project_id, commit_id);


--
-- Name: project_members project_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_members
    ADD CONSTRAINT project_members_pkey PRIMARY KEY (repo_id, user_id);


--
-- Name: project_topics project_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_topics
    ADD CONSTRAINT project_topics_pkey PRIMARY KEY (project_id, topic_name);


--
-- Name: projects projects_name_owner_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_name_owner_id_key UNIQUE (name, owner_id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: pull_request_commits pull_request_commits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_commits
    ADD CONSTRAINT pull_request_commits_pkey PRIMARY KEY (pull_request_id, commit_id);


--
-- Name: pull_request_history pull_request_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_history
    ADD CONSTRAINT pull_request_history_pkey PRIMARY KEY (id);


--
-- Name: pull_requests pull_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_requests
    ADD CONSTRAINT pull_requests_pkey PRIMARY KEY (id);


--
-- Name: pull_requests pull_requests_pullreq_id_base_repo_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_requests
    ADD CONSTRAINT pull_requests_pullreq_id_base_repo_id_key UNIQUE (pullreq_id, base_repo_id);


--
-- Name: repo_labels repo_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repo_labels
    ADD CONSTRAINT repo_labels_pkey PRIMARY KEY (id);


--
-- Name: repo_milestones repo_milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repo_milestones
    ADD CONSTRAINT repo_milestones_pkey PRIMARY KEY (id);


--
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: watchers watchers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY watchers
    ADD CONSTRAINT watchers_pkey PRIMARY KEY (repo_id, user_id);


--
-- Name: commit_comments commit_comments_commit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commit_comments
    ADD CONSTRAINT commit_comments_commit_id_fkey FOREIGN KEY (commit_id) REFERENCES commits(id);


--
-- Name: commit_comments commit_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commit_comments
    ADD CONSTRAINT commit_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: commit_parents commit_parents_commit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commit_parents
    ADD CONSTRAINT commit_parents_commit_id_fkey FOREIGN KEY (commit_id) REFERENCES commits(id);


--
-- Name: commit_parents commit_parents_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commit_parents
    ADD CONSTRAINT commit_parents_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES commits(id);


--
-- Name: commits commits_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commits
    ADD CONSTRAINT commits_author_id_fkey FOREIGN KEY (author_id) REFERENCES users(id);


--
-- Name: commits commits_committer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commits
    ADD CONSTRAINT commits_committer_id_fkey FOREIGN KEY (committer_id) REFERENCES users(id);


--
-- Name: commits commits_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY commits
    ADD CONSTRAINT commits_project_id_fkey FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: followers followers_follower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY followers
    ADD CONSTRAINT followers_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES users(id);


--
-- Name: followers followers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY followers
    ADD CONSTRAINT followers_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: issue_comments issue_comments_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issue_comments
    ADD CONSTRAINT issue_comments_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES issues(id);


--
-- Name: issue_comments issue_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issue_comments
    ADD CONSTRAINT issue_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: issue_events issue_events_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issue_events
    ADD CONSTRAINT issue_events_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES users(id);


--
-- Name: issue_events issue_events_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issue_events
    ADD CONSTRAINT issue_events_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES issues(id);


--
-- Name: issue_labels issue_labels_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issue_labels
    ADD CONSTRAINT issue_labels_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES issues(id);


--
-- Name: issue_labels issue_labels_label_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issue_labels
    ADD CONSTRAINT issue_labels_label_id_fkey FOREIGN KEY (label_id) REFERENCES repo_labels(id);


--
-- Name: issues issues_assignee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issues
    ADD CONSTRAINT issues_assignee_id_fkey FOREIGN KEY (assignee_id) REFERENCES users(id);


--
-- Name: issues issues_pull_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issues
    ADD CONSTRAINT issues_pull_request_id_fkey FOREIGN KEY (pull_request_id) REFERENCES pull_requests(id);


--
-- Name: issues issues_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issues
    ADD CONSTRAINT issues_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES projects(id);


--
-- Name: issues issues_reporter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY issues
    ADD CONSTRAINT issues_reporter_id_fkey FOREIGN KEY (reporter_id) REFERENCES users(id);


--
-- Name: organization_members organization_members_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_members
    ADD CONSTRAINT organization_members_org_id_fkey FOREIGN KEY (org_id) REFERENCES users(id);


--
-- Name: organization_members organization_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organization_members
    ADD CONSTRAINT organization_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: project_commits project_commits_commit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_commits
    ADD CONSTRAINT project_commits_commit_id_fkey FOREIGN KEY (commit_id) REFERENCES commits(id);


--
-- Name: project_commits project_commits_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_commits
    ADD CONSTRAINT project_commits_project_id_fkey FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: project_languages project_languages_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_languages
    ADD CONSTRAINT project_languages_project_id_fkey FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: project_members project_members_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_members
    ADD CONSTRAINT project_members_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES projects(id);


--
-- Name: project_members project_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_members
    ADD CONSTRAINT project_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: project_topics project_topics_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project_topics
    ADD CONSTRAINT project_topics_project_id_fkey FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: projects projects_forked_commit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_forked_commit_id_fkey FOREIGN KEY (forked_commit_id) REFERENCES commits(id);


--
-- Name: projects projects_forked_from_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_forked_from_fkey FOREIGN KEY (forked_from) REFERENCES projects(id);


--
-- Name: projects projects_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- Name: pull_request_comments pull_request_comments_commit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_comments
    ADD CONSTRAINT pull_request_comments_commit_id_fkey FOREIGN KEY (commit_id) REFERENCES commits(id);


--
-- Name: pull_request_comments pull_request_comments_pull_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_comments
    ADD CONSTRAINT pull_request_comments_pull_request_id_fkey FOREIGN KEY (pull_request_id) REFERENCES pull_requests(id);


--
-- Name: pull_request_comments pull_request_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_comments
    ADD CONSTRAINT pull_request_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: pull_request_commits pull_request_commits_commit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_commits
    ADD CONSTRAINT pull_request_commits_commit_id_fkey FOREIGN KEY (commit_id) REFERENCES commits(id);


--
-- Name: pull_request_commits pull_request_commits_pull_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_commits
    ADD CONSTRAINT pull_request_commits_pull_request_id_fkey FOREIGN KEY (pull_request_id) REFERENCES pull_requests(id);


--
-- Name: pull_request_history pull_request_history_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_history
    ADD CONSTRAINT pull_request_history_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES users(id);


--
-- Name: pull_request_history pull_request_history_pull_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_request_history
    ADD CONSTRAINT pull_request_history_pull_request_id_fkey FOREIGN KEY (pull_request_id) REFERENCES pull_requests(id);


--
-- Name: pull_requests pull_requests_base_commit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_requests
    ADD CONSTRAINT pull_requests_base_commit_id_fkey FOREIGN KEY (base_commit_id) REFERENCES commits(id);


--
-- Name: pull_requests pull_requests_base_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_requests
    ADD CONSTRAINT pull_requests_base_repo_id_fkey FOREIGN KEY (base_repo_id) REFERENCES projects(id);


--
-- Name: pull_requests pull_requests_head_commit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_requests
    ADD CONSTRAINT pull_requests_head_commit_id_fkey FOREIGN KEY (head_commit_id) REFERENCES commits(id);


--
-- Name: pull_requests pull_requests_head_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pull_requests
    ADD CONSTRAINT pull_requests_head_repo_id_fkey FOREIGN KEY (head_repo_id) REFERENCES projects(id);


--
-- Name: repo_labels repo_labels_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repo_labels
    ADD CONSTRAINT repo_labels_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES projects(id);


--
-- Name: repo_milestones repo_milestones_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY repo_milestones
    ADD CONSTRAINT repo_milestones_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES projects(id);


--
-- Name: watchers watchers_repo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY watchers
    ADD CONSTRAINT watchers_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES projects(id);


--
-- Name: watchers watchers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY watchers
    ADD CONSTRAINT watchers_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--
