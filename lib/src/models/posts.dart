// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

MyPost postsFromJson(String str) => MyPost.fromJson(json.decode(str));

String postsToJson(MyPost data) => json.encode(data.toJson());

class MyPost {
  
  static Future<MyPost> getAllPosts() async{
    var response = await http.get(Uri.https('techzombie.gr','/api/get_recent_posts'));
    MyPost allPosts = postsFromJson(response.body);
    return allPosts;
  }
  
  
  MyPost({
    this.status,
    this.count,
    this.countTotal,
    this.pages,
    this.posts,
  });

  String status;
  int count;
  int countTotal;
  int pages;
  List<Post> posts;

  factory MyPost.fromJson(Map<String, dynamic> json) => MyPost(
    status: json["status"],
    count: json["count"],
    countTotal: json["count_total"],
    pages: json["pages"],
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "count": count,
    "count_total": countTotal,
    "pages": pages,
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
  };
}

class Post {
  Post({
    this.id,
    this.type,
    this.slug,
    this.url,
    this.status,
    this.title,
    this.titlePlain,
    this.content,
    this.excerpt,
    this.date,
    this.modified,
    this.categories,
    this.tags,
    this.author,
    this.comments,
    this.attachments,
    this.commentCount,
    this.commentStatus,
    this.thumbnail,
    this.customFields,
    this.thumbnailSize,
    this.thumbnailImages,
    this.taxonomySeries,
  });

  int id;
  Type type;
  String slug;
  String url;
  Status status;
  String title;
  String titlePlain;
  String content;
  String excerpt;
  DateTime date;
  DateTime modified;
  List<Category> categories;
  List<Category> tags;
  Author author;
  List<Comment> comments;
  List<Attachment> attachments;
  int commentCount;
  CommentStatus commentStatus;
  String thumbnail;
  CustomFields customFields;
  ThumbnailSize thumbnailSize;
  Map<String, MyImage> thumbnailImages;
  List<dynamic> taxonomySeries;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    type: typeValues.map[json["type"]],
    slug: json["slug"],
    url: json["url"],
    status: statusValues.map[json["status"]],
    title: json["title"],
    titlePlain: json["title_plain"],
    content: json["content"],
    excerpt: json["excerpt"],
    date: DateTime.parse(json["date"]),
    modified: DateTime.parse(json["modified"]),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    tags: List<Category>.from(json["tags"].map((x) => Category.fromJson(x))),
    author: Author.fromJson(json["author"]),
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
    commentCount: json["comment_count"],
    commentStatus: commentStatusValues.map[json["comment_status"]],
    thumbnail: json["thumbnail"],
    customFields: CustomFields.fromJson(json["custom_fields"]),
    thumbnailSize: thumbnailSizeValues.map[json["thumbnail_size"]],
    thumbnailImages: Map.from(json["thumbnail_images"]).map((k, v) => MapEntry<String, MyImage>(k, MyImage.fromJson(v))),
    taxonomySeries: List<dynamic>.from(json["taxonomy_series"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": typeValues.reverse[type],
    "slug": slug,
    "url": url,
    "status": statusValues.reverse[status],
    "title": title,
    "title_plain": titlePlain,
    "content": content,
    "excerpt": excerpt,
    "date": date.toIso8601String(),
    "modified": modified.toIso8601String(),
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "author": author.toJson(),
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
    "comment_count": commentCount,
    "comment_status": commentStatusValues.reverse[commentStatus],
    "thumbnail": thumbnail,
    "custom_fields": customFields.toJson(),
    "thumbnail_size": thumbnailSizeValues.reverse[thumbnailSize],
    "thumbnail_images": Map.from(thumbnailImages).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "taxonomy_series": List<dynamic>.from(taxonomySeries.map((x) => x)),
  };
}

class Attachment {
  Attachment({
    this.id,
    this.url,
    this.slug,
    this.title,
    this.description,
    this.caption,
    this.parent,
    this.mimeType,
    this.images,
  });

