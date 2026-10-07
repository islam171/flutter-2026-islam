import 'package:flutter/material.dart';
import 'package:never_overflows/contact_card.dart';

import 'contacts.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const Text("20 contacts"),
      Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (BuildContext context, int index) {
            return ContactCard(contact: contacts[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: Colors.green);
          },
          itemCount: contacts.length,
        ),
      ),
    ],
  );
}
