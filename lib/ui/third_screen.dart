import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:suitmedia/data/model/user.dart';
import 'package:suitmedia/data/api/user_service.dart';
import 'package:suitmedia/utils/alert_dialog.dart';
import 'package:suitmedia/utils/app_bar.dart';
import 'package:suitmedia/utils/constants.dart';

class ThirdScreen extends StatefulWidget {
  final String userName;

  const ThirdScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late ScrollController _scrollController;
  late UserService _userService;
  final Logger _logger = Logger();

  final List<User> _users = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMorePages = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _userService = UserService();
    _fetchData();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_hasMorePages && !_isLoading) {
        await _fetchData();
      }
    }
  }

  Future<void> _fetchData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final List<User> fetchedUsers =
          await _userService.getUsers(page: _currentPage);

      setState(() {
        _users.addAll(fetchedUsers);
        _currentPage++;
        _isLoading = false;
        _hasMorePages = fetchedUsers.isNotEmpty;
      });
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _users.clear();
      _currentPage = 1;
      _hasMorePages = true;
    });
    await _fetchData();
  }

  Widget _buildBody() {
    if (_users.isEmpty && _isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_users.isEmpty) {
      return _buildEmptyState();
    } else {
      return _buildUserList();
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No users available'),
          ElevatedButton(
            onPressed: _refresh,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _users.length + 1,
        itemBuilder: (context, index) {
          return index == _users.length
              ? _buildLoadingIndicator()
              : _buildUserItem(_users[index]);
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container();
  }

  Widget _buildUserItem(User user) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(0),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
            ),
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Text(user.email),
            onTap: () => _handleUserItemClick(user),
          ),
        ),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }

  void _handleUserItemClick(User selectedUser) async {
    Navigator.pop(
        context, '${selectedUser.firstName} ${selectedUser.lastName}');
  }

  void _handleError(dynamic e) {
    _logger.e('An unexpected error occurred: $e');
    showErrorDialog(kErrorTitle, kErrorMessage);
  }

  void showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(title: title, message: message);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _userService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Third Screen'),
      body: _buildBody(),
    );
  }
}
