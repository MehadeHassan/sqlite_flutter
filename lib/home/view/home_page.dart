import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sqlite_flutter/models/models.dart';
import 'package:sqlite_flutter/services/database_service.dart';

import '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeCubit(context.read<DatabaseService>())..readDummyUser(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Text('Loading'),
              success: (users) => ShowUsers(users: users),
            );
          },
        ),
      ),
      floatingActionButton: ButtonBar(
        children: [
          TextButton(
              onPressed: context.read<HomeCubit>().createDummyUser,
              child: const Text('Create')),
          TextButton(
              onPressed: context.read<HomeCubit>().readDummyUser,
              child: const Text('Read')),

        ],
      ),
    );
  }
}

class ShowUsers extends StatelessWidget {
  const ShowUsers({
    Key? key,
    required this.users,
  }) : super(key: key);
  final List<User> users;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      physics: const BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        title: Text(users[index].name),
        subtitle: Text(users[index].id.toString()),
        onTap: () => context.read<HomeCubit>().deleteTable(users[index].id),
      ),
    );
  }
}
