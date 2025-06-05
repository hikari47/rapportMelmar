/*==============================================================*/
/* Nom de SGBD :  Sybase SQL Anywhere 11                        */
/* Date de création :  29/05/2025 20:59:40                      */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_ABONNEME_ENREGISTR_CLIENT') then
    alter table ABONNEMENT
       delete foreign key FK_ABONNEME_ENREGISTR_CLIENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ABONNEME_INTERVENI_EMPLOYE') then
    alter table ABONNEMENT
       delete foreign key FK_ABONNEME_INTERVENI_EMPLOYE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ABONNEME_LIER3_SECTEUR') then
    alter table ABONNEMENT
       delete foreign key FK_ABONNEME_LIER3_SECTEUR
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ADMIN_HERITAGE__EMPLOYE') then
    alter table ADMIN
       delete foreign key FK_ADMIN_HERITAGE__EMPLOYE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CLIENT_HERITAGE__USER') then
    alter table CLIENT
       delete foreign key FK_CLIENT_HERITAGE__USER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EMPLOYE_HERITAGE__USER') then
    alter table EMPLOYE
       delete foreign key FK_EMPLOYE_HERITAGE__USER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MODEL_PR_HERITAGE__PRODUIT_') then
    alter table MODEL_PRODUIT_SERVICE
       delete foreign key FK_MODEL_PR_HERITAGE__PRODUIT_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PAIEMENT_EFFECTUER_CLIENT') then
    alter table PAIEMENT
       delete foreign key FK_PAIEMENT_EFFECTUER_CLIENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PAIEMENT_INTERVENI_EMPLOYE') then
    alter table PAIEMENT
       delete foreign key FK_PAIEMENT_INTERVENI_EMPLOYE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PAIEMENT_LIER2_PRODUIT_') then
    alter table PAIEMENT
       delete foreign key FK_PAIEMENT_LIER2_PRODUIT_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PLANNING_CONSULTER_EMPLOYE') then
    alter table PLANNING
       delete foreign key FK_PLANNING_CONSULTER_EMPLOYE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PRESENCE_MARQUER_EMPLOYE') then
    alter table PRESENCE
       delete foreign key FK_PRESENCE_MARQUER_EMPLOYE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_RESERVAT_INTERVENI_EMPLOYE') then
    alter table RESERVATION
       delete foreign key FK_RESERVAT_INTERVENI_EMPLOYE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_RESERVAT_LIER1_PRODUIT_') then
    alter table RESERVATION
       delete foreign key FK_RESERVAT_LIER1_PRODUIT_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_RESERVAT_OBTENIR_CLIENT') then
    alter table RESERVATION
       delete foreign key FK_RESERVAT_OBTENIR_CLIENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SALAIRE__CONSULTER_EMPLOYE') then
    alter table SALAIRE_STATUT
       delete foreign key FK_SALAIRE__CONSULTER_EMPLOYE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SEANCE_INTERVENI_EMPLOYE') then
    alter table SEANCE
       delete foreign key FK_SEANCE_INTERVENI_EMPLOYE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SEANCE_LIER4_SECTEUR') then
    alter table SEANCE
       delete foreign key FK_SEANCE_LIER4_SECTEUR
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SEANCE_PARTICIPE_CLIENT') then
    alter table SEANCE
       delete foreign key FK_SEANCE_PARTICIPE_CLIENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TACHE_CREER_EMPLOYE') then
    alter table TACHE
       delete foreign key FK_TACHE_CREER_EMPLOYE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='LIER3_FK'
     and t.table_name='ABONNEMENT'
) then
   drop index ABONNEMENT.LIER3_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ENREGISTRER_FK'
     and t.table_name='ABONNEMENT'
) then
   drop index ABONNEMENT.ENREGISTRER_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='INTERVENIR2_FK'
     and t.table_name='ABONNEMENT'
) then
   drop index ABONNEMENT.INTERVENIR2_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ABONNEMENT_PK'
     and t.table_name='ABONNEMENT'
) then
   drop index ABONNEMENT.ABONNEMENT_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='ABONNEMENT'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table ABONNEMENT
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='HERITAGE_3_FK'
     and t.table_name='ADMIN'
) then
   drop index ADMIN.HERITAGE_3_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ADMIN_PK'
     and t.table_name='ADMIN'
) then
   drop index ADMIN.ADMIN_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='ADMIN'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table ADMIN
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='HERITAGE_1_FK'
     and t.table_name='CLIENT'
) then
   drop index CLIENT.HERITAGE_1_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='CLIENT_PK'
     and t.table_name='CLIENT'
) then
   drop index CLIENT.CLIENT_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='CLIENT'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table CLIENT
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='HERITAGE_2_FK'
     and t.table_name='EMPLOYE'
) then
   drop index EMPLOYE.HERITAGE_2_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='EMPLOYE_PK'
     and t.table_name='EMPLOYE'
) then
   drop index EMPLOYE.EMPLOYE_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='EMPLOYE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table EMPLOYE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='HERITAGE_4_FK'
     and t.table_name='MODEL_PRODUIT_SERVICE'
) then
   drop index MODEL_PRODUIT_SERVICE.HERITAGE_4_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='MODEL_PRODUIT_SERVICE_PK'
     and t.table_name='MODEL_PRODUIT_SERVICE'
) then
   drop index MODEL_PRODUIT_SERVICE.MODEL_PRODUIT_SERVICE_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='MODEL_PRODUIT_SERVICE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table MODEL_PRODUIT_SERVICE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='LIER2_FK'
     and t.table_name='PAIEMENT'
) then
   drop index PAIEMENT.LIER2_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='EFFECTUER_FK'
     and t.table_name='PAIEMENT'
) then
   drop index PAIEMENT.EFFECTUER_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='INTERVENIR3_FK'
     and t.table_name='PAIEMENT'
) then
   drop index PAIEMENT.INTERVENIR3_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='PAIEMENT_PK'
     and t.table_name='PAIEMENT'
) then
   drop index PAIEMENT.PAIEMENT_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='PAIEMENT'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table PAIEMENT
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='CONSULTER1_FK'
     and t.table_name='PLANNING'
) then
   drop index PLANNING.CONSULTER1_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='PLANNING_PK'
     and t.table_name='PLANNING'
) then
   drop index PLANNING.PLANNING_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='PLANNING'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table PLANNING
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='MARQUER_FK'
     and t.table_name='PRESENCE'
) then
   drop index PRESENCE.MARQUER_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='PRESENCE_PK'
     and t.table_name='PRESENCE'
) then
   drop index PRESENCE.PRESENCE_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='PRESENCE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table PRESENCE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='PRODUIT_SERVICE_PK'
     and t.table_name='PRODUIT_SERVICE'
) then
   drop index PRODUIT_SERVICE.PRODUIT_SERVICE_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='PRODUIT_SERVICE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table PRODUIT_SERVICE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='LIER1_FK'
     and t.table_name='RESERVATION'
) then
   drop index RESERVATION.LIER1_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='OBTENIR_FK'
     and t.table_name='RESERVATION'
) then
   drop index RESERVATION.OBTENIR_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='INTERVENIR4_FK'
     and t.table_name='RESERVATION'
) then
   drop index RESERVATION.INTERVENIR4_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='RESERVATION_PK'
     and t.table_name='RESERVATION'
) then
   drop index RESERVATION.RESERVATION_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='RESERVATION'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table RESERVATION
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='CONSULTER_FK'
     and t.table_name='SALAIRE_STATUT'
) then
   drop index SALAIRE_STATUT.CONSULTER_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='SALAIRE_STATUT_PK'
     and t.table_name='SALAIRE_STATUT'
) then
   drop index SALAIRE_STATUT.SALAIRE_STATUT_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='SALAIRE_STATUT'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table SALAIRE_STATUT
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='LIER4_FK'
     and t.table_name='SEANCE'
) then
   drop index SEANCE.LIER4_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='PARTICIPER_FK'
     and t.table_name='SEANCE'
) then
   drop index SEANCE.PARTICIPER_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='INTERVENIR1_FK'
     and t.table_name='SEANCE'
) then
   drop index SEANCE.INTERVENIR1_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='SEANCE_PK'
     and t.table_name='SEANCE'
) then
   drop index SEANCE.SEANCE_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='SEANCE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table SEANCE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='SECTEUR_PK'
     and t.table_name='SECTEUR'
) then
   drop index SECTEUR.SECTEUR_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='SECTEUR'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table SECTEUR
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='CREER_FK'
     and t.table_name='TACHE'
) then
   drop index TACHE.CREER_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='TACHE_PK'
     and t.table_name='TACHE'
) then
   drop index TACHE.TACHE_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='TACHE'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table TACHE
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='USER_PK'
     and t.table_name='USER'
) then
   drop index "USER".USER_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='USER'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table "USER"
