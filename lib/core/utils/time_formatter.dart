import 'package:intl/intl.dart';

class TimeFormatter {
  /// Format a DateTime to relative time string (e.g., "2 hours ago", "3 days ago")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    // If the date is in the future, return "Just now"
    if (difference.isNegative) {
      return "Just now";
    }

    // Less than 1 minute
    if (difference.inMinutes < 1) {
      return "Just now";
    }

    // Less than 1 hour
    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return minutes == 1 ? "1 minute ago" : "$minutes mins ago";
    }

    // Less than 1 day
    if (difference.inHours < 24) {
      final hours = difference.inHours;
      return hours == 1 ? "1 hour ago" : "$hours hours ago";
    }

    // Less than 1 week
    if (difference.inDays < 7) {
      final days = difference.inDays;
      return days == 1 ? "1 day ago" : "$days days ago";
    }

    // Less than 1 month (4 weeks)
    if (difference.inDays < 28) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? "1 week ago" : "$weeks weeks ago";
    }

    // Less than 1 year
    if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? "1 month ago" : "$months months ago";
    }

    // More than 1 year
    final years = (difference.inDays / 365).floor();
    return years == 1 ? "1 year ago" : "$years years ago";
  }

  /// Format a DateTime to a short relative time string (e.g., "2h", "3d", "1w")
  static String getShortRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    // If the date is in the future, return "now"
    if (difference.isNegative) {
      return "now";
    }

    // Less than 1 minute
    if (difference.inMinutes < 1) {
      return "now";
    }

    // Less than 1 hour
    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return "${minutes}m";
    }

    // Less than 1 day
    if (difference.inHours < 24) {
      final hours = difference.inHours;
      return "${hours}h";
    }

    // Less than 1 week
    if (difference.inDays < 7) {
      final days = difference.inDays;
      return "${days}d";
    }

    // Less than 1 month (4 weeks)
    if (difference.inDays < 28) {
      final weeks = (difference.inDays / 7).floor();
      return "${weeks}w";
    }

    // Less than 1 year
    if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return "${months}mo";
    }

    // More than 1 year
    final years = (difference.inDays / 365).floor();
    return "${years}y";
  }

  /// Format a DateTime to a readable date string (e.g., "Jan 15, 2024")
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('MMM d, yyyy').format(dateTime);
  }

  /// Format a DateTime to a readable date and time string (e.g., "Jan 15, 2024 at 2:30 PM")
  static String getFormattedDateTime(DateTime dateTime) {
    return DateFormat('MMM d, yyyy \'at\' h:mm a').format(dateTime);
  }

  /// Format a DateTime to a time string (e.g., "2:30 PM")
  static String getFormattedTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  /// Check if a DateTime is today
  static bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  /// Check if a DateTime is yesterday
  static bool isYesterday(DateTime dateTime) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day;
  }

  /// Get a smart relative time that shows "Today", "Yesterday", or relative time
  static String getSmartRelativeTime(DateTime dateTime) {
    if (isToday(dateTime)) {
      return "Today";
    } else if (isYesterday(dateTime)) {
      return "Yesterday";
    } else {
      return getRelativeTime(dateTime);
    }
  }
}
