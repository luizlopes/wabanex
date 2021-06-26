# Wabanex

***Application created in NLW Together event.***

*Wa ban ex* = Water + Banana + Elixir

Wabanex is an API to record users and their physical training and exercises.

Wabanex is a GraphQL API and your main stack is developed with Elixir 1.7, Phoenix 1.5.7, Absinthe 1.5.0 and PostgresSQL database.

## Setup

### With Docker **(WIP)**

  Just checkout project

### Without Docker

  Firstly you need install Elixir, link [here](https://elixir-lang.org/install.html) and checkout project.

  Wabanex uses PostgresSQL, you need to access [this link](https://www.postgresql.org/download/) and follow the instructions. 
  
  Or you can run PostgresSQL on Docker with the command:
  ```
  $ docker container run --name postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
  ```

## Running

### With Docker **(WIP)**
  When we use docker, we have initial executed commands in Dockerfile and docker-entrypoint.sh files.

  ```
  $ docker-compose up wabanex
  ```

### Without Docker

  * To install project dependencies
  ```
  $ mix deps.get
  ```

  * To create database and add tables
  ```
  $ mix ecto.setup
  ```

  * To start Wabanex
  ```
  $ mix phx.server
  ```

  * To run tests (optional)
  ```
  $ mix tests
  ```

## Using Wabanex GraphQL API

  Thankfully Absinthe, Wabanex has an interface to test GraphQL queries: [`http://localhost:4000/api/graphiql`](http://localhost:4000/api/graphiql)

  * Creating an user:
  ```
    mutation {
      createUser(input: {name:"Wabanex", email:"wabanex@test.com", password:"123asd"}) {
        id
      }
    }
  ```

  * Finding an user:
  ```
    query {
      getUser(id: "an_user_uuid_created_before") {
        name
        email
      }
    }
  ```

  * Creating a training
  ```
    mutation {
      createTraining(input: {
        userId:"an_user_uuid_created_before", 
        startDate: "2021-06-23",
        endDate: "2021-07-23", 
        exercises:[
          {
            name:"Novice",
            protocolDescription: "regular",
            repetitions:"3x12",
            youtubeVideoUrl:"www.yt.com/o12"
          }
        ]
      }) {
        id
      }
    }
  ```

  * Getting an user with training and exercises
  ```
    query {
      getUser(id: "90850be5-a4d5-4824-8bd8-8f0cc05412e1") {
        id
        name
        trainings {
          id
          exercises {
            name
            repetitions
          }
        }
      }
    }
  ```

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
