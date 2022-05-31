FROM ubuntu As builder  -----> Build
WORKDIR /app
RUN apt update -y
RUN apt install maven -y
COPY . .
RUN mvn clean package

FROM tomcat:latest  ----> deploy
CMD ["SERVICE" , "TOMCAT"]
COPY --from = builder ./project/target/hello-world-war.war ./webapps
RUN docker run -itd -p 8080:8080
