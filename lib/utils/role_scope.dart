import 'package:flutter/material.dart';

enum UserRole { admin, trainee, trainer, author, programManager, reviewManager }

class RoleScope extends InheritedWidget {
  final UserRole role;
  final ValueChanged<UserRole> onRoleChanged;

  const RoleScope({
    super.key,
    required this.role,
    required this.onRoleChanged,
    required super.child,
  });

  static RoleScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RoleScope>()!;
  }

  static RoleScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RoleScope>();
  }

  @override
  bool updateShouldNotify(RoleScope oldWidget) => role != oldWidget.role;
}
