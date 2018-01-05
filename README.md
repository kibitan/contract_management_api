# Contract Management API

API server for contract management.

## Installation

```bash
 $ git clone git@github.com:kibitan/contract_management_api.git
 $ bin/setup
```

## Requirement

 * Ruby 2.5.0

## API documentation

 Defined with [OpenAPI Specification ver. 2 (fka Swagger)](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md), at [swagger.yml](config/swagger.yml)


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
 - [ ] write swagger.yaml
   - [ ] define url for swagger-ui
 - [ ] implement error handing for /v1/uesrs
  - [ ] use comittee
 - [ ] implement basic authorization
 - [ ] implement contracts API
