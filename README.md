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
 * [Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/kibitan/contract_management_api/master/config/swagger.yml) (without Mock Server - Try it out)
 * [waggerapi/swagger-ui - Docker Hub](https://hub.docker.com/r/swaggerapi/swagger-ui/)

  ```bash
   $ docker pull swaggerapi/swagger-ui
   $ docker run -p 80:8080 -e API_URL=http://localhost:3000/v1/swagger.json swaggerapi/swagger-ui
   // with Docker for Mac with higher than v 17.06, use API_URL=http://docker.for.mac.localhost:3000/v1/swagger.json
   $ open http://localhost
  ```

## Usage

NOTE: now development only

```
 $ bundle exec rails s
```

## Run test

```
 $ bundle exec rspec
```

## TODO
 - [x] update swagger.yaml
 - [x] implement error handing for /v1/uesrs
   - use [comittee](https://github.com/interagent/committee)
     - it's not working well with OpenAPI v2
 - implement authorization
   - [x] implement ApiKeyAuth
   - [ ] implement BasicAuth
 - implement contracts API
  - [ ] `/contracts` post
  - [ ] `/contracts/{contract_id}` get
  - [ ] `/contracts/{contract_id}` delete
  - [ ] introduce [jb](https://github.com/amatsuda/jb) or [json-api](https://github.com/jsonapi-rb/jsonapi-rb) for building json response
