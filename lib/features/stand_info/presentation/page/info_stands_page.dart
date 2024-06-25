import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/stand_create/presentation/page/stands_create_page.dart';
import 'package:pamphlets_management/features/stand_delete/domain/use_cases/delete_stand_use_case.dart';
import 'package:pamphlets_management/features/stand_delete/presentation/bloc/delete_stands_bloc.dart';
import 'package:pamphlets_management/features/stand_info/domain/use_cases/get_stands_info.dart';
import 'package:pamphlets_management/features/stand_info/presentation/bloc/info_stands_bloc.dart';
import 'package:pamphlets_management/features/stand_info/presentation/widgets/list_stands_widget.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class StandsInfoPage extends StatelessWidget {
  final int eventId;
  const StandsInfoPage({super.key,required this.eventId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) =>
         InfoStandsBloc(GetIt.instance.get<GetStandsInfoUseCase>())
         ..add(InfoStandsStart(eventId: eventId))
      ),
      BlocProvider(create: (context) => 
       DeleteStandsBloc(GetIt.instance.get<DeleteStandUseCase>()))
      ],
       child: _StandsInformationBody(eventId: eventId,)
      );
  }
}

class _StandsInformationBody extends StatelessWidget with Toaster {
  const _StandsInformationBody({
    required this.eventId,
  });

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return 
    BlocListener<DeleteStandsBloc, DeleteStandsState>(
      listener: (context, state) {
        if (state is DeleteStandFailure) {
          showToast(context: context, message: state.msgError);
        }
        if (state is DeleteStandSuccess) {
          showToast(context: context, message: 'Stand eliminado');
          context.read<InfoStandsBloc>().add(InfoStandsStart(eventId: eventId));
        }
      },
      child: 
      CardScaffold(
          appBar: CustomAppBar(
            title: 'Stands',
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.keyboard_arrow_left_rounded)),
            trailing: Tooltip(
              message: 'Crear Stand',
              child: IconButton(
                onPressed: () => {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StandsCreatePage(eventId: eventId),
                    )).then((value) => context.read<InfoStandsBloc>().add(InfoStandsStart(eventId: eventId)))
                },
                icon: const Icon(Icons.add_business),
              ),
            ),
          ),
          body: Column(
            children: [
              const Divider(height: 1.0),
              Expanded(child: _StandsInfoBody(eventId: eventId)),
  
            ],
          )));
  }
}

class _StandsInfoBody extends StatelessWidget with Toaster {
  final int eventId;
  const _StandsInfoBody({
    required this.eventId,
  });
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoStandsBloc,InfoStandsState>
    (builder: (context,state){
      if(state is InfoStandsLoading){
        return const Center(child: CupertinoActivityIndicator());
      }
      if(state is InfoStandsFailure){
        return Center(child: Text(state.msgFail));
      }
      if(state is InfoStandsSuccess){
        return state.listStands.isNotEmpty
        ? ListStandsWidget(eventId: eventId, listStands: state.listStands)
        : _EmptyStandsList(eventId: eventId);
      }
      return const Center(child: Text("No hay Datos"));
    }
    );
  }
}

class _EmptyStandsList extends StatelessWidget {
  const _EmptyStandsList({
    required this.eventId,
  });

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text('No contiene Stands'),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StandsCreatePage(eventId: eventId),
              ),
            );
          },
          child: const Text("Crear Stands"),
        )
      ],
    );
  }
}