import 'package:flutter/material.dart';

typedef GlobalFailureHandler = bool Function(Failure);

abstract class Failure {
  final String msg;
  final dynamic data;
  Failure(this.msg, {this.data});
}

class ServerFailure extends Failure {
  ServerFailure(String msg, {dynamic data}) : super(msg, data: data);
}

class InternalFailure extends Failure {
  InternalFailure(String msg, {dynamic data}) : super(msg, data: data);
}

class DataOrFailure<E> extends Either<E?, Failure> {
  DataOrFailure() : super();
  DataOrFailure.withData(E e) : super.fromA(e);
  DataOrFailure.withFailure(Failure fail) : super.fromB(fail);

  bool get isSuccess => isA;
  bool get isFailed => isB;

  E? get data => a;
  Failure get failure => b!;
  set data(E? newData) => a = newData;
  set failure(Failure newFailure) => b = newFailure;
}

class Either<A, B> {
  @protected
  A? a;

  late bool _isA;

  @protected
  B? b;

  late bool _isB;

  Either() : assert(A != B) {
    a = null;
    _isA = false;
    b = null;
    _isB = false;
  }

  Either.fromA(A withA)
      : assert(A != B),
        a = withA,
        _isA = true,
        b = null,
        _isB = false;

  Either.fromB(B withB)
      : assert(A != B),
        a = null,
        _isA = false,
        b = withB,
        _isB = true;

  Either.from(dynamic data) {
    if (data is A) {
      Either.fromA(data);
    }
    if (data is B) {
      Either.fromB(data);
    }
  }

  bool get isA => _isA;

  bool get isB => _isB;
}

class Both<A, B> {
  @protected
  A? a;

  @protected
  B? b;

  Both() : assert(A != B) {
    a = null;
    b = null;
  }

  Both.value(this.a, this.b) : assert(A != B);

  T? of<T>() {
    if (T == A) {
      return a as T;
    }
    if (T == B) {
      return b as T;
    }
    return null;
  }
}

class Tuple<A, B> {
  @protected
  A? a;

  @protected
  B? b;

  Tuple() {
    a = null;
    b = null;
  }

  Tuple.value(this.a, this.b);

  A? get first => a;

  B? get second => b;
}

class Triple<A, B, C> {
  @protected
  A? a;

  @protected
  B? b;

  @protected
  C? c;

  Triple() {
    a = null;
    b = null;
    c = null;
  }

  Triple.value(this.a, this.b, this.c);

  A? get first => a;

  B? get second => b;

  C? get third => c;
}
