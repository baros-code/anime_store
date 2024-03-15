import 'package:anime_store/features/anime/domain/entities/anime.dart';
import 'package:anime_store/features/anime/domain/entities/anime_character.dart';
import 'package:anime_store/features/anime/domain/entities/anime_character_response.dart';
import 'package:anime_store/features/anime/domain/entities/anime_genre.dart';
import 'package:anime_store/features/anime/domain/entities/anime_response.dart';
import 'package:anime_store/features/anime/domain/entities/custom_image.dart';
import 'package:anime_store/features/anime/domain/entities/image_url.dart';
import 'package:anime_store/features/anime/domain/entities/pagination.dart';
import 'package:anime_store/features/anime/domain/entities/pagination_items.dart';
import 'package:anime_store/features/anime/presentation/bloc/anime_cubit.dart';
import 'package:anime_store/features/anime/presentation/bloc/anime_state.dart';
import 'package:anime_store/features/anime/presentation/ui/models/anime_ui_model.dart';
import 'package:anime_store/stack/common/models/failure.dart';
import 'package:anime_store/stack/common/models/result.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/dummy_data/test_helper.mocks.dart';

void main() {
  late MockGetAnimeList mockGetAnimeList;
  late MockGetAnimeCharacters mockGetAnimeCharacters;
  late AnimeCubit animeCubit;

  setUp(() {
    mockGetAnimeList = MockGetAnimeList();
    mockGetAnimeCharacters = MockGetAnimeCharacters();
    animeCubit = AnimeCubit(
      mockGetAnimeList,
      mockGetAnimeCharacters,
    );
  });

  const testAnimeList = AnimeResponse(
    pagination: Pagination(
      lastPage: 10,
      currentPage: 1,
      items: PaginationItems(total: 50),
    ),
    data: [
      Anime(
        id: 1,
        title: 'Naruto',
        images: CustomImage(
          jpg: ImageUrl(imageUrl: 'imageUrl', smallImageUrl: 'smallImageUrl'),
          webp: ImageUrl(imageUrl: 'imageUrl', smallImageUrl: 'smallImageUrl'),
        ),
        score: 8.5,
        episodes: 25,
        synopsis: 'synopsis',
        type: 'TV',
        genres: [
          AnimeGenre(name: 'Drama'),
          AnimeGenre(name: 'Action'),
        ],
      )
    ],
  );

  const testAnimeCharacters = [
    AnimeCharacterResponse(
      character: AnimeCharacter(
        id: 1,
        name: 'name',
        images: CustomImage(
          jpg: ImageUrl(imageUrl: 'imageUrl', smallImageUrl: 'smallImageUrl'),
          webp: ImageUrl(imageUrl: 'imageUrl', smallImageUrl: 'smallImageUrl'),
        ),
      ),
      role: 'role',
      favorites: 1,
    ),
  ];

  test('initial state should be empty', () {
    expect(animeCubit.state, AnimeInitial());
  });

  blocTest<AnimeCubit, AnimeState>(
    'should emit [AnimeListFetched] when fetchAnimeList returns success',
    build: () {
      when(
        mockGetAnimeList(params: anyNamed('params')),
      ).thenAnswer(
        (_) async => Future.value(Result.success(value: testAnimeList)),
      );
      return animeCubit;
    },
    act: (cubit) => cubit.fetchAnimeList(1),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      AnimeListFetched(
        testAnimeList.data.map(AnimeUiModel.fromEntity).toList(),
      ),
    ],
  );

  blocTest<AnimeCubit, AnimeState>(
    'should emit [AnimeListFetchFailed] when fetchAnimeList returns error',
    build: () {
      when(
        mockGetAnimeList(params: anyNamed('params')),
      ).thenAnswer(
        (_) async => Future.value(
          Result.failure(
            const Failure(message: 'message'),
          ),
        ),
      );
      return animeCubit;
    },
    act: (cubit) => cubit.fetchAnimeList(1),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      AnimeListFetchFailed(),
    ],
  );

  blocTest<AnimeCubit, AnimeState>(
    '''should emit [AnimeCharactersLoading] first and [AnimeCharactersFetched] 
    when fetchAnimeCharacters returns success''',
    build: () {
      when(
        mockGetAnimeCharacters(params: anyNamed('params')),
      ).thenAnswer(
        (_) async => Future.value(
          Result.success(value: testAnimeCharacters),
        ),
      );
      return animeCubit;
    },
    act: (cubit) => cubit.fetchAnimeCharacters(1),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      AnimeCharactersLoading(),
      AnimeCharactersFetched(
        testAnimeCharacters.map((e) => e.character).toList(),
      ),
    ],
  );

  blocTest<AnimeCubit, AnimeState>(
    '''should emit [AnimeCharactersLoading] first and [AnimeCharactersFetchFailed] 
    when fetchAnimeCharacters returns error''',
    build: () {
      when(
        mockGetAnimeCharacters(params: anyNamed('params')),
      ).thenAnswer(
        (_) async => Future.value(
          Result.failure(
            const Failure(message: 'message'),
          ),
        ),
      );
      return animeCubit;
    },
    act: (cubit) => cubit.fetchAnimeCharacters(1),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      AnimeCharactersLoading(),
      AnimeCharactersFetchFailed(),
    ],
  );
}
