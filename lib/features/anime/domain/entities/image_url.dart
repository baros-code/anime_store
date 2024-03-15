import 'package:equatable/equatable.dart';

class ImageUrl extends Equatable {
  const ImageUrl({
    required this.imageUrl,
    required this.smallImageUrl,
  });

  final String imageUrl;
  final String smallImageUrl;

  static ImageUrl nullValue() {
    return const ImageUrl(
      imageUrl: 'N/A',
      smallImageUrl: 'N/A',
    );
  }

  @override
  List<Object?> get props => [imageUrl, smallImageUrl];
}
