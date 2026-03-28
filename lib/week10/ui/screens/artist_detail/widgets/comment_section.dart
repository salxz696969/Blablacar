import 'package:blabla/week10/model/comment/comment.dart';
import 'package:blabla/week10/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({required this.comments});

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Comments',
            style: AppTextStyles.title.copyWith(fontSize: 24),
          ),
        ),
        const SizedBox(height: 12),
        if (comments.isEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: Text('No comments yet.', style: AppTextStyles.label),
          )
        else
          ...comments.map((c) => _CommentCard(content: c.content)),
      ],
    );
  }
}

class _CommentCard extends StatelessWidget {
  const _CommentCard({required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(content, style: AppTextStyles.label.copyWith(fontSize: 18)),
    );
  }
}