  int id;
  String url;
  String slug;
  String title;
  String description;
  String caption;
  int parent;
  MimeType mimeType;
  Map<String, MyImage> images;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json["id"],
    url: json["url"],
    slug: json["slug"],
    title: json["title"],
    description: json["description"],
    caption: json["caption"],
    parent: json["parent"],
    mimeType: mimeTypeValues.map[json["mime_type"]],
    images: Map.from(json["images"]).map((k, v) => MapEntry<String, MyImage>(k, MyImage.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "slug": slug,
    "title": title,
    "description": description,
    "caption": caption,
    "parent": parent,
    "mime_type": mimeTypeValues.reverse[mimeType],
    "images": Map.from(images).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class MyImage {
  MyImage({
    this.url,
    this.width,
    this.height,
  });

  String url;
  int width;
  int height;

  factory MyImage.fromJson(Map<String, dynamic> json) => MyImage(
    url: json["url"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
  };
}

enum MimeType { IMAGE_JPEG, IMAGE_PNG }

final mimeTypeValues = EnumValues({
  "image/jpeg": MimeType.IMAGE_JPEG,
  "image/png": MimeType.IMAGE_PNG
});

class Author {
  Author({
    this.id,
    this.slug,
    this.name,
    this.firstName,
    this.lastName,
    this.nickname,
    this.url,
    this.description,
  });

  int id;
  Slug slug;
  Name name;
  FirstName firstName;
  LastName lastName;
  Name nickname;
  String url;
  String description;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"],
    slug: slugValues.map[json["slug"]],
    name: nameValues.map[json["name"]],
    firstName: firstNameValues.map[json["first_name"]],
    lastName: lastNameValues.map[json["last_name"]],
    nickname: nameValues.map[json["nickname"]],
    url: json["url"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slugValues.reverse[slug],
    "name": nameValues.reverse[name],
    "first_name": firstNameValues.reverse[firstName],
    "last_name": lastNameValues.reverse[lastName],
    "nickname": nameValues.reverse[nickname],
    "url": url,
    "description": description,
  };
}

enum FirstName { EMPTY }

final firstNameValues = EnumValues({
  "Κοσμάς": FirstName.EMPTY
});

enum LastName { EMPTY }

final lastNameValues = EnumValues({
  "Γουργιώτης": LastName.EMPTY
});

enum Name { KOSMASGOU }

final nameValues = EnumValues({
  "kosmasgou": Name.KOSMASGOU
});

enum Slug { KOSMAS1991 }

final slugValues = EnumValues({
  "kosmas1991": Slug.KOSMAS1991
});

class Category {
  Category({
    this.id,
    this.slug,
    this.title,
    this.description,
    this.parent,
    this.postCount,
  });

  int id;
  String slug;
  String title;
  String description;
  int parent;
  int postCount;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    slug: json["slug"],
    title: json["title"],
    description: json["description"],
    parent: json["parent"] == null ? null : json["parent"],
    postCount: json["post_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "title": title,
    "description": description,
    "parent": parent == null ? null : parent,
    "post_count": postCount,
  };
}

enum CommentStatus { OPEN }

final commentStatusValues = EnumValues({
  "open": CommentStatus.OPEN
});

class Comment {
  Comment({
    this.id,
    this.name,
    this.url,
    this.date,
    this.content,
    this.parent,
  });

  int id;
  String name;
  String url;
  DateTime date;
  String content;
  int parent;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    name: json["name"],
    url: json["url"],
    date: DateTime.parse(json["date"]),
    content: json["content"],
    parent: json["parent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
    "date": date.toIso8601String(),
    "content": content,
    "parent": parent,
  };
}

class CustomFields {
  CustomFields({
    this.views,
  });

  List<String> views;

  factory CustomFields.fromJson(Map<String, dynamic> json) => CustomFields(
    views: List<String>.from(json["Views"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Views": List<dynamic>.from(views.map((x) => x)),
  };
}

enum Status { PUBLISH }

final statusValues = EnumValues({
  "publish": Status.PUBLISH
});

enum ThumbnailSize { THUMBNAIL }

final thumbnailSizeValues = EnumValues({
  "thumbnail": ThumbnailSize.THUMBNAIL
});

enum Type { POST }

final typeValues = EnumValues({
  "post": Type.POST
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
