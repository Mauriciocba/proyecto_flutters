// import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/bloc/category_updater_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class CategoryUpdateForm extends StatefulWidget {
  final Category category;
  final void Function(Category?) onCreated;

  const CategoryUpdateForm({
    super.key,
    required this.category,
    required this.onCreated,
  });

  @override
  State<CategoryUpdateForm> createState() => _CategoryUpdateFormState();
}

class _CategoryUpdateFormState extends State<CategoryUpdateForm> with Toaster {
  IconData _selectedIconData = Icons.sell;
  Color _selectedColor = Colors.red;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.value = TextEditingValue(text: widget.category.name);

    if (widget.category.description != null) {
      _descriptionController.value =
          TextEditingValue(text: widget.category.description!);
    }

    _selectedIconData = IconData(int.parse(widget.category.iconName!));
    _selectedColor = Color(int.parse(widget.category.color!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryUpdaterBloc, CategoryUpdaterState>(
      listener: (context, state) {
        if (state is CategoryUpdaterLoadFailure) {
          showToast(context: context, message: state.message, isError: true);
        }

        if (state is CategoryUpdaterLoadSuccess) {
          showToast(
            context: context,
            message: 'Registrado con éxito',
          );
        }
      },
      child: SingleChildScrollView(
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
              ),
              CustomTextField(
                label: "Descripción",
                controller: _descriptionController,
              ),
              Ink(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                  onTap: () async {
                    final selected = await showIconPicker(
                      context,
                      iconPackModes: [IconPack.material],
                    );

                    if (selected != null) {
                      setState(() {
                        _selectedIconData = selected;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      IconData(
                        _selectedIconData.codePoint,
                        fontFamily: 'MaterialIcons',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Ink(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(8.0),
                  color: _selectedColor,
                ),
                child: InkWell(
                  onTap: () async {
                    // final color =
                    //     await showColorPickerDialog(context, _selectedColor);

                    // setState(() {
                    //   _selectedColor = color;
                    // });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 24.0,
                      height: 24.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              BlocBuilder<CategoryUpdaterBloc, CategoryUpdaterState>(
                builder: (context, state) {
                  if (state is CategoryUpdaterInProgress) {
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
      ),
    );
  }

  void _editCategory() async {
    BlocProvider.of<CategoryUpdaterBloc>(context).add(
      CategoryUpdaterPressed(
        categoryId: widget.category.categoryId,
        newData: (
          name: _nameController.text,
          description: _descriptionController.text,
          colorCode: '0xFF${_selectedColor}',
          iconName: _selectedIconData.codePoint.toString(),
        ),
      ),
    );
  }
}
