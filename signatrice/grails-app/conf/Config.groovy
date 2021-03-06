// Custom logic to control config file from command line or environment
def ENV_VAR1 = 'SIGNATRICE_CONF'
def ENV_VAR2 = 'MOTRICE_CONF'
def FILENAME = '/usr/local/etc/motrice/motrice.properties'
def CONFPROP1 = System.getProperty(ENV_VAR1)
def CONFENV1 = System.getenv(ENV_VAR1)
def CONFPROP2 = System.getProperty(ENV_VAR2)
def CONFENV2 = System.getenv(ENV_VAR2)

if (!grails.config.locations || !(grails.config.locations instanceof List)) grails.config.locations = []

if (CONFPROP1) {
  println "--- Signatrice CONFIG: Command line specified ${CONFPROP1}"
  FILENAME = CONFPROP1
} else if (CONFENV1) {
  println "--- Signatrice CONFIG: Environment specified ${CONFENV1}"
  FILENAME = CONFENV1
} else if (CONFPROP2) {
  println "--- Signatrice CONFIG: Command line specified ${CONFPROP2}"
  FILENAME = CONFPROP2
} else if (CONFENV2) {
  println "--- Signatrice CONFIG: Environment specified ${CONFENV2}"
  FILENAME = CONFENV2
} else {
  println "--- Signatrice CONFIG: Default ${FILENAME}"
}

grails.config.locations << "file:${FILENAME}"

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [
    all:           '*/*',
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Inst'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

environments {
    development {
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
    }
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'

	   debug 'grails.app.controllers', 'grails.app.jobs', 'org.motrice.signatrice.SignService', 'org.motrice.signatrice.audit.AuditService'
}
