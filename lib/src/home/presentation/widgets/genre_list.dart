import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/utils.dart';
import 'package:movies_app/src/home/domain/entities/genre_entity.dart';
import 'package:movies_app/src/home/presentation/blocs/genre_bloc/genre_bloc.dart';
import 'package:movies_app/src/home/presentation/blocs/movie_bloc/movie_bloc.dart';
import 'package:shimmer/shimmer.dart';

class GenreList extends StatefulWidget {
  const GenreList({super.key});

  @override
  State<GenreList> createState() => _GenreListState();
}

class _GenreListState extends State<GenreList> {
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreBloc, GenreState>(
      builder: (context, state) {
        if (state is GenreLoadingState ||
            state is GenreEmptyState ||
            state is GenreErrorState) {
          return _buildGenreLoadingList(itemCount: 5);
        } else if (state is GenreLoadedState) {
          return _buildGenreList(state);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildGenreList(GenreLoadedState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 12.0),
          child: Text(
            'Genre List',
            style: CustomTextStyle.textLargeSemiBold,
          ),
        ),
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.only(left: 16.0),
          color: Colors.white,
          height: 70.0,
          child: ListView.separated(
            itemCount: state.genres.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (state.genres.length == 5) {
                return _buildGenreItem();
              } else {
                GenreEntity genre = state.genres[index];
                bool isSelected = _currentPageNotifier.value == index;
                return _buildGenreItem(
                  isSelected: isSelected,
                  genre: genre,
                  onTap: () {
                    context
                        .read<MovieBloc>()
                        .add(ChangeMoviesByGenreEvent(id: genre.id!));
                    _currentPageNotifier.value = index;
                    setState(() {});
                  },
                );
              }
            },
            separatorBuilder: (context, index) => const SizedBox(width: 2.0),
          ),
        ),
      ],
    );
  }

  Widget _buildGenreLoadingList(
      {required int itemCount, GenreLoadedState? state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            height: 25.0,
            width: 120.0,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Shimmer.fromColors(
              baseColor: AppColors.greyColor,
              highlightColor: const Color(0xFFe1e1e1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        Container(
          padding: const EdgeInsets.only(left: 16.0),
          color: Colors.white,
          height: 70.0,
          child: ListView.separated(
            itemCount: itemCount,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (itemCount == 5) {
                return _buildGenreItem();
              } else {
                GenreEntity genre = state!.genres[index];
                bool isSelected = _currentPageNotifier.value == index;
                return _buildGenreItem(
                  isSelected: isSelected,
                  genre: genre,
                  onTap: () {
                    context
                        .read<MovieBloc>()
                        .add(ChangeMoviesByGenreEvent(id: genre.id!));
                    _currentPageNotifier.value = index;
                    setState(() {});
                  },
                );
              }
            },
            separatorBuilder: (context, index) => const SizedBox(width: 2.0),
          ),
        ),
      ],
    );
  }

  Widget _buildGenreItem(
      {bool isSelected = false, GenreEntity? genre, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ValueListenableBuilder<int>(
        valueListenable: _currentPageNotifier,
        builder: (context, currentPage, child) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                    color:
                        isSelected ? AppColors.blackColor : AppColors.greyColor,
                    width: 2.0),
              ),
              child: Center(
                child: Text(
                  genre?.name ?? '',
                  style: CustomTextStyle.textExtraSmallRegular
                      .copyWith(fontSize: 10.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
