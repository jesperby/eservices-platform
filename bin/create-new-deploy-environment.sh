#!/bin/bash

################################################################
# The great create deploy server config                        #
# Must be run from ${BUILD_DIR}/bin
#
################################################################

################################################################
# CONFIG                                                #
################################################################

###### current_config.sh  #####
# symlink to actual config of current installation
. current_config.sh
################################################################
# END OF CONFIG                                                #
################################################################

################################################################


if ${ESERVICE_SSL}; then
   if [ -n "$ESERVICE_PORT" ]; then
     ESERVICE_SITE_URL=https://${ESERVICE_HOST}:${ESERVICE_PORT}/site
   else 
     ESERVICE_SITE_URL=https://${ESERVICE_HOST}:443/site
   fi
else
   if [ -n "$ESERVICE_PORT" ]; then
     ESERVICE_SITE_URL=http://${ESERVICE_HOST}:${ESERVICE_PORT}/site
   else 
     ESERVICE_SITE_URL=http://${ESERVICE_HOST}:80/site
   fi
fi

#tostman if ${KSERVICE_SSL}; then
#tostman    if [ -n "$KSERVICE_PORT" ]; then
#tostman      KSERVICE_SITE_URL=https://${KSERVICE_HOST}:${KSERVICE_PORT}/site
#tostman    else 
#tostman      KSERVICE_SITE_URL=https://${KSERVICE_HOST}:443/site
#tostman    fi
#tostman else
#tostman    if [ -n "$KSERVICE_PORT" ]; then
#tostman      KSERVICE_SITE_URL=http://${KSERVICE_HOST}:${KSERVICE_PORT}/site
#tostman    else 
#tostman      KSERVICE_SITE_URL=http://${KSERVICE_HOST}:80/site
#tostman    fi
#tostman fi

################################################################
# Check some requirements 
#    i.e. do not overwrite CONTAINER_ROOT
#         check that open am policy agent password file exists 
################################################################

if [ -d ${CONTAINER_ROOT} ];
then
   echo "Cannot create deploy environment at ${CONTAINER_ROOT}. Directory already exists."
   exit 0;
fi

#tostman if [ ! -f ${OPENAM_POLICY_AGENT_PWD_FILE_ESERVICE} ]; then 
#tostman   echo "Missing file OPENAM_POLICY_AGENT_PWD_FILE_ESERVICE=${OPENAM_POLICY_AGENT_PWD_FILE_ESERVICE}"
#tostman    exit 1;
#tostman fi

#tostman if [ ! -f ${OPENAM_POLICY_AGENT_PWD_FILE_KSERVICE} ]; then 
#tostman   echo "Missing file OPENAM_POLICY_AGENT_PWD_FILE_KSERVICE=${OPENAM_POLICY_AGENT_PWD_FILE_KSERVICE}"
#tostman    exit 1;
#tostman fi

mkdir -p ${CONTAINER_ROOT}

################################################################
# Download and extract to deployment environment               #
################################################################

# Work from temporary directory
TMP_DIR=${BUILD_DIR}/bin/tmp

if [ ! -d $TMP_DIR/downloads ]
then
  mkdir -p ${TMP_DIR}/downloads
fi

pushd ${TMP_DIR}

# download not already downloaded stuff 
if [ ! -f downloads/${TOMCAT_TGZ} ]; then
    response=$(curl --write-out %{http_code} --silent -o  downloads/${TOMCAT_TGZ}  ${TOMCAT_DOWNLOAD_URL})
    if [ "$response" = "404" ] ; 
    then
       echo "Failed to fetch ${TOMCAT_DOWNLOAD_URL}"
       echo "Maybe the version is not available and the config file needs to be updated."
       exit 1 
    fi
fi

#tostman if [ ! -f downloads/${FORGEROCK_POLICY_AGENT_ZIP} ]; then
#tostman     curl -o downloads/${FORGEROCK_POLICY_AGENT_ZIP} ${FORGEROCK_POLICY_AGENT_URL}
#tostman fi

