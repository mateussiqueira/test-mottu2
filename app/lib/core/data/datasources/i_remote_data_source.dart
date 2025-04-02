/// Interface for remote data source operations
abstract class IRemoteDataSource {
  /// Performs a GET request to the specified endpoint
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  /// Performs a POST request to the specified endpoint
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  });

  /// Performs a PUT request to the specified endpoint
  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  });

  /// Performs a DELETE request to the specified endpoint
  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });
}
