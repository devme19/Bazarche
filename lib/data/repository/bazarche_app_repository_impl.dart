import 'package:bazarche/core/error/exceptions.dart';
import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/data/datasources/local/bazarche_app_local_data_source.dart';
import 'package:bazarche/data/datasources/remote/bazarche_app_remote_data_source.dart';
import 'package:bazarche/data/model/all_category_model.dart';
import 'package:bazarche/data/model/all_facilities_model.dart';
import 'package:bazarche/data/model/all_services_model.dart';
import 'package:bazarche/data/model/comment_model.dart';
import 'package:bazarche/data/model/count_of_chekins_model.dart';
import 'package:bazarche/data/model/following_model.dart';
import 'package:bazarche/data/model/image_model.dart';
import 'package:bazarche/data/model/job_model.dart';
import 'package:bazarche/data/model/job_profile_model.dart';
import 'package:bazarche/data/model/login_model.dart';
import 'package:bazarche/data/model/own_comment_model.dart';
import 'package:bazarche/data/model/profile_model.dart';
import 'package:bazarche/domain/entities/all_category_entity.dart';
import 'package:bazarche/domain/entities/all_facilities_entity.dart';
import 'package:bazarche/domain/entities/all_services_entity.dart';
import 'package:bazarche/domain/entities/comment_entity.dart';
import 'package:bazarche/domain/entities/count_of_checkins_entity.dart';
import 'package:bazarche/domain/entities/following_entity.dart';
import 'package:bazarche/domain/entities/image_entity.dart';
import 'package:bazarche/domain/entities/job_entity.dart';
import 'package:bazarche/domain/entities/job_profile_entity.dart';
import 'package:bazarche/domain/entities/login_entity.dart';
import 'package:bazarche/domain/entities/own_comment_entity.dart';
import 'package:bazarche/domain/entities/profile_entity.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:dio/src/form_data.dart';
import 'package:either_type/src/either.dart';

class BazarcheAppRepositoryImpl implements BazarcheAppRepository{
  final BazarcheAppLocalDataSource localDataSource;
  final BazarcheAppRemoteDataSource remoteDataSource;

  BazarcheAppRepositoryImpl({
    this.localDataSource,
    this.remoteDataSource,
  });
  ///////////////// User /////////////////
  @override
  Future<Either<Failure, bool>> isLogin() async{
    String authToken='';
    try{
      authToken = localDataSource.getAuthToken();
      if(authToken == null)
        return Left(null);
      try{
        final response = await remoteDataSource.get<ProfileModel,Null>("user/dashboard/profile",new Map<String, dynamic>());
        // localDataSource.saveRefreshToken(response.authData.refreshToken);
      }on ServerException catch(e){
        return Left(ServerFailure(errorCode: e.errorCode));
      }
      return Right(true);
    }on CacheException catch(e){
      return Left(CacheFailure());
    }
  }
  @override
  Future<Either<Failure, OwnCommentEntity>> getOwnComment(String id) async{
    try{
      final response = await remoteDataSource.get<OwnCommentModel,Null>('user/jobs/$id/own-comment', new Map<String, dynamic>());
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, bool>> login(Map<dynamic, dynamic> body) async{
    try{
      final response = await remoteDataSource.post<bool,Null>(body, "user/login");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> phoneVerification(Map<dynamic, dynamic> body) async{
    try{
      final response = await remoteDataSource.post<LoginModel,Null>(body,'user/verify');
      localDataSource.saveAuthToken(response.data.token);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, ProfileEntity>> getUserProfile() async{
    try{
      final response = await remoteDataSource.get<ProfileModel,Null>('user/dashboard/profile', new Map<String, dynamic>());
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, bool>> updateUserProfile(FormData formData, uploadedAmount) async{
    try{
      final response = await remoteDataSource.requestMultiPart(formData,'user/dashboard/profile', uploadedAmount);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  /////////////////// Category ///////////////////////
  @override
  Future<Either<Failure, AllCategoryEntity>> getAllCategory() async{
    try{
      final response = await remoteDataSource.get<AllCategoryModel,Null>("category",new Map<String, dynamic>());
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  /////////////////// Services ///////////////////////////
  @override
  Future<Either<Failure, AllServicesEntity>> getAllServices() async{
    try{
      final response = await remoteDataSource.get<AllServicesModel,Null>("services",new Map<String, dynamic>());
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  ///////////////////// Following /////////////////////////

  @override
  Future<Either<Failure, FollowingEntity>> getFollowing() async{
    try{
      final response = await remoteDataSource.get<FollowingModel,Null>("user/dashboard/following",new Map<String, dynamic>());
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  ////////////////// Facilities ///////////////////////////
  @override
  Future<Either<Failure, AllFacilitiesEntity>> getAllFacilities() async{
    try{
      final response = await remoteDataSource.get<AllFacilitiesModel,Null>("facilities",new Map<String, dynamic>());
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  ////////////////// Jobs //////////////////////////////////
  @override
  Future<Either<Failure, JobEntity>> getBestJobs(Map<dynamic, dynamic> queryParameters,String path) async{
    try{
      final response = await remoteDataSource.get<JobModel,Null>('user/jobs/best-list$path',queryParameters);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, JobEntity>> getJobsBySearch(Map<dynamic, dynamic> queryParameters) async{
    try{
      final response = await remoteDataSource.get<JobModel,Null>('user/jobs',queryParameters);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, JobProfileEntity>> getJobProfile(String id,Map<dynamic, dynamic> queryParameters) async {
    try{
      final response = await remoteDataSource.get<JobProfileModel,Null>('user/jobs/$id',queryParameters);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, JobEntity>> getNearLocations(Map<dynamic, dynamic> queryParameters) async{
    try{
      final response = await remoteDataSource.get<JobModel,Null>('user/jobs', queryParameters);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> followJob(Map<dynamic, dynamic> parameters) async{
    try{
      final response = await remoteDataSource.post<bool,Null>(parameters, "user/jobs/follow");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, CountOfCheckInsEntity>> getCheckInsCount(String id) async{
    try{
      final response = await remoteDataSource.get<CountOfCheckInsModel,Null>('user/jobs/$id/check-ins', Map<String, dynamic>());
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> addCheckIns(Map parameters) async{
    try{
      final response = await remoteDataSource.post<bool,Null>(parameters, "user/jobs/check-ins");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, bool>> unFollowJob(String id) async{
    try{
      final response = await remoteDataSource.delete("user/jobs/$id/follow");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, ImageEntity>> getImages(String id,Map parameters) async{
    try{
      final response = await remoteDataSource.get<ImageModel,Null>('user/jobs/images/$id', parameters);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> uploadJobImages(FormData formData, uploadedAmount) async{
    try{
      final response = await remoteDataSource.requestMultiPart(formData, 'user/jobs/images', uploadedAmount);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, CommentEntity>> getComments(String id,Map<dynamic, dynamic> queryParameters) async{
    try{
      final response = await remoteDataSource.get<CommentModel,Null>('user/jobs/$id/comments',queryParameters);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> sendRate(Map<dynamic, dynamic> parameters) async{
    try{
      final response = await remoteDataSource.post<bool,Null>(parameters, 'user/jobs/rates');
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }


 
}