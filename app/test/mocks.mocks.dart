
import 'dart:async' as _i5;

import 'package:flutter/src/services/binary_messenger.dart' as _i3;
import 'package:flutter/src/services/message_codec.dart' as _i2;
import 'package:flutter/src/services/platform_channel.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;
import 'package:shared_preferences/src/shared_preferences_legacy.dart' as _i4;


class _FakeMethodCodec_0 extends _i1.SmartFake implements _i2.MethodCodec {
  _FakeMethodCodec_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeBinaryMessenger_1 extends _i1.SmartFake
    implements _i3.BinaryMessenger {
  _FakeBinaryMessenger_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class MockSharedPreferences extends _i1.Mock implements _i4.SharedPreferences {
  MockSharedPreferences() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Set<String> getKeys() =>
      (super.noSuchMethod(
            Invocation.method(#getKeys, []),
            returnValue: <String>{},
          )
          as Set<String>);

  @override
  Object? get(String? key) =>
      (super.noSuchMethod(Invocation.method(#get, [key])) as Object?);

  @override
  bool? getBool(String? key) =>
      (super.noSuchMethod(Invocation.method(#getBool, [key])) as bool?);

  @override
  int? getInt(String? key) =>
      (super.noSuchMethod(Invocation.method(#getInt, [key])) as int?);

  @override
  double? getDouble(String? key) =>
      (super.noSuchMethod(Invocation.method(#getDouble, [key])) as double?);

  @override
  String? getString(String? key) =>
      (super.noSuchMethod(Invocation.method(#getString, [key])) as String?);

  @override
  bool containsKey(String? key) =>
      (super.noSuchMethod(
            Invocation.method(#containsKey, [key]),
            returnValue: false,
          )
          as bool);

  @override
  List<String>? getStringList(String? key) =>
      (super.noSuchMethod(Invocation.method(#getStringList, [key]))
          as List<String>?);

  @override
  _i5.Future<bool> setBool(String? key, bool? value) =>
      (super.noSuchMethod(
            Invocation.method(#setBool, [key, value]),
            returnValue: _i5.Future<bool>.value(false),
          )
          as _i5.Future<bool>);

  @override
  _i5.Future<bool> setInt(String? key, int? value) =>
      (super.noSuchMethod(
            Invocation.method(#setInt, [key, value]),
            returnValue: _i5.Future<bool>.value(false),
          )
          as _i5.Future<bool>);

  @override
  _i5.Future<bool> setDouble(String? key, double? value) =>
      (super.noSuchMethod(
            Invocation.method(#setDouble, [key, value]),
            returnValue: _i5.Future<bool>.value(false),
          )
          as _i5.Future<bool>);

  @override
  _i5.Future<bool> setString(String? key, String? value) =>
      (super.noSuchMethod(
            Invocation.method(#setString, [key, value]),
            returnValue: _i5.Future<bool>.value(false),
          )
          as _i5.Future<bool>);

  @override
  _i5.Future<bool> setStringList(String? key, List<String>? value) =>
      (super.noSuchMethod(
            Invocation.method(#setStringList, [key, value]),
            returnValue: _i5.Future<bool>.value(false),
          )
          as _i5.Future<bool>);

  @override
  _i5.Future<bool> remove(String? key) =>
      (super.noSuchMethod(
            Invocation.method(#remove, [key]),
            returnValue: _i5.Future<bool>.value(false),
          )
          as _i5.Future<bool>);

  @override
  _i5.Future<bool> commit() =>
      (super.noSuchMethod(
            Invocation.method(#commit, []),
            returnValue: _i5.Future<bool>.value(false),
          )
          as _i5.Future<bool>);

  @override
  _i5.Future<bool> clear() =>
      (super.noSuchMethod(
            Invocation.method(#clear, []),
            returnValue: _i5.Future<bool>.value(false),
          )
          as _i5.Future<bool>);

  @override
  _i5.Future<void> reload() =>
      (super.noSuchMethod(
            Invocation.method(#reload, []),
            returnValue: _i5.Future<void>.value(),
            returnValueForMissingStub: _i5.Future<void>.value(),
          )
          as _i5.Future<void>);
}

class MockMethodChannel extends _i1.Mock implements _i6.MethodChannel {
  MockMethodChannel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get name =>
      (super.noSuchMethod(
            Invocation.getter(#name),
            returnValue: _i7.dummyValue<String>(this, Invocation.getter(#name)),
          )
          as String);

  @override
  _i2.MethodCodec get codec =>
      (super.noSuchMethod(
            Invocation.getter(#codec),
            returnValue: _FakeMethodCodec_0(this, Invocation.getter(#codec)),
          )
          as _i2.MethodCodec);

  @override
  _i3.BinaryMessenger get binaryMessenger =>
      (super.noSuchMethod(
            Invocation.getter(#binaryMessenger),
            returnValue: _FakeBinaryMessenger_1(
              this,
              Invocation.getter(#binaryMessenger),
            ),
          )
          as _i3.BinaryMessenger);

  @override
  _i5.Future<T?> invokeMethod<T>(String? method, [dynamic arguments]) =>
      (super.noSuchMethod(
            Invocation.method(#invokeMethod, [method, arguments]),
            returnValue: _i5.Future<T?>.value(),
          )
          as _i5.Future<T?>);

  @override
  _i5.Future<List<T>?> invokeListMethod<T>(
    String? method, [
    dynamic arguments,
  ]) =>
      (super.noSuchMethod(
            Invocation.method(#invokeListMethod, [method, arguments]),
            returnValue: _i5.Future<List<T>?>.value(),
          )
          as _i5.Future<List<T>?>);

  @override
  _i5.Future<Map<K, V>?> invokeMapMethod<K, V>(
    String? method, [
    dynamic arguments,
  ]) =>
      (super.noSuchMethod(
            Invocation.method(#invokeMapMethod, [method, arguments]),
            returnValue: _i5.Future<Map<K, V>?>.value(),
          )
          as _i5.Future<Map<K, V>?>);

  @override
  void setMethodCallHandler(
    _i5.Future<dynamic> Function(_i2.MethodCall)? handler,
  ) => super.noSuchMethod(
    Invocation.method(#setMethodCallHandler, [handler]),
    returnValueForMissingStub: null,
  );
}

class MockEventChannel extends _i1.Mock implements _i6.EventChannel {
  MockEventChannel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get name =>
      (super.noSuchMethod(
            Invocation.getter(#name),
            returnValue: _i7.dummyValue<String>(this, Invocation.getter(#name)),
          )
          as String);

  @override
  _i2.MethodCodec get codec =>
      (super.noSuchMethod(
            Invocation.getter(#codec),
            returnValue: _FakeMethodCodec_0(this, Invocation.getter(#codec)),
          )
          as _i2.MethodCodec);

  @override
  _i3.BinaryMessenger get binaryMessenger =>
      (super.noSuchMethod(
            Invocation.getter(#binaryMessenger),
            returnValue: _FakeBinaryMessenger_1(
              this,
              Invocation.getter(#binaryMessenger),
            ),
          )
          as _i3.BinaryMessenger);

  @override
  _i5.Stream<dynamic> receiveBroadcastStream([dynamic arguments]) =>
      (super.noSuchMethod(
            Invocation.method(#receiveBroadcastStream, [arguments]),
            returnValue: _i5.Stream<dynamic>.empty(),
          )
          as _i5.Stream<dynamic>);
}
