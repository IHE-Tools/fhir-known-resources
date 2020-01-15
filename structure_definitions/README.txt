2020.01.14	Steve Moore

Populating FHIR Read/Write Server with Structure definitions

1.  Retrieve the IHE Structure Definitions from the IHE GitHub repository
    git clone https://github.com/IHE/fhir.git <local folder>

2.  cd ../scripts

3.  Make sure the script base_url.sh has the right value for the base URL for the FHIR server
    BASE_URL=http://localhost:8080/fhir/baseR4
    This script is called by other scripts.

4.  ./structure_definitions_post.sh <local folder>/StructureDefinition
    This script reads through the files you retrieved in step 1 and posts them to the FHIR Read/Write server
