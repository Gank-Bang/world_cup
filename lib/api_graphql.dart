import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


final HttpLink httpLink = HttpLink(
  'https://wcap-apigraphql-5d9206258e76.herokuapp.com/graphql', 
);

final Link link = httpLink; 
final ValueNotifier<GraphQLClient> clientNotifier = ValueNotifier(
  GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  ),
);