<%@ page import="org.motrice.coordinatrice.pxd.PxdFormdefVer" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main"/>
      <g:set var="entityName" value="${message(code: 'pxdFormdefVer.label', default: 'PxdFormdefVer')}" />
      <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
    <a href="#show-pxdFormdefVer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <div class="nav" role="navigation">
      <ul>
	<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
	<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
      </ul>
    </div>
    <div id="show-pxdFormdefVer" class="content scaffold-show" role="main">
      <h1><g:message code="default.show.label" args="[entityName]" /></h1>
      <g:if test="${flash.message}">
	<div class="message" role="status">${flash.message}</div>
      </g:if>
      <ol class="property-list pxdFormdefVer">
	<g:if test="${pxdFormdefVerInst?.path}">
	  <li class="fieldcontain">
	    <span id="path-label" class="property-label"><g:message code="pxdFormdefVer.path.label" default="Path" /></span>
	    <span class="property-value" aria-labelledby="path-label"><g:fieldValue bean="${pxdFormdefVerInst}" field="path"/></span>
	  </li>
	</g:if>
	<g:if test="${pxdFormdefVerInst?.title}">
	  <li class="fieldcontain">
	    <span id="title-label" class="property-label"><g:message code="pxdFormdefVer.title.label" default="Title" /></span>
	    <span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${pxdFormdefVerInst}" field="title"/></span>
	  </li>
	</g:if>
	<g:if test="${pxdFormdefVerInst?.appName}">
	  <li class="fieldcontain">
	    <span id="appName-label" class="property-label"><g:message code="pxdFormdefVer.appName.label" default="App Name" /></span>
	    <span class="property-value" aria-labelledby="appName-label"><g:fieldValue bean="${pxdFormdefVerInst}" field="appName"/></span>
	  </li>
	</g:if>
	<g:if test="${pxdFormdefVerInst?.formName}">
	  <li class="fieldcontain">
	    <span id="formName-label" class="property-label"><g:message code="pxdFormdefVer.formName.label" default="Form Name" /></span>
	    <span class="property-value" aria-labelledby="formName-label"><g:fieldValue bean="${pxdFormdefVerInst}" field="formName"/></span>
	  </li>
	</g:if>
	<g:if test="${pxdFormdefVerInst?.fvno}">
	  <li class="fieldcontain">
	    <span id="fvno-label" class="property-label"><g:message code="pxdFormdefVer.fvno.label" default="Fvno" /></span>
	    <span class="property-value" aria-labelledby="fvno-label"><g:fieldValue bean="${pxdFormdefVerInst}" field="fvno"/></span>
	  </li>
	</g:if>
	<g:if test="${pxdFormdefVerInst?.draft && pxdFormdefVerInst.draft < 9999}">
	  <li class="fieldcontain">
	    <span id="draft-label" class="property-label"><g:message code="pxdFormdefVer.draft.label" default="Draft" /></span>
	    <span class="property-value" aria-labelledby="draft-label"><g:fieldValue bean="${pxdFormdefVerInst}" field="draft"/></span>
	  </li>
	</g:if>
	<g:if test="${pxdFormdefVerInst?.description}">
	  <li class="fieldcontain">
	    <span id="description-label" class="property-label"><g:message code="pxdFormdefVer.description.label" default="Description" /></span>
	    <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${pxdFormdefVerInst}" field="description"/></span>
	  </li>
	</g:if>
	<g:if test="${pxdFormdefVerInst?.language}">
	  <li class="fieldcontain">
	    <span id="language-label" class="property-label"><g:message code="pxdFormdefVer.language.label" default="Language" /></span>
	    <span class="property-value" aria-labelledby="language-label"><g:fieldValue bean="${pxdFormdefVerInst}" field="language"/></span>
	  </li>
	</g:if>
	<g:if test="${pxdFormdefVerInst?.formdef}">
	  <li class="fieldcontain">
	    <span id="formdef-label" class="property-label"><g:message code="pxdFormdefVer.formdef.label" default="Formdef" /></span>
	    <span class="property-value" aria-labelledby="formdef-label"><g:link controller="pxdFormdef" action="show" id="${pxdFormdefVerInst?.formdef?.id}">${pxdFormdefVerInst?.formdef?.encodeAsHTML()}</g:link></span>
	  </li>
	</g:if>
	
      </ol>
      <g:form>
	<fieldset class="buttons">
	  <g:hiddenField name="id" value="${pxdFormdefVerInst?.id}" />
	</fieldset>
      </g:form>
    </div>
  </body>
</html>
