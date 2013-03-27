package org.inherit.service.rest.server;

import java.util.List;
import java.util.logging.Logger;

import org.inherit.service.common.domain.ProcessInstanceListItem;
import org.inherit.service.common.util.ParameterEncoder;
import org.inherit.taskform.engine.TaskFormService;
import org.restlet.resource.Post;
import org.restlet.resource.ServerResource;


public class SearchProcessInstancesByTagValue extends ServerResource {

	public static final Logger log = Logger.getLogger(SearchProcessInstancesByTagValue.class.getName());
	
	TaskFormService engine = new TaskFormService();
	
	@Post
	public List<ProcessInstanceListItem> searchProcessInstancesByTagValue() {
		String tagValue = ParameterEncoder.decode((String)getRequestAttributes().get("tagValue"));
		
		log.fine("REST SearchProcessInstancesByTagValue with parameter tagValue=[" + tagValue + "]" );
		
		return engine.getProcessInstancesListByTag(tagValue);
	}
}