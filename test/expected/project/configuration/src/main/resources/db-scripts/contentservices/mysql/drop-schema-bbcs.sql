
    alter table OBJECT_DATA 
        drop 
        foreign key FK_354y502ct1ju7tg6v1rlfpwgo;

    alter table OBJECT_DATA 
        drop 
        foreign key FK_mhp750onsg14deqsc5mkp4dx;

    alter table OBJECT_DATA 
        drop 
        foreign key FK_i6hwfpq7ppvktiim2thpqxiac;

    alter table OBJECT_DATA 
        drop 
        foreign key FK_6gu2if5arkmusbvrssixki55r;

    alter table OBJECT_TYPE_DEFINITION 
        drop 
        foreign key FK_83a12dvjdi2psds4t3pfrwbfb;

    alter table OBJECT_TYPE_DEFINITION 
        drop 
        foreign key FK_luq75uv8ksxyjp0t3v16jkanx;

    alter table PROPERTY_DATA 
        drop 
        foreign key FK_r5pfq0qmo565nb85q01q6r5og;

    alter table PROPERTY_DATA 
        drop 
        foreign key FK_c2yshju50dy6nutodteogo28t;

    alter table PROPERTY_DEFINITION 
        drop 
        foreign key FK_s6scxspskrpjulqsj4u98us2g;

    alter table RELATIONSHIPS 
        drop 
        foreign key FK_cwor9qcw8nm14qawhqtatfhbc;

    alter table RENDITION 
        drop 
        foreign key FK_aw8vtq9lh7ehwfu0oc30q0hqn;

    alter table RENDITION 
        drop 
        foreign key FK_l7rl4ulhh823p0t9oswg761c9;

    drop table if exists CONTENT_STREAM;

    drop table if exists OBJECT_DATA;

    drop table if exists OBJECT_TYPE_DEFINITION;

    drop table if exists PROPERTY_DATA;

    drop table if exists PROPERTY_DEFINITION;

    drop table if exists RELATIONSHIPS;

    drop table if exists RENDITION;

    drop table if exists REPOSITORY_DEFINITION;
