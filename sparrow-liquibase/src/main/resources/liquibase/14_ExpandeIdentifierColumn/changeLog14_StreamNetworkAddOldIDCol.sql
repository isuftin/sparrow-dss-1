--liquibase formatted sql

--This is for the stream_network schema

--changeset kmschoep:ERaddColumnOld_Identifier
ALTER TABLE ENH_REACH ADD (OLD_IDENTIFIER number(10,0));
--rollback update enh_reach set identifier = old_identifier;
--rollback alter table ENH_REACH drop COLUMN OLD_IDENTIFIER;

--changeset kmschoep:ERcopyIDENTIFIERtoOLD_IDENTIFIER
--preconditions onFail:HALT onError:HALT
UPDATE ENH_REACH
SET OLD_IDENTIFIER = IDENTIFIER
WHERE
      identifier is not null;
--rollback select null from dual; 
      
--changeset kmschoep:NRaddColumnOld_Identifier
ALTER TABLE NOM_REACH ADD (OLD_IDENTIFIER number(10,0));
--rollback update nom_reach set identifier = old_identifier;
--rollback alter table NOM_REACH drop COLUMN OLD_IDENTIFIER;

--changeset kmschoep:NRcopyIDENTIFIERtoOLD_IDENTIFIER
--preconditions onFail:HALT onError:HALT
UPDATE NOM_REACH
SET OLD_IDENTIFIER = IDENTIFIER
WHERE
      identifier is not null;
--rollback select null from dual;  

--changeset kmschoep:NRmodIDENTIFIER11digits
--preconditions onFail:HALT onError:HALT
ALTER TABLE NOM_REACH MODIFY (IDENTIFIER number(11,0));
--rollback select null from dual;