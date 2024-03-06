import 'package:flutter/material.dart';
import 'package:flutter_movie_app/domain/entities/movies/discover_movies_entity.dart';
import 'package:flutter_movie_app/domain/use_cases/show_movies_use_case.dart';
import 'package:flutter_movie_app/presenter/states/app_states.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class MoviesController extends ChangeNotifier {
  final ShowMoviesUseCase _showMoviesUseCase;
  AppState appState = LoadingState();
  late DiscoverMoviesEntity movieLists;

  MoviesController(this._showMoviesUseCase);

  Future<Either<Exception, DiscoverMoviesEntity>> getMovies() async {
    final result = await _showMoviesUseCase();
    return result.fold((failure) {
      appState = FailureState();
      notifyListeners();
      return Left(failure);
    }, (success) {
      movieLists = success;
      appState = SuccessState();
      notifyListeners();
      return Right(success);
    });
  }
}
