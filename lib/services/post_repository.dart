import '../app/constants/app_constants.dart';
import '../models/post_model.dart';
import '../models/story_model.dart';
import '../models/user_model.dart';

class PostRepository {
  // ─── Mock Users ───────────────────────────────────────────────────────────
  static final List<UserModel> _mockUsers = [
    const UserModel(
      id: 'u1',
      username: 'nature.vibes',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      isVerified: false,
      isFollowing: true,
    ),
    const UserModel(
      id: 'u2',
      username: 'travel_with_alex',
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      isVerified: true,
      isFollowing: true,
    ),
    const UserModel(
      id: 'u3',
      username: 'cityscape.daily',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      isVerified: false,
      isFollowing: false,
    ),
    const UserModel(
      id: 'u4',
      username: 'foodie.tales',
      avatarUrl: 'https://i.pravatar.cc/150?img=4',
      isVerified: false,
      isFollowing: true,
    ),
    const UserModel(
      id: 'u5',
      username: 'portrait.studio',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      isVerified: true,
      isFollowing: false,
    ),
    const UserModel(
      id: 'u6',
      username: 'mountain.hike',
      avatarUrl: 'https://i.pravatar.cc/150?img=6',
      isVerified: false,
      isFollowing: true,
    ),
    const UserModel(
      id: 'u7',
      username: 'ocean.breeze',
      avatarUrl: 'https://i.pravatar.cc/150?img=7',
      isVerified: false,
      isFollowing: true,
    ),
    const UserModel(
      id: 'u8',
      username: 'urban.explorer',
      avatarUrl: 'https://i.pravatar.cc/150?img=8',
      isVerified: true,
      isFollowing: false,
    ),
    const UserModel(
      id: 'u9',
      username: 'sunset.chaser',
      avatarUrl: 'https://i.pravatar.cc/150?img=9',
      isVerified: false,
      isFollowing: true,
    ),
    const UserModel(
      id: 'u10',
      username: 'minimal.art',
      avatarUrl: 'https://i.pravatar.cc/150?img=10',
      isVerified: false,
      isFollowing: true,
    ),
  ];

  // ─── Mock Captions ────────────────────────────────────────────────────────
  static const List<String> _captions = [
    'The mountains are calling and I must go. 🏔️ Every summit is a new beginning. #nature #mountains #hiking',
    'Lost in the city lights ✨ There\'s something magical about the way the night transforms everything.',
    'Good food, good mood 🍜 This bowl of ramen literally made my week. Highly recommend!',
    'Chasing golden hour every single day 🌅 #photography #sunset #goldenhour',
    'Sometimes you need to step back and appreciate the view 🌊',
    'Coffee and conversations ☕ The best mornings are the ones with nowhere to be.',
    'This place took my breath away. No filter needed. 🌿 #travel #nature #nofilter',
    'Street photography is about capturing life as it unfolds. 📸 #streetphotography #urban',
    'The ocean has a way of making all your worries feel small 🌊 #ocean #waves #peace',
    'Minimalism is not about having less. It\'s about making room for more of what matters. 🤍',
    'Adventure awaits around every corner 🗺️ Keep exploring, keep discovering. #wanderlust',
    'There is no WiFi in the forest, but I promise you will find a better connection 🌲 #forest #nature',
    'Every morning is a fresh start. Make it count! ☀️ #motivation #morning',
    'Art is not what you see, but what you make others see 🎨 #art #creativity',
    'The best views come after the hardest climbs 🏔️ Worth every step.',
    'Life is a collection of moments. Make them beautiful 📷 #photography #life',
    'Wandering where the WiFi is weak and the mountains are strong 🏕️ #camping #outdoors',
    'Just a small town girl living in a lonely world 🌍 #travel #adventure',
    'Find beauty in the ordinary ✨ Sometimes the best shots are right in front of you.',
    'Keep your face always toward the sunshine ☀️ and shadows will fall behind you.',
  ];

  static const List<String?> _locations = [
    'Swiss Alps, Switzerland',
    'Tokyo, Japan',
    null,
    'Santorini, Greece',
    null,
    'New York City',
    'Bali, Indonesia',
    null,
    'Maldives',
    null,
    'Paris, France',
    'Yosemite National Park',
    null,
    'Barcelona, Spain',
    null,
  ];

