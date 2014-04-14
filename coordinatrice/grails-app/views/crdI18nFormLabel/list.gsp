<%@ page import="org.motrice.coordinatrice.CrdI18nFormLabel" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main"/>
      <g:set var="entityName" value="${message(code: 'crdI18nFormLabel.label', default: 'CrdI18nFormLabel')}" />
      <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    <a href="#list-crdI18nFormLabel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <div id="list-crdI18nFormLabel" class="content scaffold-list" role="main">
      <h1><g:message code="default.list.label" args="[entityName]" /></h1>
      <g:if test="${flash.message}">
	<div class="message" role="status">${flash.message}</div>
      </g:if>
      <table>
	<thead>
	  <tr>
	    <g:sortableColumn property="formdefPath" title="${message(code: 'crdI18nFormLabel.formdefPath.label', default: 'Formdef Path')}" />
	    <g:sortableColumn property="formdefVer" title="${message(code: 'crdI18nFormLabel.formdefVer.label', default: 'Formdef Ver')}" />
	    <g:sortableColumn property="label" title="${message(code: 'crdI18nFormLabel.label.label', default: 'Label')}" />
	    <g:sortableColumn property="locale" title="${message(code: 'crdI18nFormLabel.locale.label', default: 'Locale')}" />
	  </tr>
	</thead>
	<tbody>
	  <g:each in="${crdI18nFormLabelInstList}" status="i" var="crdI18nFormLabelInst">
	    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
	      <td><g:link action="show" id="${crdI18nFormLabelInst.id}">${crdI18nFormLabelInst?.formdef?.path}</g:link></td>
	      <td>${fieldValue(bean: crdI18nFormLabelInst, field: "formdefVer")}</td>
	      <td>${fieldValue(bean: crdI18nFormLabelInst, field: "label")}</td>
	      <td>${fieldValue(bean: crdI18nFormLabelInst, field: "locale")}</td>
	    </tr>
	  </g:each>
	</tbody>
      </table>
      <div class="pagination">
	<g:paginate total="${crdI18nFormLabelInstTotal}" />
      </div>
    </div>
  </body>
</html>