import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/features/daily_news/domain/entities/article.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity? article;
  final bool isRemovable;
  final void Function(ArticleEntity article) onRemove;
  final void Function(ArticleEntity article) onArticlePressed;

  const ArticleWidget({
    super.key,
    this.article,
    required this.isRemovable,
    required this.onRemove,
    required this.onArticlePressed,
  });

  @override
  Widget build(BuildContext context) {
    if (article == null) return const SizedBox.shrink();

    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onArticlePressed(article!),
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 14, end: 14, top: 10),
        height: width / 2.2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context, width),
            const SizedBox(width: 8),
            Expanded(child: _buildTitleAndDescription()),
            if (isRemovable)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => onRemove(article!),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, double width) {
    final imageUrl = article?.urlToImage;
    final imageWidget = imageUrl == null || imageUrl.isEmpty
        ? const Icon(Icons.image, size: 40, color: Colors.grey)
        : CachedNetworkImage(
            imageUrl: imageUrl,
            fadeInDuration: Duration.zero,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            progressIndicatorBuilder: (context, url, progress) =>
                const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image, size: 40, color: Colors.grey),
          );
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width: width / 3,
          height: double.infinity,
          color: Colors.grey[300],
          child: imageWidget,
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article?.title ?? '',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Butler',
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                article?.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Row(
            children: [
              const Icon(Icons.timeline_outlined, size: 16),
              const SizedBox(width: 4),
              Text(
                article?.publishedAt ?? '',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
