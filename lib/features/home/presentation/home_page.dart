import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pamphlets_management/features/activity/delete_activity/presentation/bloc/delete_activity_bloc.dart';
import 'package:pamphlets_management/features/delete_event/presentation/bloc/bloc/delete_event_bloc.dart';
import 'package:pamphlets_management/features/event/domain/use_cases/get_events_all_use_case.dart';
import 'package:pamphlets_management/features/event/presentation/bloc/bloc/event_all_bloc.dart';
import 'package:pamphlets_management/features/home/domain/use_cases/token_checker_use_case.dart';
import 'package:pamphlets_management/features/home/presentation/home_view.dart';
import 'package:pamphlets_management/features/info_event/presentation/bloc/bloc/info_event_bloc.dart';
import 'package:pamphlets_management/features/log_out/presentation/bloc/log_out_bloc.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_activity_metrics_use_case.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_logins_events_metrics_use_case.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_logins_hour_metrics_use_case.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_payment_events_use_case.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_payments_data_use_case.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_payments_networking_use_case.dart';
import 'package:pamphlets_management/features/metrics/presentation/bloc/activities_metrics_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/bloc/metric_hour_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/bloc/metrics_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/bloc/payment_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/bloc/select_activity_bloc.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class HomePage extends StatelessWidget with Toaster {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => EventAllBloc(
            GetIt.instance.get(),
            GetIt.instance.get<TokenCheckerUseCase>(),
          )..add(EventAllStart()),
        ),
        BlocProvider(
          create: (_) => InfoEventBloc(GetIt.instance.get()),
        ),
        BlocProvider(
          create: (_) => DeleteEventBloc(GetIt.instance.get()),
        ),
        BlocProvider(
          create: (_) => DeleteActivityBloc(GetIt.instance.get()),
        ),
        BlocProvider(
          create: (_) => LogOutBloc(GetIt.instance.get()),
        ),
        BlocProvider<MetricsBloc>(
          create: (_) => MetricsBloc(
            getLoginsEventsMetricsUseCase:
                GetIt.instance.get<GetLoginsEventsMetricsUseCase>(),
            getLoginsHourMetricsUseCase:
                GetIt.instance.get<GetLoginsHourMetricsUseCase>(),
          )..add(const LoadMetricsLogins(start: null, end: null)),
        ),
        BlocProvider<MetricHourBloc>(
          create: (_) => MetricHourBloc(
            getLoginsHourMetricsUseCase:
                GetIt.instance.get<GetLoginsHourMetricsUseCase>(),
          ),
        ),
        BlocProvider<PaymentBloc>(
          create: (_) => PaymentBloc(
            getPaymentEventsUseCase:
                GetIt.instance.get<GetPaymentEventsUseCase>(),
            getPaymentsNetworkingUseCase:
                GetIt.instance.get<GetPaymentsNetworkingUseCase>(),
            getPaymentsDataUseCase:
                GetIt.instance.get<GetPaymentsDataUseCase>(),
          )..add(const LoadPayment(startDate: null, endDate: null)),
        ),
        BlocProvider<ActivitiesMetricsBloc>(
          create: (_) => ActivitiesMetricsBloc(
            getActivityMetricsUseCase:
                GetIt.instance.get<GetActivityMetricsUseCase>(),
            getEventAllUseCase: GetIt.instance.get<GetEventAllUseCase>(),
          )..add(const LoadActivitiesMetricsEvents(eventId: null)),
        ),
        BlocProvider<SelectActivityBloc>(
          create: (_) => SelectActivityBloc(
            getActivityMetricsUseCase:
                GetIt.instance.get<GetActivityMetricsUseCase>(),
          ),
        )
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<LogOutBloc, LogOutState>(
            listener: (innerContext, state) {
              if (state is LogOutSuccess) {
                context.go('/');
              }
              if (state is LogOutFailure) {
                showToast(
                  context: innerContext,
                  message: state.errorMessage,
                  isError: true,
                );
              }
              if (state is LogOutLoading) {
                const Center(child: CupertinoActivityIndicator());
              }
            },
          ),
          BlocListener<EventAllBloc, EventAllState>(
            listener: (context, state) {
              if (state is NotLoggedIn) {
                context.go('/');
              }
            },
          ),
        ],
        child: const HomeView(),
      ),
    );
  }
}