tar xzf downloads/${TOMCAT_TGZ}
################################################################
# Hippo Tomcat config                                          #
################################################################
HIPPO_APPEND_COMMON_LOADER=
mv ${TOMCAT_DIR}/conf/catalina.properties ${TOMCAT_DIR}/conf/catalina.properties.orig
sed -e 's/\(common\.loader=\)\(.*\)$/\1\2,\${catalina.base}\/common\/classes,\${catalina.base}\/common\/lib\/*.jar/' -e 's/shared.loader=/shared.loader=${catalina.base}\/shared\/classes,${catalina.base}\/shared\/lib\/*.jar/g' ${TOMCAT_DIR}/conf/catalina.properties.orig > ${TOMCAT_DIR}/conf/catalina.properties
##   modification for shibboleth 
mv ${TOMCAT_DIR}/conf/server.xml ${TOMCAT_DIR}/conf/server.xml.orig
sed -e 's%protocol=\"AJP\/1.3\"\ redirectPort=\"8443\"%protocol=\"AJP\/1.3\" redirectPort=\"8443\"\ tomcatAuthentication=\"false\"\ packetSize=\"65536\"%g' ${TOMCAT_DIR}/conf/server.xml.orig > ${TOMCAT_DIR}/conf/server.xml


################################################################
# copy to eservice and kservice tomcats                        #
################################################################

cp -r  ${TOMCAT_DIR} ${CONTAINER_ROOT}/${ESERVICE}
#tostman cp -r  ${TOMCAT_DIR} ${CONTAINER_ROOT}/${CMSSERVICE}
#tostman mv  ${TOMCAT_DIR} ${CONTAINER_ROOT}/${KSERVICE}
### NOTE Check this
## cp ${BUILD_DIR}/conf/repository.xml ${CONTAINER_ROOT}/${KSERVICE}/conf/
## cp ${BUILD_DIR}/conf/repository.xml ${CONTAINER_ROOT}/${CMSSERVICE}/conf/
#tostman added 
cp ${BUILD_DIR}/conf/repository.xml ${CONTAINER_ROOT}/${ESERVICE}/conf/

################################################################
# Write kservice Tomcat setenv.sh due to Hippo and Motrice requirements 
################################################################

##  use for "cms service 
#tostman echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" > ${CONTAINER_ROOT}/${CMSSERVICE}/bin/setenv.sh
#tostman echo REP_OPTS=\"-Drepo.upgrade=false -Drepo.path=${CONTENT_ROOT} -Drepo.config=file:\${CATALINA_BASE}/conf/repository.xml\" >>  ${CONTAINER_ROOT}/${CMSSERVICE}/bin/setenv.sh
#tostman echo L4J_OPTS=\"-Dlog4j.configuration=file:\${CATALINA_BASE}/conf/log4j.xml\" >>  ${CONTAINER_ROOT}/${CMSSERVICE}/bin/setenv.sh
#tostman echo JVM_OPTS=\"-server -Xmx2048m -Xms1024m -XX:PermSize=256m\" >>  ${CONTAINER_ROOT}/${CMSSERVICE}/bin/setenv.sh
#tostman echo CATALINA_OPTS=\"\$CATALINA_OPTS -Dfile.encoding=UTF-8 \${JVM_OPTS} \${REP_OPTS} \${L4J_OPTS} -XX:+HeapDumpOnOutOfMemoryError\" >>  ${CONTAINER_ROOT}/${CMSSERVICE}/bin/setenv.sh
#tostman echo export CATALINA_OPTS >>  ${CONTAINER_ROOT}/${CMSSERVICE}/bin/setenv.sh

################################################################
# Write eservice Tomcat setenv.sh due to Hippo and Motrice requirements 
#   the diff is repo conf and policy agent conf
################################################################