end if;

/*==============================================================*/
/* Table : ABONNEMENT                                           */
/*==============================================================*/
create table ABONNEMENT 
(
   ID_ABONNEMENT        integer                        not null,
   ID_SECTEUR           integer                        not null,
   CLI_ID_USER          integer                        null,
   ID_CLI               integer                        null,
   ID_USER              integer                        not null,
   ID_EMPL              integer                        not null,
   TYPE                 varchar                        not null,
   MONTANTU             float                          not null,
   MONTANTT             float                          not null,
   NOMBRE_MOIS          integer                        not null,
   constraint PK_ABONNEMENT primary key (ID_ABONNEMENT)
);

/*==============================================================*/
/* Index : ABONNEMENT_PK                                        */
/*==============================================================*/
create unique index ABONNEMENT_PK on ABONNEMENT (
ID_ABONNEMENT ASC
);

/*==============================================================*/
/* Index : INTERVENIR2_FK                                       */
/*==============================================================*/
create index INTERVENIR2_FK on ABONNEMENT (
ID_USER ASC,
ID_EMPL ASC
);

/*==============================================================*/
/* Index : ENREGISTRER_FK                                       */
/*==============================================================*/
create index ENREGISTRER_FK on ABONNEMENT (
CLI_ID_USER ASC,
ID_CLI ASC
);

