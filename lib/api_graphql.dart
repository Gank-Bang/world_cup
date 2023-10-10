import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


final HttpLink httpLink = HttpLink(
  'https://votre-serveur-graphql.com/graphql', // Replace with your GraphQL server URL
);

final Link link = httpLink; // Link combines the HTTP and cache logic

final ValueNotifier<GraphQLClient> clientNotifier = ValueNotifier(
  GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  ),
);