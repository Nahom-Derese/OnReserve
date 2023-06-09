import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';

class EditProfileBottomSheet extends StatelessWidget {
  const EditProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        'Edit Profile',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close_outlined)),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Form(
                key: profileController.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 75,
                                  minHeight: 65,
                                ),
                                child: TextField(
                                  controller: profileController.fname,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'First Name',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 75,
                                  minHeight: 65,
                                ),
                                child: TextField(
                                  controller: profileController.lname,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Last Name',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 75,
                            minHeight: 65,
                          ),
                          child: TextFormField(
                            controller: profileController.phoneNumber,
                            keyboardType: TextInputType.phone,
                            validator: ValidationBuilder()
                                .phone()
                                .regExp(RegExp(r"^\+?((2519)|(09)|(9))\d{8}$"),
                                    "Invalid No. start with +251 or 09/07")
                                .build(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone Number',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 75,
                            minHeight: 65,
                          ),
                          child: TextField(
                            controller: profileController.profbio,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bio',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        // Logo Upload
                        GetBuilder<ProfileController>(
                            builder: (profileController) {
                          return Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    profileController.getImage(profile: true);
                                  },
                                  child: Container(
                                    height: 90,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: profileController.profilePic == null
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add_a_photo,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                              SizedBox(height: 8),
                                              Text(
                                                "Profile Image",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                              )
                                            ],
                                          )
                                        : Image.file(
                                            File(profileController
                                                .profilePic!.path),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    profileController.getImage(profile: false);
                                  },
                                  child: Container(
                                    height: 90,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: profileController.coverPic == null
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add_a_photo,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                              SizedBox(height: 8),
                                              Text(
                                                "Cover Image",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                              )
                                            ],
                                          )
                                        : Image.file(
                                            File(profileController
                                                .coverPic!.path),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        GetBuilder<ProfileController>(
                            builder: (profileController) {
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                if (profileController.formKey.currentState!
                                    .validate()) {
                                  if (await profileController.editProfile()) {
                                    Get.back();
                                    Get.snackbar("Success",
                                        'Successfuly Updated Profile');
                                  } else {
                                    Get.snackbar("Error", 'Error Occured...');
                                  }
                                }
                              },
                              child: profileController.isLoading
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    )
                                  : Text('Edit Profile'),
                            ),
                          );
                        }),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
