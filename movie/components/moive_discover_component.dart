// ignore_for_file: prefer_const_constructors, unused_local_variable
/* Discover 화면 */
/* Discover 화면 UI 위젯 
  1. 앱이 빌드 될 경우에는 처음에는 위젯에 아무것도 나타나지 않음(위젯 초기화)
  2. 앱이 빌드 될 경우에는 SilverToBoxAdapter로 보이다가 몇 초 뒤 영화 리스트들을 Carousel로 화면 넘기기 진행, 이 때 3초 간격으로 넘김
  3. 앱 빌드 중 에러가 발생하였을 경우에는 영화 리스트를 찾을 수 없다고 띄움
*/

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/movie/pages/movie_detail_page.dart';
import 'package:moviedb/movie/providers/movie_get_discover_provider.dart';
import 'package:moviedb/widget/item_movie_widget.dart';
import 'package:provider/provider.dart';

class MovieDiscoverComponent extends StatefulWidget {
  const MovieDiscoverComponent({super.key});

  @override
  State<MovieDiscoverComponent> createState() => _MovieDiscoverComponentState();
}

class _MovieDiscoverComponentState extends State<MovieDiscoverComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDiscoverProvider>(builder: (_, provider, __) {
        if (provider.isLoading) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            height: 300.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
            ),
          );
        }

        if (provider.movies.isNotEmpty) {
          return CarouselSlider.builder(
            itemCount: provider.movies.length,
            itemBuilder: (_, index, __) {
              final movie = provider.movies[index];
              return ItemMoiveWidget(
                movie: movie,
                heightBackdrop: 300,
                widthBackdrop: double.infinity,
                heightPoster: 160,
                widthPoster: 100,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) {
                      return MovieDetailPage(id: movie.id);
                    },
                  ));
                },
              );
            },
            options: CarouselOptions(
              autoPlayInterval: Duration(seconds: 3),
              height: 300.0,
              viewportFraction: 0.8,
              reverse: false,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          );
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          height: 300.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              'Not found discover movies',
              style: TextStyle(color: Colors.black45),
            ),
          ),
        );
      }),
    );
  }
}
