package org.inherit.service.rest.server;

import java.util.List;
import java.util.logging.Logger;

import org.inherit.service.common.domain.ProcessInstanceListItem;
import org.inherit.service.common.util.ParameterEncoder;
import org.inherit.taskform.engine.TaskFormService;
import org.restlet.resource.Post;
import org.restlet.resource.ServerResource;


public class StatusByUserId extends ServerResource {

	public static final Logger log = Logger.getLogger(StatusByUserId.class.getName());
	
	TaskFormService engine = new TaskFormService();
	
	@Post
	public List<ProcessInstanceListItem> getUserInstancesList() {
		String userid = ParameterEncoder.decode((String)getRequestAttributes().get("userid"));
		
		log.fine("REST getUserInstancesList with parameter userid=[" + userid + "]" );
		
		return engine.getUserInstancesList(userid);
	}
}
