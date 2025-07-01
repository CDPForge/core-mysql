# CDP Forge – MySQL Schema Migrations

This repository contains version-controlled SQL migration scripts for the MySQL database used by the **CDP Forge** platform.  
It uses [Flyway](https://flywaydb.org/) to manage database schema changes in a safe, automated, and repeatable way.

---

## 📁 Structure
```
/
├── flyway.conf # Optional Flyway configuration
├── sql/
│ ├── V1__init_schema.sql
│ ├── V2__add_opensearch_metadata.sql
│ └── V3__add_kafka_tracking.sql
```

Each migration script follows the Flyway naming convention:

```
V<version>__<description>.sql
```

Scripts are **immutable** once committed and must be executed in sequential order.

---

## 🚀 Usage

### Run Migrations Locally

Install the [Flyway CLI](https://flywaydb.org/download/community), then run:

```bash
flyway \
  -url=jdbc:mysql://<host>:<port>/<database> \
  -user=<user> \
  -password=<password> \
  -locations=filesystem:./sql \
  migrate
```