##  use for KSERVICE and ESERVICE 
echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" > ${CONTAINER_ROOT}/${ESERVICE}/bin/setenv.sh
echo L4J_OPTS=\"-Dlog4j.configuration=file:\${CATALINA_BASE}/conf/log4j.xml\" >>  ${CONTAINER_ROOT}/${ESERVICE}/bin/setenv.sh
echo JVM_OPTS=\"-server -Xmx4096m -Xms2048m -XX:PermSize=512m\" >>  ${CONTAINER_ROOT}/${ESERVICE}/bin/setenv.sh
# echo JVM_OPTS=\"-server -Xmx2048m -Xms1024m -XX:PermSize=256m\" >>  ${CONTAINER_ROOT}/${ESERVICE}/bin/setenv.sh
echo CATALINA_OPTS=\"\$CATALINA_OPTS -Dfile.encoding=UTF-8 \${JVM_OPTS} \${L4J_OPTS} -XX:+HeapDumpOnOutOfMemoryError\" >>  ${CONTAINER_ROOT}/${ESERVICE}/bin/setenv.sh
echo export CATALINA_OPTS >>  ${CONTAINER_ROOT}/${ESERVICE}/bin/setenv.sh

#tostman echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" > ${CONTAINER_ROOT}/${KSERVICE}/bin/setenv.sh
#tostman echo L4J_OPTS=\"-Dlog4j.configuration=file:\${CATALINA_BASE}/conf/log4j.xml\" >>  ${CONTAINER_ROOT}/${KSERVICE}/bin/setenv.sh
#tostman echo JVM_OPTS=\"-server -Xmx2048m -Xms1024m -XX:PermSize=256m\" >>  ${CONTAINER_ROOT}/${KSERVICE}/bin/setenv.sh
#tostman echo CATALINA_OPTS=\"\$CATALINA_OPTS -Dfile.encoding=UTF-8 \${JVM_OPTS} \${L4J_OPTS} -XX:+HeapDumpOnOutOfMemoryError\" >>  ${CONTAINER_ROOT}/${KSERVICE}/bin/setenv.sh
#tostman echo export CATALINA_OPTS >>  ${CONTAINER_ROOT}/${KSERVICE}/bin/setenv.sh

#tostman # copy one policy agent config per tomcat ( only  KSERVICE and ESERVICE )
#tostman unzip -uq downloads/${FORGEROCK_POLICY_AGENT_ZIP}
#tostman mv j2ee_agents  ${CONTAINER_ROOT}/
#tostman cp -r ${CONTAINER_ROOT}/j2ee_agents/tomcat_v6_agent ${CONTAINER_ROOT}/j2ee_agents/eservice-tomcat_v6_agent
#tostman mv ${CONTAINER_ROOT}/j2ee_agents/tomcat_v6_agent ${CONTAINER_ROOT}/j2ee_agents/kservice-tomcat_v6_agent

################################################################
# change port on eservice tomcat
################################################################
#tostman mv  ${CONTAINER_ROOT}/${ESERVICE}/conf/server.xml  ${CONTAINER_ROOT}/${ESERVICE}/conf/server.xml.orig
#tostman sed -e 's/8080/38080/g' -e 's/8009/38009/g' -e 's/8005/38005/g'  ${CONTAINER_ROOT}/${ESERVICE}/conf/server.xml.orig >  ${CONTAINER_ROOT}/${ESERVICE}/conf/server.xml
#tostman #  use 4XXXX for CMS 

################################################################
# change port on cmsservice tomcat
################################################################
#tostman mv  ${CONTAINER_ROOT}/${CMSSERVICE}/conf/server.xml  ${CONTAINER_ROOT}/${CMSSERVICE}/conf/server.xml.orig
#tostman sed -e 's/8080/48080/g' -e 's/8009/48009/g' -e 's/8005/48005/g'  ${CONTAINER_ROOT}/${CMSSERVICE}/conf/server.xml.orig >  ${CONTAINER_ROOT}/${CMSSERVICE}/conf/server.xml
#tostman #  use 4XXXX for CMS 

