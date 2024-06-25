// import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/bloc/category_saver_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class CategoryRegisterForm extends StatefulWidget {
  final void Function(Category?) _onCreated;
  const CategoryRegisterForm(
      {super.key, required void Function(Category?) onCreated})
      : _onCreated = onCreated;

  @override
  State<CategoryRegisterForm> createState() => _CategoryRegisterFormState();
}

class _CategoryRegisterFormState extends State<CategoryRegisterForm>
    with Toaster {
  IconData _selectedIconData = Icons.sell;
  Color _selectedColor = Colors.red;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategorySaverBloc, CategorySaverState>(
      listener: (context, state) {
        if (state is CategorySaverLoadSuccess) {
          showToast(context: context, message: 'Categoría guardada');
          widget._onCreated(state.category);
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Puedes crear nuevas categorías y organizar mejor tus Actividades. Presiona "Guardar" para registrar tu nueva Categoría y asignarla a tu Actividad',
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
              BlocBuilder<CategorySaverBloc, CategorySaverState>(
                builder: (context, state) {
                  if (state is CategorySaverLoadInProgress) {
                    return const CupertinoActivityIndicator();
                  }

                  return Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        BlocProvider.of<CategorySaverBloc>(context).add(
                          SavedNewCategory(
                            categoryRegistrationForm: (
                              name: _nameController.text,
                              description: _descriptionController.text,
                              colorCode: '0xFF${_selectedColor}',
                              iconName: _selectedIconData.codePoint.toString(),
                            ),
                          ),
                        );
                      },
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
}
