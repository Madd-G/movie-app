import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/res/app_media.dart';
import 'package:movies_app/core/utils/utils.dart';
import 'package:movies_app/src/home/domain/entities/movie_entity.dart';
import 'package:movies_app/src/home/presentation/blocs/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MovieCarousel extends StatefulWidget {
  const MovieCarousel({super.key});

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    );

    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPageNotifier.value != next) {
        _currentPageNotifier.value = next;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeTimer();
    });
  }

  void _initializeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentPageNotifier.value + 1) % 20;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }


  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      builder: (context, state) {
        if (state is NowPlayingMoviesLoadingState ||
            state is NowPlayingMoviesErrorState) {
          return _buildLoadingState();
        } else if (state is NowPlayingMoviesLoadedState) {
          return _buildLoadedState(state);
        } else if (state is NowPlayingMoviesEmptyState) {
          return const Center(child: Text('Empty Movie'));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildLoadingState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShimmerContainer(20.0, 150.0),
        const SizedBox(height: 15.0),
        _buildShimmerPageView(2),
        const SizedBox(height: 15.0),
        _buildShimmerContainer(20.0, 120.0),
      ],
    );
  }

  Widget _buildLoadedState(NowPlayingMoviesLoadedState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0),
          child: Text(
            'Now Playing Movies',
            style: CustomTextStyle.textLargeSemiBold,
          ),
        ),
        const SizedBox(height: 15.0),
        _buildPageView(state.movies),
        const SizedBox(height: 10.0),
        _buildPageIndicator(state.movies.length),
      ],
    );
  }

  Widget _buildShimmerContainer(double height, double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 24.0),
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Shimmer.fromColors(
          baseColor: AppColors.greyColor,
          highlightColor: const Color(0xFFe1e1e1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.greyColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerPageView(int itemCount) {
    return SizedBox(
      height: 140.0,
      child: Shimmer.fromColors(
        baseColor: AppColors.greyColor,
        highlightColor: const Color(0xFFe1e1e1),
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: PageController(viewportFraction: 0.9),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.black),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPageView(List<MovieEntity> movies) {
    return SizedBox(
      height: 140.0,
      child: PageView.builder(
        onPageChanged: (index) {
          _currentPageNotifier.value = index;
          setState(() {});
        },
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemBuilder: (context, index) {
          MovieEntity movie = movies[index % movies.length];
          return Container(
            padding: const EdgeInsets.only(right: 10.0),
            child: _buildCachedNetworkImage(movie.backdropPath),
          );
        },
      ),
    );
  }

  Widget _buildCachedNetworkImage(String? backdropPath) {
    return CachedNetworkImage(
      imageUrl: 'http://image.tmdb.org/t/p/original$backdropPath',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: AppColors.greyColor,
        highlightColor: const Color(0xFFe1e1e1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: AppColors.greyColor,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Image.asset(
        AppMedia.imageError,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildPageIndicator(int itemCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Container(
          width: 9.0,
          height: 9.0,
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == _currentPageNotifier.value
                ? Colors.black
                : const Color(0xFFBBBBBB),
          ),
        ),
      ),
    );
  }
}
