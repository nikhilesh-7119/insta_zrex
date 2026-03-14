import 'user_model.dart';

class PostModel {
  final String id;
  final UserModel user;
  final List<String> imageUrls;
  final String caption;
  final int likesCount;
  final int commentsCount;
  final int repostsCount;
  final int sharesCount;
  final String timeAgo;
  final bool isLiked;
  final bool isSaved;
  final String? location;
  final String? audioInfo;
  final String? likedByUser;
  final List<String> likedByAvatars;

  const PostModel({
    required this.id,
    required this.user,
    required this.imageUrls,
    required this.caption,
    required this.likesCount,
    required this.commentsCount,
    this.repostsCount = 0,
    this.sharesCount = 0,
    required this.timeAgo,
    this.isLiked = false,
    this.isSaved = false,
    this.location,
    this.audioInfo,
    this.likedByUser,
    this.likedByAvatars = const [],
  });

  PostModel copyWith({
    String? id,
    UserModel? user,
    List<String>? imageUrls,
    String? caption,
    int? likesCount,
    int? commentsCount,
    int? repostsCount,
    int? sharesCount,
    String? timeAgo,
    bool? isLiked,
    bool? isSaved,
    String? location,
    String? audioInfo,
    String? likedByUser,
    List<String>? likedByAvatars,
  }) {
    return PostModel(
      id: id ?? this.id,
      user: user ?? this.user,
      imageUrls: imageUrls ?? this.imageUrls,
      caption: caption ?? this.caption,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      repostsCount: repostsCount ?? this.repostsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      timeAgo: timeAgo ?? this.timeAgo,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      location: location ?? this.location,
      audioInfo: audioInfo ?? this.audioInfo,
      likedByUser: likedByUser ?? this.likedByUser,
      likedByAvatars: likedByAvatars ?? this.likedByAvatars,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user.toJson(),
        'imageUrls': imageUrls,
        'caption': caption,
        'likesCount': likesCount,
        'commentsCount': commentsCount,
        'repostsCount': repostsCount,
        'sharesCount': sharesCount,
        'timeAgo': timeAgo,
        'isLiked': isLiked,
        'isSaved': isSaved,
        'location': location,
        'audioInfo': audioInfo,
        'likedByUser': likedByUser,
        'likedByAvatars': likedByAvatars,
      };

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'] as String,
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
        imageUrls: List<String>.from(json['imageUrls'] as List),
        caption: json['caption'] as String,
        likesCount: json['likesCount'] as int,
        commentsCount: json['commentsCount'] as int,
        repostsCount: json['repostsCount'] as int? ?? 0,
        sharesCount: json['sharesCount'] as int? ?? 0,
        timeAgo: json['timeAgo'] as String,
        isLiked: json['isLiked'] as bool? ?? false,
        isSaved: json['isSaved'] as bool? ?? false,
        location: json['location'] as String?,
        audioInfo: json['audioInfo'] as String?,
        likedByUser: json['likedByUser'] as String?,
        likedByAvatars: json['likedByAvatars'] != null
            ? List<String>.from(json['likedByAvatars'] as List)
            : const [],
      );
}
