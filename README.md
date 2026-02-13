# CBT - Computer Based Test System

A PHP-based Computer Based Test (CBT) platform for schools and institutions. Supports multiple user roles (Admin, Staff, Students), timed exams, automatic scoring, and result management.

Originally built as **De-Guide Light School CBT** by **DotEightPlus**.

---

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Database Setup](#database-setup)
- [Configuration](#configuration)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Default Credentials](#default-credentials)
- [Exam Flow](#exam-flow)
- [Tech Stack](#tech-stack)
- [License](#license)

---

## Features

### Admin Panel (`/admin/`)
- Create subjects and exams (Basic, JSS, SSS, Online categories)
- Upload, edit, and delete multiple-choice questions (A, B, C, D)
- Configure exam time limits (hours/minutes) and attempt counts
- Add exam instructions per subject
- Manage access codes for exam sessions
- Start and control CBT sessions
- View and print student results
- Delete subjects and reset question banks

### Staff Panel (`/staff/`)
- Upload and preview questions
- View and print student results
- Limited access compared to Admin (no subject deletion, no access code management)

### Student / CBT Interface (`/admin/cbt/` or `/staff/cbt/`)
- Subject selection with access code authentication
- Timed exam with countdown timer
- Randomized question order per session
- Auto-submit on timeout
- Immediate score display after submission

### General
- Progressive Web App (PWA) support with service workers
- Responsive design for mobile and desktop
- Session-based authentication
- URL rewriting (clean URLs without `.php` extensions)

---

## Requirements

- **PHP** 8.0+ (tested on 8.2)
- **MySQL / MariaDB** 10.4+
- **Apache** with `mod_rewrite` enabled
- **XAMPP** (recommended for local development)

---

## Installation

1. **Clone the repository** into your web server's document root:

   ```bash
   cd /path/to/htdocs
   git clone <repository-url> cbt
   ```

2. **Ensure Apache modules are enabled:**
   - `mod_rewrite` (for clean URLs)
   - `mod_php` (for `.htaccess` PHP directives)

3. **Set up the database** (see below).

4. **Configure database credentials** (see [Configuration](#configuration)).

5. **Access the application:**
   - Admin panel: `http://localhost/cbt/admin/login`
   - Staff panel: `http://localhost/cbt/staff/login`

---

## Database Setup

### Option 1: Import via command line

```bash
# Create the database
mysql -u root -e "CREATE DATABASE IF NOT EXISTS hynitr_cbt;"

# Import the schema and sample data
mysql -u root hynitr_cbt < /path/to/cbt/cbt.sql
```

### Option 2: Import via phpMyAdmin

1. Open phpMyAdmin (`http://localhost/phpmyadmin`)
2. Create a new database named `hynitr_cbt`
3. Select the database, go to **Import**
4. Choose `cbt.sql` from the project root and click **Go**

### Database Tables

| Table | Purpose |
|-------|---------|
| `login` | Admin/Staff credentials and school name |
| `timer` | Exam configuration (time limits, attempts, instructions, access codes) |
| `result` | Student exam results (ID, name, subject, score, timestamp) |
| `student` | Registered student records (exam ID, name) |
| `<subject_name>` | Dynamic tables per subject containing questions (sn, question, oa-od, correct) |

---

## Configuration

### Database Credentials

Edit the database connection files for your environment:

**Admin:** `admin/functions/db.php`
**Staff:** `staff/functions/db.php`

```php
// Local development (XAMPP default)
$con = mysqli_connect("localhost", "root", "", "hynitr_cbt");

// Production (update with your credentials)
// $con = mysqli_connect("host", "username", "password", "database");
```

### Error Logging

Both `admin/.htaccess` and `staff/.htaccess` are configured to write PHP errors to local log files:

- `admin/error.log`
- `staff/error.log`

Apache-level errors are logged to: `/Applications/XAMPP/xamppfiles/logs/error_log`

---

## Project Structure

```
cbt/
├── cbt.sql                        # Main database schema + sample data
├── README.md                      # This file
│
├── admin/                         # Admin panel
│   ├── login.php                  # Admin login page
│   ├── index.php                  # Admin entry redirect
│   ├── logout.php                 # Logout handler
│   ├── .htaccess                  # URL rewriting + error logging
│   ├── manifest.json              # PWA manifest
│   │
│   ├── functions/                 # Core PHP logic
│   │   ├── db.php                 # Database connection
│   │   ├── functions.php          # Helper functions, login, CRUD operations
│   │   └── init.php               # Session init, DB include, globals
│   │
│   ├── dashboard/                 # Admin dashboard (AdminLTE)
│   │   ├── index.php              # Dashboard home
│   │   ├── upload.php             # Upload questions
│   │   ├── questions.php          # Preview/edit questions
│   │   ├── selectcbt.php          # Start CBT session
│   │   ├── printres.php           # Print results
│   │   ├── deletesubject.php      # Delete subjects
│   │   ├── access.php             # Edit access codes
│   │   ├── includes/              # Shared layout partials
│   │   │   ├── top.php            # HTML head
│   │   │   ├── navbar.php         # Top navigation bar
│   │   │   ├── sidebar.php        # Sidebar navigation
│   │   │   └── footer.php         # Footer + scripts
│   │   └── plugins/               # AdminLTE plugins (Bootstrap, DataTables, etc.)
│   │
│   └── cbt/                       # Student exam interface (admin-managed)
│       ├── index.php              # Subject selection
│       ├── cbt.php                # Main exam page
│       ├── submitted.php          # Results page
│       └── ajax.php               # AJAX handlers
│
├── staff/                         # Staff panel (mirrors admin with limited access)
│   ├── login.php
│   ├── index.php
│   ├── logout.php
│   ├── .htaccess
│   ├── functions/
│   │   ├── db.php
│   │   ├── functions.php
│   │   └── init.php
│   ├── dashboard/
│   │   ├── index.php
│   │   ├── upload.php
│   │   ├── questions.php
│   │   ├── printres.php
│   │   └── includes/
│   ├── cbt/                       # Student exam interface (staff-managed)
│   └── icbt.sql                   # Alternative DB schema
│
└── .github/                       # GitHub workflows
```

---

## Usage

### Admin Workflow

1. Log in at `/admin/login`
2. **Upload questions:** Dashboard > Upload Questions > Select class category, subject name, time, and instructions
3. **Add questions:** After creating a subject, add questions with 4 options (A-D) and mark the correct answer
4. **Set access code:** Dashboard > Edit Access Code
5. **Start CBT:** Dashboard > Start CBT > Select subject for students

### Staff Workflow

1. Log in at `/staff/login`
2. Upload and manage questions
3. View and print results

### Student Exam

1. Navigate to `/admin/cbt/` or `/staff/cbt/`
2. Select a subject from the dropdown
3. Enter the exam access code
4. Read instructions, then start the exam
5. Answer questions within the time limit
6. Submit or wait for auto-submit on timeout
7. View score immediately

---

## Default Credentials

| Role | Username | Password |
|------|----------|----------|
| Admin/Staff | `demo` | *(check your database — password is MD5 hashed)* |

---

## Exam Flow

```
Student selects subject
        │
        ▼
Enters access code
        │
        ▼
Views instructions
        │
        ▼
Starts timed exam
        │
        ▼
Questions displayed (randomized)
        │
        ▼
Timer counts down ──── Timeout? ──► Auto-submit
        │
        ▼
Student submits answers
        │
        ▼
Score calculated & saved
        │
        ▼
Results displayed (X/Y format)
```

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Backend** | PHP 8.x, MySQLi |
| **Database** | MySQL / MariaDB |
| **Frontend** | Bootstrap 4, jQuery 3.2.1, AdminLTE 3 |
| **Icons** | Font Awesome 4.7, Linearicons |
| **UI Libraries** | Select2, DataTables, Chart.js, Animsition, Moment.js |
| **Server** | Apache (mod_rewrite, mod_php) |
| **PWA** | Service Workers, Web App Manifest |

---

## License

See [LICENSE](staff/LICENSE) for details.