/*==============================================================*/
/* Index : LIER3_FK                                             */
/*==============================================================*/
create index LIER3_FK on ABONNEMENT (
ID_SECTEUR ASC
);

/*==============================================================*/
/* Table : ADMIN                                                */
/*==============================================================*/
create table ADMIN 
(
   ID_USER              integer                        not null,
   ID_EMPL              integer                        not null,
   ID_ADMIN             integer                        not null,
   NOM                  varchar                        not null,
   PRENOM               varchar                        not null,
   SEXE                 varchar                        not null,
   DATE_NAISSANCE       timestamp                      not null,
   USE_DATE_CREATION    date                           not null,
   "LOGIN"              varchar                        not null,
   PASSWORD             varchar                        not null,
   PRISE_SERVICE        date                           not null,
   DATE_CREATION        date                           not null,
   constraint PK_ADMIN primary key (ID_USER, ID_EMPL, ID_ADMIN)
);

/*==============================================================*/
/* Index : ADMIN_PK                                             */
/*==============================================================*/
create unique index ADMIN_PK on ADMIN (
ID_USER ASC,
ID_EMPL ASC,
ID_ADMIN ASC
);

/*==============================================================*/
/* Index : HERITAGE_3_FK                                        */
/*==============================================================*/
create index HERITAGE_3_FK on ADMIN (
ID_USER ASC,
ID_EMPL ASC
);

/*==============================================================*/
/* Table : CLIENT                                               */
/*==============================================================*/
create table CLIENT 
(
   ID_USER              integer                        not null,
   ID_CLI               integer                        not null,
   NOM                  varchar                        not null,
   PRENOM               varchar                        not null,
   SEXE                 varchar                        not null,
   DATE_NAISSANCE       timestamp                      not null,
   USE_DATE_CREATION    date                           not null,
   "LOGIN"              varchar                        not null,
   PASSWORD             varchar                        not null,
   DATE_CREATION        date                           not null,
   constraint PK_CLIENT primary key (ID_USER, ID_CLI)
);

/*==============================================================*/
/* Index : CLIENT_PK                                            */
/*==============================================================*/
create unique index CLIENT_PK on CLIENT (
ID_USER ASC,
ID_CLI ASC
);

