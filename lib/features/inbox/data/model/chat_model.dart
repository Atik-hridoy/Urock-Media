class ChatModel {
  final String id;
  final List<dynamic> participants;
  final dynamic lastMessage;
  final String status;
  final bool isDeleted;
  final List<dynamic> readBy;
  final List<dynamic> mutedBy;
  final List<dynamic> deletedByDetails;
  final DateTime? lastMessageAt;
  final List<dynamic> blockedUsers;
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

  /// 🔥 Empty chat factory
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
      isRead: true,
      unreadCount: 0,
      iconUnreadCount: 0,
      isMuted: false,
      isBlocked: false,
      wasDeletedByUser: false,
      deletedAt: null,
    );
  }

  factory ChatModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ChatModel.empty();

    return ChatModel(
      id: json['_id'] ?? '',
      participants: (json['participants'] as List?) ?? [],
      lastMessage: json['lastMessage'],
      status: json['status'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      readBy: (json['readBy'] as List?) ?? [],
      mutedBy: (json['mutedBy'] as List?) ?? [],
      deletedByDetails: (json['deletedByDetails'] as List?) ?? [],
      lastMessageAt: _parseDate(json['lastMessageAt']),
      blockedUsers: (json['blockedUsers'] as List?) ?? [],
      userPinnedMessages: (json['userPinnedMessages'] as List?) ?? [],
      createdAt: _parseDate(json['createdAt']),
      updatedAt: _parseDate(json['updatedAt']),
      isRead: json['isRead'] ?? true,
      unreadCount: json['unreadCount'] ?? 0,
      iconUnreadCount: json['iconUnreadCount'] ?? 0,
      isMuted: json['isMuted'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      wasDeletedByUser: json['wasDeletedByUser'] ?? false,
      deletedAt: _parseDate(json['deletedAt']),
    );
  }

  /// 🔥 Determines if chat should be skipped
  bool get isEmpty => id.isEmpty || participants.isEmpty && lastMessage == null;
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

  factory ChatResponseModel.empty() {
    return ChatResponseModel(
      chats: [],
      unreadChatsCount: 0,
      totalUnreadMessages: 0,
      totalIconUnreadMessages: 0,
    );
  }

  factory ChatResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ChatResponseModel.empty();

    final rawChats = (json['chats'] as List?) ?? [];

    /// 🔥 Skip invalid / empty chats here
    final chats = rawChats
        .map((e) => ChatModel.fromJson(e))
        .where((chat) => !chat.isEmpty)
        .toList();

    return ChatResponseModel(
      chats: chats,
      unreadChatsCount: json['unreadChatsCount'] ?? 0,
      totalUnreadMessages: json['totalUnreadMessages'] ?? 0,
      totalIconUnreadMessages: json['totalIconUnreadMessages'] ?? 0,
    );
  }
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  try {
    return DateTime.parse(value.toString());
  } catch (_) {
    return null;
  }
}
