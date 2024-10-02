// ignore_for_file: public_member_api_docs, sort_constructors_first
class Blog {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime updatedAt;

  Blog(
      {required this.id,
      required this.posterId,
      required this.title,
      required this.content,
      required this.imageUrl,
      required this.topics,
      required this.updatedAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'posterId': posterId,
      'title': title,
      'content': content,
      'iamgeUrl': imageUrl,
      'topics': topics,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  Blog copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return Blog(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
