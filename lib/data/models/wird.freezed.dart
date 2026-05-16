// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wird.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WirdStep {
  String get dhikrId;
  int? get countOverride;

  /// Create a copy of WirdStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WirdStepCopyWith<WirdStep> get copyWith =>
      _$WirdStepCopyWithImpl<WirdStep>(this as WirdStep, _$identity);

  /// Serializes this WirdStep to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WirdStep &&
            (identical(other.dhikrId, dhikrId) || other.dhikrId == dhikrId) &&
            (identical(other.countOverride, countOverride) ||
                other.countOverride == countOverride));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, dhikrId, countOverride);

  @override
  String toString() {
    return 'WirdStep(dhikrId: $dhikrId, countOverride: $countOverride)';
  }
}

/// @nodoc
abstract mixin class $WirdStepCopyWith<$Res> {
  factory $WirdStepCopyWith(WirdStep value, $Res Function(WirdStep) _then) =
      _$WirdStepCopyWithImpl;
  @useResult
  $Res call({String dhikrId, int? countOverride});
}

/// @nodoc
class _$WirdStepCopyWithImpl<$Res> implements $WirdStepCopyWith<$Res> {
  _$WirdStepCopyWithImpl(this._self, this._then);

  final WirdStep _self;
  final $Res Function(WirdStep) _then;

