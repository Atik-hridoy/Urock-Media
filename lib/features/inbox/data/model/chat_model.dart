class ChatModel {
  final String id;
  final List<ChatParticipantModel> participants;
  final ChatMessageModel? lastMessage;
  final String status;
  final bool isDeleted;
  final List<String> readBy;
  final List<String> mutedBy;
  final List<dynamic> deletedByDetails;
  final DateTime? lastMessageAt;
  final List<String> blockedUsers;
  final List<dynamic> userPinnedMessages;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isRead;
  final int unreadCount;
  final int iconUnreadCount;
  final bool isMuted;
  final bool isBlocked;
  final bool wasDeletedByUser;
  final DateTime? deletedAt;

  ChatModel({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.status,
    required this.isDeleted,
    required this.readBy,
    required this.mutedBy,
    required this.deletedByDetails,
    required this.lastMessageAt,
    required this.blockedUsers,
    required this.userPinnedMessages,
    required this.createdAt,
    required this.updatedAt,
    required this.isRead,
    required this.unreadCount,
    required this.iconUnreadCount,
    required this.isMuted,
    required this.isBlocked,
    required this.wasDeletedByUser,
    required this.deletedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['_id'] ?? '',
      participants:
          (json['participants'] as List<dynamic>?)
              ?.map((e) => ChatParticipantModel.fromJson(e))
              .toList() ??
          [],
      lastMessage: json['lastMessage'] != null
          ? ChatMessageModel.fromJson(json['lastMessage'])
          : null,
      status: json['status'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      readBy:
          (json['readBy'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      mutedBy:
          (json['mutedBy'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      deletedByDetails: json['deletedByDetails'] ?? [],
      lastMessageAt: json['lastMessageAt'] != null
          ? DateTime.tryParse(json['lastMessageAt'])
          : null,
      blockedUsers:
          (json['blockedUsers'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      userPinnedMessages: json['userPinnedMessages'] ?? [],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      isRead: json['isRead'] ?? false,
      unreadCount: json['unreadCount'] ?? 0,
      iconUnreadCount: json['iconUnreadCount'] ?? 0,
      isMuted: json['isMuted'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      wasDeletedByUser: json['wasDeletedByUser'] ?? false,
      deletedAt: json['deletedAt'] != null
          ? DateTime.tryParse(json['deletedAt'])
          : null,
    );
  }

  factory ChatModel.empty() {
    return ChatModel(
      id: '',
      participants: [],
      lastMessage: null,
      status: '',
      isDeleted: false,
      readBy: [],
      mutedBy: [],
      deletedByDetails: [],
      lastMessageAt: null,
      blockedUsers: [],
      userPinnedMessages: [],
      createdAt: null,
      updatedAt: null,
      isRead: false,
      unreadCount: 0,
      iconUnreadCount: 0,
      isMuted: false,
      isBlocked: false,
      wasDeletedByUser: false,
      deletedAt: null,
    );
  }
}

class ChatParticipantModel {
  final String id;
  final String name;
  final String email;
  final String image;

  ChatParticipantModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
  });

  factory ChatParticipantModel.fromJson(Map<String, dynamic> json) {
    return ChatParticipantModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );
  }

  factory ChatParticipantModel.empty() {
    return ChatParticipantModel(id: '', name: '', email: '', image: '');
  }
}

class ChatResponseModel {
  final List<ChatModel> chats;
  final int unreadChatsCount;
  final int totalUnreadMessages;
  final int totalIconUnreadMessages;

  ChatResponseModel({
    required this.chats,
    required this.unreadChatsCount,
    required this.totalUnreadMessages,
    required this.totalIconUnreadMessages,
  });

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
      chats:
          (json['chats'] as List<dynamic>?)
              ?.map((e) => ChatModel.fromJson(e))
              .toList() ??
          [],
      unreadChatsCount: json['unreadChatsCount'] ?? 0,
      totalUnreadMessages: json['totalUnreadMessages'] ?? 0,
      totalIconUnreadMessages: json['totalIconUnreadMessages'] ?? 0,
    );
  }

  factory ChatResponseModel.empty() {
    return ChatResponseModel(
      chats: [],
      unreadChatsCount: 0,
      totalUnreadMessages: 0,
      totalIconUnreadMessages: 0,
    );
  }
}

class ChatMessageModel {
  ChatMessageModel();

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel();
  }
}
