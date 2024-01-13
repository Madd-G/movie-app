import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/extensions/string_extensions.dart';
import 'package:movies_app/core/res/app_media.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/custom_text_style.dart';
import 'package:movies_app/src/home/domain/entities/movie_entity.dart';
import 'package:movies_app/src/home/presentation/blocs/movie_bloc/movie_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MovieGrid extends StatefulWidget {
  const MovieGrid({super.key});

  @override
  State<MovieGrid> createState() => _MovieGridState();
}

class _MovieGridState extends State<MovieGrid> {
  @override
  void initState() {
    super.initState();
    getMovies();
  }

  void getMovies() {
    context.read<MovieBloc>().add(GetMoviesByGenreEvent(id: 28));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MoviesLoadingState ||
              state is MoviesEmptyState ||
              state is MoviesErrorState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                Container(
                  height: 20.0,
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
                Shimmer.fromColors(
                  baseColor: AppColors.greyColor,
                  highlightColor: const Color(0xFFe1e1e1),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 260.0,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    itemCount: 4,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctx, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20.0),
                          AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
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
                          const SizedBox(height: 8.0),
                          Container(
                            height: 20.0,
                            width: 120.0,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
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
                          const SizedBox(height: 6.0),
                          Container(
                            height: 20.0,
                            width: 120.0,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
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
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is MoviesLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                const Text(
                  'Movies By Genre',
                  style: CustomTextStyle.textLargeSemiBold,
                ),
                const SizedBox(height: 20.0),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 240.0,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: state.movies.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext ctx, index) {
                    MovieEntity movie = state.movies[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: CachedNetworkImage(
                            imageUrl:
                                'http://image.tmdb.org/t/p/original${movie.posterPath}',
                            imageBuilder: (context, imageProvider) => ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            placeholder: (context, url) => ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                AppMedia.imageLoading,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
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
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          movie.title!,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.textLargeSemiBold,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          movie.releaseDate!.formatDate,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyle.textSmallRegular
                              .copyWith(color: AppColors.greyTextColor),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
