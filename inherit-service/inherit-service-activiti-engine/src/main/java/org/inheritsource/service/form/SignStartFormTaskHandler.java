/* == Motrice Copyright Notice == 
 * 
 * Motrice Service Platform 
 * 
 * Copyright (C) 2011-2014 Motrice AB 
 * 
 * This program is free software: you can redistribute it and/or modify 
 * it under the terms of the GNU Affero General Public License as published by 
 * the Free Software Foundation, either version 3 of the License, or 
 * (at your option) any later version. 
 * 
 * This program is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
 * GNU Affero General Public License for more details. 
 * 
 * You should have received a copy of the GNU Affero General Public License 
 * along with this program. If not, see <http://www.gnu.org/licenses/>. 
 * 
 * e-mail: info _at_ motrice.se 
 * mail: Motrice AB, Långsjövägen 8, SE-131 33 NACKA, SWEDEN 
 * phone: +46 8 641 64 14 
 
 */ 
 
package org.inheritsource.service.form;

import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.task.Task;
import org.inheritsource.service.common.domain.FormInstance;
import org.inheritsource.taskform.engine.persistence.entity.ActivityFormDefinition;

public class SignStartFormTaskHandler extends TaskFormHandler {

	public static final String PAGE = "signform";
	
	@Override
	public FormInstance getPendingFormInstance(FormInstance form, Task task,
			String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public FormInstance initializeFormInstance(
			ActivityFormDefinition activityFormDefinition, Task task,
			String userId, FormInstance initialInstance) {
		FormInstance form = initialInstance;
		/*
		// generate a type 4 UUID
		String docId = java.util.UUID.randomUUID().toString();

		form.setPage(PAGE);

		String docBoxRef = 
		
		// initialize local task variables, will be stored by FormEngine
		form.setInstanceId(docId);
		form.setTypeId(activityFormDefinition.getFormTypeId());
		form.setDefinitionKey(activityFormDefinition.getFormConnectionKey());
		form.setActUri(null);
		form.setDataUri(orbeonDataBaseUri + form.getDefinitionKey() + "/data/" + form.getInstanceId() + ".xml");
		
		// submitted is default to not submitted
		
		calcUris(form);
				*/
		return form;
	}

	@Override
	public FormInstance initializeStartFormInstance(Long formTypeId,
			String formConnectionKey, String userId,
			FormInstance initialInstance) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public FormInstance getHistoricFormInstance(FormInstance form,
			HistoricTaskInstance historicTask, String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public FormInstance getHistoricStartFormInstance(FormInstance startForm,
			HistoricProcessInstance historicProcessInstance, String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public FormInstance validateSubmit(FormInstance form, Task task,
			String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public FormInstance afterSubmit(FormInstance form, Task task, String userId) {
		// TODO Auto-generated method stub
		return null;
	}

}
