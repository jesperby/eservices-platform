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
<%@ page import="org.motrice.docbox.doc.BoxDocStep" %>



<div class="fieldcontain ${hasErrors(bean: boxDocStepObj, field: 'step', 'error')} required">
	<label for="step">
		<g:message code="boxDocStep.step.label" default="Step" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="step" from="${0..999}" class="range" required="" value="${fieldValue(bean: boxDocStepObj, field: 'step')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: boxDocStepObj, field: 'docNo', 'error')} ">
	<label for="docNo">
		<g:message code="boxDocStep.docNo.label" default="Doc No" />
		
	</label>
	<g:textField name="docNo" maxlength="16" value="${boxDocStepObj?.docNo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: boxDocStepObj, field: 'signCount', 'error')} required">
	<label for="signCount">
		<g:message code="boxDocStep.signCount.label" default="Sign Count" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="signCount" from="${0..12}" class="range" required="" value="${fieldValue(bean: boxDocStepObj, field: 'signCount')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: boxDocStepObj, field: 'contents', 'error')} ">
	<label for="contents">
		<g:message code="boxDocStep.contents.label" default="Contents" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${boxDocStepObj?.contents?}" var="c">
    <li><g:link controller="boxContents" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="boxContents" action="create" params="['boxDocStep.id': boxDocStepObj?.id]">${message(code: 'default.add.label', args: [message(code: 'boxContents.label', default: 'BoxContents')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: boxDocStepObj, field: 'doc', 'error')} required">
	<label for="doc">
		<g:message code="boxDocStep.doc.label" default="Doc" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="doc" name="doc.id" from="${org.motrice.docbox.doc.BoxDoc.list()}" optionKey="id" required="" value="${boxDocStepObj?.doc?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: boxDocStepObj, field: 'docboxRef', 'error')} ">
	<label for="docboxRef">
		<g:message code="boxDocStep.docboxRef.label" default="Docbox Ref" />
		
	</label>
	<g:textField name="docboxRef" value="${boxDocStepObj?.docboxRef}"/>
</div>

