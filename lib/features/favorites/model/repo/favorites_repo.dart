import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/features/favorites/model/data_source/favorites_remote_data_source.dart';

class FavoritesRepo {
  final FavoritesRemoteDataSource _dataSource;
  FavoritesRepo(this._dataSource);

  Future<dynamic> getFavoritePlans() async{
    try{
    final data = await _dataSource.getFavoritePlans();
    return data;
    } catch(e){
      throw ServerException('An unexpected error occurred: $e');
    }
  }

  Future<dynamic> addPlanToFavorites({required String planId}) async{
    try{
    final data = await _dataSource.addPlanToFavorites(planId: planId);
    return data;
    } catch(e){
      throw ServerException('An unexpected error occurred: $e');
    }
  }

  Future<dynamic> removePlanFromFavorites({required String planId}) async{
    try{
    final data = await _dataSource.removePlanFromFavorites(planId: planId);
    return data;
    } catch(e){
      throw ServerException('An unexpected error occurred: $e');
    }
  }

  Future<dynamic> getFavoriteLandmarks() async{
    try{
    final data = await _dataSource.getFavoriteLandmarks();
    return data;
    } catch(e){
      throw ServerException('An unexpected error occurred: $e');
    }
  }

  Future<dynamic> addLandmarkToFavorites({required String landmarkId}) async{
    try{
    final data = await _dataSource.addLandmarkToFavorites(landmarkId: landmarkId);
    return data;
    } catch(e){
      throw ServerException('An unexpected error occurred: $e');
    }
  }

  Future<dynamic> removeLandmarkFromFavorites({required String landmarkId}) async{
    try{
    final data = await _dataSource.removeLandmarkFromFavorites(landmarkId: landmarkId);
    return data;
    } catch(e){
      throw ServerException('An unexpected error occurred: $e');
    }
  }
}