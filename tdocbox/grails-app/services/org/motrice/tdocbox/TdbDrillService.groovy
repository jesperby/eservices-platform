package org.motrice.tdocbox

import com.budjb.requestbuilder.RequestBuilder
import com.budjb.requestbuilder.ResponseStatusException

/**
 * Service for invoking the REST methods of DocBox.
 */
class TdbDrillService {
  // All methods are transactional (actually the default)
  static transactional = true

  TdbCase perform(TdbSuite suite, TdbDrill drill, TdbCase cs) {
    if (log.debugEnabled) log.debug "perform << ${drill?.debug}"
    def urlString = TdbMethod.createUrl(drill, cs)
    if (log.debugEnabled) log.debug "HTTP ${drill?.verb} [[ ${urlString}"

    // In this case we do not use the pretty DSL format.
    def builder = new RequestBuilder()
    builder.uri = urlString
    // Configure relative the invocation mode
    builder = modeConfig(builder, drill)

    try {
      cs = doPerform(builder, suite, drill, cs)
    } catch (ResponseStatusException exc) {
      if (log.debugEnabled) log.debug "HTTP ${exc.status} ]] ${exc.content}"
      cs = suite.createCase(cs)
      cs.addTextItem("${drill.name}_exception", exc.message, true)
      cs.addTextItem("${drill.name}_result", exc.content)
      cs.save()
    } catch (Exception exc) {
      if (log.debugEnabled) log.debug "HTTP EXC ]] ${exc}"
      cs = suite.createCase(cs)
      cs.addTextItem("${drill.name}_exception", exc.message, true)
      cs.save()
    }

    if (log.debugEnabled) log.debug "perform >> ${cs}"
    return cs
  }

  private RequestBuilder modeConfig(RequestBuilder builder, TdbDrill drill) {
    switch (drill.mode.id) {
    case TdbMode.PARSE_MODE_ID:
    // Default configuration
    break
    case TdbMode.TEXT_MODE_ID:
      // Do not parse JSON or XML
      builder.convertJson = false
      builder.convertXML = false
    break
    case TdbMode.BINARY_MODE_ID:
      // This option overrides the parsing options
      builder.binaryResponse = true
    break
    default:
      def msg = "Drill contains invalid mode ${drill?.mode?.id}"
      throw new ServiceException(msg)
    }

    return builder
  }

  private TdbCase doPerform(RequestBuilder builder,
			    TdbSuite suite, TdbDrill drill, TdbCase cs)
  {
    def result = null

    // Perform the invocation
    switch (drill.verb.id) {
    case TdbHttpVerb.GET_ID:
      result = builder.get()
    break
    case TdbHttpVerb.PUT_ID:
      result = builder.put()
    break
    case TdbHttpVerb.POST_ID:
      builder.body = drill.body
      result = builder.post()
    break
    default:
    def msg = "Drill contains invalid verb ${drill?.verb?.id}"
    throw new ServiceException(msg)
    }

    // Pick up the result
    String msg = null
    switch (drill.mode.id) {
    case TdbMode.PARSE_MODE_ID:
      msg = "${result?.size()} entries"
      cs = storeTextResultMap(suite, drill, cs, result)
    break
    case TdbMode.TEXT_MODE_ID:
      cs = suite.createCase(cs)
      msg = "${result.size()} characters"
      cs.addTextItem("${drill.name}_result", result)
      cs.save()
    break
    case TdbMode.BINARY_MODE_ID:
      cs = suite.createCase(cs)
      msg = "${result.size()} bytes"
      cs.addBinaryItem("${drill.name}_result", result)
      cs.save()
    break
    default:
      msg = "Drill contains invalid mode ${drill?.mode?.id}"
      throw new ServiceException(msg)
    }

    if (log.debugEnabled) log.debug "perform ]] ${msg}"
    return cs
  }

  private storeTextResultMap(TdbSuite suite, TdbDrill drill, TdbCase cs, result) {
    cs = suite.createCase(cs)
    result.each {entry ->
      String name = "${drill.name}_${entry.key}"
      cs.addTextItem(name, entry.value as String)
    }

    cs.save()
  }

}
