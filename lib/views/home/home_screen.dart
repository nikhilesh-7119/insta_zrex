import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/colors/app_colors.dart';
import '../../app/constants/app_constants.dart';
import '../../controllers/feed_controller.dart';
import '../../widgets/app_bar/instagram_app_bar.dart';
import '../../widgets/post/post_card.dart';
import '../../widgets/shimmer/feed_shimmer.dart';
import '../../widgets/story/stories_tray.dart';
import '../placeholder/coming_soon_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final List<Widget> _placeholderScreens = const [
    SizedBox.shrink(), // Home — handled separately
    ComingSoonScreen(label: 'Reels', icon: Icons.play_circle_outline),
    ComingSoonScreen(label: 'Messages', icon: Icons.near_me_outlined),
    ComingSoonScreen(label: 'Search', icon: Icons.search),
    ComingSoonScreen(label: 'Profile', icon: Icons.person_outline),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final controller = Get.find<FeedController>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent -
            (_estimatedPostHeight * AppConstants.paginationTriggerOffset)) {
      controller.loadMorePosts();
    }
  }

  // Estimated post card height for trigger calculation
  static const double _estimatedPostHeight = 500.0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final dividerColor =
        isDark ? AppColors.darkDivider : AppColors.lightDivider;

    return Scaffold(
      backgroundColor: bgColor,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildFeed(),
          ..._placeholderScreens.skip(1),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(
            top: BorderSide(color: dividerColor, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          backgroundColor: bgColor,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor:
              isDark ? AppColors.darkIcon : AppColors.lightIcon,
          unselectedItemColor:
              isDark ? AppColors.darkIcon : AppColors.lightIcon,
          items: [
            // Home
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                size: AppConstants.bottomNavIconSize,
              ),
              label: 'Home',
            ),
            // Reels — outlined circle play button
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.play_circle_outline,
                size: AppConstants.bottomNavIconSize,
              ),
              label: 'Reels',
            ),
            // DM / Messages — hollow triangle arrow
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.near_me_outlined,
                size: AppConstants.bottomNavIconSize,
              ),
              label: 'Messages',
            ),
            // Search
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: AppConstants.bottomNavIconSize,
              ),
              label: 'Search',
            ),
            // Profile — small avatar circle
            BottomNavigationBarItem(
              icon: _ProfileNavAvatar(
                isSelected: _selectedIndex == 4,
                isDark: isDark,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeed() {
    final controller = Get.find<FeedController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        // Sticky App Bar
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            child: const InstagramAppBar(),
            height: AppConstants.appBarHeight +
                MediaQuery.of(context).padding.top,
          ),
        ),
        // Stories Tray
        const SliverToBoxAdapter(
          child: StoriesTray(),
        ),
        // Post Feed
        Obx(() {
          if (controller.isLoading.value) {
            return const SliverToBoxAdapter(child: FeedShimmer());
          }
          if (controller.posts.isEmpty) {
            return SliverFillRemaining(
              child: Center(
                child: Text(
                  'Nothing to show yet',
                  style: TextStyle(
                    fontSize: AppConstants.fontSizeM,
                    color: isDark
                        ? AppColors.darkSubText
                        : AppColors.lightSubText,
                  ),
                ),
              ),
            );
          }
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index < controller.posts.length) {
                  return Obx(
                    () => PostCard(post: controller.posts[index]),
                  );
                }
                return null;
              },
              childCount: controller.posts.length,
            ),
          );
        }),
        // Pagination loading indicator
        Obx(() {
          if (!controller.isFetchingMore.value) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppConstants.paddingXL,
              ),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: isDark
                        ? AppColors.darkSubText
                        : AppColors.lightSubText,
                  ),
                ),
              ),
            ),
          );
        }),
        // Bottom padding
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  const _SliverAppBarDelegate({required this.child, required this.height});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}

class _ProfileNavAvatar extends StatelessWidget {
  final bool isSelected;
  final bool isDark;

  const _ProfileNavAvatar({required this.isSelected, required this.isDark});

  @override
  Widget build(BuildContext context) {
    const avatarUrl = 'https://i.pravatar.cc/150?img=15';
    return Container(
      width: AppConstants.bottomNavIconSize,
      height: AppConstants.bottomNavIconSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(
                color: isDark ? AppColors.darkText : AppColors.lightText,
                width: 2,
              )
            : null,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: avatarUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: isDark ? AppColors.darkPlaceholder : AppColors.lightPlaceholder,
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.person_outline,
            size: AppConstants.bottomNavIconSize,
            color: isDark ? AppColors.darkIcon : AppColors.lightIcon,
          ),
        ),
      ),
    );
  }
}
