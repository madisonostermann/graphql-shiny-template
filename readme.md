# GraphQL -- Shiny Application

Welcome! This is a template for establishing a local GraphQL API endpoint and leveraging that to pull data into a locally-ran Shiny Application (RStudio). Once the foundation is running locally, it should be easy enough for you to deploy it on a cloud resource or shared server.

This code assumes that the database driving the API is a graph database in Neo4j, but you could substitute in your other database instead.

With that, let's begin!

## 1. Clone this repository.

Make sure this template code is on your machine. 

## 2. Install requisite packages and software.

To start, download and install:
* [Neo4j](https://neo4j.com/download/): database foundation
  * You don't *need* the Desktop application, you can go through Browser or Sandbox instead.
  * If you're not using Neo4j as your database, don't worry about it!
* [Node.js and NPM (the Node Package Manager)](https://nodejs.org/en/download/): used to run the GraphQL API
* [RStudio](https://www.rstudio.com/): used to run the Shiny Application

Once you have Node.js installed, navigate to your project folder and initialize the Node project:
```
npm init --y

# only if you're using Neo4j, again!
npm install @neo4j/graphql graphql apollo-server neo4j-driver neo4j-graphql-js
```

You'll also need to make sure you have a database in Neo4j created :) 

The RStudio setup will come later.

## 3. Create and run your GraphQL playground.

This is where the template's `index.js` file comes in.

You will need to substitute in the bolt URL and port, username, and password associated with your Neo4j database. You *do not* need to enter your database schema, as that is inferred with the `neo4j-graphql-js` package.

Now, spin up your Neo4j databases and run this file using `node index.js`. Now, if you visit `http://localhost:4000` in your web browser, you'll see the *GraphQL Playground*. You can run some test GraphQL queries to see how it responds. 

## 4. Connecting to the Shiny Application.

Now that we have a local API endpoint created, time to connect it with the Shiny app.

This template comes with starter code for a Shiny app, adapted from this [great dashboard template](https://github.com/davidmeza1/example-dashboard-shiny). However, if you already have an application built, just substitute in your project for the existing one.

Open up the Shiny app in RStudio by clicking on `app.Rproj`. 

In `global.R`, you'll notice the inclusion of the `ghql` package, which is how we will connect to the API and execute queries.

In the `server.R` file, the `ghql` package uses the GraphQL client to establish an endpoint at the GraphQL Playground URL. If your URL is different, substitute that here.

```
link <<- 'http://localhost:4000/'
conn <<- GraphqlClient$new(url = link)
```

An example query is provided, but you'll also want to substitute in something relevant to your database, otherwise you'll receive an error.

```
# Run a query
execute_query('
query SampleQuery {
actors{
    name 
    birthday
    num_movies
}
}
')
```

The `execute_query` function shows the different possibilities in formatting data after retrieval -- raw JSON, flattened JSON, R dataframe, and a rendered datatable.

# Happy coding!