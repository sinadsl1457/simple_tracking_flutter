// [place/domain] 최근 고른 "장소"와 고른 시각. 길찾기 준비 화면 목록에 쓴다(최근 검색어와 별개).

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_tracking/features/place/domain/place.dart';

part 'recent_place.freezed.dart';

/// 최근에 고른 장소와 고른 시각.
@freezed
abstract class RecentPlace with _$RecentPlace {
  const factory RecentPlace({required Place place, required DateTime usedAt}) =
      _RecentPlace;
}
