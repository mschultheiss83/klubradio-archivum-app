import 'package:flutter/material.dart';

String formatDuration(Duration duration) {
  final totalSeconds = duration.inSeconds;
  final hours = totalSeconds ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;

  if (hours > 0) {
    final hourStr = hours.toString().padLeft(2, '0');
    final minuteStr = minutes.toString().padLeft(2, '0');
    final secondStr = seconds.toString().padLeft(2, '0');
    return '$hourStr:$minuteStr:$secondStr';
  }

  final minuteStr = minutes.toString().padLeft(2, '0');
  final secondStr = seconds.toString().padLeft(2, '0');
  return '$minuteStr:$secondStr';
}

String formatDate(DateTime date) {
  return '${date.year}. '
      '${date.month.toString().padLeft(2, '0')}. '
      '${date.day.toString().padLeft(2, '0')}.';
}

String formatDateTime(DateTime dateTime) {
  final date = formatDate(dateTime);
  final time = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  return '$date $time';
}

String formatRelativeTime(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inMinutes.abs() < 1) {
    return 'Az imént';
  }
  if (difference.inHours < 1) {
    return '${difference.inMinutes} perce';
  }
  if (difference.inHours < 24) {
    return '${difference.inHours} órája';
  }
  if (difference.inDays == 1) {
    return 'Tegnap';
  }
  if (difference.inDays < 7) {
    return '${difference.inDays} napja';
  }
  return formatDate(date);
}

String ellipsize(String text, {int maxLength = 140}) {
  if (text.length <= maxLength) {
    return text;
  }
  return '${text.substring(0, maxLength - 1)}…';
}

String formatDownloadPercentage(double progress) {
  final percentage = (progress * 100).clamp(0, 100).toStringAsFixed(0);
  return '$percentage%';
}

Color progressColor(double progress, ColorScheme colorScheme) {
  if (progress >= 1) {
    return colorScheme.primary;
  }
  if (progress > 0.5) {
    return colorScheme.tertiary;
  }
  return colorScheme.secondary;
}
