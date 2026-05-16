// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dhikr.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Dhikr {
  String get id;
  String get title;
  String get arabic;
  String get translation;
  String get transliteration;
  String get virtues;
  int get count;
  String get source;
  List<String> get tags;
  String? get repeatGroup;

  /// Create a copy of Dhikr
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DhikrCopyWith<Dhikr> get copyWith =>
      _$DhikrCopyWithImpl<Dhikr>(this as Dhikr, _$identity);

  /// Serializes this Dhikr to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Dhikr &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.arabic, arabic) || other.arabic == arabic) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.transliteration, transliteration) ||
                other.transliteration == transliteration) &&
            (identical(other.virtues, virtues) || other.virtues == virtues) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.source, source) || other.source == source) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.repeatGroup, repeatGroup) ||
                other.repeatGroup == repeatGroup));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      arabic,
      translation,
      transliteration,
      virtues,
      count,
      source,
      const DeepCollectionEquality().hash(tags),
      repeatGroup);

  @override
  String toString() {
    return 'Dhikr(id: $id, title: $title, arabic: $arabic, translation: $translation, transliteration: $transliteration, virtues: $virtues, count: $count, source: $source, tags: $tags, repeatGroup: $repeatGroup)';
  }
}

/// @nodoc
abstract mixin class $DhikrCopyWith<$Res> {
  factory $DhikrCopyWith(Dhikr value, $Res Function(Dhikr) _then) =
      _$DhikrCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String arabic,
      String translation,
      String transliteration,
      String virtues,
      int count,
      String source,
      List<String> tags,
      String? repeatGroup});
}

/// @nodoc
class _$DhikrCopyWithImpl<$Res> implements $DhikrCopyWith<$Res> {
  _$DhikrCopyWithImpl(this._self, this._then);

  final Dhikr _self;
  final $Res Function(Dhikr) _then;

  /// Create a copy of Dhikr
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? arabic = null,
    Object? translation = null,
    Object? transliteration = null,
    Object? virtues = null,
    Object? count = null,
    Object? source = null,
    Object? tags = null,
    Object? repeatGroup = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      arabic: null == arabic
          ? _self.arabic
          : arabic // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _self.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      transliteration: null == transliteration
          ? _self.transliteration
          : transliteration // ignore: cast_nullable_to_non_nullable
              as String,
      virtues: null == virtues
          ? _self.virtues
          : virtues // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      repeatGroup: freezed == repeatGroup
          ? _self.repeatGroup
          : repeatGroup // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Dhikr].
extension DhikrPatterns on Dhikr {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Dhikr value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Dhikr() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Dhikr value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Dhikr():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Dhikr value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Dhikr() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String title,
            String arabic,
            String translation,
            String transliteration,
            String virtues,
            int count,
            String source,
            List<String> tags,
            String? repeatGroup)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Dhikr() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.arabic,
            _that.translation,
            _that.transliteration,
            _that.virtues,
            _that.count,
            _that.source,
            _that.tags,
            _that.repeatGroup);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String title,
            String arabic,
            String translation,
            String transliteration,
            String virtues,
            int count,
            String source,
            List<String> tags,
            String? repeatGroup)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Dhikr():
        return $default(
            _that.id,
            _that.title,
            _that.arabic,
            _that.translation,
            _that.transliteration,
            _that.virtues,
            _that.count,
            _that.source,
            _that.tags,
            _that.repeatGroup);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String title,
            String arabic,
            String translation,
            String transliteration,
            String virtues,
            int count,
            String source,
            List<String> tags,
            String? repeatGroup)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Dhikr() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.arabic,
            _that.translation,
            _that.transliteration,
            _that.virtues,
            _that.count,
            _that.source,
            _that.tags,
            _that.repeatGroup);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Dhikr implements Dhikr {
  const _Dhikr(
      {required this.id,
      required this.title,
      required this.arabic,
      required this.translation,
      required this.transliteration,
      required this.virtues,
      required this.count,
      required this.source,
      final List<String> tags = const <String>[],
      this.repeatGroup})
      : _tags = tags;
  factory _Dhikr.fromJson(Map<String, dynamic> json) => _$DhikrFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String arabic;
  @override
  final String translation;
  @override
  final String transliteration;
  @override
  final String virtues;
  @override
  final int count;
  @override
  final String source;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String? repeatGroup;

  /// Create a copy of Dhikr
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DhikrCopyWith<_Dhikr> get copyWith =>
      __$DhikrCopyWithImpl<_Dhikr>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DhikrToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Dhikr &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.arabic, arabic) || other.arabic == arabic) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.transliteration, transliteration) ||
                other.transliteration == transliteration) &&
            (identical(other.virtues, virtues) || other.virtues == virtues) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.source, source) || other.source == source) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.repeatGroup, repeatGroup) ||
                other.repeatGroup == repeatGroup));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      arabic,
      translation,
      transliteration,
      virtues,
      count,
      source,
      const DeepCollectionEquality().hash(_tags),
      repeatGroup);

  @override
  String toString() {
    return 'Dhikr(id: $id, title: $title, arabic: $arabic, translation: $translation, transliteration: $transliteration, virtues: $virtues, count: $count, source: $source, tags: $tags, repeatGroup: $repeatGroup)';
  }
}

/// @nodoc
abstract mixin class _$DhikrCopyWith<$Res> implements $DhikrCopyWith<$Res> {
  factory _$DhikrCopyWith(_Dhikr value, $Res Function(_Dhikr) _then) =
      __$DhikrCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String arabic,
      String translation,
      String transliteration,
      String virtues,
      int count,
      String source,
      List<String> tags,
      String? repeatGroup});
}

/// @nodoc
class __$DhikrCopyWithImpl<$Res> implements _$DhikrCopyWith<$Res> {
  __$DhikrCopyWithImpl(this._self, this._then);

  final _Dhikr _self;
  final $Res Function(_Dhikr) _then;

  /// Create a copy of Dhikr
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? arabic = null,
    Object? translation = null,
    Object? transliteration = null,
    Object? virtues = null,
    Object? count = null,
    Object? source = null,
    Object? tags = null,
    Object? repeatGroup = freezed,
  }) {
    return _then(_Dhikr(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      arabic: null == arabic
          ? _self.arabic
          : arabic // ignore: cast_nullable_to_non_nullable
              as String,
      translation: null == translation
          ? _self.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      transliteration: null == transliteration
          ? _self.transliteration
          : transliteration // ignore: cast_nullable_to_non_nullable
              as String,
      virtues: null == virtues
          ? _self.virtues
          : virtues // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      repeatGroup: freezed == repeatGroup
          ? _self.repeatGroup
          : repeatGroup // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
