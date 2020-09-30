import 'package:graphql/client.dart';


class BackendAdapter {

  factory BackendAdapter() {
    return _instance;
  }

  BackendAdapter._internal(){
    final HttpLink _httpLink = HttpLink(
      uri: 'http://192.168.171.97:8080/graphql',
    );

    /*final AuthLink _authLink = AuthLink(
      getToken: () async => 'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
    );

    final Link _link = _authLink.concat(_httpLink);
     */
    final Link _link = _httpLink;

    _client = GraphQLClient(
      cache: InMemoryCache(),
      link: _link,
    );
  }

  static final _instance = BackendAdapter._internal();

  GraphQLClient _client;

  @override
  GraphQLClient get client => _client;
}