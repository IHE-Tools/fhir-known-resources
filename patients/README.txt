2020.01.14	Steve Moore

Populating FHIR Read/Write Server with Connectathon test patients

1.  Extract Connectathon patients from Patient Manager: https://gazelle.ihe.net/PatientManager
1.1 Extract only the Connectathon patients. In January 2020, there are 109 patients.
1.2 The default output file is selectedPatients.xml. The filename itself is not critical.

2.  This folder contains selectedPatients.xml from NA2020. You can replace with a newer version
    or use this file.

3.  Separate patients into individual files. There is a perl script that will do this for you.
    It is not a great script, but did work Jan 2020. You could always write a different one or
    do it by hand or possibly with XSLT.
    perl ../scripts/patients_extract.pl selectedPatients.xml some-folder

4.  cd ../scripts

5.  Make sure the script base_url.sh has the right value for the base URL for the FHIR server
    BASE_URL=http://localhost:8080/fhir/baseR4
    This script is called by other scripts.

6.  ./patients_post.sh some-folder
    This script reads through the files you made in step 3 and posts them to the FHIR Read/Write server
