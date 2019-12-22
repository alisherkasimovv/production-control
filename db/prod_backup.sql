PGDMP         7                w            production_control_db     11.6 (Ubuntu 11.6-1.pgdg19.10+1)     12.1 (Ubuntu 12.1-1.pgdg19.10+1) '    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16384    production_control_db    DATABASE     �   CREATE DATABASE production_control_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
 %   DROP DATABASE production_control_db;
                postgres    false            �            1259    17220    db_employees    TABLE     %  CREATE TABLE public.db_employees (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    experience double precision,
    first_name character varying(255) NOT NULL,
    group_id integer,
    second_name character varying(255)
);
     DROP TABLE public.db_employees;
       public            postgres    false            �            1259    17218    db_employees_id_seq    SEQUENCE     �   CREATE SEQUENCE public.db_employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.db_employees_id_seq;
       public          postgres    false    197            �           0    0    db_employees_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.db_employees_id_seq OWNED BY public.db_employees.id;
          public          postgres    false    196            �            1259    17231 	   db_groups    TABLE     �   CREATE TABLE public.db_groups (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    description character varying(255),
    name character varying(255) NOT NULL
);
    DROP TABLE public.db_groups;
       public            postgres    false            �            1259    17229    db_groups_id_seq    SEQUENCE     �   CREATE SEQUENCE public.db_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.db_groups_id_seq;
       public          postgres    false    199            �           0    0    db_groups_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.db_groups_id_seq OWNED BY public.db_groups.id;
          public          postgres    false    198            �            1259    17242    db_performers    TABLE       CREATE TABLE public.db_performers (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    employee_id integer,
    production_id integer,
    salary double precision,
    worked_hours double precision
);
 !   DROP TABLE public.db_performers;
       public            postgres    false            �            1259    17240    db_performers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.db_performers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.db_performers_id_seq;
       public          postgres    false    201            �           0    0    db_performers_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.db_performers_id_seq OWNED BY public.db_performers.id;
          public          postgres    false    200            �            1259    17250    db_production    TABLE     :  CREATE TABLE public.db_production (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    amount double precision,
    cost double precision,
    date timestamp without time zone,
    product_id integer,
    reference_number character varying(255)
);
 !   DROP TABLE public.db_production;
       public            postgres    false            �            1259    17248    db_production_id_seq    SEQUENCE     �   CREATE SEQUENCE public.db_production_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.db_production_id_seq;
       public          postgres    false    203            �           0    0    db_production_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.db_production_id_seq OWNED BY public.db_production.id;
          public          postgres    false    202            �            1259    17258    db_products    TABLE     2  CREATE TABLE public.db_products (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    product_desc character varying(255),
    measurement character varying(255),
    product_name character varying(255),
    product_rate double precision
);
    DROP TABLE public.db_products;
       public            postgres    false            �            1259    17256    db_products_id_seq    SEQUENCE     �   CREATE SEQUENCE public.db_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.db_products_id_seq;
       public          postgres    false    205            �           0    0    db_products_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.db_products_id_seq OWNED BY public.db_products.id;
          public          postgres    false    204                       2604    17223    db_employees id    DEFAULT     r   ALTER TABLE ONLY public.db_employees ALTER COLUMN id SET DEFAULT nextval('public.db_employees_id_seq'::regclass);
 >   ALTER TABLE public.db_employees ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    197    196    197                       2604    17234    db_groups id    DEFAULT     l   ALTER TABLE ONLY public.db_groups ALTER COLUMN id SET DEFAULT nextval('public.db_groups_id_seq'::regclass);
 ;   ALTER TABLE public.db_groups ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    199    198    199                       2604    17245    db_performers id    DEFAULT     t   ALTER TABLE ONLY public.db_performers ALTER COLUMN id SET DEFAULT nextval('public.db_performers_id_seq'::regclass);
 ?   ALTER TABLE public.db_performers ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    200    201    201                       2604    17253    db_production id    DEFAULT     t   ALTER TABLE ONLY public.db_production ALTER COLUMN id SET DEFAULT nextval('public.db_production_id_seq'::regclass);
 ?   ALTER TABLE public.db_production ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    202    203    203                       2604    17261    db_products id    DEFAULT     p   ALTER TABLE ONLY public.db_products ALTER COLUMN id SET DEFAULT nextval('public.db_products_id_seq'::regclass);
 =   ALTER TABLE public.db_products ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205            �          0    17220    db_employees 
   TABLE DATA           q   COPY public.db_employees (id, created_at, updated_at, experience, first_name, group_id, second_name) FROM stdin;
    public          postgres    false    197   m-       �          0    17231 	   db_groups 
   TABLE DATA           R   COPY public.db_groups (id, created_at, updated_at, description, name) FROM stdin;
    public          postgres    false    199   �.       �          0    17242    db_performers 
   TABLE DATA           u   COPY public.db_performers (id, created_at, updated_at, employee_id, production_id, salary, worked_hours) FROM stdin;
    public          postgres    false    201   /       �          0    17250    db_production 
   TABLE DATA           u   COPY public.db_production (id, created_at, updated_at, amount, cost, date, product_id, reference_number) FROM stdin;
    public          postgres    false    203   z0       �          0    17258    db_products 
   TABLE DATA           x   COPY public.db_products (id, created_at, updated_at, product_desc, measurement, product_name, product_rate) FROM stdin;
    public          postgres    false    205   �1       �           0    0    db_employees_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.db_employees_id_seq', 1, false);
          public          postgres    false    196            �           0    0    db_groups_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.db_groups_id_seq', 1, false);
          public          postgres    false    198            �           0    0    db_performers_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.db_performers_id_seq', 29, true);
          public          postgres    false    200            �           0    0    db_production_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.db_production_id_seq', 11, true);
          public          postgres    false    202            �           0    0    db_products_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.db_products_id_seq', 1, false);
          public          postgres    false    204                       2606    17228    db_employees db_employees_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.db_employees
    ADD CONSTRAINT db_employees_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.db_employees DROP CONSTRAINT db_employees_pkey;
       public            postgres    false    197                       2606    17239    db_groups db_groups_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.db_groups
    ADD CONSTRAINT db_groups_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.db_groups DROP CONSTRAINT db_groups_pkey;
       public            postgres    false    199                        2606    17247     db_performers db_performers_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.db_performers
    ADD CONSTRAINT db_performers_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.db_performers DROP CONSTRAINT db_performers_pkey;
       public            postgres    false    201            "           2606    17255     db_production db_production_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.db_production
    ADD CONSTRAINT db_production_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.db_production DROP CONSTRAINT db_production_pkey;
       public            postgres    false    203            $           2606    17266    db_products db_products_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.db_products
    ADD CONSTRAINT db_products_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.db_products DROP CONSTRAINT db_products_pkey;
       public            postgres    false    205            �   {  x���=o�0���W��.(���HU����@+���RW�ĉ��Rȯ�)�:������wg�`��|(XqV�ED�7�N~U�UM)�� q��ja�c�����ʉ�_��j�����FΜ��:+��:�Z#ύ���v��%��Qʌ�ේQ�!�(�jDˤ��^���G.�g�.���Ղ�|g�U�>�PG�ډ8X>s|:�]Il`�v���?�ơs��8u��#Z��$z�"�TWv���7]=1$^p���cxhY��r]��g8�&Y�ٻ�}|��>ĩw���M�9"��l���)���>�&�BB9<
�(��ff�	�[.j�2<
=�RIw		�V�#�>*t�x�j{�Ȩ�:��5r;����#|      �      x������ � �      �   U  x���ѭ�0�o2E�e��!���GҦE�*�G��*�;��iV�lE������
����$u9l��!�O��ۖI�֝�+�ƻ��к����g�I�H�-�J���N-Ӧ��Ƥڋ�/�bTN-(�+��-�a��ꛥO�SF������|E�9�1YlW��}�|�>E
Ɉ��a�����a��*;[��J�:ӉRD�]>*��ى:m#(��N�_ۧ���٨X��
<���X�&ASa;�8���`)�e����m��q���mg��u���w�B��P��yÌQ.���:�替&���39Uv�>1�a=�^��,�?G�}      �   �   x���ۍ1�oSE���"���_�B�d5M��3Gp1FZw�;��xcl����3�pPb�wҍ��hMN4ꖀO�f��oFZ�cq7���q#�ț}����CՋ�&��ИфU]�%aM8ؙ�m=�=���W/�J������6�l�
w��fQs�8#�U mD���Tq�dq�OHy�?�Y�]��AՎ�:3��c��_�Y��c��'SK��-ɍ4�����ꀴ�����_'T/��&���1�-m�      �   �   x�m̱
�0F���)�^��$� ]
���!�DZ����:Z���I4�
RA_���`�(t�i!��JN�4l����i,�`s�m��7;~�����������&���N1��b`������&��;VJ} �i1%     