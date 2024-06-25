import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/event/presentation/bloc/bloc/event_all_bloc.dart';
import 'package:pamphlets_management/features/event/presentation/pages/create_event_page.dart';
import 'package:pamphlets_management/features/info_event/presentation/bloc/bloc/info_event_bloc.dart';
import 'package:pamphlets_management/features/info_event/presentation/widgets/detail_event_widget.dart';

class InfoEventWidget extends StatelessWidget {
  const InfoEventWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoEventBloc, InfoEventState>(
      builder: (context, state) {
        if (state is InfoEventLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is InfoEventFailure) {
          return Center(child: Text(state.message));
        }
        if (state is InfoEventSuccess) {
          return DetailEvent(event: state.event);
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text("No contiene eventos"),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateEventPage()),
                    ).then((value) =>
                        context.read<EventAllBloc>().add(EventAllStart()));
                  },
                  child: const Text("Crear evento"))
            ],
          ),
        );
      },
    );
  }
}
