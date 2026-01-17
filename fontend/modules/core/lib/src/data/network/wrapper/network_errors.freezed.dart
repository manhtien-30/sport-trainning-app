// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_errors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NetworkError {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkError()';
}


}

/// @nodoc
class $NetworkErrorCopyWith<$Res>  {
$NetworkErrorCopyWith(NetworkError _, $Res Function(NetworkError) __);
}


/// Adds pattern-matching-related methods to [NetworkError].
extension NetworkErrorPatterns on NetworkError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ResponseError value)?  request,TResult Function( _DecodingError value)?  type,TResult Function( _Connectivity value)?  connectivity,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResponseError() when request != null:
return request(_that);case _DecodingError() when type != null:
return type(_that);case _Connectivity() when connectivity != null:
return connectivity(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ResponseError value)  request,required TResult Function( _DecodingError value)  type,required TResult Function( _Connectivity value)  connectivity,}){
final _that = this;
switch (_that) {
case _ResponseError():
return request(_that);case _DecodingError():
return type(_that);case _Connectivity():
return connectivity(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ResponseError value)?  request,TResult? Function( _DecodingError value)?  type,TResult? Function( _Connectivity value)?  connectivity,}){
final _that = this;
switch (_that) {
case _ResponseError() when request != null:
return request(_that);case _DecodingError() when type != null:
return type(_that);case _Connectivity() when connectivity != null:
return connectivity(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( DioException error)?  request,TResult Function( String? error)?  type,TResult Function( String? message)?  connectivity,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResponseError() when request != null:
return request(_that.error);case _DecodingError() when type != null:
return type(_that.error);case _Connectivity() when connectivity != null:
return connectivity(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( DioException error)  request,required TResult Function( String? error)  type,required TResult Function( String? message)  connectivity,}) {final _that = this;
switch (_that) {
case _ResponseError():
return request(_that.error);case _DecodingError():
return type(_that.error);case _Connectivity():
return connectivity(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( DioException error)?  request,TResult? Function( String? error)?  type,TResult? Function( String? message)?  connectivity,}) {final _that = this;
switch (_that) {
case _ResponseError() when request != null:
return request(_that.error);case _DecodingError() when type != null:
return type(_that.error);case _Connectivity() when connectivity != null:
return connectivity(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _ResponseError extends NetworkError {
  const _ResponseError({required this.error}): super._();
  

 final  DioException error;

/// Create a copy of NetworkError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResponseErrorCopyWith<_ResponseError> get copyWith => __$ResponseErrorCopyWithImpl<_ResponseError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResponseError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'NetworkError.request(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ResponseErrorCopyWith<$Res> implements $NetworkErrorCopyWith<$Res> {
  factory _$ResponseErrorCopyWith(_ResponseError value, $Res Function(_ResponseError) _then) = __$ResponseErrorCopyWithImpl;
@useResult
$Res call({
 DioException error
});




}
/// @nodoc
class __$ResponseErrorCopyWithImpl<$Res>
    implements _$ResponseErrorCopyWith<$Res> {
  __$ResponseErrorCopyWithImpl(this._self, this._then);

  final _ResponseError _self;
  final $Res Function(_ResponseError) _then;

/// Create a copy of NetworkError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_ResponseError(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as DioException,
  ));
}


}

/// @nodoc


class _DecodingError extends NetworkError {
  const _DecodingError({this.error}): super._();
  

 final  String? error;

/// Create a copy of NetworkError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecodingErrorCopyWith<_DecodingError> get copyWith => __$DecodingErrorCopyWithImpl<_DecodingError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DecodingError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'NetworkError.type(error: $error)';
}


}

/// @nodoc
abstract mixin class _$DecodingErrorCopyWith<$Res> implements $NetworkErrorCopyWith<$Res> {
  factory _$DecodingErrorCopyWith(_DecodingError value, $Res Function(_DecodingError) _then) = __$DecodingErrorCopyWithImpl;
@useResult
$Res call({
 String? error
});




}
/// @nodoc
class __$DecodingErrorCopyWithImpl<$Res>
    implements _$DecodingErrorCopyWith<$Res> {
  __$DecodingErrorCopyWithImpl(this._self, this._then);

  final _DecodingError _self;
  final $Res Function(_DecodingError) _then;

/// Create a copy of NetworkError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = freezed,}) {
  return _then(_DecodingError(
error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Connectivity extends NetworkError {
  const _Connectivity({this.message}): super._();
  

 final  String? message;

/// Create a copy of NetworkError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectivityCopyWith<_Connectivity> get copyWith => __$ConnectivityCopyWithImpl<_Connectivity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Connectivity&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NetworkError.connectivity(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ConnectivityCopyWith<$Res> implements $NetworkErrorCopyWith<$Res> {
  factory _$ConnectivityCopyWith(_Connectivity value, $Res Function(_Connectivity) _then) = __$ConnectivityCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$ConnectivityCopyWithImpl<$Res>
    implements _$ConnectivityCopyWith<$Res> {
  __$ConnectivityCopyWithImpl(this._self, this._then);

  final _Connectivity _self;
  final $Res Function(_Connectivity) _then;

/// Create a copy of NetworkError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_Connectivity(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
