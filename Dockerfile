# Pull base image
FROM 10.19.13.36:5000/tomcat:7.x-GMT
MAINTAINER gucl<gucl@asiainfo.com>

# Install tomcat7
RUN rm -rf /opt/tomcat/webapps/* && mkdir /opt/tomcat/webapps/ROOT
# 如门户中心的为portal-web.war
COPY ./build/libs/portal-web.war /opt/tomcat/webapps/ROOT/ROOT.war
RUN cd /opt/tomcat/webapps/ROOT && jar -xf ROOT.war && rm -rf /opt/tomcat/webapps/ROOT.war

ADD ./script/start-web.sh /start-web.sh
RUN chmod 755 /*.sh

#RUN echo '43.240.136.154  translateport.yeekit.com' >> /etc/hosts
#RUN echo '43.240.136.193  api.yeekit.com' >> /etc/hosts

# Define default command.
CMD ["/start-web.sh"]