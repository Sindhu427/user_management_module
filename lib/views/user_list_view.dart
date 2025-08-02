import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../viewmodels/user_view_model.dart';
import '../models/user_model.dart';
import 'user_form_view.dart';

class UserListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Management",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: userVM.loadUsers,
        child: userVM.loading
            ? const Center(child: CircularProgressIndicator())
            : userVM.error != null
                ? Center(child: Text(userVM.error!))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: userVM.users.length,
                      itemBuilder: (ctx, i) {
                        User user = userVM.users[i];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.deepPurple.shade100,
                              child: Text(
                                user.name.isNotEmpty
                                    ? user.name[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                            title: Text(
                              user.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(user.email),
                            trailing: PopupMenuButton<String>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              icon: const FaIcon(
                                FontAwesomeIcons.ellipsisVertical,
                                color: Colors.grey,
                                size: 20,
                              ),
                              onSelected: (value) async {
                                if (value == "edit") {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          UserFormView(editUser: user),
                                    ),
                                  );
                                  userVM.loadUsers();
                                }
                                if (value == "delete") {
                                  await userVM.deleteUser(user.id);
                                }
                              },
                              itemBuilder: (_) => [
                                const PopupMenuItem(
                                  value: "edit",
                                  child: Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.penToSquare,
                                          color: Colors.blue),
                                      SizedBox(width: 8),
                                      Text("Edit"),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: "delete",
                                  child: Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.trash,
                                          color: Colors.red),
                                      SizedBox(width: 8),
                                      Text("Delete"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {
      //     await Navigator.of(context).push(
      //       MaterialPageRoute(builder: (_) => UserFormView(editUser: null)),
      //     );
      //     userVM.loadUsers();
      //   },
      //   icon: const FaIcon(FontAwesomeIcons.userPlus),
      //   label: const Text("Add User"),
      //   backgroundColor: Colors.deepPurple,
      // ),
    );
  }
}
