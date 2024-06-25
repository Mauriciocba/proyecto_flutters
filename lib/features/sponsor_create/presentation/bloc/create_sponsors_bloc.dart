import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsor_create/domain/entities/sponsors_create_model.dart';
import 'package:pamphlets_management/features/sponsor_create/domain/use_cases/register_sponsor_use_case.dart';

part 'create_sponsors_event.dart';
part 'create_sponsors_state.dart';

class CreateSponsorsBloc
    extends Bloc<CreateSponsorsEvent, CreateSponsorsState> {
  final RegisterSponsorUseCase _registerSponsorUseCase;
  CreateSponsorsBloc(this._registerSponsorUseCase)
      : super(CreateSponsorsInitial()) {
    on<SponsorsCreateStart>(onSponsorCreate);
  }

  FutureOr<void> onSponsorCreate(SponsorsCreateStart event, emit) async {
    emit(CreateSponsorLoading());

    final result = await _registerSponsorUseCase(event.sponsorModel);

    result.fold((error) => emit(CreateSponsorFailure(msgFail: error.message)),
        (data) => emit(CreateSponsorSuccess()));
  }
}
