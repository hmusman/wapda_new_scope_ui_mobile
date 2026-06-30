/// Plain dummy-data model classes for the UI kit. No persistence, no backend.
library models;

class Bill {
  final String id;
  final String title;
  final String period;
  final double amount;
  final String dueDate;
  final bool paid;
  final String? paidDate;
  Bill({
    required this.id,
    required this.title,
    required this.period,
    required this.amount,
    required this.dueDate,
    required this.paid,
    this.paidDate,
  });
}

class Complaint {
  final String id;
  final String title;
  final String category;
  final String status; // Open, In Progress, Resolved
  final String date;
  final String description;
  final List<String> updates;
  Complaint({
    required this.id,
    required this.title,
    required this.category,
    required this.status,
    required this.date,
    required this.description,
    this.updates = const [],
  });
}

class NoticeItem {
  final String id;
  final String title;
  final String body;
  final String date;
  final String category;
  final bool pinned;
  NoticeItem({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.category,
    this.pinned = false,
  });
}

class EventItem {
  final String id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String description;
  final String coverColor;
  final int going;
  EventItem({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.coverColor,
    required this.going,
  });
}

class DirectoryEntry {
  final String id;
  final String name;
  final String subtitle;
  final String phone;
  final String initials;
  DirectoryEntry({required this.id, required this.name, required this.subtitle, required this.phone, required this.initials});
}

class ServiceProvider {
  final String id;
  final String name;
  final String category;
  final double rating;
  final String phone;
  final String initials;
  final String description;
  ServiceProvider({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.phone,
    required this.initials,
    required this.description,
  });
}

class Visitor {
  final String id;
  final String name;
  final String purpose;
  final String time;
  final String status; // Expected, Checked In, Checked Out
  Visitor({required this.id, required this.name, required this.purpose, required this.time, required this.status});
}

class Post {
  final String id;
  final String author;
  final String initials;
  final String time;
  final String body;
  final String category;
  int likes;
  int comments;
  Post({
    required this.id,
    required this.author,
    required this.initials,
    required this.time,
    required this.body,
    required this.category,
    this.likes = 0,
    this.comments = 0,
  });
}

class Listing {
  final String id;
  final String title;
  final String price;
  final String category;
  final String seller;
  final String time;
  final String status; // Active, Sold, Expired
  final int relistCount;
  final String description;
  Listing({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.seller,
    required this.time,
    this.status = 'Active',
    this.relistCount = 0,
    required this.description,
  });
}

class Poll {
  final String id;
  final String question;
  final List<String> options;
  final List<int> votes;
  final bool closed;
  final bool votedByMe;
  Poll({
    required this.id,
    required this.question,
    required this.options,
    required this.votes,
    this.closed = false,
    this.votedByMe = false,
  });

  int get totalVotes => votes.fold(0, (a, b) => a + b);
}

class AppNotification {
  final String id;
  final String title;
  final String body;
  final String time;
  final String type; // bill, complaint, notice, event, visitor, sos
  final bool read;
  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.type,
    this.read = false,
  });
}

class ChatThread {
  final String id;
  final String withName;
  final String initials;
  final List<ChatMessage> messages;
  ChatThread({required this.id, required this.withName, required this.initials, required this.messages});
}

class ChatMessage {
  final String text;
  final bool fromMe;
  final String time;
  ChatMessage({required this.text, required this.fromMe, required this.time});
}
