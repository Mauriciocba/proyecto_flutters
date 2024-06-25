import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activity_categories/data/models/categories_response.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/domain/repositories/categories_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class CategoriesRepositoryImpl implements CategoriesRepository {
  final ApiService _apiService;

  CategoriesRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, List<Category>>> getAllByEvent(int eventId) async {
    try {
      final result = await _apiService.request(
          method: HttpMethod.get, url: '/activity-categories/all');

      if (result.resultType == ResultType.failure) {
        return Left(BaseFailure(message: "Hubo un error, vuelve a intentar"));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(
          message: "No se pudo comunicar con el servidor, intenta nuevamente",
        ));
      }

      if (result.body == null || result.body?['data'] == null) {
        return left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      final data = result.body?["data"];
      final categoriesJson = categoriesResponseFromJson(jsonEncode(data));

      final List<Category> categories = categoriesJson
          .map((e) => Category(
                categoryId: e.accId,
                name: e.accBlock ?? "Sin nombre",
                description: e.accDescription,
                color: e.accFontColor,
                iconName: e.accIcon,
                subCategory: null,
              ))
          .toList();

      return Right(categories);
    } catch (e) {
      debugPrint(e.toString());
      return Left(BaseFailure(message: "Hubo un fallo interno"));
    }
  }
}