/*==============================================================*/
/* Index : HERITAGE_1_FK                                        */
/*==============================================================*/
create index HERITAGE_1_FK on CLIENT (
ID_USER ASC
);

/*==============================================================*/
/* Table : EMPLOYE                                              */
/*==============================================================*/
create table EMPLOYE 
(
   ID_USER              integer                        not null,
   ID_EMPL              integer                        not null,
   NOM                  varchar                        not null,
   PRENOM               varchar                        not null,
   SEXE                 varchar                        not null,
   DATE_NAISSANCE       timestamp                      not null,
   USE_DATE_CREATION    date                           not null,
   "LOGIN"              varchar                        not null,
   PASSWORD             varchar                        not null,
   PRISE_SERVICE        date                           not null,
   DATE_CREATION        date                           not null,
   constraint PK_EMPLOYE primary key (ID_USER, ID_EMPL)
);

/*==============================================================*/
/* Index : EMPLOYE_PK                                           */
/*==============================================================*/
create unique index EMPLOYE_PK on EMPLOYE (
ID_USER ASC,
ID_EMPL ASC
);

/*==============================================================*/
/* Index : HERITAGE_2_FK                                        */
/*==============================================================*/
create index HERITAGE_2_FK on EMPLOYE (
ID_USER ASC
);

/*==============================================================*/
/* Table : MODEL_PRODUIT_SERVICE                                */
/*==============================================================*/
create table MODEL_PRODUIT_SERVICE 
(
   ID_PRODUIT_SERVICE   integer                        not null,
   ID_MODEL             integer                        not null,
   DATE_CREATION        date                           not null,
   NOM_MODEL            varchar                        not null,
   CHAMPS_MODEL         char(10)                       null,
   constraint PK_MODEL_PRODUIT_SERVICE primary key (ID_PRODUIT_SERVICE, ID_MODEL)
);

/*==============================================================*/
/* Index : MODEL_PRODUIT_SERVICE_PK                             */
/*==============================================================*/
create unique index MODEL_PRODUIT_SERVICE_PK on MODEL_PRODUIT_SERVICE (
ID_PRODUIT_SERVICE ASC,
ID_MODEL ASC
);

/*==============================================================*/
/* Index : HERITAGE_4_FK                                        */
/*==============================================================*/
create index HERITAGE_4_FK on MODEL_PRODUIT_SERVICE (
ID_PRODUIT_SERVICE ASC
);

/*==============================================================*/
/* Table : PAIEMENT                                             */
/*==============================================================*/
create table PAIEMENT 
(
   ID_PAIEMENT          integer                        not null,
   ID_USER              integer                        not null,
   ID_EMPL              integer                        not null,
   CLI_ID_USER          integer                        not null,
   ID_CLI               integer                        not null,
   ID_PRODUIT_SERVICE   integer                        not null,
   DATE_PAIEMENT        date                           not null,
   MONTANT              float                          not null,
   constraint PK_PAIEMENT primary key (ID_PAIEMENT)
);

/*==============================================================*/
/* Index : PAIEMENT_PK                                          */
/*==============================================================*/
create unique index PAIEMENT_PK on PAIEMENT (
ID_PAIEMENT ASC
);

/*==============================================================*/
/* Index : INTERVENIR3_FK                                       */
/*==============================================================*/
create index INTERVENIR3_FK on PAIEMENT (
ID_USER ASC,
ID_EMPL ASC
);

/*==============================================================*/
/* Index : EFFECTUER_FK                                         */
/*==============================================================*/
create index EFFECTUER_FK on PAIEMENT (
CLI_ID_USER ASC,
ID_CLI ASC
);

/*==============================================================*/
/* Index : LIER2_FK                                             */
/*==============================================================*/
create index LIER2_FK on PAIEMENT (
ID_PRODUIT_SERVICE ASC
);

/*==============================================================*/
/* Table : PLANNING                                             */
/*==============================================================*/
create table PLANNING 
(
   ID_PLANNING          integer                        not null,
   ID_USER              integer                        not null,
   ID_EMPL              integer                        not null,
   JOURS_TRAVAIL        long varchar                   not null,
   DATE_CREATION        date                           not null,
   constraint PK_PLANNING primary key (ID_PLANNING)
);

