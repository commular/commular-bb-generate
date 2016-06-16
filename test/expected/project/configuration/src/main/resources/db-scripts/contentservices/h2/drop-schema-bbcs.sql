
    alter table OBJECT_DATA 
        drop constraint FK_354y502ct1ju7tg6v1rlfpwgo;

    alter table OBJECT_DATA 
        drop constraint FK_mhp750onsg14deqsc5mkp4dx;

    alter table OBJECT_DATA 
        drop constraint FK_i6hwfpq7ppvktiim2thpqxiac;

    alter table OBJECT_DATA 
        drop constraint FK_6gu2if5arkmusbvrssixki55r;

    alter table OBJECT_TYPE_DEFINITION 
        drop constraint FK_83a12dvjdi2psds4t3pfrwbfb;

    alter table OBJECT_TYPE_DEFINITION 
        drop constraint FK_luq75uv8ksxyjp0t3v16jkanx;

    alter table PROPERTY_DATA 
        drop constraint FK_r5pfq0qmo565nb85q01q6r5og;

    alter table PROPERTY_DATA 
        drop constraint FK_c2yshju50dy6nutodteogo28t;

    alter table PROPERTY_DEFINITION 
        drop constraint FK_s6scxspskrpjulqsj4u98us2g;

    alter table RELATIONSHIPS 
        drop constraint FK_cwor9qcw8nm14qawhqtatfhbc;

    alter table RENDITION 
        drop constraint FK_aw8vtq9lh7ehwfu0oc30q0hqn;

    alter table RENDITION 
        drop constraint FK_l7rl4ulhh823p0t9oswg761c9;

    drop table CONTENT_STREAM if exists;

    drop table OBJECT_DATA if exists;

    drop table OBJECT_TYPE_DEFINITION if exists;

    drop table PROPERTY_DATA if exists;

    drop table PROPERTY_DEFINITION if exists;

    drop table RELATIONSHIPS if exists;

    drop table RENDITION if exists;

    drop table REPOSITORY_DEFINITION if exists;