################################################################
# eservice - Agent install configuration
#
################################################################
#tostman cd  ${CONTAINER_ROOT}/j2ee_agents/eservice-tomcat_v6_agent/bin
#tostman echo # Agent User Response File > eservice-openam-agent-config
#tostman echo CONFIG_DIR= ${CONTAINER_ROOT}/${ESERVICE}/conf >> eservice-openam-agent-config
#tostman echo AM_SERVER_URL= ${OPENAM_SERVER_URL_ESERVICE} >> eservice-openam-agent-config
#tostman echo CATALINA_HOME= ${CONTAINER_ROOT}/${ESERVICE} >> eservice-openam-agent-config
#tostman echo INSTALL_GLOBAL_WEB_XML= false >> eservice-openam-agent-config
#tostman echo AGENT_URL= ${ESERVICE_SITE_URL} >> eservice-openam-agent-config
#tostman echo AGENT_PROFILE_NAME= ${OPENAM_POLICY_AGENT_ESERVICE} >> eservice-openam-agent-config
#tostman echo AGENT_PASSWORD_FILE= ${OPENAM_POLICY_AGENT_PWD_FILE_ESERVICE} >> eservice-openam-agent-config

################################################################
# Install eservice agent
################################################################
#tostman ./agentadmin --install --useResponse eservice-openam-agent-config <<< $'n\nyes\n'

################################################################
# Fix realm in eservice bootstrap config
################################################################
#tostman cd ../Agent_001/config/
#tostman mv OpenSSOAgentBootstrap.properties OpenSSOAgentBootstrap.properties.orig
#tostman sed -e "s/\(com\.sun\.identity\.agents\.config\.organization\.name\s=\s\/\).*$/\1${OPENAM_REALM_ESERVICE}/" OpenSSOAgentBootstrap.properties.orig > OpenSSOAgentBootstrap.properties

################################################################
# kservice - Agent install configuration
#
################################################################
#tostman cd  ${CONTAINER_ROOT}/j2ee_agents/kservice-tomcat_v6_agent/bin
#tostman echo # Agent User Response File > kservice-openam-agent-config
#tostman echo CONFIG_DIR= ${CONTAINER_ROOT}/${KSERVICE}/conf >> kservice-openam-agent-config
#tostman echo AM_SERVER_URL= ${OPENAM_SERVER_URL_KSERVICE} >> kservice-openam-agent-config
#tostman echo CATALINA_HOME= ${CONTAINER_ROOT}/${KSERVICE} >> kservice-openam-agent-config
#tostman echo INSTALL_GLOBAL_WEB_XML= false >> kservice-openam-agent-config
#tostman echo AGENT_URL= ${KSERVICE_SITE_URL} >> kservice-openam-agent-config
#tostman echo AGENT_PROFILE_NAME= ${OPENAM_POLICY_AGENT_KSERVICE} >> kservice-openam-agent-config
#tostman echo AGENT_PASSWORD_FILE= ${OPENAM_POLICY_AGENT_PWD_FILE_KSERVICE} >> kservice-openam-agent-config

#tostman ################################################################
#tostman # Install kservice agent
#tostman ################################################################
#tostman ./agentadmin --install --useResponse kservice-openam-agent-config <<< $'n\nyes\n'

#tostman ################################################################
#tostman # Fix realm in kservice bootstrap config
#tostman ################################################################
#tostman cd ../Agent_001/config/
#tostman mv OpenSSOAgentBootstrap.properties OpenSSOAgentBootstrap.properties.orig
#tostman sed -e "s/\(com\.sun\.identity\.agents\.config\.organization\.name\s=\s\/\).*$/\1${OPENAM_REALM_KSERVICE}/" OpenSSOAgentBootstrap.properties.orig > OpenSSOAgentBootstrap.properties

popd
################################################################
# Install opendj
################################################################
if ${WITH_OPENDJ}
then
  pushd ${TMP_DIR}

  if [ ! -f downloads/${OPENDJ_ZIP} ]
  then
       curl -o downloads/${OPENDJ_ZIP} ${OPENDJ_URL}
  fi

  unzip -d $CONTAINER_ROOT downloads/${OPENDJ_ZIP} && cd $CONTAINER_ROOT/opendj

  ./setup --cli --propertiesFilePath $OPENDJ_SETUP_PROPERTIES --acceptLicense --no-prompt

  popd
fi

################################################################
# prepare a directory for hippo jcr
################################################################
mkdir -p ${CONTENT_ROOT}