/*==============================================================*/
/* Index : PLANNING_PK                                          */
/*==============================================================*/
create unique index PLANNING_PK on PLANNING (
ID_PLANNING ASC
);

/*==============================================================*/
/* Index : CONSULTER1_FK                                        */
/*==============================================================*/
create index CONSULTER1_FK on PLANNING (
ID_USER ASC,
ID_EMPL ASC
);

/*==============================================================*/
/* Table : PRESENCE                                             */
/*==============================================================*/
create table PRESENCE 
(
   ID_PRESENCE          char(10)                       not null,
   ID_USER              integer                        not null,
   ID_EMPL              integer                        not null,
   PRESENCE             smallint                       not null,
   MOTIF                long varchar                   not null,
   DATE_CREATION        date                           not null,
   constraint PK_PRESENCE primary key (ID_PRESENCE)
);

/*==============================================================*/
/* Index : PRESENCE_PK                                          */
/*==============================================================*/
create unique index PRESENCE_PK on PRESENCE (
ID_PRESENCE ASC
);

/*==============================================================*/
/* Index : MARQUER_FK                                           */
/*==============================================================*/
create index MARQUER_FK on PRESENCE (
ID_USER ASC,
ID_EMPL ASC
);

/*==============================================================*/
/* Table : PRODUIT_SERVICE                                      */
/*==============================================================*/
create table PRODUIT_SERVICE 
(
   ID_PRODUIT_SERVICE   integer                        not null,
   DATE_CREATION        date                           not null,
   constraint PK_PRODUIT_SERVICE primary key (ID_PRODUIT_SERVICE)
);

/*==============================================================*/
/* Index : PRODUIT_SERVICE_PK                                   */
/*==============================================================*/
create unique index PRODUIT_SERVICE_PK on PRODUIT_SERVICE (
ID_PRODUIT_SERVICE ASC
);

/*==============================================================*/
/* Table : RESERVATION                                          */
/*==============================================================*/
create table RESERVATION 
(
   ID_RESERVATION       integer                        not null,
   CLI_ID_USER          integer                        null,
   ID_CLI               integer                        null,
   ID_PRODUIT_SERVICE   integer                        not null,
   ID_USER              integer                        not null,
   ID_EMPL              integer                        not null,
   DATE_RESERVATION     date                           not null,
   constraint PK_RESERVATION primary key (ID_RESERVATION)
);

/*==============================================================*/
/* Index : RESERVATION_PK                                       */
/*==============================================================*/
create unique index RESERVATION_PK on RESERVATION (
ID_RESERVATION ASC
);

/*==============================================================*/
/* Index : INTERVENIR4_FK                                       */
/*==============================================================*/
create index INTERVENIR4_FK on RESERVATION (
ID_USER ASC,
ID_EMPL ASC
);

/*==============================================================*/
/* Index : OBTENIR_FK                                           */
/*==============================================================*/
create index OBTENIR_FK on RESERVATION (
CLI_ID_USER ASC,
ID_CLI ASC
);

/*==============================================================*/
/* Index : LIER1_FK                                             */
/*==============================================================*/
create index LIER1_FK on RESERVATION (
ID_PRODUIT_SERVICE ASC
);

/*==============================================================*/
/* Table : SALAIRE_STATUT                                       */
/*==============================================================*/
create table SALAIRE_STATUT 
(
   ID_SALAIRE_STATUT    integer                        not null,
   ID_USER              integer                        not null,
   ID_EMPL              integer                        not null,
   PAYER                smallint                       not null,
   MOTIF                long varchar                   not null,
   DATE_CREATION        date                           not null,
   constraint PK_SALAIRE_STATUT primary key (ID_SALAIRE_STATUT)
);

/*==============================================================*/
/* Index : SALAIRE_STATUT_PK                                    */
/*==============================================================*/
create unique index SALAIRE_STATUT_PK on SALAIRE_STATUT (
ID_SALAIRE_STATUT ASC
);

