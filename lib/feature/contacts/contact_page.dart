import 'package:flutter/material.dart';
import 'package:myportfolio/core/widget/custom_svg.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Contacts'),
              CustomSvg(
                path: 'assets/images/contacts.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
