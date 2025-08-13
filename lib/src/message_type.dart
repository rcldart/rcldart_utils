// src/message_type.dart
// src/rcldart_utils_base.dart
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'package:rcldart_utils/src/dynamic_library_loader.dart';

import 'dart:ffi';
import 'dart:io';

abstract class BaseRosMessage<T extends ffi.NativeType> {
  late ffi.Pointer<T> nativeData;
  late ffi.Pointer<T> data;
  // Base class for all ROS messages
  DynamicLibrary get rosidlGeneratorDylib => dynamiclibraryloader("${packageName}__rosidl_typesupport_c");

  String get typeName;
  String get packageName => 'std_msgs';

  String get fullTypeName => 'std_msgs__msg__$typeName';
  String get typeSupportName =>
      'rosidl_typesupport_c__get_message_type_support_handle__$fullTypeName';
  

  ffi.Pointer<T>? get fromGetNative => nativeData.cast<T>();
  // set fromSetValue(ffi.Pointer<ffi.NativeType>? val) => nativeData = (val != null) ? val.cast<T>() : ffi.nullptr;

  void dispose() {
    if (data != ffi.nullptr) {
      calloc.free(data);
    }
    if (nativeData != ffi.nullptr) {
      calloc.free(nativeData);
    }
  }
}