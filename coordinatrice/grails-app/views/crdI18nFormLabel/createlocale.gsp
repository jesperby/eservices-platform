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
<%@ page import="org.motrice.coordinatrice.CrdI18nFormLabel" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main"/>
      <g:set var="entityName" value="${message(code: 'crdI18nFormLabel.label', default: 'CrdI18nFormLabel')}" />
      <title><g:message code="default.create.label" args="[entityName]" /></title>
  </head>
  <body>
    <a href="#create-crdI18nFormLabel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <div id="create-crdI18nFormLabel" class="content scaffold-create" role="main">
      <h1><g:message code="crdI18nFormLabel.create.header" /></h1>
      <g:if test="${flash.message}">
	<div class="message" role="status">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${formLabelInst}">
	<ul class="errors" role="alert">
	  <g:eachError bean="${formLabelInst}" var="error">
	    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
	  </g:eachError>
	</ul>
      </g:hasErrors>
      <ol class="property-list crdI18nFormLabel">
	<li class="fieldcontain">
	  <span id="formdefInst-label" class="property-label"><g:message code="crdI18nFormLabel.formdefInst.label" default="Form" /></span>
	  <span class="property-value" aria-labelledby="formdefInst-label">${formdefInst?.path?.encodeAsHTML()}</span>
	</li>
      </ol>
      <g:form action="savelocale" >
	<g:hiddenField name="formdefId" value="${formdefInst?.id}" />
	<fieldset class="form">
	  <div class="fieldcontain ${hasErrors(bean: formLabelInst, field: 'locale', 'error')} ">
	    <label for="locale">
	      <g:message code="crdI18nFormLabel.locale.label" default="Locale" />
	    </label>
	    <g:textField name="locale" maxlength="24" value="${formLabelInst?.locale}"/>
	  </div>
	  <div class="fieldcontain">
	    <label></label>
	    <g:message code="crdI18nFormLabel.create.help1" default="Help 1"/>
	  </div>
	  <div class="fieldcontain">
	    <label></label>
	    <g:message code="crdI18nFormLabel.create.help2" default="Help 2"/>
	  </div>
	</fieldset>
	<fieldset class="buttons">
	  <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
	</fieldset>
      </g:form>
    </div>
  </body>
</html>
