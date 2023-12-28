import 'package:flutter/material.dart';
import 'package:suitmedia/utils/app_bar.dart';
import 'package:suitmedia/ui/third_screen.dart';
import 'package:suitmedia/utils/utility.dart';

class SecondScreen extends StatefulWidget {
  final String userName;

  const SecondScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String? selectedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Second Screen'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                height: 3.0,
                letterSpacing: 0.0,
              ),
              textAlign: TextAlign.left,
            ),
            _buildUserNameText(widget.userName),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  selectedUser ?? 'Selected User Name',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserNameText(String userName) {
    return Text(
      userName,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildButton() {
    return buildButton(
      context: context,
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThirdScreen(userName: widget.userName),
          ),
        );

        setState(() {
          selectedUser = result;
        });
      },
      label: 'Choose a User',
    );
  }
}
