import 'package:flutter/material.dart';
import 'package:odiya_news_app/constants/app_colors.dart';
import 'package:odiya_news_app/constants/app_strings.dart';
import 'package:odiya_news_app/constants/app_textstyles.dart';
import 'package:odiya_news_app/models/news_model.dart';
import 'package:odiya_news_app/utils/helper_methods.dart';

class ContentColumn extends StatelessWidget {
  const ContentColumn({super.key, required this.article});

  final NewsModel article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchSourceUrl(article.sourceUrl, context),
      child: Column(
        spacing: 12.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            article.title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  article.category,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                formatDate(article.publishedAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final textSpan = TextSpan(
                text: article.content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              );

              final textPainter = TextPainter(
                text: textSpan,
                maxLines: 7,
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(maxWidth: constraints.maxWidth);

              final isOverflowing = textPainter.didExceedMaxLines;

              if (isOverflowing) {
                // Show truncated text with "Read more" at the end
                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: article.content,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      TextSpan(
                        text: '... Read more',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                );
              } else {
                // Content fits within 7 lines, show normally
                return Text(
                  article.content,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                );
              }
            },
          ),
          Text(
            '${AppStrings.by} ${article.sourceName}',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
