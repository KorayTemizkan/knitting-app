import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/supabase_provider.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Profil Güncelleme'),
      body: Column(
        children: [
          SizedBox(height: 50),

          Text('GÜNCELLEME EKRANI'),

          Divider(height: 50, thickness: 15, color: Colors.amber),

          TextField(
            controller: _firstNameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Ad',
            ),
          ),

          Divider(height: 50, thickness: 15, color: Colors.amber),

          TextField(
            controller: _lastNameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Soyad',
            ),
          ),

          Divider(height: 50, thickness: 15, color: Colors.amber),

          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Telefon Numarası',
            ),
          ),

          Divider(height: 50, thickness: 15, color: Colors.amber),

          ElevatedButton(
            onPressed: () {
              context.read<SupabaseProvider>().updateProfile(
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                phone: _phoneController.text,
              );

              context.pop();
            },
            child: Text('Güncelle'),
          ),
        ],
      ),
    );
  }
}
