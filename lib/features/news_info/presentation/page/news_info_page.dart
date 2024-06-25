import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/news_create/presentation/page/news_page.dart';
import 'package:pamphlets_management/features/news_delete/domain/use_case/delete_news_use_case.dart';
import 'package:pamphlets_management/features/news_delete/presentation/bloc/bloc/delete_news_bloc.dart';
import 'package:pamphlets_management/features/news_info/domain/use_cases/news_info_use_case.dart';
import 'package:pamphlets_management/features/news_info/presentation/bloc/news_info_bloc.dart';
import 'package:pamphlets_management/features/news_info/presentation/widgets/news_list.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';


class NewsInfoPage extends StatelessWidget {
  final int eventId;
  const NewsInfoPage({super.key,required this.eventId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) =>
         NewsInfoBloc(GetIt.instance.get<GetNewsInfoUseCase>())
         ..add(NewsInfoStart(eventId: eventId))
      ),
      BlocProvider(
          create: (context) => DeleteNewsBloc(
            GetIt.instance.get<DeleteNewsUseCase>(),
          ),
        ),
      ],
       child: _NewsInformationBody(eventId: eventId,)
      );
  }
}

class _NewsInformationBody extends StatelessWidget with Toaster {
  const _NewsInformationBody({
    required this.eventId,
  });

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return 
    BlocListener<DeleteNewsBloc, DeleteNewsState>(
      listener: (context, state) {
        if (state is DeleteNewsFailure) {
          showToast(context: context, message: state.msgErro);
        }
        if (state is DeleteNewsSuccess) {
          showToast(context: context, message: 'Articulo eliminado');
          context.read<NewsInfoBloc>().add(NewsInfoStart(eventId: eventId));
        }
      },
      child: 
      CardScaffold(
          appBar: CustomAppBar(
            title: 'Noticias',
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.keyboard_arrow_left_rounded)),
            trailing: Tooltip(
              message: 'Crear Noticia',
              child: IconButton(
                onPressed: () => {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewsPage(eventId: eventId),
                    )).then((value) => context.read<NewsInfoBloc>().add(NewsInfoStart(eventId: eventId)))
                },
                icon: const Icon(Icons.newspaper),
              ),
            ),
          ),
          body: Column(
            children: [
              const Divider(height: 1.0),
              Expanded(child: _NewsInfoBody(eventId: eventId)),
  
            ],
          )));
  }
}

class _NewsInfoBody extends StatelessWidget with Toaster {
  final int eventId;
  const _NewsInfoBody({
    required this.eventId,
  });
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsInfoBloc,NewsInfoState>
    (builder: (context,state){
      if(state is NewsInfoLoading){
        return const Center(child: CupertinoActivityIndicator());
      }
      if(state is NewsInfoFailure){
        return Center(child: Text(state.msgFail));
      }
      if(state is NewsInfoSuccess){
        return state.listNews.isNotEmpty
        ? NewsList(eventId: eventId, listNews: state.listNews)
        : _EmptyNewsList(eventId: eventId);
      }
      return const Center(child: Text("No hay Datos"));
    }
    );
  }
}

class _EmptyNewsList extends StatelessWidget {
  const _EmptyNewsList({
    required this.eventId,
  });

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text('No contiene Artículos'),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsPage(eventId: eventId),
              ),
            );
          },
          child: const Text("Crear Noticia"),
        )
      ],
    );
  }
}