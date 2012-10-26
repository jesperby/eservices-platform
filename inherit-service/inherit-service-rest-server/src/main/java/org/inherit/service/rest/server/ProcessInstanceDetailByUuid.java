package org.inherit.service.rest.server;

import java.util.logging.Logger;

import org.inherit.bonita.client.BonitaEngineServiceImpl;
import org.inherit.service.common.domain.ProcessInstanceDetails;
import org.inherit.service.common.util.ParameterEncoder;
import org.restlet.resource.Post;
import org.restlet.resource.ServerResource;


public class ProcessInstanceDetailByUuid extends ServerResource {

	public static final Logger log = Logger.getLogger(ProcessInstanceDetailByUuid.class.getName());
	
	BonitaEngineServiceImpl engine = new BonitaEngineServiceImpl();
	
	@Post
	public ProcessInstanceDetails getProcessInstanceDetails() {
		String processInstanceUuid = ParameterEncoder.decode((String)getRequestAttributes().get("processInstanceUuid"));
		
		log.fine("REST getProcessInstanceDetails with parameter processInstanceUuid=[" + processInstanceUuid + "]" );
		
		return engine.getProcessInstanceDetails(processInstanceUuid);
	}
}
