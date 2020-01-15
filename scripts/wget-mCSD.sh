#!/bin/bash

check_args() {
 if [ $# -ne 1 ]; then
  echo "Usage: <working folder>"
  exit 1
 fi
}

check_args $*

WORKING_FOLDER=$1
mkdir -p $WORKING_FOLDER
pushd $WORKING_FOLDER

P=ftp://ftp.ihe.net/Connectathon/test_data/ITI-profiles/mCSD-test-data/mCSD_FHIR-R4_Resources

for f in	\
	HealthcareService/mCSD_HealthcareService_101-001_Hospital_Outpatient.xml HealthcareService/mCSD_HealthcareService_101-002_Radiation_Therapy.xml HealthcareService/mCSD_HealthcareService_101-003_Dialysis.xml HealthcareService/mCSD_HealthcareService_101-004_Routine_Exam.xml HealthcareService/mCSD_HealthcareService_101-005_Well_Baby_Care.xml HealthcareService/mCSD_HealthcareService_101-006_Laboratory.xml HealthcareService/mCSD_HealthcareService_101-007_Occupational_Therapy.xml HealthcareService/mCSD_HealthcareService_101-008_Generic_Prescription_Drug_Formulary.xml HealthcareService/mCSD_HealthcareService_101-009_Massage_Therapy.xml HealthcareService/mCSD_HealthcareService_101-010_Screening_X-Ray.xml HealthcareService/mCSD_HealthcareService_101-011_Vision_Frames.xml HealthcareService/mCSD_HealthcareService_101-012_Gynecological.xml HealthcareService/mCSD_HealthcareService_101-013_Screening_Mammography.xml	\
	Location/mCSD_Location_ConnectathonDialysisFacilityOne.xml Location/mCSD_Location_ConnectathonDialysisFacilityTwo.xml Location/mCSD_Location_ConnectathonRadiologyFacilityOne-work.xml Location/mCSD_Location_ConnectathonRadiologyFacilityTwo.xml \
	 Organization/mCSD_Organization_Connectathon_IDN_One.xml Organization/mCSD_Organization_Connectathon_NGO_One.xml Organization/mCSD_Organization_Connectathon_NGO_Quatre_partOf_NGO_One.xml Organization/mCSD_Organization_Connectathon_NGO_Trois_partOf_NGO_One.xml Organization/mCSD_Organization_Connectathon_NGO_Two.xml	\
	Practitioner/mCSD_Practitioner_Banargee_Dev.xml Practitioner/mCSD_Practitioner_Carrara_Carla.xml Practitioner/mCSD_Practitioner_Fredricks_Theodora.xml Practitioner/mCSD_Practitioner_Grant_Glenda.xml Practitioner/mCSD_Practitioner_Johnson_Jack.xml Practitioner/mCSD_Practitioner_McDonald_Mary.xml Practitioner/mCSD_Practitioner_Robertson_Robert.xml Practitioner/mCSD_Practitioner_Rogers_Rhonda.xml Practitioner/mCSD_Practitioner_Williamson_William.xml	\
	PractitionerRole/mCSD_PractitionerRole_Banargee_Dev_IDN_One_RadiationTherapy-MWFam.xml PractitionerRole/mCSD_PractitionerRole_Banargee_Dev_NGO_Two_RadiationTherapy-TuesThur.xml PractitionerRole/mCSD_PractitionerRole_Carrara_Carla_IDN_One_ScreeningMammo-MWFpm.xml PractitionerRole/mCSD_PractitionerRole_Johnson_Jack_IDN_One_ScreeningMammo-MWFpm.xml PractitionerRole/mCSD_PractitionerRole_McDonald_Mary_IDN_One_RadiationTherapy-MWFpm.xml PractitionerRole/mCSD_PractitionerRole_Robertson_Robert_NGO_One.xml PractitionerRole/mCSD_PractitionerRole_Williamson_William_NGO_One.xml	\
; do
 FOLDER=${f%%/*}
 echo $f $FOLDER
 mkdir -p mCSD_FHIR-R4_Resources/$FOLDER
 wget -O mCSD_FHIR-R4_Resources/$f $P/$f
 if [ $? != 0 ] ; then
  echo "Unable to retrieve/store $P/$f"
  echo Exiting now
  exit
 fi
done
