import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'user_list_view.dart';
import 'user_form_view.dart';
import '../viewmodels/user_view_model.dart';

class UserBottomNav extends StatefulWidget {
  @override
  _UserBottomNavState createState() => _UserBottomNavState();
}

class _UserBottomNavState extends State<UserBottomNav> {
  int _index = 0;
  final _pages = [
    UserListView(),
    Center(child: Text("Settings Tab (Placeholder)")),
  ];

  // Custom tab selection handler
  Future<void> _onTabSelected(int index) async {
    if (index == 1) {
      // Navigate to UserFormView
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => UserFormView(editUser: null),
        ),
      );

      // Refresh user list after form submission
      Provider.of<UserViewModel>(context, listen: false).loadUsers();
    } else {
      setState(() {
        _index = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _onTabSelected,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.list),
            label: 'Users List',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userPlus),
            label: 'Add User',
          ),
        ],
      ),
    );
  }
}
