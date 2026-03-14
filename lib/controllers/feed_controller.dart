import 'package:get/get.dart';
import '../models/post_model.dart';
import '../services/post_repository.dart';

class FeedController extends GetxController {
  final PostRepository _repo = PostRepository();

  final RxList<PostModel> posts = <PostModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isFetchingMore = false.obs;

  int _currentPage = 0;

  @override
  void onInit() {
    super.onInit();
    loadInitialPosts();
  }

  Future<void> loadInitialPosts() async {
    isLoading.value = true;
    _currentPage = 0;
    final result = await _repo.fetchPage(0);
    posts.assignAll(result);
    isLoading.value = false;
  }

  Future<void> loadMorePosts() async {
    if (isFetchingMore.value) return;
    isFetchingMore.value = true;
    _currentPage++;
    final more = await _repo.fetchPage(_currentPage);
    posts.addAll(more);
    isFetchingMore.value = false;
  }

  void toggleLike(String postId) {
    final idx = posts.indexWhere((p) => p.id == postId);
    if (idx == -1) return;
    final post = posts[idx];
    posts[idx] = post.copyWith(
      isLiked: !post.isLiked,
      likesCount: post.isLiked ? post.likesCount - 1 : post.likesCount + 1,
    );
  }

  void toggleSave(String postId) {
    final idx = posts.indexWhere((p) => p.id == postId);
    if (idx == -1) return;
    final post = posts[idx];
    posts[idx] = post.copyWith(isSaved: !post.isSaved);
  }
}
