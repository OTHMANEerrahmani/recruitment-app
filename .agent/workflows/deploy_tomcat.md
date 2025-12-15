---
description: Deploy the Recruitment App WAR file to Apache Tomcat
---

This workflow guides you through deploying `recruitment-app.war` to a local Apache Tomcat server.

# Prerequisites
- Apache Tomcat 10+ (compatible with Jakarta EE 10) downloaded or installed. [Download Tomcat 10](https://tomcat.apache.org/download-10.cgi)
- Java 17+ installed.

# Steps

1. **Locate the WAR file**
   The WAR file was generated at:
   `/Users/MAC/recruttAnty/target/recruitment-app.war`

2. **Copy to Webapps**
   Copy the WAR file to the `webapps` directory of your Tomcat installation.

   If you installed via Homebrew (example path):
   ```zsh
   cp target/recruitment-app.war /usr/local/opt/tomcat/libexec/webapps/
   ```
   
   If you downloaded the tar.gz manually (example path):
   ```zsh
   cp target/recruitment-app.war /path/to/apache-tomcat-10.x.x/webapps/
   ```

3. **Start Tomcat**
   Navigate to the `bin` directory of your Tomcat installation and run `startup.sh`.

   If using Homebrew:
   ```zsh
   brew services start tomcat
   ```
   
   Or manually:
   ```zsh
   /path/to/apache-tomcat-10.x.x/bin/startup.sh
   ```

4. **Access the Application**
   Tomcat will automatically extract the WAR file.
   Open your browser and navigate to:
   http://localhost:8080/recruitment-app

# Troubleshooting
- **404 Not Found**: Ensure Tomcat successfully started and check the logs in `logs/catalina.out` for deployment errors.
- **Database Connection**: Ensure your Docker container is running (`docker-compose up -d`) and accessible.
