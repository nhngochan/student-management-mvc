STUDENT INFORMATION:
Name: Nguyễn Hồng Ngọc Hân
Student ID: ITCSIU22229
Class: Web App Development Laboratory - Group 1

COMPLETED EXERCISES:
[x] Exercise 1: Database & User Model
[x] Exercise 2: User Model & DAO
[x] Exercise 3: Login/Logout Controllers
[x] Exercise 4: Views & Dashboard
[x] Exercise 5: Authentication Filter
[x] Exercise 6: Admin Authorization Filter
[x] Exercise 7: Role-Based UI
[ ] Exercise 8: Change Password

AUTHENTICATION COMPONENTS:
- Models: User.java
- DAOs: UserDAO.java
- Controllers: LoginController.java, LogoutController.java, DashboardController.java
- Filters: AuthFilter.java, AdminFilter.java
- Views: login.jsp, dashboard.jsp, updated student-list.jsp

TEST CREDENTIALS:
Admin:
- Username: admin
- Password: password123

Regular User:
- Username: john
- Password: password123

FEATURES IMPLEMENTED:
- User authentication with BCrypt
- Session management
- Login/Logout functionality
- Dashboard with statistics
- Authentication filter for protected pages
- Admin authorization filter
- Role-based UI elements
- Password security
SECURITY MEASURES:
- BCrypt password hashing
- Session regeneration after login
- Session timeout (30 minutes)
- SQL injection prevention (PreparedStatement)
- Input validation
- XSS prevention (JSTL escaping)

TIME SPENT: 4.5 hours

TESTING NOTES:
1. Authentication Verification:

Valid Login: Successfully tested login with Admin (admin/password123) and Regular User (john/password123) credentials. Verified redirection to the Dashboard upon success.

Invalid Login: Attempted login with incorrect passwords and non-existent usernames. Verified that the system prevented access and displayed the correct "Invalid username or password" error message.

BCrypt Validation: Checked the database directly to ensure new passwords are not stored in plain text and verified that the BCrypt.checkpw() method correctly matches raw input against the hashed values.

2. Access Control (AuthFilter) Testing:

Direct URL Access: Attempted to access protected resources (e.g., /dashboard, /student, /student?action=list) via the address bar without logging in. Verified that AuthFilter intercepted the request and redirected immediately to the /login page.

Public Resource Access: Verified that public resources defined in the whitelist (CSS, JS, images, login page) remained accessible without a session.

3. Role-Based Authorization (AdminFilter) & UI Testing:

Admin Privileges: Logged in as admin and verified full access to CRUD operations (Add, Edit, Delete). Confirmed that action buttons were visible in the UI.

User Restrictions: Logged in as john (Regular User). Verified that "Add Student," "Edit," and "Delete" buttons were hidden in student-list.jsp.

URL Manipulation: While logged in as john, attempted to force an admin action by manually typing /student?action=delete&id=1 in the URL. Verified that AdminFilter blocked the request and redirected to the list page with an "Access Denied" error message.

4. Session Management & Security:

Logout Functionality: Clicked the "Logout" button and confirmed the session was invalidated (session.invalidate()). Attempted to use the browser's "Back" button to return to the Dashboard and verified that the application forced a redirect to the login page.

SQL Injection: Attempted to input SQL injection strings (e.g., ' OR '1'='1) into the login form. Verified that PreparedStatement usage prevented unauthorized access.