import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


final HttpLink httpLink = HttpLink(
  'https://wcap-apigraphql-5d9206258e76.herokuapp.com/graphql', // Replace with your GraphQL server URL
);

final Link link = httpLink; // Link combines the HTTP and cache logic

final ValueNotifier<GraphQLClient> clientNotifier = ValueNotifier(
  GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  ),
);