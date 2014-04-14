<%@ page import="org.motrice.coordinatrice.Procdef" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main"/>
      <g:set var="entityName" value="${message(code: 'procdef.label', default: 'Procdef')}" />
      <title><g:message code="procdef.edit.state.label" args="[entityName]" /></title>
  </head>
  <body>
    <a href="#edit-procdef" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <div id="edit-procdef" class="content scaffold-edit" role="main">
      <h1><g:message code="procdef.edit.state.label" args="[entityName]" /></h1>
      <g:if test="${flash.message}">
	<div class="message" role="status">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${procdefInst}">
	<ul class="errors" role="alert">
	  <g:eachError bean="${procdefInst}" var="error">
	    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
	  </g:eachError>
	</ul>
      </g:hasErrors>
      <g:form method="post" action="update">
	<g:hiddenField name="id" value="${procdefInst?.uuid}" />
	<fieldset class="form">
	  <g:render template="state"/>
	</fieldset>
	<fieldset class="buttons">
	  <g:actionSubmit class="save" action="updatestate" value="${message(code: 'default.button.update.label', default: 'Save')}" />
	  <g:actionSubmit class="show" action="show" value="${message(code: 'procdef.show.label', default: 'Show')}" />
	</fieldset>
      </g:form>
    </div>
  </body>
</html>