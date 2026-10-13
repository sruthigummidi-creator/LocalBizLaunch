# LocalBiz Launch — integrated Eclipse + Java Servlet/JSP + MySQL project

This project combines the supplied LocalBiz Launch frontend (green/cream/gold landing page and auth UI) with the Java Servlet/JSP/JDBC backend.

## Stack
- Eclipse IDE for Enterprise Java and Web Developers
- Java 24 installed locally; project language/facet is set to Java 21 for compatibility with Eclipse's Tomcat 9 web tooling. JDK 24 can compile Java 21 source/bytecode.
- Apache Tomcat 9 (Servlet 4.0 / `javax.servlet`)
- MySQL database: `localbiz_launch`
- MySQL Connector/J JDBC driver

## Import into Eclipse
1. Extract the ZIP.
2. In Eclipse Enterprise: **File → Import → General → Existing Projects into Workspace**.
3. Browse to the extracted `LocalBizLaunch_Integrated` folder (the folder containing `.project`) and select `LocalBizLaunch`.
4. Finish the import.
5. If Eclipse cannot resolve the Java runtime: right-click project → Properties → Java Build Path → Libraries; set the JRE System Library to your installed Java 24. Keep Project Facets → Dynamic Web Module at 4.0 and Java at 21.
6. If the Tomcat runtime is marked unbound, use Properties → Targeted Runtimes and select your installed **Apache Tomcat v9.0** runtime.

## Connect MySQL
1. Start MySQL Server and open MySQL Workbench.
2. Select the existing database: `USE localbiz_launch;`
3. Run `database/role_migration.sql`. This adds `role` and `phone` to `users` only if missing. Existing users become `CUSTOMER` by default.
4. Ensure the existing tables have the columns used by this project:
   - `users`: `user_id`, `full_name`, `email`, `phone`, `password_hash`, `role`
   - `businesses`: `business_id`, `owner_id`, `category_id`, `area_id`, `business_name`, `description`, `street_address`, `contact_phone`, `contact_email`, `logo_path`, `verification_status`
   - `business_categories`: `category_id`, `category_name`, `description`
   - `areas`: `area_id`, `area_name`
5. Open `src/com/localbiz/util/DBConnection.java`. Replace `YOUR_MYSQL_PASSWORD` with your local MySQL root password. Do not share or commit your password.
6. Add MySQL Connector/J to the project:
   - Right-click project → **Build Path → Configure Build Path → Libraries → Add External JARs...**
   - Select your existing `mysql-connector-j-*.jar`.
   - Also copy that same JAR into `WebContent/WEB-INF/lib/` (create `lib` if needed) so Tomcat can load the JDBC driver at runtime.
   - If you do not have the JAR, download MySQL Connector/J from the official MySQL website.
7. To make a user a business owner or admin, update their role in Workbench, using the account's actual email:
   - `UPDATE users SET role='OWNER' WHERE email='owner-email@example.com';`
   - `UPDATE users SET role='ADMIN' WHERE email='admin-email@example.com';`
   Use `CUSTOMER`, `OWNER`, or `ADMIN` exactly.

## Run
1. Right-click the project → **Refresh**.
2. Right-click `LocalBizLaunch` → **Run As → Run on Server**.
3. Select **Tomcat v9.0 Server at localhost** and finish.
4. Open `http://localhost:8080/LocalBizLaunch/` (or `http://localhost:8080/LocalBizLaunch/HomeServlet`).

## Main pages and routes
- `HomeServlet` → common landing page with approved listings loaded from MySQL
- `BusinessServlet` → searchable approved business directory
- `RegisterServlet` → saves customer/owner account using PBKDF2 password hashing
- `LoginServlet` → authenticates and redirects by role
- `owner-dashboard.jsp` → owner listing form and the owner's listing statuses
- `AdminApprovalServlet` / `admin-dashboard.jsp` → admin approval/rejection
- `LogoutServlet` → invalidates the login session

## Important notes
- Public listing pages display only businesses with `verification_status='APPROVED'`.
- Owner submissions are `PENDING` until an admin approves them.
- `logo_path` expects a relative path to a logo file inside the web application; a placeholder illustration appears when no logo is set.
- The optional phone field on registration is stored after running the migration above.
- Existing user records are not automatically made owners/admins. Update the role intentionally.
- This ZIP has not been run against your local MySQL/Tomcat installation. If an error occurs, copy the exact message from Eclipse's Problems tab or Tomcat Console.
