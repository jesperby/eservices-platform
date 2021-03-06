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
 
 
<%@ include file="/WEB-INF/jspf/htmlTags.jspf"%>
<%--@elvariable id="document" type="org.inheritsource.portal.beans.NewsDocument"--%>

<c:choose>
	<c:when test="${empty document}">
		<tag:pagenotfound />
	</c:when>
	<c:otherwise>
		<c:if test="${not empty document.title}">
			<hst:element var="headTitle" name="title">
				<c:out value="${document.title}" />
			</hst:element>
			<hst:headContribution keyHint="headTitle" element="${headTitle}" />
		</c:if>

		<hst:cmseditlink hippobean="${document}" />
		<h2>${document.title}</h2>
		<p>${document.summary}</p>
		<hst:html hippohtml="${document.html}" />

		<table cellpadding="0" cellspacing="0" border="0"
			class="display dataTable">
			<thead>
				<tr>
					<th><fmt:message key="mycases.process.column.lbl" /></th>
					<th><fmt:message key="mycases.diaryNo.lbl" /></th>
					<th><fmt:message key="mycases.startDate.column.lbl" /></th>
					<th><fmt:message key="mycases.expectedEndDate.column.lbl" /></th>
					<th><fmt:message key="mycases.activity.column.lbl" /></th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty tasks}">
						<c:forEach var="task" items="${tasks}">
							<tr>
								<td>${task.processLabel}</td>
								<td>
								<c:if test="${not empty task and not empty task.tags}">
									<c:forEach var="tag" items="${task.tags}">
				        				<c:if test="${not empty tag and tag.typeId eq 1}">
						  					${tag.value}&nbsp;
										</c:if>
				      				</c:forEach>
			      				</c:if>
								</td>
								<td><fmt:formatDate value="${task.activityCreated}"
										type="Both" dateStyle="short" timeStyle="short"/></td>
								<!-- href="form?taskUuid={task.taskUuid}&activityDefinitionUUID={task.activityDefinitionUUID}">{task.activityLabel} -->
								<td><fmt:formatDate value="${task.expectedEndDate}"
										type="Date" dateStyle="short" timeStyle="short"/></td>
								<td><a href="${task.relativePageLink}">${task.activityLabel}</a></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4"><fmt:message key="mycases.noActivity.lbl" /></td>
						</tr>

					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</c:otherwise>
</c:choose>