  /// Create a copy of WirdStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dhikrId = null,
    Object? countOverride = freezed,
  }) {
    return _then(_self.copyWith(
      dhikrId: null == dhikrId
          ? _self.dhikrId
          : dhikrId // ignore: cast_nullable_to_non_nullable
              as String,
      countOverride: freezed == countOverride
          ? _self.countOverride
          : countOverride // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [WirdStep].
extension WirdStepPatterns on WirdStep {
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
    TResult Function(_WirdStep value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WirdStep() when $default != null:
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
    TResult Function(_WirdStep value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WirdStep():
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
    TResult? Function(_WirdStep value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WirdStep() when $default != null:
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
    TResult Function(String dhikrId, int? countOverride)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WirdStep() when $default != null:
        return $default(_that.dhikrId, _that.countOverride);
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
    TResult Function(String dhikrId, int? countOverride) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WirdStep():
        return $default(_that.dhikrId, _that.countOverride);
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
    TResult? Function(String dhikrId, int? countOverride)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WirdStep() when $default != null:
        return $default(_that.dhikrId, _that.countOverride);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WirdStep implements WirdStep {
  const _WirdStep({required this.dhikrId, this.countOverride});
  factory _WirdStep.fromJson(Map<String, dynamic> json) =>
      _$WirdStepFromJson(json);

  @override
  final String dhikrId;
  @override
  final int? countOverride;

  /// Create a copy of WirdStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WirdStepCopyWith<_WirdStep> get copyWith =>
      __$WirdStepCopyWithImpl<_WirdStep>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WirdStepToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WirdStep &&
            (identical(other.dhikrId, dhikrId) || other.dhikrId == dhikrId) &&
            (identical(other.countOverride, countOverride) ||
                other.countOverride == countOverride));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, dhikrId, countOverride);

  @override
  String toString() {
    return 'WirdStep(dhikrId: $dhikrId, countOverride: $countOverride)';
  }
}

/// @nodoc
abstract mixin class _$WirdStepCopyWith<$Res>
    implements $WirdStepCopyWith<$Res> {
  factory _$WirdStepCopyWith(_WirdStep value, $Res Function(_WirdStep) _then) =
      __$WirdStepCopyWithImpl;
  @override
  @useResult
  $Res call({String dhikrId, int? countOverride});
}

/// @nodoc
class __$WirdStepCopyWithImpl<$Res> implements _$WirdStepCopyWith<$Res> {
  __$WirdStepCopyWithImpl(this._self, this._then);

  final _WirdStep _self;
  final $Res Function(_WirdStep) _then;

  /// Create a copy of WirdStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? dhikrId = null,
    Object? countOverride = freezed,
  }) {
    return _then(_WirdStep(
      dhikrId: null == dhikrId
          ? _self.dhikrId
          : dhikrId // ignore: cast_nullable_to_non_nullable
              as String,
      countOverride: freezed == countOverride
          ? _self.countOverride
          : countOverride // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$Wird {
  String get id;
  String get title;
  String get subtitle;
  String get cover;
  String get author;
  String get createdAt;
  int get durationMinutes;
  List<WirdStep> get steps;

  /// Create a copy of Wird
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WirdCopyWith<Wird> get copyWith =>
      _$WirdCopyWithImpl<Wird>(this as Wird, _$identity);

  /// Serializes this Wird to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Wird &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            const DeepCollectionEquality().equals(other.steps, steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      subtitle,
      cover,
      author,
      createdAt,
      durationMinutes,
      const DeepCollectionEquality().hash(steps));

  @override
  String toString() {
    return 'Wird(id: $id, title: $title, subtitle: $subtitle, cover: $cover, author: $author, createdAt: $createdAt, durationMinutes: $durationMinutes, steps: $steps)';
  }
}

/// @nodoc
abstract mixin class $WirdCopyWith<$Res> {
  factory $WirdCopyWith(Wird value, $Res Function(Wird) _then) =
      _$WirdCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String subtitle,
      String cover,
      String author,
      String createdAt,
      int durationMinutes,
      List<WirdStep> steps});
}

/// @nodoc
class _$WirdCopyWithImpl<$Res> implements $WirdCopyWith<$Res> {
  _$WirdCopyWithImpl(this._self, this._then);

  final Wird _self;
  final $Res Function(Wird) _then;

  /// Create a copy of Wird
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? cover = null,
    Object? author = null,
    Object? createdAt = null,
    Object? durationMinutes = null,
    Object? steps = null,
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
      subtitle: null == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      cover: null == cover
          ? _self.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _self.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      steps: null == steps
          ? _self.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<WirdStep>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Wird].
extension WirdPatterns on Wird {
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
    TResult Function(_Wird value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Wird() when $default != null:
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
    TResult Function(_Wird value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Wird():
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
    TResult? Function(_Wird value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Wird() when $default != null:
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
            String subtitle,
            String cover,
            String author,
            String createdAt,
            int durationMinutes,
            List<WirdStep> steps)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Wird() when $default != null:
        return $default(_that.id, _that.title, _that.subtitle, _that.cover,
            _that.author, _that.createdAt, _that.durationMinutes, _that.steps);
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
            String subtitle,
            String cover,
            String author,
            String createdAt,
            int durationMinutes,
            List<WirdStep> steps)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Wird():
        return $default(_that.id, _that.title, _that.subtitle, _that.cover,
            _that.author, _that.createdAt, _that.durationMinutes, _that.steps);
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
            String subtitle,
            String cover,
            String author,
            String createdAt,
            int durationMinutes,
            List<WirdStep> steps)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Wird() when $default != null:
        return $default(_that.id, _that.title, _that.subtitle, _that.cover,
            _that.author, _that.createdAt, _that.durationMinutes, _that.steps);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Wird implements Wird {
  const _Wird(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.cover,
      required this.author,
      required this.createdAt,
      required this.durationMinutes,
      required final List<WirdStep> steps})
      : _steps = steps;
  factory _Wird.fromJson(Map<String, dynamic> json) => _$WirdFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String cover;
  @override
  final String author;
  @override
  final String createdAt;
  @override
  final int durationMinutes;
  final List<WirdStep> _steps;
  @override
  List<WirdStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  /// Create a copy of Wird
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WirdCopyWith<_Wird> get copyWith =>
      __$WirdCopyWithImpl<_Wird>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WirdToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Wird &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            const DeepCollectionEquality().equals(other._steps, _steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      subtitle,
      cover,
      author,
      createdAt,
      durationMinutes,
      const DeepCollectionEquality().hash(_steps));

  @override
  String toString() {
    return 'Wird(id: $id, title: $title, subtitle: $subtitle, cover: $cover, author: $author, createdAt: $createdAt, durationMinutes: $durationMinutes, steps: $steps)';
  }
}

/// @nodoc
abstract mixin class _$WirdCopyWith<$Res> implements $WirdCopyWith<$Res> {
  factory _$WirdCopyWith(_Wird value, $Res Function(_Wird) _then) =
      __$WirdCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String subtitle,
      String cover,
      String author,
      String createdAt,
      int durationMinutes,
      List<WirdStep> steps});
}

/// @nodoc
class __$WirdCopyWithImpl<$Res> implements _$WirdCopyWith<$Res> {
  __$WirdCopyWithImpl(this._self, this._then);

  final _Wird _self;
  final $Res Function(_Wird) _then;

  /// Create a copy of Wird
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? cover = null,
    Object? author = null,
    Object? createdAt = null,
    Object? durationMinutes = null,
    Object? steps = null,
  }) {
    return _then(_Wird(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      cover: null == cover
          ? _self.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _self.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      steps: null == steps
          ? _self._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<WirdStep>,
    ));
  }
}

// dart format on
