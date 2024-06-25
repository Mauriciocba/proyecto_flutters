import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activities/data/models/activity_response.dart';
import 'package:pamphlets_management/features/activities/domain/entities/activity.dart';
import 'package:pamphlets_management/features/activities/domain/entities/speakers.dart';
import 'package:pamphlets_management/features/activities/domain/repositories/activity_repository.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/register_activity_use_case.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/subcategory.dart';

import '../../../../core/errors/base_failure.dart';

final class ActivityRepositoryImpl implements ActivityRepository {
  final ApiService _apiService;

  ActivityRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, List<Activity>>> getAllByEvent({
    required int eventId,
    int? page,
    int? limit,
    String? search,
  }) async {
    try {
      var searchQuery = "&search=";
      if (search != null) {
        searchQuery += search;
      }

      final result = await _apiService.request(
        method: HttpMethod.get,
        url:
            "/activity/search/act-eve/$eventId/date?page=$page&limit=$limit$searchQuery",
      );

      if (result.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      if (result.body == null || result.body?['data'] == null) {
        return Left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      final json = result.body?['data'];

      final activitiesResponse = activityResponseFromJson(jsonEncode(json));
      final activities = activitiesResponse
          .map(
            (e) => Activity(
              activityId: e.actId,
              name: e.actName,
              description: e.actDescription,
              location: e.actLocation,
              start: e.actStart,
              end: e.actEnd,
              urlForm: e.actForm,
              actAsk: e.actAsk,
              speakers: e.speaker
                  ?.map((e) =>
                      Speaker(name: e.speFirstName, lastName: e.speLastName))
                  .toList(),
              category: _mapToCategory(e.category),
            ),
          )
          .toList();

      return Right(activities);
    } catch (e) {
      debugPrint("$e");
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }

  @override
  Future<Either<BaseFailure, Activity>> save(
    ActivityFormInput newActivity,
  ) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.post,
        url: '/activity/create',
        body: {
          "act_name": newActivity.name,
          "act_description": newActivity.description,
          "act_location": newActivity.location,
          "act_form": newActivity.urlForm,
          "act_start": newActivity.start.toIso8601String(),
          "act_end": newActivity.end.toIso8601String(),
          "eve_id": newActivity.eventId,
          "acc_id": newActivity.categoryId,
          "act_ask": newActivity.actAsk,
        },
      );

      if (result.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      if (result.body?['data'] == null) {
        return Left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      final json = result.body!['data'];

      final activitiesResponse = ActivityResponse.fromJson(json);
      return Right(
        Activity(
          activityId: activitiesResponse.actId,
          name: activitiesResponse.actName,
          description: activitiesResponse.actDescription,
          location: activitiesResponse.actLocation,
          start: activitiesResponse.actStart,
          end: activitiesResponse.actEnd,
          urlForm: activitiesResponse.actForm,
          actAsk: activitiesResponse.actAsk,
        ),
      );
    } catch (e) {
      debugPrint("$e");
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }

  @override
  Future<Either<BaseFailure, Activity>> update({
    required int activityId,
    required ActivityFormInput activityData,
  }) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.patch,
        url: '/activity/update/$activityId',
        body: {
          "act_name": activityData.name,
          "act_description": activityData.description,
          "act_location": activityData.location,
          "act_form": activityData.urlForm,
          "act_start": activityData.start.toIso8601String(),
          "act_end": activityData.end.toIso8601String(),
          "acc_id": activityData.categoryId,
          "act_ask": activityData.actAsk,
        },
      );

      if (result.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      if (result.body?['statusCode'] != HttpStatus.created) {
        return Left(
            BaseFailure(message: 'No es posible actualizar la actividad'));
      }
      return Right(
        Activity(
          activityId: activityId,
          name: activityData.name,
          description: activityData.description,
          location: activityData.location,
          start: activityData.start,
          end: activityData.end,
          urlForm: activityData.urlForm,
          actAsk: activityData.actAsk,
        ),
      );
    } catch (e) {
      debugPrint("$e");
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }

  Category? _mapToCategory(List<CategoryElementResponse>? categories) {
    if (categories == null) return null;

    Category? categoryAux;
    SubCategory? subCategoryAux;

    for (var cat in categories) {
      if (cat.category != null) {
        categoryAux = Category(
          categoryId: cat.category!.accId,
          name: cat.category!.accBlock,
          iconName: cat.category!.accIcon,
          color: cat.category!.accFontColor,
          description: cat.category!.accDescription,
          isActive: cat.category!.accIsActive ?? true,
        );
      } else if (cat.subcategory != null) {
        subCategoryAux = SubCategory(
            subcategoryId: cat.subcategory!.ascId,
            name: cat.subcategory!.ascBlock,
            color: cat.subcategory!.ascFontColor,
            icon: cat.subcategory!.ascIcon,
            description: cat.subcategory!.ascDescription,
            isActive: cat.subcategory!.ascIsActive ?? true);
      }
    }

    if (categoryAux == null) return null;

    if (subCategoryAux != null) {
      categoryAux.subCategory = subCategoryAux;
    }

    return categoryAux;
  }
}
