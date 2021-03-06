<%-- == Motrice Copyright Notice ==

  Motrice Service Platform

  Copyright (C) 2011-2014 Motrice AB

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU Affero General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with this program. If not, see <http://www.gnu.org/licenses/>.

  e-mail: info _at_ motrice.se
  mail: Motrice AB, Långsjövägen 8, SE-131 33 NACKA, SWEDEN
  phone: +46 8 641 64 14

--%>
<%@ page import="org.motrice.docbox.doc.BoxContents" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
      <g:set var="entityName" value="${message(code: 'boxContents.label', default: 'BoxContents')}" />
      <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
    <a href="#show-boxContents" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <div id="show-boxContents" class="content scaffold-show" role="main">
      <h1><g:message code="default.show.label" args="[entityName]" /></h1>
      <g:if test="${flash.message}">
	<div class="message" role="status">${flash.message}</div>
      </g:if>
      <ol class="property-list boxContents">
	<g:if test="${boxContentsObj?.name}">
	  <li class="fieldcontain">
	    <span id="name-label" class="property-label"><g:message code="boxContents.name.label" default="Name" /></span>
	    <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${boxContentsObj}" field="name"/></span>
	  </li>
	</g:if>
	<g:if test="${boxContentsObj?.dateCreated}">
	  <li class="fieldcontain">
	    <span id="dateCreated-label" class="property-label"><g:message code="boxContents.dateCreated.label" default="Date Created" /></span>
	    <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${boxContentsObj?.dateCreated}" /></span>
	  </li>
	</g:if>
	
	<g:if test="${boxContentsObj?.lastUpdated}">
	  <li class="fieldcontain">
	    <span id="lastUpdated-label" class="property-label"><g:message code="boxContents.lastUpdated.label" default="Last Updated" /></span>
	    <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${boxContentsObj?.lastUpdated}" /></span>
	  </li>
	</g:if>
	<g:if test="${boxContentsObj?.format}">
	  <li class="fieldcontain">
	    <span id="format-label" class="property-label"><g:message code="boxContents.format.label" default="Format" /></span>
	    <span class="property-value" aria-labelledby="format-label"><g:fieldValue bean="${boxContentsObj}" field="format"/></span>
	  </li>
	</g:if>
	<g:if test="${boxContentsObj?.size}">
	  <li class="fieldcontain">
	    <span id="size-label" class="property-label"><g:message code="boxContents.size.label" default="Size" /></span>
	    <span class="property-value" aria-labelledby="size-label"><g:fieldValue bean="${boxContentsObj}" field="size"/></span>
	  </li>
	</g:if>
	<g:if test="${boxContentsObj?.checksum}">
	  <li class="fieldcontain">
	    <span id="checksum-label" class="property-label"><g:message code="boxContents.checksum.label" default="Checksum" /></span>
	    <span class="property-value" aria-labelledby="checksum-label"><g:fieldValue bean="${boxContentsObj}" field="checksum"/></span>
	  </li>
	</g:if>
	<g:if test="${boxContentsObj?.text}">
	  <li class="fieldcontain">
	    <span id="text-label" class="property-label"><g:message code="boxContents.text.label" default="Text" /></span>
	    <span class="property-value" aria-labelledby="text-label"><g:fieldValue bean="${boxContentsObj}" field="text"/></span>
	  </li>
	</g:if>
	<g:if test="${boxContentsObj?.step}">
	  <li class="fieldcontain">
	    <span id="step-label" class="property-label"><g:message code="boxContents.step.label" default="Step" /></span>
	    <span class="property-value" aria-labelledby="step-label"><g:link controller="boxDocStep" action="show" id="${boxContentsObj?.step?.id}">${boxContentsObj?.step?.display()?.encodeAsHTML()}</g:link></span>
	  </li>
	</g:if>
      </ol>
      <g:form>
	<fieldset class="buttons">
	  <g:hiddenField name="id" value="${boxContentsObj?.id}" />
	  <g:link class="download" action="downloadContent" id="${boxContentsObj?.id}">
	    <g:message code="default.button.download.label" default="Download" /></g:link>
	  <g:link class="edit" action="edit" id="${boxContentsObj?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
	  <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
	</fieldset>
      </g:form>
    </div>
  </body>
</html>
