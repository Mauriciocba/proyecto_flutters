import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_category/presentation/bloc/sponsors_category_edit/sponsors_category_edit_bloc.dart';
import 'package:pamphlets_management/features/sponsor_category/presentation/bloc/sponsors_category_get/sponsors_category_bloc.dart';

import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class CategorySponsorsUpdateForm extends StatefulWidget {
  final int eventId;
  final SponsorsCategoryModel spcEditModel;
  final void Function(SponsorsCategoryModel?) onCreated;

  const CategorySponsorsUpdateForm(
      {super.key,
      required this.spcEditModel,
      required this.onCreated,
      required this.eventId});

  @override
  State<CategorySponsorsUpdateForm> createState() =>
      _CategorySponsorsUpdateFormState();
}

class _CategorySponsorsUpdateFormState extends State<CategorySponsorsUpdateForm>
    with Toaster {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.value =
        TextEditingValue(text: widget.spcEditModel.spcName!);
    _descriptionController.value =
        TextEditingValue(text: widget.spcEditModel.spcDescription!);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actualiza la información de tu categoría. Presiona "Guardar" para registrar los cambios',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              label: "* Nombre",
              controller: _nameController,
              validator: (name) {
                if (name == null || name == "" || name.trim().isEmpty) {
                  return "Debes completar el Nombre de la categoría Sponsor";
                }
                return null;
              },
            ),
            CustomTextField(
              label: "* Descripción",
              controller: _descriptionController,
              validator: (descriptionCS) {
                if (descriptionCS == null ||
                    descriptionCS == "" ||
                    descriptionCS.trim().isEmpty) {
                  return "Debes ingresar una descripción para categoría sponsor";
                }
                return null;
              },
            ),
            const SizedBox(height: 24.0),
            BlocBuilder<SponsorsCategoryEditBloc, SponsorsCategoryEditState>(
              builder: (context, state) {
                if (state is SponsorsCategoryEditLoading) {
                  return const CupertinoActivityIndicator();
                }

                return Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _editCategory,
                    child: const Text('Guardar'),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _editCategory() async {
    if (_nameController.text.trim().isEmpty) {
      return;
    }
    if (_descriptionController.text.trim().isEmpty) {
      return;
    }
    BlocProvider.of<SponsorsCategoryEditBloc>(context).add(
        CategoryUpdaterPressed(
            categoryId: widget.spcEditModel.spcId!,
            newData: (
          spcName: _nameController.text,
          spcDescription: _descriptionController.text,
          eventId: widget.eventId
        )));
    BlocProvider.of<SponsorsCategoryBloc>(context)
        .add(CategorySponsorsStart(eventId: widget.eventId));
  }
}
