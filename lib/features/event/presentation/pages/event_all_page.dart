import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pamphlets_management/features/event/presentation/bloc/bloc/event_all_bloc.dart';
import 'package:pamphlets_management/features/home/domain/use_cases/token_checker_use_case.dart';

import '../../domain/use_cases/get_events_all_use_case.dart';
import '../widgets/event_card.dart';

class EventAllPage extends StatelessWidget {
  const EventAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventAllBloc(
        GetIt.instance<GetEventAllUseCase>(),
        GetIt.instance<TokenCheckerUseCase>(),
      )..add(EventAllStart()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<EventAllBloc, EventAllState>(
          builder: (context, state) {
            if (state is EventAllLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is EventAllFailure) {
              return Center(child: Text(state.message));
            }
            if (state is EventAllSuccess) {
              return state.event.isNotEmpty
                  ? SingleChildScrollView(
                      child: TableEvent(eventList: state.event),
                    )
                  : Center(
                      child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Lista de Eventos Disponibles',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.go('/createEventPage');
                                    },
                                    child: const Text('Crear'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                      child:
                                          Text('No hay eventos disponibles')),
                                ),
                              ),
                            ],
                          )),
                    );
            }
            return Center(
              child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Lista de Eventos Disponibles',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.go('/createEventPage');
                            },
                            child: const Text('Crear'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Text('No hay eventos disponibles')),
                        ),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