/*==============================================================*/
/* Index : CONSULTER_FK                                         */
/*==============================================================*/
create index CONSULTER_FK on SALAIRE_STATUT (
ID_USER ASC,
ID_EMPL ASC
);

/*==============================================================*/
/* Table : SEANCE                                               */
/*==============================================================*/
create table SEANCE 
(
   ID_SEANCE            integer                        not null,
   ID_USER              integer                        not null,
   ID_EMPL              integer                        not null,
   CLI_ID_USER          integer                        null,
   ID_CLI               integer                        null,
   ID_SECTEUR           integer                        not null,
   DATE_SEANCE          date                           not null,
   DUREE                timestamp                      null,
   MONTANT              float                          not null,
   constraint PK_SEANCE primary key (ID_SEANCE)
);

/*==============================================================*/
/* Index : SEANCE_PK                                            */
/*==============================================================*/
create unique index SEANCE_PK on SEANCE (
ID_SEANCE ASC
);

/*==============================================================*/
/* Index : INTERVENIR1_FK                                       */
/*==============================================================*/
create index INTERVENIR1_FK on SEANCE (
ID_USER ASC,
ID_EMPL ASC
);

/*==============================================================*/
/* Index : PARTICIPER_FK                                        */
/*==============================================================*/
create index PARTICIPER_FK on SEANCE (
CLI_ID_USER ASC,
ID_CLI ASC
);

/*==============================================================*/
/* Index : LIER4_FK                                             */
/*==============================================================*/
create index LIER4_FK on SEANCE (
ID_SECTEUR ASC
);

/*==============================================================*/
/* Table : SECTEUR                                              */
/*==============================================================*/
create table SECTEUR 
(
   ID_SECTEUR           integer                        not null,
   LIBELLE              varchar                        not null,
   DATE_CREATION        date                           not null,
   constraint PK_SECTEUR primary key (ID_SECTEUR)
);

/*==============================================================*/
/* Index : SECTEUR_PK                                           */
/*==============================================================*/
create unique index SECTEUR_PK on SECTEUR (
ID_SECTEUR ASC
);

/*==============================================================*/
/* Table : TACHE                                                */
/*==============================================================*/
create table TACHE 
(
   ID_TACHE             integer                        not null,
   ID_USER              integer                        null,
   ID_EMPL              integer                        null,
   TITRE                varchar                        not null,
   CONTENU              long varchar                   null,
   constraint PK_TACHE primary key (ID_TACHE)
);

/*==============================================================*/
/* Index : TACHE_PK                                             */
/*==============================================================*/
create unique index TACHE_PK on TACHE (
ID_TACHE ASC
);

/*==============================================================*/
/* Index : CREER_FK                                             */
/*==============================================================*/
create index CREER_FK on TACHE (
ID_USER ASC,
ID_EMPL ASC
);

/*==============================================================*/
/* Table : "USER"                                               */
/*==============================================================*/
create table "USER" 
(
   ID_USER              integer                        not null,
   NOM                  varchar                        not null,
   PRENOM               varchar                        not null,
   SEXE                 varchar                        not null,
   DATE_NAISSANCE       timestamp                      not null,
   DATE_CREATION        date                           not null,
   constraint PK_USER primary key (ID_USER)
);

/*==============================================================*/
/* Index : USER_PK                                              */
/*==============================================================*/
create unique index USER_PK on "USER" (
ID_USER ASC
);

alter table ABONNEMENT
   add constraint FK_ABONNEME_ENREGISTR_CLIENT foreign key (CLI_ID_USER, ID_CLI)
      references CLIENT (ID_USER, ID_CLI)
      on update restrict
      on delete restrict;

alter table ABONNEMENT
   add constraint FK_ABONNEME_INTERVENI_EMPLOYE foreign key (ID_USER, ID_EMPL)
      references EMPLOYE (ID_USER, ID_EMPL)
      on update restrict
      on delete restrict;

alter table ABONNEMENT
   add constraint FK_ABONNEME_LIER3_SECTEUR foreign key (ID_SECTEUR)
      references SECTEUR (ID_SECTEUR)
      on update restrict
      on delete restrict;

