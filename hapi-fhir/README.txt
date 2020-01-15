2020.01.14	Steve Moore

Configuration of the HAPI FHIR Read/Write server

1.   Before you perform this step, you have to know the base URL for the HAPI FHIR server.
     We name the final war file fhir.war, so the base URL will be http://fhir-read-write:8080/fhir
     You will use this information in steps 3 and 8.

2.   clone the HAPI-FHIR code repository
     git clone https://github.com/jamesagnew/hapi-fhir.git <local folder>
     cd <local folder>
     git checkout v4.1.0
     git status

3.   Edit the file hapi-fhir-jpaserver-uhnfhirtest/src/main/java/ca/uhn/fhirtest/config/FhirTesterConfig.java
3.1  Change the baseURLs that point to the hapi.fhir.org servers to point to localhost:8080
     Change the Name of those servers to indicate they are Connectathon Read/Write servers
3.2  Remove any references to external servers. At the point, the file should only know about
     the implementations supported by the HAPI-FHIR software
       fhir/baseR4
       fhir/baseDstu3
       fhir/baseDstu2
       fhir/baseR5

4.   In that same FhirTesterConfig.java
4.1  Add a new server for any Connectathon participant. This is another manual step.

5.   Build the software
       mvn -DskipTests install

6.   The maven command builds several different files.
     Copy this war: hapi-fhir-jpaserver-uhnfhirtest/target/hapi-fhir-jpaserver.war
     e.g., cp hapi-fhir-jpaserver-uhnfhirtest/target/hapi-fhir-jpaserver.war /tmp/fhir.war

7.   Install Apache Tomcat 8. This is what we tested in 2020

8.   Replace bin/catalina.sh with the file in this folder.
     It sets configuration values for the application
     The configuration values in catalina.sh set the URL to /fhir to match the .war file.
     If you choose a different name for the war file, you should update catalina.sh.

9.   Copy fhir.war to the tomcat/webapps folder

10.  Run the postgres script in this folder to create databases needed by the application
     ./postgres.sh

11.  Create folders used by lucene. You can use the script
     ./lucene.sh
     The lucene folders need to match configuration values in catalina.sh

12.  You are now ready to run the Tomcat server
     chmod +x bin/*sh
     ./bin/startup.sh
     tail -f logs/catalina.out

12.1 Shutdown is
     ./bin/shutdown.sh
