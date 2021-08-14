import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/data/model/login_model.dart';
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
import 'package:dio/dio.dart';
import 'package:either_type/either_type.dart';
import 'package:flutter/material.dart';

abstract class BazarcheAppRepository{
  /////////////////// user //////////////////
  // Future<Either<Failure,IdentityEntity>> login(Map body);
  // Future<Either<Failure,IdentityEntity>> register(Map body);
  Future<Either<Failure,bool>> isLogin();
  Future<Either<Failure,bool>> login(Map body);
  Future<Either<Failure,bool>> updateUserProfile(FormData formData,ValueChanged<double> uploadedAmount);
  Future<Either<Failure,LoginEntity>> phoneVerification(Map body);
  Future<Either<Failure,ProfileEntity>> getUserProfile();
  Future<Either<Failure,OwnCommentEntity>> getOwnComment(String id);

  /////////////////// Category /////////////////
  Future<Either<Failure,AllCategoryEntity>> getAllCategory();

  /////////////////// Services ///////////////////
  Future<Either<Failure,AllServicesEntity>> getAllServices();

  /////////////////// Facilities //////////////
  Future<Either<Failure,AllFacilitiesEntity>> getAllFacilities();

  /////////////////// Following /////////////////
  Future<Either<Failure,FollowingEntity>> getFollowing();
  ////////////////// Jobs ///////////////////
  Future<Either<Failure,JobEntity>> getBestJobs(Map queryParameters,String path);
  Future<Either<Failure,JobEntity>> getJobsBySearch(Map queryParameters);
  Future<Either<Failure,JobProfileEntity>> getJobProfile(String id,Map queryParameters);
  Future<Either<Failure,JobEntity>> getNearLocations(Map queryParameters);
  Future<Either<Failure,bool>> followJob(Map parameters);
  Future<Either<Failure,bool>> unFollowJob(String id);
  Future<Either<Failure,CountOfCheckInsEntity>> getCheckInsCount(String id);
  Future<Either<Failure,bool>> addCheckIns(Map parameters);
  Future<Either<Failure,ImageEntity>> getImages(String id,Map parameters);
  Future<Either<Failure,bool>> uploadJobImages(FormData formData,ValueChanged<double> uploadedAmount);
  Future<Either<Failure,CommentEntity>> getComments(String id,Map queryParameters);
  Future<Either<Failure,bool>> sendRate(Map parameters);



}