import 'dart:ffi';
import 'dart:js_util';

import 'package:flutter/material.dart';

typedef void EventCallBack(arg);

class EventBus {
  //私有构造函数
  EventBus.internal();
  //保存单例
  static EventBus _singleton = new EventBus.internal();
  //工厂构造函数
  factory EventBus() => _singleton;
  //保存事件订阅者队列,key:事件名(id) value:对应事件的订阅者队列
  var _emap = new Map<Object, List<EventCallBack>>();
  //添加订阅者
  void on(eventname, EventCallBack f) {
    if (eventname == null || f == null) {
      return;
    }
    _emap[eventname] ??= <EventCallBack>[];
    _emap[eventname]!.add(f);
  }
}
