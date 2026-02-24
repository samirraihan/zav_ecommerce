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
