# Sport Training App

Monorepo containing:
- server: Java Spring Boot backend (Maven, Java 21)
- fontend: Flutter client application (Dart/Flutter SDK)


## Overview
A sports training application with a Spring Boot REST backend and a Flutter cross‑platform client. The backend is prepared for PostgreSQL via Spring Data JPA/JDBC; the Flutter app is the default starter ready to connect to the API.

TODO:
- Describe core features, user roles, and main flows.
- Document API endpoints once implemented.

## Tech Stack
- Backend: Java 21, Spring Boot 3.5.x, Spring Web, Spring Data JPA/JDBC, Spring Session JDBC, PostgreSQL driver, Lombok, Maven Wrapper
- Frontend: Flutter (Dart SDK constraint ^3.9.2), Material design, Android/iOS/Web/Desktop targets

## Requirements
- Java Development Kit (JDK) 21+
- Git
- For backend: Maven Wrapper included (no global Maven required)
- For frontend: Flutter SDK 3.9.x+, Android Studio/Xcode for mobile targets, Chrome for web target
- Optional: PostgreSQL 14+ (or compatible)

## Project Structure
- README.md (this file)
- server/ (Spring Boot application)
  - pom.xml
  - src/main/java/com/example/server/ServerApplication.java (entry point)
  - src/main/resources/application.properties
  - mvnw, mvnw.cmd (Maven wrapper)
- fontend/ (Flutter app)
  - pubspec.yaml
  - lib/main.dart (entry point)
  - android/, ios/, web/, macos/, windows/, linux/

## Setup and Run

### Backend (server)
Commands below are shown for Windows PowerShell/CMD using the Maven Wrapper.

- Install dependencies and run in dev mode:
  cd server
  .\mvnw.cmd spring-boot:run

- Run tests:
  cd server
  .\mvnw.cmd test

- Build jar:
  cd server
  .\mvnw.cmd clean package

- Run packaged jar:
  cd server
  java -jar .\target\server-0.0.1-SNAPSHOT.jar

- Active profile and DB settings can be provided via environment variables or application-*.properties (see Environment Variables section).

### Frontend (fontend)
Make sure Flutter SDK is installed and on PATH.

- Get dependencies:
  cd fontend
  flutter pub get

- Run on a device/emulator (choose your device with flutter devices):
  cd fontend
  flutter run

- Run for web (Chrome):
  cd fontend
  flutter run -d chrome

- Run tests:
  cd fontend
  flutter test

- Build Android APK (release):
  cd fontend
  flutter build apk

## Scripts and Tooling
- Maven Wrapper scripts:
  - server\mvnw (Unix) / server\mvnw.cmd (Windows)
- Flutter CLI commands used directly from the Flutter SDK (no custom npm/yarn scripts in this repo)

## Environment Variables and Configuration
Backend (Spring Boot):
- SPRING_DATASOURCE_URL: JDBC URL for PostgreSQL, e.g. jdbc:postgresql://localhost:5432/yourdb
- SPRING_DATASOURCE_USERNAME: DB username
- SPRING_DATASOURCE_PASSWORD: DB password
- SPRING_JPA_HIBERNATE_DDL_AUTO: create|update|validate|none (optional)
- SERVER_PORT: HTTP port (default 8080)
- SPRING_PROFILES_ACTIVE: dev|prod (optional)

The default application.properties contains:
- spring.application.name=server

Frontend (Flutter):
- No explicit .env is configured. TODO: Decide how to configure the API base URL (compile-time Dart define, flavors, or runtime config) and document it here.

## Tests
- Backend: JUnit tests via Spring Boot Test. Run with .\mvnw.cmd test inside the server directory.
- Frontend: Flutter test suite. Run with flutter test inside the fontend directory.

## Development Notes
- Java version is set to 21 in server/pom.xml properties.
- Spring Boot version: 3.5.6 (from parent in pom.xml).
- PostgreSQL driver is included as runtime dependency.
- Lombok is included; ensure your IDE has Lombok plugin enabled for best experience.

## Known TODOs
- Implement API endpoints and document them.
- Add database schema/migrations (Flyway/Liquibase) and instructions.
- Wire the Flutter app to the backend (API base URL, services, models) and add usage docs/screenshots.
- Add CI workflow and badges if applicable.

## License
No license file is present in this repository.

TODO: Choose and add a LICENSE file (e.g., MIT, Apache-2.0, GPL-3.0) at the project root and update this section accordingly.
