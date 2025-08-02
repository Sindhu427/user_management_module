// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../viewmodels/user_view_model.dart';
// import '../models/user_model.dart';

// class UserFormView extends StatefulWidget {
//   final User? editUser;
//   UserFormView({this.editUser});

//   @override
//   _UserFormViewState createState() => _UserFormViewState();
// }

// class _UserFormViewState extends State<UserFormView> {
//   final _formKey = GlobalKey<FormState>();
//   late String _name;
//   late String _email;

//   @override
//   void initState() {
//     super.initState();
//     _name = widget.editUser?.name ?? '';
//     _email = widget.editUser?.email ?? '';
//   }

//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) return "Email required";
//     final regexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     if (!regexp.hasMatch(value)) return "Invalid email";
//     return null;
//   }

//   String? _validateName(String? value) {
//     if (value == null || value.trim().isEmpty) return "Name required";
//     if (value.trim().length < 3) return "Name too short";
//     return null;
//   }

//   void _saveForm() async {
//     if (!_formKey.currentState!.validate()) return;
//     _formKey.currentState?.save();
//     final userVM = Provider.of<UserViewModel>(context, listen: false);

//     if (widget.editUser == null) {
//       await userVM.addUser(User(id: 0, name: _name, email: _email));
//     } else {
//       await userVM.editUser(
//         User(id: widget.editUser!.id, name: _name, email: _email),
//       );
//     }
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.editUser == null ? "Add User" : "Edit User"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 initialValue: _name,
//                 decoration: const InputDecoration(labelText: "Name"),
//                 validator: _validateName,
//                 onSaved: (v) => _name = v!.trim(),
//               ),
//               TextFormField(
//                 initialValue: _email,
//                 decoration: const InputDecoration(labelText: "Email"),
//                 validator: _validateEmail,
//                 onSaved: (v) => _email = v!.trim(),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _saveForm,
//                 child: Text(widget.editUser == null ? "Add" : "Update"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_view_model.dart';
import '../models/user_model.dart';

class UserFormView extends StatefulWidget {
  final User? editUser;
  UserFormView({this.editUser});

  @override
  _UserFormViewState createState() => _UserFormViewState();
}

class _UserFormViewState extends State<UserFormView> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;

  @override
  void initState() {
    super.initState();
    _name = widget.editUser?.name ?? '';
    _email = widget.editUser?.email ?? '';
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email required";
    final regexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regexp.hasMatch(value)) return "Invalid email";
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return "Name required";
    if (value.trim().length < 3) return "Name too short";
    return null;
  }

  void _saveForm() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    final userVM = Provider.of<UserViewModel>(context, listen: false);

    if (widget.editUser == null) {
      await userVM.addUser(User(id: 0, name: _name, email: _email));
    } else {
      await userVM.editUser(
        User(id: widget.editUser!.id, name: _name, email: _email),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            FaIcon(
              widget.editUser == null
                  ? FontAwesomeIcons.userPlus
                  : FontAwesomeIcons.userPen,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(widget.editUser == null ? "Add User" : "Edit User"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(
                  labelText: "Name",
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: FaIcon(FontAwesomeIcons.user),
                  ),
                ),
                validator: _validateName,
                onSaved: (v) => _name = v!.trim(),
              ),
              const SizedBox(height: 15),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: FaIcon(FontAwesomeIcons.envelope),
                  ),
                ),
                validator: _validateEmail,
                onSaved: (v) => _email = v!.trim(),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _saveForm,
                icon: FaIcon(
                  widget.editUser == null
                      ? FontAwesomeIcons.plus
                      : FontAwesomeIcons.check,
                  size: 16,
                ),
                label: Text(widget.editUser == null ? "Add" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
