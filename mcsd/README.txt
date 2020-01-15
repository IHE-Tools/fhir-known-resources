2020.01.14	Steve Moore

Populating FHIR Read/Write Server with Connectathon mCSD data

1.  Pull the mCSD known resources from the IHE FTP server
    ../scripts/wget-mCSD.sh <working folder>
    The working folder now contains subfolders
        working-folder/mCSD_FHIR-R4_Resources/HealthcareService
        working-folder/mCSD_FHIR-R4_Resources/Location
        working-folder/mCSD_FHIR-R4_Resources/Organization
        working-folder/mCSD_FHIR-R4_Resources/Practitioner
        working-folder/mCSD_FHIR-R4_Resources/PractitionerRole

2.  cd ../scripts

3.  Make sure the script base_url.sh has the right value for the base URL for the FHIR server
    BASE_URL=http://localhost:8080/fhir/baseR4
    This script is called by other scripts.

4.  ./mcsd_post.sh <working folder>
    This script reads through the files you pulled in step 1 and posts them to the FHIR Read/Write server
