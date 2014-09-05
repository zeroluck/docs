# Gluu Sever Tomcat Configuration

Below is the server.xml template file we use for Gluu Community

    <?xml version='1.0' encoding='utf-8'?>
    <!--
      Licensed to the Apache Software Foundation (ASF) under one or more
      contributor license agreements.  See the NOTICE file distributed with
      this work for additional information regarding copyright ownership.
      The ASF licenses this file to You under the Apache License, Version 2.0
      (the "License"); you may not use this file except in compliance with
      the License.  You may obtain a copy of the License at
    
          http://www.apache.org/licenses/LICENSE-2.0
    
      Unless required by applicable law or agreed to in writing, software
      distributed under the License is distributed on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      See the License for the specific language governing permissions and
      limitations under the License.
    -->
    <!-- Note:  A "Server" is not itself a "Container", so you may not
         define subcomponents such as "Valves" at this level.
         Documentation at /docs/config/server.html
     -->
    <Server port="8005" shutdown="SHUTDOWN">
      <!-- Security listener. Documentation at /docs/config/listeners.html
      <Listener className="org.apache.catalina.security.SecurityListener" />
      -->
      <!--APR library loader. Documentation at /docs/apr.html -->
      <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
      <!--Initialize Jasper prior to webapps are loaded. Documentation at /docs/jasper-howto.html -->
      <Listener className="org.apache.catalina.core.JasperListener" />
      <!-- Prevent memory leaks due to use of particular java/javax APIs-->
      <Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
      <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
      <Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />
    
      <!-- Global JNDI resources
           Documentation at /docs/jndi-resources-howto.html
      -->
      <GlobalNamingResources>
        <!-- Editable user database that can also be used by
             UserDatabaseRealm to authenticate users
        -->
        <Resource name="UserDatabase" auth="Container"
                  type="org.apache.catalina.UserDatabase"
                  description="User database that can be updated and saved"
                  factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
                  pathname="conf/tomcat-users.xml" />
      </GlobalNamingResources>
    
      <!-- A "Service" is a collection of one or more "Connectors" that share
           a single "Container" Note:  A "Service" is not itself a "Container",
           so you may not define subcomponents such as "Valves" at this level.
           Documentation at /docs/config/service.html
       -->
      <Service name="Catalina">
    
        <!--The connectors can use a shared executor, you can define one or more named thread pools-->
        <!--
        <Executor name="tomcatThreadPool" namePrefix="catalina-exec-"
            maxThreads="150" minSpareThreads="4"/>
        -->
    
    
        <!-- A "Connector" represents an endpoint by which requests are received
             and responses are returned. Documentation at :
             Java HTTP Connector: /docs/config/http.html (blocking & non-blocking)
             Java AJP  Connector: /docs/config/ajp.html
             APR (HTTP/AJP) Connector: /docs/apr.html
             Define a non-SSL HTTP/1.1 Connector on port 8080
        -->
        <Connector port="8080" protocol="HTTP/1.1"
                   connectionTimeout="20000"
                   redirectPort="8443" />
        <!-- A "Connector" using the shared thread pool-->
        <!--
        <Connector executor="tomcatThreadPool"
                   port="8080" protocol="HTTP/1.1"
                   connectionTimeout="20000"
                   redirectPort="8443" />
        -->
        <!-- Define a SSL HTTP/1.1 Connector on port 8443
             This connector uses the JSSE configuration, when using APR, the
             connector should be using the OpenSSL style configuration
             described in the APR documentation -->
        <!--
        <Connector port="8443" protocol="HTTP/1.1" SSLEnabled="true"
                   maxThreads="150" scheme="https" secure="true"
                   clientAuth="false" sslProtocol="TLS" />
        -->
    
      <Connector port="8443" address="%(ip)s"
    	protocol="HTTP/1.1" scheme="https" secure="true"
    	clientAuth="false" sslProtocol="TLS" SSLEnabled="true"
    	keystoreFile="/etc/certs/%(inumOrgFN)s-java.jks"
    	keystoreType="JKS" keystorePass="5wf8hk5!"
    	truststoreFile="/etc/certs/%(inumOrgFN)s-java.jks"
    	truststorePass="%(jksPass)s" truststoreType="JKS"
    	truststoreAlgorithm="DelegateToApplication" />
    
      <Connector port="9443" address="%(ip)s"
    	protocol="org.apache.coyote.http11.Http11Protocol"
    	SSLImplementation="edu.internet2.middleware.security.tomcat6.DelegateToApplicationJSSEImplementation"
    	scheme="https"
    	SSLEnabled="true"
    	clientAuth="true"
    	keystoreFile="/etc/certs/%(inumOrgFN)s-java.jks"
    	keystorePass="%(jksPass)s" />
    
        <!-- Define an AJP 1.3 Connector on port 8009 -->
      <Connector port="8009" address="%(ip)s" protocol="AJP/1.3"
    	redirectPort="8443" tomcatAuthentication="false" />
    
    
        <!-- An Engine represents the entry point (within Catalina) that processes
             every request.  The Engine implementation for Tomcat stand alone
             analyzes the HTTP headers included with the request, and passes them
             on to the appropriate Host (virtual host).
             Documentation at /docs/config/engine.html -->
    
        <!-- You should set jvmRoute to support load-balancing via AJP ie :
        <Engine name="Catalina" defaultHost="localhost" jvmRoute="jvm1">
        -->
        <Engine name="Catalina" defaultHost="localhost">
    
          <!--For clustering, please take a look at documentation at:
              /docs/cluster-howto.html  (simple how to)
              /docs/config/cluster.html (reference documentation) -->
          <!--
          <Cluster className="org.apache.catalina.ha.tcp.SimpleTcpCluster"/>
          -->
    
          <!-- Use the LockOutRealm to prevent attempts to guess user passwords
               via a brute-force attack -->
          <Realm className="org.apache.catalina.realm.LockOutRealm">
            <!-- This Realm uses the UserDatabase configured in the global JNDI
                 resources under the key "UserDatabase".  Any edits
                 that are performed against this UserDatabase are immediately
                 available for use by the Realm.  -->
            <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
                   resourceName="UserDatabase"/>
          </Realm>
    
          <Host name="localhost"  appBase="webapps"
    	unpackWARs="true" autoDeploy="false"
    	xmlValidation="false" xmlNamespaceAware="false">
    
    
    
            <!-- SingleSignOn valve, share authentication between web applications
                 Documentation at: /docs/config/valve.html -->
            <!--
            <Valve className="org.apache.catalina.authenticator.SingleSignOn" />
            -->
    
            <!-- Access log processes all example.
                 Documentation at: /docs/config/valve.html
                 Note: The pattern used is equivalent to using pattern="common" -->
    	<!--
            <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
                   prefix="localhost_access_log." suffix=".txt"
                   pattern="%%h %%l %%u %%t &quot;%%r&quot; %%s %%b" />
            -->
    
          </Host>
        </Engine>
      </Service>
    </Server>
    
    
   
