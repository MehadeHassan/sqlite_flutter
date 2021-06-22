import 'package:bloc/bloc.dart';
import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqlite_flutter/models/models.dart';

import 'package:sqlite_flutter/services/database_service.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._databaseService,
  ) : super(const HomeState.initial());

  final DatabaseService _databaseService;

  void createDummyUser() async {
    final faker = Faker();

    final user = User(
      id: faker.guid.random.integer(99999),
      name: faker.person.name(),
    );
    await _databaseService.create(user);
  }

  void readDummyUser() async {
    _loadUser(List<User> users) {
      emit(HomeState.success(users));
    }

    final users = await _databaseService.user();
    users.listen(_loadUser);
  }

  void deleteTable(int id) async {
    await _databaseService.removeData(id);

    readDummyUser();
  }
}
