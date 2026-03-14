import 'package:get/get.dart';
import '../models/story_model.dart';
import '../services/post_repository.dart';

class StoryController extends GetxController {
  final PostRepository _repo = PostRepository();

  final RxList<StoryModel> stories = <StoryModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadStories();
  }

  Future<void> loadStories() async {
    isLoading.value = true;
    final result = await _repo.fetchStories();
    stories.assignAll(result);
    isLoading.value = false;
  }

  void markSeen(String storyId) {
    final idx = stories.indexWhere((s) => s.id == storyId);
    if (idx != -1) {
      stories[idx] = stories[idx].copyWith(isSeen: true);
    }
  }
}
