FROM openjdk:11
WORKDIR /app
COPY ./* /app/
CMD java -Dserver.port=${SERVER_PORT:-}\
          -Dserver.context-path=/\
          -Dspring.messages.basename=messages/messages\
          -Dlogging.level.org.springframework=${LOG_LEVEL:-INFO}\
          -Dsecurity.ignored=${SECURITY_IGNORED:-/**}\
          -Dbasic.authentication.enabled=${AUTHENTICATION_ENABLED:-false}\
          -Dserver.address=${SERVER_ADDRESS:-0.0.0.0}\
          -jar /app/app.jar