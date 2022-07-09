import 'package:dio/dio.dart';
import 'package:got/Models/CharactersInfoResponse.dart';
import 'package:retrofit/http.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "https://thronesapi.com/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('api/v2/Characters')
  Future<List<CharactersInfoResponse>> getCharacters();

}