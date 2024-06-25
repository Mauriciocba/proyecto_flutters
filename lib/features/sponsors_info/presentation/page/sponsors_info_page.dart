
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/sponsor_create/presentation/page/sponsors_create_page.dart';
import 'package:pamphlets_management/features/sponsor_delete/domain/use_cases/delete_sponsors_use_case.dart';
import 'package:pamphlets_management/features/sponsor_delete/presentation/bloc/sponsors_delete_bloc.dart';
import 'package:pamphlets_management/features/sponsors_info/domain/use_cases/get_sponsors_use_cases.dart';
import 'package:pamphlets_management/features/sponsors_info/presentation/bloc/info_sponsors_bloc.dart';
import 'package:pamphlets_management/features/sponsors_info/presentation/widgets/list_sponsors_info.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class SponsorsInfoPage extends StatelessWidget {
  final int eventId;
  const SponsorsInfoPage({super.key,required this.eventId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) =>
         InfoSponsorsBloc(GetIt.instance.get<GetSponsorsInfoUseCase>())
         ..add(InfoSponsorsStart(eventId: eventId))
      ),
      BlocProvider(create: (context) => 
       SponsorsDeleteBloc(GetIt.instance.get<DeleteSponsorsUseCase>()))
      ],
       child: _SponsorsInformationBody(eventId: eventId,)
      );
  }
}

class _SponsorsInformationBody extends StatelessWidget with Toaster {
  const _SponsorsInformationBody({
    required this.eventId,
  });

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return 
    BlocListener<SponsorsDeleteBloc, SponsorsDeleteState>(
      listener: (context, state) {
        if (state is SponsorsDeleteFailure) {
          showToast(context: context, message: state.msgFail);
        }
        if (state is SponsorsDeleteSuccess) {
          showToast(context: context, message: 'Sponsor eliminado');
          context.read<InfoSponsorsBloc>().add(InfoSponsorsStart(eventId: eventId));
        }
      },
      child:  CardScaffold(
          appBar: CustomAppBar(
            title: 'Sponsors',
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.keyboard_arrow_left_rounded)),
            trailing: Tooltip(
              message: 'Crear Sponsor',
              child: IconButton(
                onPressed: () => {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SponsorsCreatePage(eventId: eventId),
                    )).then((value) => context.read<InfoSponsorsBloc>().add(InfoSponsorsStart(eventId: eventId)))
                },
                icon: const Icon(Icons.add_business),
              ),
            ),
          ),
          body: Column(
            children: [
              const Divider(height: 1.0),
              Expanded(child: _SponsorsInfoBody(eventId: eventId)),
  
            ],
          )));
  }
}

class _SponsorsInfoBody extends StatelessWidget with Toaster {
  final int eventId;
  const _SponsorsInfoBody({
    required this.eventId,
  });
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoSponsorsBloc,InfoSponsorsState>
    (builder: (context,state){
      if(state is InfoSponsorsLoading){
        return const Center(child: CupertinoActivityIndicator());
      }
      if(state is InfoSponsorsFailure){
        return Center(child: Text(state.msgFail));
      }
      if(state is InfoSponsorsSuccess){
        return state.listSponsors.isNotEmpty
        ? ListSponsorsWidget(eventId: eventId, listSponsors: state.listSponsors)
        : _EmptySponsorsList(eventId: eventId);
      }
      return const Center(child: Text("No hay Datos"));
    }
    );
  }
}

class _EmptySponsorsList extends StatelessWidget {
  const _EmptySponsorsList({
    required this.eventId,
  });

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text('No contiene Sponsors'),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SponsorsCreatePage(eventId: eventId),
              ),
            );
          },
          child: const Text("Crear Stands"),
        )
      ],
    );
  }
}