  static const List<String> _timeAgo = [
    '2 minutes ago',
    '15 minutes ago',
    '1 hour ago',
    '2 hours ago',
    '3 hours ago',
    '5 hours ago',
    '8 hours ago',
    '12 hours ago',
    '1 day ago',
    '2 days ago',
  ];

  // ─── Image Seeds ──────────────────────────────────────────────────────────
  static const List<String> _imageSeeds = [
    'forest1', 'city2', 'food3', 'sunset4', 'ocean5',
    'street6', 'mountain7', 'portrait8', 'cafe9', 'minimal10',
    'travel11', 'nature12', 'art13', 'urban14', 'beach15',
    'landscape16', 'architecture17', 'flower18', 'lake19', 'desert20',
    'aurora21', 'waterfall22', 'canyon23', 'jungle24', 'snow25',
    'bridge26', 'skyline27', 'garden28', 'cliff29', 'valley30',
  ];

  String _imageUrl(String seed, {int width = 800, int height = 800}) {
    return 'https://picsum.photos/seed/$seed/$width/$height';
  }

  List<String> _imageUrlsForPost(int index) {
    final seed1 = _imageSeeds[index % _imageSeeds.length];
    final seed2 = _imageSeeds[(index + 10) % _imageSeeds.length];
    final seed3 = _imageSeeds[(index + 20) % _imageSeeds.length];

    final mod = index % 10;
    if (mod == 0 || mod == 3 || mod == 6) {
      // 3-image carousel
      return [_imageUrl(seed1), _imageUrl(seed2), _imageUrl(seed3)];
    } else if (mod == 1 || mod == 4 || mod == 7) {
      // 2-image carousel
      return [_imageUrl(seed1), _imageUrl(seed2)];
    }
    // single image
    return [_imageUrl(seed1)];
  }

  PostModel _buildPost(int absoluteIndex) {
    final user = _mockUsers[absoluteIndex % _mockUsers.length];
    final caption = _captions[absoluteIndex % _captions.length];
    final location = _locations[absoluteIndex % _locations.length];
    final timeAgo = _timeAgo[absoluteIndex % _timeAgo.length];
    final imageUrls = _imageUrlsForPost(absoluteIndex);

    return PostModel(
      id: 'post_$absoluteIndex',
      user: user.copyWith(
        id: '${user.id}_$absoluteIndex',
        username: absoluteIndex > 9
            ? '${user.username}_${absoluteIndex ~/ 10}'
            : user.username,
      ),
      imageUrls: imageUrls,
      caption: caption,
      likesCount: 1000 + (absoluteIndex * 1337) % 49000,
      commentsCount: 10 + (absoluteIndex * 73) % 990,
      timeAgo: timeAgo,
      isLiked: false,
      isSaved: false,
      location: location,
    );
  }

  // ─── Public API ───────────────────────────────────────────────────────────

  Future<List<PostModel>> fetchPage(int page) async {
    await Future.delayed(AppConstants.shimmerDelay);
    final start = page * AppConstants.postsPerPage;
    return List.generate(
      AppConstants.postsPerPage,
      (i) => _buildPost(start + i),
    );
  }

  Future<List<StoryModel>> fetchStories() async {
    await Future.delayed(AppConstants.storiesDelay);
    return [
      // "Your Story" first
      const StoryModel(
        id: 'story_own',
        user: UserModel(
          id: 'own',
          username: 'Your Story',
          avatarUrl: 'https://i.pravatar.cc/150?img=15',
        ),
        isSeen: false,
        isOwn: true,
      ),
      ...List.generate(11, (i) {
        final img = i + 1;
        return StoryModel(
          id: 'story_$i',
          user: UserModel(
            id: 'su_$i',
            username: _mockUsers[i % _mockUsers.length].username,
            avatarUrl: 'https://i.pravatar.cc/150?img=${img + 20}',
          ),
          isSeen: i >= 8,
        );
      }),
    ];
  }
}
