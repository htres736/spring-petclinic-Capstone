FROM openjdk:11
WORKDIR /app
COPY target/spring-petclinic-2.5.0-SNAPSHOT.jar /app/app.jar
EXPOSE 80
CMD java -Dserver.port=80\
          -Dserver.context-path=/\
          -Dspring.messages.basename=messages/messages\
          -Dlogging.level.org.springframework=${LOG_LEVEL:-INFO}\
          -Dsecurity.ignored=${SECURITY_IGNORED:-/**}\
          -Dbasic.authentication.enabled=${AUTHENTICATION_ENABLED:-false}\
          -Dserver.address=${SERVER_ADDRESS:-0.0.0.0}\
          -jar /app/app.jar