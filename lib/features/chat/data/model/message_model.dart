// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageResponseModel {
  final List<MessageModel> messages;
  final List<MessageModel> pinnedMessages;
  final List<MessageParticipantModel> participants;

  MessageResponseModel({
    required this.messages,
    required this.pinnedMessages,
    required this.participants,
  });

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map((e) => MessageModel.fromJson(e))
              .toList() ??
          [],
      pinnedMessages:
          (json['pinnedMessages'] as List<dynamic>?)
              ?.map((e) => MessageModel.fromJson(e))
              .toList() ??
          [],
      participants:
          (json['participants'] as List<dynamic>?)
              ?.map((e) => MessageParticipantModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  factory MessageResponseModel.empty() {
    return MessageResponseModel(
      messages: [],
      pinnedMessages: [],
      participants: [],
    );
  }
}

class MessageModel {
  final String id;
  final String chatId;
  final MessageSenderModel sender;
  final List<String> images;
  final bool read;
  final String type;
  final bool isDeleted;
  final bool isPinned;
  bool isMuted;
  final MessageModel? replyTo;
  final String? text;
  final List<String> iconViewed;
  final DateTime? createdAt;
  final List<String> pinnedByUsers;
  final List<String> deletedForUsers;
  final List<MessageReactionModel> reactions;
  final DateTime? updatedAt;
  final bool isPinnedByCurrentUser;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.sender,
    required this.images,
    required this.read,
    required this.type,
    required this.isDeleted,
    required this.isPinned,
    required this.isMuted,
    required this.replyTo,
    this.text,
    required this.iconViewed,
    required this.createdAt,
    required this.pinnedByUsers,
    required this.deletedForUsers,
    required this.reactions,
    required this.updatedAt,
    required this.isPinnedByCurrentUser,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] ?? '',
      chatId: json['chatId'] ?? '',
      sender: MessageSenderModel.fromJson(json['sender'] ?? {}),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      read: json['read'] ?? false,
      type: json['type'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      isPinned: json['isPinned'] ?? false,
      replyTo: json['replyTo'] != null
          ? MessageModel.fromJson(json['replyTo'])
          : null,
      isMuted: json['isMuted'] ?? false,
      iconViewed:
          (json['iconViewed'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      pinnedByUsers:
          (json['pinnedByUsers'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      deletedForUsers:
          (json['deletedForUsers'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      text: json['text'],
      reactions:
          (json['reactions'] as List<dynamic>?)
              ?.map((e) => MessageReactionModel.fromJson(e))
              .toList() ??
          [],
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      isPinnedByCurrentUser: json['isPinnedByCurrentUser'] ?? false,
    );
  }

  factory MessageModel.empty() {
    return MessageModel(
      id: '',
      chatId: '',
      sender: MessageSenderModel.empty(),
      images: [],
      read: false,
      text: '',
      type: '',
      isDeleted: false,
      isPinned: false,
      replyTo: null,
      isMuted: false,
      iconViewed: [],
      createdAt: null,
      pinnedByUsers: [],
      deletedForUsers: [],
      reactions: [],
      updatedAt: null,
      isPinnedByCurrentUser: false,
    );
  }
  MessageModel copyWith({
    String? id,
    String? chatId,
    MessageSenderModel? sender,
    List<String>? images,
    bool? read,
    String? type,
    String? text,
    bool? isDeleted,
    bool? isPinned,
    MessageModel? replyTo,
    List<String>? iconViewed,
    DateTime? createdAt,
    List<String>? pinnedByUsers,
    List<String>? deletedForUsers,
    List<MessageReactionModel>? reactions,
    DateTime? updatedAt,
    bool? isPinnedByCurrentUser,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      sender: sender ?? this.sender,
      images: images ?? this.images,
      read: read ?? this.read,
      type: type ?? this.type,
      isMuted: isMuted,
      text: text ?? this.text,
      isDeleted: isDeleted ?? this.isDeleted,
      isPinned: isPinned ?? this.isPinned,
      replyTo: replyTo ?? this.replyTo,
      iconViewed: iconViewed ?? this.iconViewed,
      createdAt: createdAt ?? this.createdAt,
      pinnedByUsers: pinnedByUsers ?? this.pinnedByUsers,
      deletedForUsers: deletedForUsers ?? this.deletedForUsers,
      reactions: reactions ?? this.reactions,
      updatedAt: updatedAt ?? this.updatedAt,
      isPinnedByCurrentUser:
          isPinnedByCurrentUser ?? this.isPinnedByCurrentUser,
    );
  }
}

class MessageSenderModel {
  final String id;
  final String name;
  final String email;
  final String image;

  MessageSenderModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
  });

  factory MessageSenderModel.fromJson(Map<String, dynamic> json) {
    return MessageSenderModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );
  }

  factory MessageSenderModel.empty() {
    return MessageSenderModel(id: '', name: '', email: '', image: '');
  }
}

class MessageReactionModel {
  final String emoji;
  final List<String> users;

  MessageReactionModel({required this.emoji, required this.users});

  factory MessageReactionModel.fromJson(Map<String, dynamic> json) {
    return MessageReactionModel(
      emoji: json['emoji'] ?? '',
      users:
          (json['users'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  factory MessageReactionModel.empty() {
    return MessageReactionModel(emoji: '', users: []);
  }
}

class MessageParticipantModel {
  final String id;
  final String name;
  final String role;
  final String image;

  MessageParticipantModel({
    required this.id,
    required this.name,
    required this.role,
    required this.image,
  });

  factory MessageParticipantModel.fromJson(Map<String, dynamic> json) {
    return MessageParticipantModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      image: json['image'] ?? '',
    );
  }

  factory MessageParticipantModel.empty() {
    return MessageParticipantModel(id: '', name: '', role: '', image: '');
  }
}
