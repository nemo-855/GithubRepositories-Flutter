import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repositories_flutter/ui/top/top_ui_state.dart';
import 'package:github_repositories_flutter/ui/top/top_view_model.dart';

class TopPage extends ConsumerStatefulWidget {
  const TopPage({super.key});

  @override
  TopPageState createState() => TopPageState();
}

class TopPageState extends ConsumerState<TopPage> {
  @override
  void initState() {
    super.initState();

    ref.read(topViewModelProvider.notifier).onInitialized();
  }

  @override
  Widget build(BuildContext context) {
    // FIXME このアセットのパスと、jsonのキーのハードコーディングを辞めたい
    DefaultAssetBundle.of(context).loadString('assets/locales/strings.json').then((value) =>
        ref.read(topViewModelProvider.notifier).onTextAssetSet(
          pageName: jsonDecode(value)["top_page_name"],
          pageDescription: jsonDecode(value)["top_page_description"],
          projectsSectionTitle: jsonDecode(value)["all_projects"],
      )
    );
    final state = ref.watch(topViewModelProvider);

    return Scaffold(
      appBar: _buildAppBar(
          pageName: state.pageName,
          pageDescription: state.pageDescription,
          onPressedSearchButton: () => {
            // TODO 実装
          }
      ),
      body: _buildScaffoldBody(
          state: state,
          onProjectCardPressed: () => {
            // TODO 実装
          },
          onCarouselPageChanged: (index) => {
            ref.read(topViewModelProvider.notifier).onCarouselPageChanged(newIndex: index)
          }
      )
    );
  }

  AppBar _buildAppBar({
    required String pageName,
    required String pageDescription,
    required VoidCallback onPressedSearchButton,
  }) {
    return AppBar(
      leadingWidth: double.infinity,
      leading: Container(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pageName,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
            Text(
              pageDescription,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: onPressedSearchButton,
        )
      ],
    );
  }
  
  Widget _buildScaffoldBody({
    required TopUiState state,
    required VoidCallback onProjectCardPressed,
    required Function(int index) onCarouselPageChanged,
  }) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarousel(
                uiModel: state.carouselUiModel,
                onPageChanged: onCarouselPageChanged,
            ),
            const SizedBox(
              width: double.infinity,
              height: 16,
            ),
            Text(
              state.projectsSectionTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                ),
                primary: false,
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                itemCount: state.projects.length,
                itemBuilder: (context, index) {
                  return _buildProjectCard(
                    uiModel: state.projects[index],
                    onPressed: onProjectCardPressed,
                  );
                }
            )
          ],
        ),
      );
    }
  }

  Widget _buildProjectCard({
    required ProjectUiModel uiModel,
    required VoidCallback onPressed,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.network(uiModel.ownerImage),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ClipRect(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: Container(
                      width: double.infinity,
                      color: Colors.white.withOpacity(0.0),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Text(
                              uiModel.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                        ),
                        const Icon(Icons.arrow_circle_right_sharp),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel({
    required CarouselUiModel uiModel,
    required Function(int index) onPageChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: 100,
          child: CarouselSlider.builder(
            itemCount: uiModel.images.length,
            options: CarouselOptions(
              scrollDirection: Axis.horizontal,
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              onPageChanged: (int index, CarouselPageChangedReason reason) => {
                onPageChanged(index)
              }
            ),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    _buildCarouselCard(uiModel.images[itemIndex]),
          ),
        ),
        _buildDotsIndicator(
            itemCount: uiModel.images.length,
            currentIndex: uiModel.currentIndex,
        )
      ],
    );
  }

  Widget _buildCarouselCard(String image) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        )
    );
  }

  Widget _buildDotsIndicator({
    required int itemCount,
    required int currentIndex
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
          itemCount,
          (int index) => Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index ? Colors.black : Colors.grey),
              )
      ),
    );
  }
}