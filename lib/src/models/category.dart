import 'package:flutter/material.dart';

/// Represents a category of meals.
/// Has an [id], a [title], and a [color].
class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });

  final String id;
  final String title;
  final Color color;
}
