import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_category/presentation/bloc/sponsors_category_create/sponsors_category_create_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';



class CategorySponsorRegisterForm extends StatefulWidget {
  final int eventId;
  final void Function(SponsorsCategoryModel?) _onCreated;
  const CategorySponsorRegisterForm(
      {super.key, required void Function(SponsorsCategoryModel?) onCreated, required this.eventId})
      : _onCreated = onCreated;

  @override
  State<CategorySponsorRegisterForm> createState() => _CategorySponsorRegisterFormState();
}

class _CategorySponsorRegisterFormState extends State<CategorySponsorRegisterForm>
    with Toaster {

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SponsorsCategoryCreateBloc, SponsorsCategoryCreateState>(
      listener: (context, state) {
        if (state is SponsorsCategoryCreateSuccess) {
          showToast(context: context, message: 'Categoría guardada');
          widget._onCreated(state.spcModel);
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Puedes crear nuevas categorías y organizar mejor tus Sponsors. Presiona "Guardar" para registrar tu nueva Categoría y asignarla a tu Sponsor',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                tooltip: "Por favor, seleccione la categoría que prefiera. Por ejemplo, puede ser Gold, Silver o Diamond.",
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
              BlocBuilder<SponsorsCategoryCreateBloc, SponsorsCategoryCreateState>(
                builder: (context, state) {
                  if (state is SponsorsCategoryCreateLoading) {
                    return const CupertinoActivityIndicator();
                  }

                  return Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(_nameController.text.trim().isEmpty){
                          return;
                        }
                        if(_descriptionController.text.trim().isEmpty){
                          return;
                        }
                        BlocProvider.of<SponsorsCategoryCreateBloc>(context).add(SponsorsCategoryStart(
                          spcRegister: (
                        spcName: _nameController.text,
                        spcDescription: _descriptionController.text,
                        eventId: widget.eventId
                        ))
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
