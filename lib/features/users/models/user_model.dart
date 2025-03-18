import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? bio;
  final String? link;
  final String? avatarUrl;
  final List<String> followers;
  final List<String> following;
  final int followersCount;
  final int followingCount;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.bio,
    this.link,
    this.avatarUrl,
    List<String>? followers,
    List<String>? following,
    this.followersCount = 0,
    this.followingCount = 0,
    DateTime? createdAt,
    this.updatedAt,
  })  : followers = followers ?? [],
        following = following ?? [],
        createdAt = createdAt ?? DateTime.now();

  // JSON으로부터 UserModel 생성
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      bio: json['bio'] as String?,
      link: json['link'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
      followersCount: json['followersCount'] as int? ?? 0,
      followingCount: json['followingCount'] as int? ?? 0,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  // UserModel을 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'link': link,
      'avatarUrl': avatarUrl,
      'followers': followers,
      'following': following,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  // 현재 UserModel을 기반으로 새로운 UserModel 생성 (업데이트 시 사용)
  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? bio,
    String? link,
    String? avatarUrl,
    List<String>? followers,
    List<String>? following,
    int? followersCount,
    int? followingCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