## Tanuki Wrapper File

See [Tanuki Software](http://www.tanukisoftware.com/en/wrapper.php) Below is the 
template we use for Gluu Server Community Edition.

    
    ##### Part 1 Starts #####
    
    #encoding=UTF-8
    # Configuration files must begin with a line specifying the encoding
    #  of the the file.
    
    #********************************************************************
    # Wrapper License Properties (Ignored by Community Edition)
    #********************************************************************
    # Professional and Standard Editions of the Wrapper require a valid
    #  License Key to start.  Licenses can be purchased or a trial license
    #  requested on the following pages:
    # http://wrapper.tanukisoftware.com/purchase
    # http://wrapper.tanukisoftware.com/trial
    
    # Include file problems can be debugged by removing the first '#'
    #  from the following line:
    ##include.debug
    
    # The Wrapper will look for either of the following optional files for a
    #  valid License Key.  License Key properties can optionally be included
    #  directly in this configuration file.
    #include ../conf/wrapper-license.conf
    #include ../conf/wrapper-license-%%WRAPPER_HOST_NAME%%.conf
    
    # The following property will output information about which License Key(s)
    #  are being found, and can aid in resolving any licensing problems.
    #wrapper.license.debug=TRUE
    
    #********************************************************************
    # Wrapper Localization
    #********************************************************************
    # Specify the locale which the Wrapper should use.  By default the system
    #  locale is used.
    #wrapper.lang=en_US # en_US or ja_JP
    
    # Specify the location of the Wrapper's language resources.  If these are
    #  missing, the Wrapper will default to the en_US locale.
    #wrapper.lang.folder=../lang
    
    #********************************************************************
    # Wrapper Java Properties
    #********************************************************************
    # Java Application
    #  Locate the java binary on the system PATH:
    wrapper.java.command=java
    #  Specify a specific java binary:
    #set.JAVA_HOME=/java/path
    wrapper.java.command=/usr/java/latest/bin/java
    
    ##### Part 1 Ends #####
    
    
    ###### Part 2 Starts #####
    
    ###Custom python for Duo module
    set.PYTHON_HOME=/opt/jython 
    
    ##### Part 2 Ends #####
    
    
    ##### Part 3 Starts #####
    
    # Tell the Wrapper to log the full generated Java command line.
    #wrapper.java.command.loglevel=INFO
    
    # Java Main class.  This class must implement the WrapperListener interface
    #  or guarantee that the WrapperManager class is initialized.  Helper
    #  classes are provided to do this for you.  See the Integration section
    #  of the documentation for details.
    wrapper.java.mainclass=org.tanukisoftware.wrapper.WrapperStartStopApp
    
    # Java Classpath (include wrapper.jar)  Add class path elements as
    #  needed starting from 1
    wrapper.java.classpath.1=/opt/wrapper/lib/wrapper.jar
    wrapper.java.classpath.2=/opt/tomcat/bin/bootstrap.jar
    
    ##### Part 3 Ends #####
    
    
    ##### Part 4 Starts #####
    
    wrapper.java.classpath.3=/opt/tomcat/bin/tomcat-juli.jar
    
    ##### Part 4 Ends #####
    
    ##### Part 5 Starts #####
    
    # Java Library Path (location of Wrapper.DLL or libwrapper.so)
    wrapper.java.library.path.1=/opt/tomcat/lib
    wrapper.java.library.path.2=/opt/wrapper/lib
    #
    # # Java Bits.  On applicable platforms, tells the JVM to run in 32 or 64-bit mode.
    wrapper.java.additional.auto_bits=TRUE
    #
    # Java Additional Parameters
    wrapper.java.additional.1=-Djava.util.logging.config.file=/opt/tomcat/conf/logging.properties
    wrapper.java.additional.2=-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
    wrapper.java.additional.3=-Djava.endorsed.dirs=/opt/tomcat/endorsed
    wrapper.java.additional.4=-Dcatalina.base=/opt/tomcat
    wrapper.java.additional.5=-Dcatalina.home=/opt/tomcat
    wrapper.java.additional.6=-Djava.io.tmpdir=/opt/tomcat/temp
    wrapper.java.additional.7=-Djavax.net.ssl.trustStore=%(certFolder)s/%(inumOrgFN)s-java.jks
    wrapper.java.additional.8=-Djavax.net.ssl.trustStorePassword=%(jksPass)s
    wrapper.java.additional.9=-Xdebug
    wrapper.java.additional.10=-Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n
    
    ##### Part 5 Ends #####
    
    
    ##### Part 6 Starts #####
    
    wrapper.java.additional.11=-XX:PermSize=128m
    wrapper.java.additional.12=-XX:MaxPermSize=256m
    
    # Initial Java Heap Size (in MB)
    wrapper.java.initmemory=64
    
    # Maximum Java Heap Size (in MB)
    wrapper.java.maxmemory=2048
    
    ##### Part 6 Ends #####
    
    
    ##### Part 7 Starts #####
    
    # The first application parameter is the name of the class whose main
    # method is to be called when the application is launched.  The class
    # name is followed by the number of parameters to be passed to its main
    # method.  Then comes the actual parameters.
    wrapper.app.parameter.1=org.apache.catalina.startup.Bootstrap
    wrapper.app.parameter.2=1
    wrapper.app.parameter.3=start
    
    # The start parameters are followed by the name of the class whose main
    # method is to be called to stop the application.  The stop class name
    # is followed by a flag which controls whether or not the Wrapper should
    # wait for all non daemon threads to complete before exiting the JVM.
    # The flag is followed by the number of parameters to be passed to the
    # stop class's main method.  Finally comes the actual parameters.
    wrapper.app.parameter.4=org.apache.catalina.startup.Bootstrap
    wrapper.app.parameter.5=TRUE
    wrapper.app.parameter.6=1
    wrapper.app.parameter.7=stop
    
    #********************************************************************
    # Wrapper Logging Properties
    #********************************************************************
    # Enables Debug output from the Wrapper.
    # wrapper.debug=TRUE
    
    # Format of output for the console.  (See docs for formats)
    wrapper.console.format=PM
    
    # Log Level for console output.  (See docs for log levels)
    wrapper.console.loglevel=INFO
    
    # Log file to use for wrapper output logging.
    wrapper.logfile=/opt/tomcat/logs/wrapper.log
    
    # Format of output for the log file.  (See docs for formats)
    wrapper.logfile.format=LPTM
    
    # Log Level for log file output.  (See docs for log levels)
    wrapper.logfile.loglevel=INFO
    
    # Maximum size that the log file will be allowed to grow to before
    #  the log is rolled. Size is specified in bytes.  The default value
    #  of 0, disables log rolling.  May abbreviate with the 'k' (kb) or
    #  'm' (mb) suffix.  For example: 10m = 10 megabytes.
    wrapper.logfile.maxsize=0
    
    # Maximum number of rolled log files which will be allowed before old
    #  files are deleted.  The default value of 0 implies no limit.
    wrapper.logfile.maxfiles=0
    
    # Log Level for sys/event log output.  (See docs for log levels)
    wrapper.syslog.loglevel=NONE
    
    #********************************************************************
    # Wrapper General Properties
    #********************************************************************
    # Allow for the use of non-contiguous numbered properties
    wrapper.ignore_sequence_gaps=TRUE
    
    # Title to use when running as a console
    wrapper.console.title=@app.long.name@
    
    #********************************************************************
    # Wrapper JVM Checks
    #********************************************************************
    # Detect DeadLocked Threads in the JVM. (Requires Standard Edition)
    wrapper.check.deadlock=TRUE
    wrapper.check.deadlock.interval=60
    wrapper.check.deadlock.action=RESTART
    wrapper.check.deadlock.output=FULL
    
    # Out Of Memory detection.
    # (Simple match)
    wrapper.filter.trigger.1000=java.lang.OutOfMemoryError
    # (Only match text in stack traces if -XX:+PrintClassHistogram is being used.)
    #wrapper.filter.trigger.1000=Exception in thread "*" java.lang.OutOfMemoryError
    #wrapper.filter.allow_wildcards.1000=TRUE
    wrapper.filter.action.1000=RESTART
    wrapper.filter.message.1000=The JVM has run out of memory.
    
    #********************************************************************
    # Wrapper Email Notifications. (Requires Professional Edition)
    #********************************************************************
    # Common Event Email settings.
    #wrapper.event.default.email.debug=TRUE
    #wrapper.event.default.email.smtp.host=<SMTP_Host>
    #wrapper.event.default.email.smtp.port=25
    #wrapper.event.default.email.subject=[%%WRAPPER_HOSTNAME%%:%%WRAPPER_NAME%%:%%WRAPPER_EVENT_NAME%%] Event Notification
    #wrapper.event.default.email.sender=<Sender email>
    #wrapper.event.default.email.recipient=<Recipient email>
    
    # Configure the log attached to event emails.
    #wrapper.event.default.email.attach_log=TRUE
    #wrapper.event.default.email.maillog.lines=50
    #wrapper.event.default.email.maillog.format=LPTM
    #wrapper.event.default.email.maillog.loglevel=INFO
    
    # Enable specific event emails.
    #wrapper.event.wrapper_start.email=TRUE
    #wrapper.event.jvm_prelaunch.email=TRUE
    #wrapper.event.jvm_start.email=TRUE
    #wrapper.event.jvm_started.email=TRUE
    #wrapper.event.jvm_deadlock.email=TRUE
    #wrapper.event.jvm_stop.email=TRUE
    #wrapper.event.jvm_stopped.email=TRUE
    #wrapper.event.jvm_restart.email=TRUE
    #wrapper.event.jvm_failed_invocation.email=TRUE
    #wrapper.event.jvm_max_failed_invocations.email=TRUE
    #wrapper.event.jvm_kill.email=TRUE
    #wrapper.event.jvm_killed.email=TRUE
    #wrapper.event.jvm_unexpected_exit.email=TRUE
    #wrapper.event.wrapper_stop.email=TRUE
    
    # Specify custom mail content
    wrapper.event.jvm_restart.email.body=The JVM was restarted.\n\nPlease check on its status.\n
    
    #********************************************************************
    # Wrapper Windows NT/2000/XP Service Properties
    #********************************************************************
    # WARNING - Do not modify any of these properties when an application
    #  using this configuration file has been installed as a service.
    #  Please uninstall the service before modifying this section.  The
    #  service can then be reinstalled.
    
    # Name of the service
    wrapper.name=@app.name@
    
    # Display name of the service
    wrapper.displayname=@app.long.name@
    
    # Description of the service
    wrapper.description=@app.description@
    
    # Service dependencies.  Add dependencies as needed starting from 1
    wrapper.ntservice.dependency.1=
    
    # Mode in which the service is installed.  AUTO_START, DELAY_START or DEMAND_START
    wrapper.ntservice.starttype=AUTO_START
    
    # Allow the service to interact with the desktop.
    wrapper.ntservice.interactive=false
    
    ##### Part 7 Ends #####
    

 
