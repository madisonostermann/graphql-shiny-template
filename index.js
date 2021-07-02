const { Neo4jGraphQL } = require("@neo4j/graphql");
const { ApolloServer } = require("apollo-server");
const neo4j = require("neo4j-driver");

const typeDefs = `
    type Actor {
        name: String!
        birthday: Date!
        num_movies: Int!
	actedIn: [Movie!]! @relationship(type: "ACTED_IN", direction: OUT)
    }
    type Movie {
        name: String!
        released: Date!
        box_office: Int!
    actors: [Actor!]! @relationship(type: "ACTED_IN", direction: IN)
    }
`;

const driver = neo4j.driver(
    'bolt_url_and_port',
    neo4j.auth.basic('username', 'password')
);

const neoSchema = new Neo4jGraphQL({
    typeDefs,
    driver,
});

const server = new ApolloServer({
    schema: neoSchema.schema,
    context: ({ req }) => ({ req }),
});

server.listen(4000).then(() => console.log("http://localhost:4000"));