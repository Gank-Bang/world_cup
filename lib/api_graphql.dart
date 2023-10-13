import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


final HttpLink httpLink = HttpLink(
  'https://wcap-apigphql-63cf92fc1c4a.herokuapp.com/graphql', 
);

final Link link = httpLink; 
final ValueNotifier<GraphQLClient> clientNotifier = ValueNotifier(
  GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  ),
);