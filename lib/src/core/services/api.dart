import 'package:dio/dio.dart';
import 'package:flutter_talk7/src/core/models/models.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

/// rest client service interface
@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /// get all albums
  @GET("albums")
  Future<List<Album>> getAlbums();

  /// get a single album
  @GET("albums/{id}")
  Future<Album> getAlbum(@Path("id") int id);

  /// get album photos
  @GET("albums/{id}/photos")
  Future<List<Photo>> getAlbumPhotos(@Path("id") int id);

  /// update album
  @PUT("/albums/{id}")
  Future<Album> updateAlbum(@Path() int id, @Body() Album album);

  /// delete album
  @DELETE("/albums/{id}")
  Future<void> deleteAlbum(@Path() int id);

  /// create album
  @POST("/albums")
  Future<Album> createAlbum(@Body() Album album);

  /// get all photos
  @GET("photos")
  Future<List<Photo>> getPhotos();
  @GET("photos/{id}")
  Future<Photo> getPhoto(@Path("id") int id);

  /// update photo
  @PUT("/albums/{id}")
  Future<Album> updatePhoto(@Path() int id, @Body() Photo photo);

  /// delete photo
  @DELETE("/albums/{id}")
  Future<void> deletePhoto(@Path() int id);

  /// create photo
  @POST("/albums")
  Future<Photo> createPhoto(@Body() Album photo);

  @GET("users")
  Future<List<User>> getUsers();
  @GET("users/{id}")
  Future<User> getUser(@Path("id") int id);
}

/// get a rest client service instance
RestClient getRestClient() {
  final dio = Dio();
  dio.options.headers["Accept"] = "application/json";
  dio.options.headers["Content-Type"] = "application/json";
  return RestClient(dio);
}
