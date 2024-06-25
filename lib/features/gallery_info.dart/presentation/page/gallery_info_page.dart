import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/gallery_create/presentation/page/gallery_create_page.dart';
import 'package:pamphlets_management/features/gallery_delete/domain/use_cases/delete_gallery_use_case.dart';
import 'package:pamphlets_management/features/gallery_delete/presentation/bloc/gallery_delete_bloc.dart';
import 'package:pamphlets_management/features/gallery_info.dart/domain/use_cases/get_gallery_info_use_case.dart';
import 'package:pamphlets_management/features/gallery_info.dart/presentation/bloc/gallery_info_bloc.dart';
import 'package:pamphlets_management/features/gallery_info.dart/presentation/widgets/list_gallery_info_widget.dart';

import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';


class GalleryInfoPage extends StatelessWidget {
  final int eventId;
  const GalleryInfoPage({super.key,required this.eventId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) =>
         GalleryInfoBloc(GetIt.instance.get<GetGalleryInfoUseCase>())
         ..add(GalleryInfoStart(eventId: eventId))
      ),
      BlocProvider(
          create: (context) => GalleryDeleteBloc(
            GetIt.instance.get<DeleteGalleryUseCase>(),
          ),
        ),
      ],
       child: _GalleryInformationBody(eventId: eventId,)
      );
  }
}

class _GalleryInformationBody extends StatelessWidget with Toaster {
  const _GalleryInformationBody({
    required this.eventId,
  });

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return 
    BlocListener<GalleryDeleteBloc, GalleryDeleteState>(
      listener: (context, state) {
        if (state is GalleryDeleteFailure) {
          showToast(context: context, message: state.msgFail);
        }
        if (state is GalleryDeleteSuccess) {
          showToast(context: context, message: 'Imagen de galleria Eliminada');
          context.read<GalleryInfoBloc>().add(GalleryInfoStart(eventId: eventId));
       }
      },
      child: 
      CardScaffold(
          appBar: CustomAppBar(
            title: 'Galería de Imágenes',
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.keyboard_arrow_left_rounded)),
            trailing: Tooltip(
              message: 'Cargar imágenes',
              child: IconButton(
                onPressed: () => {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GalleryCreatePage(eventId: eventId),
                    )).then((value) => context.read<GalleryInfoBloc>().add(GalleryInfoStart(eventId: eventId)))
                },
                icon: const Icon(Icons.add_photo_alternate),
              ),
            ),
          ),
          body: Column(
            children: [
              const Divider(height: 1.0),
              Expanded(child: _GalleryInfoBody(eventId: eventId)),
  
            ],
          )));
  }
}

class _GalleryInfoBody extends StatelessWidget with Toaster {
  final int eventId;
  const _GalleryInfoBody({
    required this.eventId,
  });
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryInfoBloc,GalleryInfoState>
    (builder: (context,state){
      if(state is GalleryInfoLoading){
        return const Center(child: CupertinoActivityIndicator());
      }
      if(state is GalleryInfoFailure){
        return Center(child: Text(state.msgFail));
      }
      if(state is GalleryInfoSuccess){
        return state.galleryModel.isNotEmpty
        ? ListGalleryInfoWidget(eventId: eventId, gallery: state.galleryModel)
        : _EmptyGalleryList(eventId: eventId);
      }
      return const Center(child: Text("No hay Datos"));
    }
    );
  }
}

class _EmptyGalleryList extends StatelessWidget {
  const _EmptyGalleryList({
    required this.eventId,
  });

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text('No contiene Imágenes'),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GalleryCreatePage(eventId: eventId),
              ),
            );
          },
          child: const Text("Crear Galleria de Imágenes"),
        )
      ],
    );
  }
}