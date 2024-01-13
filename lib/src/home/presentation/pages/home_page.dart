import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/utils.dart';
import 'package:movies_app/src/home/presentation/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text('The Movie List'),
        shadowColor: AppColors.greyColor,
        elevation: 1.0,
      ),
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: MovieCarousel(),
          ),
          SliverToBoxAdapter(
            child: GenreList(),
          ),
          SliverToBoxAdapter(
            child: MovieGrid(),
          ),
        ],
      ),
    );
  }
}
