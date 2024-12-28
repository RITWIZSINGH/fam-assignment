import 'package:flutter/material.dart';

class FormattedText {
  final String text;
  final List<Entity> entities;
  final String? align;

  FormattedText({
    required this.text,
    required this.entities,
    this.align,
  });

  factory FormattedText.fromJson(Map<String, dynamic> json) {
    return FormattedText(
      text: json['text'] ?? '',
      entities: (json['entities'] as List?)
          ?.map((e) => Entity.fromJson(e))
          .toList() ?? [],
      align: json['align'],
    );
  }
}

class Entity {
  final String text;
  final String? color;
  final String? url;
  final String? fontStyle;
  final int? fontSize;
  final String? fontFamily;

  Entity({
    required this.text,
    this.color,
    this.url,
    this.fontStyle,
    this.fontSize,
    this.fontFamily,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      text: json['text'] ?? '',
      color: json['color'],
      url: json['url'],
      fontStyle: json['font_style'],
      fontSize: json['font_size'],
      fontFamily: json['font_family'],
    );
  }
}

class CardImage {
  final String imageType;
  final String? assetType;
  final String? imageUrl;
  final double? aspectRatio;

  CardImage({
    required this.imageType,
    this.assetType,
    this.imageUrl,
    this.aspectRatio,
  });

  factory CardImage.fromJson(Map<String, dynamic> json) {
    return CardImage(
      imageType: json['image_type'] ?? '',
      assetType: json['asset_type'],
      imageUrl: json['image_url'],
      aspectRatio: json['aspect_ratio']?.toDouble(),
    );
  }
}

class CallToAction {
  final String text;
  final String? bgColor;
  final String? url;
  final String? textColor;
  final bool? isCircular;
  final bool? isSecondary;
  final int? strokeWidth;

  CallToAction({
    required this.text,
    this.bgColor,
    this.url,
    this.textColor,
    this.isCircular,
    this.isSecondary,
    this.strokeWidth,
  });

  factory CallToAction.fromJson(Map<String, dynamic> json) {
    return CallToAction(
      text: json['text'] ?? '',
      bgColor: json['bg_color'],
      url: json['url'],
      textColor: json['text_color'],
      isCircular: json['is_circular'],
      isSecondary: json['is_secondary'],
      strokeWidth: json['stroke_width'],
    );
  }
}

class Gradient {
  final List<String> colors;
  final double angle;

  Gradient({
    required this.colors,
    required this.angle,
  });

  factory Gradient.fromJson(Map<String, dynamic> json) {
    return Gradient(
      colors: (json['colors'] as List?)?.map((e) => e.toString()).toList() ?? [],
      angle: (json['angle'] ?? 0).toDouble(),
    );
  }
}

class ContextualCard {
  final int id;
  final String name;
  final String? slug;
  final String? title;
  final FormattedText? formattedTitle;
  final String? description;
  final FormattedText? formattedDescription;
  final CardImage? icon;
  final String? url;
  final CardImage? bgImage;
  final String? bgColor;
  final Gradient? bgGradient;
  final List<CallToAction>? cta;
  final bool isDisabled;
  final bool isShareable;
  final bool isInternal;

  ContextualCard({
    required this.id,
    required this.name,
    this.slug,
    this.title,
    this.formattedTitle,
    this.description,
    this.formattedDescription,
    this.icon,
    this.url,
    this.bgImage,
    this.bgColor,
    this.bgGradient,
    this.cta,
    this.isDisabled = false,
    this.isShareable = false,
    this.isInternal = false,
  });

  factory ContextualCard.fromJson(Map<String, dynamic> json) {
    return ContextualCard(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'],
      title: json['title'],
      formattedTitle: json['formatted_title'] != null
          ? FormattedText.fromJson(json['formatted_title'])
          : null,
      description: json['description'],
      formattedDescription: json['formatted_description'] != null
          ? FormattedText.fromJson(json['formatted_description'])
          : null,
      icon: json['icon'] != null ? CardImage.fromJson(json['icon']) : null,
      url: json['url'],
      bgImage:
          json['bg_image'] != null ? CardImage.fromJson(json['bg_image']) : null,
      bgColor: json['bg_color'],
      bgGradient:
          json['bg_gradient'] != null ? Gradient.fromJson(json['bg_gradient']) : null,
      cta: (json['cta'] as List?)
          ?.map((e) => CallToAction.fromJson(e))
          .toList(),
      isDisabled: json['is_disabled'] ?? false,
      isShareable: json['is_shareable'] ?? false,
      isInternal: json['is_internal'] ?? false,
    );
  }
}