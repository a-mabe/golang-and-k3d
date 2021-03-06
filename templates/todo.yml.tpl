version: 1.0
provider:
  name: openfaas
  gateway: http://127.0.0.1:8080
functions:
  todo:
    lang: golang-middleware
    handler: ./todo
    image: amabe/todo:latest
    secrets:
    - host
    - password
    - username
    environment:
      postgres_db: postgres
      postgres_sslmode: "disable"
      postgres_port: 5432
