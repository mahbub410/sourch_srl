--EXECUTE DPG_EPAY_PAY_AUTO_POSTIN_NESCO.DPD_PYMT_POSTING_JOB_SUBMIT('JOB_PYMT_DATA_TRNS_NESCO','EPAY.DPG_EPAY_PAY_AUTO_POSTIN_NESCO.DPD_EPAY_PYMT_POSTING_CONT',120);

EXECUTE DPG_MBILL_DATA_DOWNLOAD.DPD_JOB_SUBMIT('JOB_MBILL_DATA_DOWNLOAD','DPG_MBILL_DATA_DOWNLOAD.DPD_MBILL_DOWNLOAD_CONT',120);
    
EXECUTE DPG_MBILL_DATA_DOWNLOAD.DPD_JOB_SUBMIT('JOB_AUDIT_DATA_UPLOAD','DPG_MIS_AUDIT_DATA_UPLOAD.DPD_MIS_AUDIT_DATA_TRNS_CONT',120);
        
EXECUTE DPG_MBILL_DATA_DOWNLOAD.DPD_JOB_SUBMIT('JOB_MBILL_DATA_UPLOAD','DPG_MBILL_DATA_UPLOAD.DPD_MBILL_UPLOAD_CONT',120);


EXECUTE DPG_MBILL_DATA_DOWNLOAD.DPD_JOB_SUBMIT('JOB_MBILL_DATA_DOWNLOAD','DPG_MBILL_DATA_DOWNLOAD.DPD_MBILL_DOWNLOAD_CONT',120)

grant create job to data_trns;

EXECUTE DPG_SDA_PAY_AUTO_POSTING.DPD_PYMT_POSTING_JOB_SUBMIT('JOB_SDA_PYMT_DATA_TRNS','DPG_SDA_PAY_AUTO_POSTING.DPD_SDA_PYMT_POSTING_CONT',720);