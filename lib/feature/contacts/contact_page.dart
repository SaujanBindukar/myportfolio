import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/core/appwrite_client.dart';
import 'package:myportfolio/core/colors.dart';
import 'package:myportfolio/core/widget/custom_svg.dart';
import 'package:myportfolio/utils/appwrite_utils.dart';

class ContactPage extends ConsumerStatefulWidget {
  const ContactPage({super.key});

  @override
  ConsumerState<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends ConsumerState<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final client = ref.read(appwriteClient);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Contact Me',
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Do you have an app idea and want to develop it?',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Feel free to contact me. I am always OPEN TO WORK!',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 4,
                                blurRadius: 20,
                              )
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 40),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Full Name',
                                    fillColor: Colors.grey.withOpacity(0.2),
                                    filled: true,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    fillColor: Colors.grey.withOpacity(0.2),
                                    filled: true,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _messageController,
                                  maxLines: 5,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter message';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Your message',
                                    fillColor: Colors.grey.withOpacity(0.2),
                                    filled: true,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                InkWell(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      final databases = Databases(client);
                                      Future result = databases.createDocument(
                                        databaseId: AppwriteUtils.databaseId,
                                        collectionId: '65182d4e2f7674e94a1d',
                                        documentId:
                                            _emailController.text.trim(),
                                        data: {
                                          'name': _nameController.text,
                                          'email': _emailController.text,
                                          'message': _messageController.text,
                                        },
                                      );
                                      result.then((value) {
                                        _emailController.clear();
                                        _nameController.clear();
                                        _messageController.clear();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          content: Text(
                                            'Thanks for the message. I will contact you shorly.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ));
                                      }).onError((error, stackTrace) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          content: Text(
                                            error.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ));
                                      });
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.primaryColor,
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: CircularProgressIndicator(),
                                          )
                                        : Text(
                                            'Submit',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: CustomSvg(
                      path: 'assets/images/contacts.svg',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Text(
              'Made with Flutter & Appwrite',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          )
        ],
      ),
    );
  }
}
