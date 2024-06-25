import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/news_create/domain/use_case/register_news.dart';
import 'package:pamphlets_management/features/news_create/presentation/bloc/news_bloc.dart';
import 'package:pamphlets_management/features/news_create/presentation/widgets/news_widget.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class NewsPage extends StatelessWidget with Toaster {
  final int eventId;
  const NewsPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return CardScaffold(
        appBar: CustomAppBar(
          title: "Crear Noticia",
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left_rounded)),
        ),
        body: BlocProvider(
            create: (_) => NewsBloc(GetIt.instance.get<RegisterNewsUseCase>()),
            child:
                BlocListener<NewsBloc, NewsState>(listener: (context, state) {
              if (state is NewsFailure) {
                showToast(
                  context: context,
                  message: 'No se pudo registrar',
                  isError: true,
                );
              }
              if (state is NewsSuccess) {
                showToast(
                  context: context,
                  message: 'Articulo Registrado.',
                );
              }
            },
            child: SingleChildScrollView(
              child: Center(child: NewsWidget(eventId: eventId),),
            ),
            )));
  }
}
