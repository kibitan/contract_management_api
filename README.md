# Contract Management API

API server for contract management.

## Installation

```bash
 $ git clone git@github.com:kibitan/contract_management_api.git
 $ bin/setup
```

## Requirement

 * Ruby 2.5.0
 * PostgreSQL

## API documentation

Defined with [OpenAPI Specification ver. 2 (fka Swagger)](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md) at [swagger.yml](config/swagger.yml)

You can see documentation as Swagger UI by
 * [Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/kibitan/contract_management_api/master/config/swagger.yml)
 * [http://localhost:3000/api_doc](http://localhost:3000/api_doc) ( Swagger UI v2)
 * [waggerapi/swagger-ui - Docker Hub](https://hub.docker.com/r/swaggerapi/swagger-ui/)

  ```bash
   $ docker pull swaggerapi/swagger-ui
   $ docker run -p 80:8080 -e API_URL=http://localhost:3000/v1/swagger.json swaggerapi/swagger-ui
   $ open http://localhost
  ```

## Usage

 * now development only

```
 $ bundle exec rails s
```

## Run test

```
 $ bundle exec rspec
```

## TODO
 - [ ] update swagger.yaml
 - [ ] implement error handing for /v1/uesrs
  - [ ] use comittee
 - [ ] implement basic authorization
 - [ ] implement contracts API
