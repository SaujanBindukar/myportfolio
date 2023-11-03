import 'package:appwrite/appwrite.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/core/appwrite_client.dart';
import 'package:myportfolio/core/colors.dart';
import 'package:myportfolio/core/responsive_extensions.dart';
import 'package:myportfolio/core/widget/custom_svg.dart';
import 'package:myportfolio/core/widget/header_text.dart';
import 'package:myportfolio/utils/appwrite_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends ConsumerStatefulWidget {
  const ContactPage({
    super.key,
  });

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
    final isMobile = context.isMobile;
    return Column(
      children: [
        Padding(
          padding: isMobile
              ? const EdgeInsets.fromLTRB(0, 20, 0, 0)
              : const EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: Column(
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
                            const HeaderText(label: 'Contact Me'),
                            const SizedBox(height: 10),
                            Text(
                              'Do you have an app idea and want to develop it?',
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: AppColors.onPrimaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'Feel free to contact me. I am always ',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      color: AppColors.onPrimaryColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'OPEN TO WORK!',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.onPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 20 : 40,
                                  vertical: isMobile ? 20 : 40),
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
                                    const SizedBox(height: 10),
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
                                    const SizedBox(height: 10),
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
                                    const SizedBox(height: 30),
                                    InkWell(
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          final databases = Databases(client);
                                          Future result =
                                              databases.createDocument(
                                            databaseId:
                                                AppwriteUtils.databaseId,
                                            collectionId:
                                                '65182d4e2f7674e94a1d',
                                            documentId: DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString(),
                                            data: {
                                              'name': _nameController.text,
                                              'email': _emailController.text,
                                              'message':
                                                  _messageController.text,
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
                                                    ?.copyWith(
                                                        color: Colors.white),
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
                                                    ?.copyWith(
                                                        color: Colors.white),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColors.primaryColor,
                                        ),
                                        child: isLoading
                                            ? const SizedBox(
                                                height: 25,
                                                width: 25,
                                                child:
                                                    CircularProgressIndicator(),
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
                      if (!isMobile)
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
              const SizedBox(height: 20),
            ],
          ),
        ),
        const AppFooter()
      ],
    );
  }
}

class AppFooter extends StatelessWidget {
  const AppFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: AppColors.onPrimaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Follow Me',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await FirebaseAnalytics.instance.logEvent(
                        name: 'linkedin_click',
                      );
                      launchUrl(
                        Uri.parse(
                          'https://www.linkedin.com/in/saujan-bindukar-8b165714b/',
                        ),
                        webOnlyWindowName: '_blank',
                      );
                    },
                    icon: Image.asset(
                      'assets/social_icons/linkedin.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await FirebaseAnalytics.instance.logEvent(
                        name: 'github_click',
                      );
                      launchUrl(
                        Uri.parse('https://github.com/SaujanBindukar'),
                        webOnlyWindowName: '_blank',
                      );
                    },
                    icon: Image.asset(
                      'assets/social_icons/github.png',
                      color: Colors.white,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await FirebaseAnalytics.instance.logEvent(
                        name: 'medium_click',
                      );
                      launchUrl(
                        Uri.parse('https://medium.com/@saujanbindukar'),
                        webOnlyWindowName: '_blank',
                      );
                    },
                    icon: Image.asset(
                      'assets/social_icons/medium.png',
                      color: Colors.white,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await FirebaseAnalytics.instance.logEvent(
                        name: 'email_click',
                      );
                      await Clipboard.setData(
                        const ClipboardData(text: 'sauzanbindukar@gmail.com'),
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: AppColors.primaryColor,
                        content: Text(
                          'Email copied to clipboard!',
                          // ignore: use_build_context_synchronously
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ));
                    },
                    icon: const Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              )
            ],
          ),
          Center(
            child: Text(
              'Made with Flutter & Appwrite',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
