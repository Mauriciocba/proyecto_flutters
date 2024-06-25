import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq.dart';
import 'package:pamphlets_management/features/faq/presentation/bloc/faqs_bloc/faqs_bloc.dart';
import 'package:pamphlets_management/features/faq/presentation/bloc/faqs_delete_bloc/faqs_delete_bloc.dart';
import 'package:pamphlets_management/features/faq/presentation/page/update_faq_page.dart';
import 'package:pamphlets_management/features/faq/presentation/widgets/faq_image_list.dart';
import 'package:pamphlets_management/utils/common/panel_dialog.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class FaqsList extends StatelessWidget with Toaster {
  const FaqsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaqsBloc, FaqsState>(
      builder: (context, state) {
        if (state is FaqsSuccess) {
          return ListView.builder(
            itemCount: state.faqs.length,
            itemBuilder: (context, index) {
              return _FaqListItem(
                faq: state.faqs[index],
              );
            },
          );
        }

        if (state is FaqsLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        return const Center(child: Text("No contiene preguntas frecuentes"));
      },
    );
  }
}

class _FaqListItem extends StatefulWidget {
  final Faq faq;

  const _FaqListItem({
    required this.faq,
  });

  @override
  State<_FaqListItem> createState() => _FaqListItemState();
}

class _FaqListItemState extends State<_FaqListItem> {
  bool _isUnfold = false;
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: _isHover
                ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                : Colors.grey.shade200,
            width: 1,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton.filled(
                splashRadius: 16,
                onPressed: _onFoldPressed,
                icon: Icon(
                  _isUnfold
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: _isUnfold ? Colors.deepPurple : Colors.grey,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.faq.question,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        _isHover
                            ? IconButton(
                                onPressed: _onEditPressed,
                                icon: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              )
                            : const SizedBox(),
                        _isHover
                            ? IconButton(
                                onPressed: _deleteFaqsPressed,
                                icon: const Icon(
                                  Icons.delete_forever_outlined,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_isUnfold)
                      Text(
                        widget.faq.answer,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey.shade600),
                      ),
                    const SizedBox(height: 16),
                    if (_isUnfold && widget.faq.images.isNotEmpty)
                      FaqImagesList(
                        images:
                            widget.faq.images.map((e) => e.ifqImage).toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFoldPressed() {
    setState(() {
      _isUnfold = !_isUnfold;
    });
  }

  void _onEditPressed() async {
    showPanelDialog(
      context,
      UpdateFaqPage(
        initialFaq: widget.faq,
        confirmUpdateTap: () => BlocProvider.of<FaqsBloc>(context).add(
          FaqsStarted(
            eventId: widget.faq.eventId,
          ),
        ),
      ),
    );
  }

  void _deleteFaqsPressed() {
    context
        .read<FaqsDeleteBloc>()
        .add(FaqsDeletePressed(faqId: widget.faq.faqId));
  }

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _isHover = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _isHover = false;
    });
  }
}
