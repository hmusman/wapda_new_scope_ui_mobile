import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum UserRole { member, family, tenant, employee, mc }

extension UserRoleX on UserRole {
  RoleAccent get accent {
    switch (this) {
      case UserRole.member:
      case UserRole.family:
        return RoleAccent.memberFamily;
      case UserRole.tenant:
        return RoleAccent.tenant;
      case UserRole.employee:
        return RoleAccent.employee;
      case UserRole.mc:
        return RoleAccent.mc;
    }
  }

  String get label {
    switch (this) {
      case UserRole.member:
        return 'Member / Owner';
      case UserRole.family:
        return 'Family Member';
      case UserRole.tenant:
        return 'Tenant';
      case UserRole.employee:
        return 'WC Employee';
      case UserRole.mc:
        return 'Management Committee';
    }
  }
}

class Identity {
  final String name;
  final String role;
  final String prop;
  const Identity({required this.name, required this.role, required this.prop});

  String get initials => name.split(' ').map((x) => x[0]).join();
}

const Map<UserRole, Identity> kIdentities = {
  UserRole.member: Identity(name: 'Ahsan Raza', role: 'Owner · Verified', prop: 'House H-247, Block C'),
  UserRole.family: Identity(name: 'Hira Raza', role: 'Family — Sister', prop: 'House H-247, Block C'),
  UserRole.tenant: Identity(name: 'Bilal Ahmed', role: 'Tenant', prop: 'House H-247, Block C'),
  UserRole.employee: Identity(name: 'Kashif Iqbal', role: 'WC Employee · Maintenance', prop: 'Staff ID WC-EMP-3391'),
  UserRole.mc: Identity(name: 'Tariq Mehmood', role: 'Management Committee', prop: 'WAPDA City · Admin'),
};
