import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:rick_and_morty/data/datasources/local_datasource/db/database_helper.dart';
import 'package:rick_and_morty/data/datasources/local_datasource/local_datasource.dart';
import 'package:rick_and_morty/data/datasources/remote_datasource/remote_datasource.dart';
import 'package:rick_and_morty/domain/repository/app_repository.dart';

@GenerateMocks(
    [Dio, DatabaseHelper, RemoteDataSource, LocalDataSource, AppRepository])
void main() {}
