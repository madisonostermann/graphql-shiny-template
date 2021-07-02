const { makeAugmentedSchema, inferSchema } = require("neo4j-graphql-js");
const { ApolloServer } = require("apollo-server");
const neo4j = require("neo4j-driver");

const driver = neo4j.driver(
    'bolt_url_and_port',
    neo4j.auth.basic('username', 'password')
);

// this infers the schema already in your database!
const inferAugmentedSchema = driver => {
  return inferSchema(driver).then(result => {
    return makeAugmentedSchema({
      typeDefs: result.typeDefs
    });
  });
};

const createServer = schema =>
new ApolloServer({
  schema,
  context: { driver }
});

inferAugmentedSchema(driver)
  .then(createServer)
  .then(server => server.listen(4000))
  .then(({ url }) => {
    console.log(`GraphQL API ready at ${url}`);
  })
  .catch(err => console.error(err));