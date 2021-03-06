<%@ page import="org.motrice.signatrice.SigScheme" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
      <g:set var="entityName" value="${message(code: 'sigScheme.label', default: 'SigScheme')}" />
      <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    <a href="#list-sigScheme" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <div id="list-sigScheme" class="content scaffold-list" role="main">
      <h1><g:message code="default.list.label" args="[entityName]" /></h1>
      <g:if test="${flash.message}">
	<div class="message" role="status">${flash.message}</div>
      </g:if>
      <table>
	<thead>
	  <tr>
	    <g:sortableColumn property="name" title="${message(code: 'sigScheme.name.label', default: 'Name')}" />
	    <th><g:message code="sigScheme.service.label" default="Service" /></th>
	    <th><g:message code="sigScheme.displayName.label" default="Display Name" /></th>
	    <th><g:message code="sigScheme.policy.label" default="Policy" /></th>
	    <g:sortableColumn property="dateCreated" title="${message(code: 'sigScheme.dateCreated.label', default: 'Date Created')}" />
	  </tr>
	</thead>
	<tbody>
	  <g:each in="${sigSchemeObjList}" status="i" var="sigSchemeObj">
	    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
	      <td><g:link action="show" id="${sigSchemeObj.id}"><g:fieldValue bean="${sigSchemeObj}" field="flaggedName"/></g:link></td>
	      <td>${sigSchemeObj?.service?.alias}</td>
	      <td>${fieldValue(bean: sigSchemeObj, field: "displayName")}</td>
	      <td>${fieldValue(bean: sigSchemeObj, field: "policy")}</td>
	      <td><g:formatDate date="${sigSchemeObj.dateCreated}" /></td>
	    </tr>
	  </g:each>
	</tbody>
      </table>
      <div class="pagination">
	<g:paginate total="${sigSchemeObjTotal}" />
      </div>
    </div>
  </body>
</html>
