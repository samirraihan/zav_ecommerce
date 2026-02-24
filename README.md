# Ecommerce App (Auth Provider)

This project is the **authentication provider** in a multi-login system built with Laravel 12 and Sanctum.

When a user logs in or registers here, they can automatically access the **Foodpanda App** without logging in again (SSO-style authentication).

---

## 🚀 Tech Stack

* Laravel 12
* Laravel Breeze (Blade)
* Laravel Sanctum
* MySQL
* PHP 8+

---

## 🧩 How the Multi Login System Works

This project acts as the **Authentication Provider** in a multi-login system between two independent Laravel applications:

* **Ecommerce App** (Auth Provider)
* **Foodpanda App** (SSO Consumer)

Both applications are completely separate Laravel projects with independent databases and sessions.

---

### 🔐 Problem

Browser sessions are domain-scoped, meaning:

* Login sessions from `ecommerce-app` cannot be shared directly with `foodpanda-app`.
* Cookies cannot be reused across different applications.

Because of this, a normal Laravel session-based login cannot achieve cross-app authentication.

---

### ⭐ Solution (SSO-style Token Flow)

A lightweight SSO-like mechanism is implemented using **Laravel Sanctum tokens**.

#### Flow Overview

1. User logs in or registers in **Ecommerce App**.
2. Ecommerce authenticates the user normally using Laravel Breeze.
3. A Sanctum token is generated:

```php
$user->createToken('foodpanda-sso')->plainTextToken;
```

4. When Foodpanda requires authentication, it redirects the user to:

```
/sso-login
```

inside Ecommerce.

5. Ecommerce checks:

* If user session exists → continue
* If not → redirect to Ecommerce login page.

6. If authenticated, Ecommerce redirects back to Foodpanda with a temporary token:

```
foodpanda-app/check-sso?token=XXXX
```

7. Foodpanda calls Ecommerce API:

```
GET /api/me
```

using the token.

8. Ecommerce returns authenticated user data.

9. Foodpanda creates (or finds) the user locally and logs them in.

---

### 🔄 Authentication Flow Diagram

```
Foodpanda (Guest)
        ↓
Redirect to Ecommerce /sso-login
        ↓
Ecommerce verifies session
        ↓
Generate Sanctum Token
        ↓
Redirect back with token
        ↓
Foodpanda validates token (/api/me)
        ↓
Auto login user
```

---

### 📡 API Used

#### Get Authenticated User

```
GET /api/me
```

Middleware:

```
auth:sanctum
```

Returns the currently authenticated user based on the provided token.

---

### 🧠 Design Decisions

* Laravel Sanctum chosen for simplicity and speed.
* No OAuth server setup required.
* Redirect-based token exchange mimics real-world SSO behavior.
* Each app maintains its own local session for security and separation.

---

### 🔒 Security Notes

* Tokens are generated only after successful authentication.
* Foodpanda validates token before login.
* Applications remain isolated (no shared session or database).

---

### 🎯 Result

Users authenticated in Ecommerce can access Foodpanda without manually logging in again, while keeping both systems independent.

---

## ⚙️ Installation

```bash
git clone https://github.com/samirraihan/zav_ecommerce.git
cd ecommerce-app
composer install
cp .env.example .env
php artisan key:generate
```

---

## 🗄️ Database Setup

Create database:

```
ecommerce_db
```

Update `.env`:

```
DB_DATABASE=ecommerce_db
```

Run migrations:

```bash
php artisan migrate
```

---

## 👤 Seed Users (Optional)

```bash
php artisan db:seed
```

Default password:

```
password
```

---

## 🔐 Sanctum Setup

Sanctum is used to generate SSO tokens.

```bash
php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider"
php artisan migrate
```

---

## ▶️ Run Project

```bash
php artisan serve
```

Default:

```
http://ecommerce-app.test
```

---

## 🔄 SSO Flow (Auth Provider)

1. User logs in or registers.
2. Sanctum token is generated.
3. User is redirected from Foodpanda to:

```
/sso-login
```

4. Ecommerce verifies session.
5. Redirects back with token.

Route:

```
GET /sso-login
```

---

## 📡 API Endpoints

### Get Authenticated User

```
GET /api/me
```

Requires Sanctum token.

Used by Foodpanda app to validate user identity.

---

## 🔧 Environment Variables

```
FOODPANDA_APP_URL=http://foodpanda-app.test:8080
```

---

## 🧠 Architecture Note

Browser sessions are domain-scoped, so authentication between applications is handled using **token-based redirect flow**, similar to OAuth SSO.

---

## 👨‍💻 Author

Samir Raihan – Laravel Multi Login Task – Hiring Assignment
