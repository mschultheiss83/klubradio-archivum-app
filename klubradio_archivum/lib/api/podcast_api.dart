import 'package:klubradio_archivum/services/http_requester.dart';
import 'package:klubradio_archivum/screens/utils/constants.dart' as constants;

class PodcastApi {
  PodcastApi({
    required this.baseUrl,
    required String apiKey,
    HttpRequester? requester,
  }) : _requester =
           requester ??
           HttpRequester(
             defaultHeaders: {
               'apikey': apiKey,
               'Authorization': 'Bearer $apiKey',
               'Content-Type': 'application/json',
               'Accept': 'application/json',
             },
           );

  final String baseUrl;
  final HttpRequester _requester;

  // Rohdaten (List<Map>) zurückgeben – Mapping macht Repository/Model
  Future<List<Map<String, dynamic>>> latest({int limit = 10}) async {
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&order=last_updated.desc&limit=$limit';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> recommended({int limit = 10}) async {
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&order=last_updated.desc.nullslast&limit=$limit';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> trending({int limit = 10}) async {
    final url =
        '$baseUrl/rest/v1/${constants.podcastsTable}?select=*&limit=$limit';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> recentEpisodes({int limit = 8}) async {
    final url =
        '$baseUrl/rest/v1/${constants.episodesTable}?select=*&order=id.desc&limit=$limit';
    final json = await _requester.getJson(url);
    return (json as List).cast<Map<String, dynamic>>();
  }
}
