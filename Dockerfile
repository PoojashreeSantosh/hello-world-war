FROM ubuntu As builder
WORKDIR /app
RUN apt update -y
RUN apt install maven -y
COPY . .
RUN mvn clean package

FROM tomcat
CMD ["SERVICE" , "TOMCAT"]
COPY --from=builder ./hello-world-war/target/hello-world-war-1.0.0.war ./webapps
RUN docker run -itd -p 8080:8080
