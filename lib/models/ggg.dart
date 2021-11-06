import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late Iterable<Contact> _contacts;

  var list = [];

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
    list =_contacts.toList();
    var mobilenum;
    for(int i =0;i<list.length;i++){
      if(_contacts.elementAt(i).phones.isNotEmpty){
     mobilenum = _contacts.elementAt(i).phones.first.value.toString();
     print(mobilenum);}

      //print(_contacts.elementAt(i).phones.first..toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text('Contacts')),
      ),
      body: _contacts != null
      //Build a list view of all contacts, displaying their avatar and
      // display name
          ? ListView.builder(
        itemCount: _contacts?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          Contact contact = _contacts.elementAt(index);
          return ListTile(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
            leading: (contact.avatar != null && contact.avatar.isNotEmpty)
                ? CircleAvatar(
              backgroundImage: MemoryImage(contact.avatar),
            )
                : CircleAvatar(
              child: Text(contact.initials()),
              backgroundColor: Theme.of(context).accentColor,
            ),
            title: Text(_contacts.elementAt(index).displayName ?? ''),
            //This can be further expanded to showing contacts detail
            // onPressed().
          );
        },
      )
          : Center(child: const CircularProgressIndicator()),
    );
  }
}