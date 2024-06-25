import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/gallery_create/domain/use_cases/register_gallery_create_use_case.dart';
import 'package:pamphlets_management/features/gallery_create/presentation/bloc/gallery_create_bloc.dart';
import 'package:pamphlets_management/features/gallery_create/presentation/widgets/gallery_create_widget.dart';

import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class GalleryCreatePage extends StatelessWidget with Toaster {
  final int eventId;
  const GalleryCreatePage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return CardScaffold(
        appBar: CustomAppBar(
          title: "Crear Galería de imágenes",
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left_rounded)),
        ),
        body: BlocProvider(
            create: (_) => GalleryCreateBloc(GetIt.instance.get<RegisterGalleryCreateUseCase>()),
            child:
                BlocListener<GalleryCreateBloc, GalleryCreateState>(listener: (context, state) {
              if (state is GalleryFailure) {
                showToast(
                  context: context,
                  message: 'No se pudo registrar',
                  isError: true,
                );
              }
              if (state is GallerySuccess) {
                showToast(
                  context: context,
                  message: 'Imagen Registrada.',
                );
              }
            },
            child: SingleChildScrollView(
              child: Center(child: GalleryCreateWidget(eventId: eventId),),
            ),
            )));
  }
}