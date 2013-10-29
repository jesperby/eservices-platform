
<%@ page import="org.motrice.coordinatrice.MtfStartFormDefinition" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'mtfStartFormDefinition.label', default: 'MtfStartFormDefinition')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-mtfStartFormDefinition" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-mtfStartFormDefinition" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list mtfStartFormDefinition">
			
				<g:if test="${mtfStartFormDefinitionInst?.authTypeReq}">
				<li class="fieldcontain">
					<span id="authTypeReq-label" class="property-label"><g:message code="mtfStartFormDefinition.authTypeReq.label" default="Auth Type Req" /></span>
					
						<span class="property-value" aria-labelledby="authTypeReq-label"><g:fieldValue bean="${mtfStartFormDefinitionInst}" field="authTypeReq"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mtfStartFormDefinitionInst?.formPath}">
				<li class="fieldcontain">
					<span id="formPath-label" class="property-label"><g:message code="mtfStartFormDefinition.formPath.label" default="Form Path" /></span>
					
						<span class="property-value" aria-labelledby="formPath-label"><g:fieldValue bean="${mtfStartFormDefinitionInst}" field="formPath"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mtfStartFormDefinitionInst?.processDefinitionUuid}">
				<li class="fieldcontain">
					<span id="processDefinitionUuid-label" class="property-label"><g:message code="mtfStartFormDefinition.processDefinitionUuid.label" default="Process Definition Uuid" /></span>
					
						<span class="property-value" aria-labelledby="processDefinitionUuid-label"><g:fieldValue bean="${mtfStartFormDefinitionInst}" field="processDefinitionUuid"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mtfStartFormDefinitionInst?.userDataXpath}">
				<li class="fieldcontain">
					<span id="userDataXpath-label" class="property-label"><g:message code="mtfStartFormDefinition.userDataXpath.label" default="User Data Xpath" /></span>
					
						<span class="property-value" aria-labelledby="userDataXpath-label"><g:fieldValue bean="${mtfStartFormDefinitionInst}" field="userDataXpath"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mtfStartFormDefinitionInst?.activityFormDefs}">
				<li class="fieldcontain">
					<span id="activityFormDefs-label" class="property-label"><g:message code="mtfStartFormDefinition.activityFormDefs.label" default="Activity Form Defs" /></span>
					
						<g:each in="${mtfStartFormDefinitionInst.activityFormDefs}" var="a">
						<span class="property-value" aria-labelledby="activityFormDefs-label"><g:link controller="mtfActivityFormDefinition" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${mtfStartFormDefinitionInst?.activityFormInst}">
				<li class="fieldcontain">
					<span id="activityFormInst-label" class="property-label"><g:message code="mtfStartFormDefinition.activityFormInst.label" default="Activity Form Inst" /></span>
					
						<g:each in="${mtfStartFormDefinitionInst.activityFormInst}" var="a">
						<span class="property-value" aria-labelledby="activityFormInst-label"><g:link controller="mtfProcessActivityFormInstance" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${mtfStartFormDefinitionInst?.id}" />
					<g:link class="edit" action="edit" id="${mtfStartFormDefinitionInst?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>