package org.inherit.service.rest.server;

import org.inherit.service.common.util.ParameterEncoder;
import org.inherit.taskform.engine.TaskFormService;
import org.restlet.resource.Post;
import org.restlet.resource.ServerResource;

public class DeleteTagByValue extends ServerResource {
	TaskFormService engine = new TaskFormService();
	
	@Post
	public boolean addComment() {
		String processInstanceUuid = ParameterEncoder.decode((String)getRequestAttributes().get("processInstanceUuid"));
		String value = ParameterEncoder.decode((String)getRequestAttributes().get("value"));
		String userId = ParameterEncoder.decode((String)getRequestAttributes().get("userid"));
		
		boolean result = engine.deleteTag(processInstanceUuid, value, userId);
		
		return result;
	}
}