alter table ADMIN
   add constraint FK_ADMIN_HERITAGE__EMPLOYE foreign key (ID_USER, ID_EMPL)
      references EMPLOYE (ID_USER, ID_EMPL)
      on update restrict
      on delete restrict;

alter table CLIENT
   add constraint FK_CLIENT_HERITAGE__USER foreign key (ID_USER)
      references "USER" (ID_USER)
      on update restrict
      on delete restrict;

alter table EMPLOYE
   add constraint FK_EMPLOYE_HERITAGE__USER foreign key (ID_USER)
      references "USER" (ID_USER)
      on update restrict
      on delete restrict;

alter table MODEL_PRODUIT_SERVICE
   add constraint FK_MODEL_PR_HERITAGE__PRODUIT_ foreign key (ID_PRODUIT_SERVICE)
      references PRODUIT_SERVICE (ID_PRODUIT_SERVICE)
      on update restrict
      on delete restrict;

alter table PAIEMENT
   add constraint FK_PAIEMENT_EFFECTUER_CLIENT foreign key (CLI_ID_USER, ID_CLI)
      references CLIENT (ID_USER, ID_CLI)
      on update restrict
      on delete restrict;

alter table PAIEMENT
   add constraint FK_PAIEMENT_INTERVENI_EMPLOYE foreign key (ID_USER, ID_EMPL)
      references EMPLOYE (ID_USER, ID_EMPL)
      on update restrict
      on delete restrict;

alter table PAIEMENT
   add constraint FK_PAIEMENT_LIER2_PRODUIT_ foreign key (ID_PRODUIT_SERVICE)
      references PRODUIT_SERVICE (ID_PRODUIT_SERVICE)
      on update restrict
      on delete restrict;

alter table PLANNING
   add constraint FK_PLANNING_CONSULTER_EMPLOYE foreign key (ID_USER, ID_EMPL)
      references EMPLOYE (ID_USER, ID_EMPL)
      on update restrict
      on delete restrict;

alter table PRESENCE
   add constraint FK_PRESENCE_MARQUER_EMPLOYE foreign key (ID_USER, ID_EMPL)
      references EMPLOYE (ID_USER, ID_EMPL)
      on update restrict
      on delete restrict;

alter table RESERVATION
   add constraint FK_RESERVAT_INTERVENI_EMPLOYE foreign key (ID_USER, ID_EMPL)
      references EMPLOYE (ID_USER, ID_EMPL)
      on update restrict
      on delete restrict;

alter table RESERVATION
   add constraint FK_RESERVAT_LIER1_PRODUIT_ foreign key (ID_PRODUIT_SERVICE)
      references PRODUIT_SERVICE (ID_PRODUIT_SERVICE)
      on update restrict
      on delete restrict;

alter table RESERVATION
   add constraint FK_RESERVAT_OBTENIR_CLIENT foreign key (CLI_ID_USER, ID_CLI)
      references CLIENT (ID_USER, ID_CLI)
      on update restrict
      on delete restrict;

alter table SALAIRE_STATUT
   add constraint FK_SALAIRE__CONSULTER_EMPLOYE foreign key (ID_USER, ID_EMPL)
      references EMPLOYE (ID_USER, ID_EMPL)
      on update restrict
      on delete restrict;

alter table SEANCE
   add constraint FK_SEANCE_INTERVENI_EMPLOYE foreign key (ID_USER, ID_EMPL)
      references EMPLOYE (ID_USER, ID_EMPL)
      on update restrict
      on delete restrict;

alter table SEANCE
   add constraint FK_SEANCE_LIER4_SECTEUR foreign key (ID_SECTEUR)
      references SECTEUR (ID_SECTEUR)
      on update restrict
      on delete restrict;

alter table SEANCE
   add constraint FK_SEANCE_PARTICIPE_CLIENT foreign key (CLI_ID_USER, ID_CLI)
      references CLIENT (ID_USER, ID_CLI)
      on update restrict
      on delete restrict;

alter table TACHE
   add constraint FK_TACHE_CREER_EMPLOYE foreign key (ID_USER, ID_EMPL)
      references EMPLOYE (ID_USER, ID_EMPL)
      on update restrict
      on delete restrict;

