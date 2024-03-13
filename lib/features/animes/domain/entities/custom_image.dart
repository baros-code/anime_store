import 'package:equatable/equatable.dart';

import 'image_url.dart';

class CustomImage extends Equatable {
  const CustomImage({
    required this.jpg,
    required this.webp,
  });

  final ImageUrl jpg;
  final ImageUrl webp;


  static CustomImage nullValue() {
    return CustomImage(
      jpg: ImageUrl.nullValue(),
      webp: ImageUrl.nullValue(),
    );
  }

  @override
  List<Object?> get props => [jpg, webp];
}
