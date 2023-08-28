// 第一个参数合并表的路径
// 第二个参数表4的路径
// 第三个表1 的路径
// 第四个参数表2 的路径
import 'dart:io';

import 'package:auto_data_merge/auto_data_merge.dart';

mergeUserInfoToResult(List<String> args) async {
  print('正在获取合并表的数据');
  final resultUsers = await File(cacheResultFile).readAsLines();
  print('正在查询表 4 的数据');
  final table4Users = await File(allUserFile).readAsLines();
  print('正在将表 4 按照用户 ID 进行索引');
  final table4UserMap = table4Users.asMap().map((key, value) {
    final user = value.split(',');
    final id = user[2];
    return MapEntry(id, value);
  });
  print('正在获取表 1 的数据');
  final table1Users = await File(table1File).readAsLines();
  print('正在将表 1 按照用户 ID 进行索引');
  final table1UserMap = table1Users.asMap().map((key, value) {
    final user = value.split(',');
    final id = user[0].trim();
    return MapEntry(id, value);
  });
  print('正在查询表 2 的数据');
  final table2Users = await File(table2File).readAsLines();
  print('正在将表 2 按照手机号进行索引');
  final table2UserMap = table2Users.asMap().map((key, value) {
    final user = value.split(',');
    final id = user[0].replaceAll("\"", "").replaceAll(" ", "");
    return MapEntry(id.trim(), value);
  });

  print('正在处理合并的用户数据.....');
  final unupdateUserIds = [];
  for (int i = 0; i < resultUsers.length; i++) {
    if (i < 2) continue;
    print('正在处理第 [$i] 行用户数据');
    final resultUser = resultUsers[i].split(',');
    final id = resultUser[0];
    // 查询表 4 的用户的数据
    final table4User = table4UserMap[id];
    if (table4User == null) {
      print('⚠️ 表 4中用户 [$id] 查询不到');
      unupdateUserIds.add(id);
      continue;
    }
    final phone = table4User
        .split(',')[3]
        .replaceAll("\"", '')
        .replaceAll(" ", "")
        .trim();
    resultUser[1] = phone;

    /// 获取表 1 的数据
    final table1User = table1UserMap[id];
    if (table1User == null) {
      // print('⚠️ 表 1 中用户 [$id] 查询不到');
      resultUser[2] = '否';
    } else {
      final buy = table1User.split(',')[1];
      resultUser[2] = buy;
    }

    /// 获取表 2 的数据
    final table2User = table2UserMap[phone];
    if (table2User == null) {
      // print('⚠️ 表 2 中用户 [$phone] 查询不到');
      resultUser[9] = "失败";
    } else {
      final pushStates = table2User.split(',')[1].trimString;
      resultUser[9] = pushStates == "成功" ? pushStates : "失败";
    }

    resultUsers[i] = resultUser.join(',');
  }
  print('正在将最新的数据写出.......');
  File(cacheResultFile).writeAsString(resultUsers.join('\n'));
  print('正在将不能更新的数据用户 ID 导出...');
  File(unupdatedUserIdFile).writeAsString(unupdateUserIds.join('\n'));
  print('✅合并完毕');
}

extension on String {
  String get trimString => replaceAll("\"", "").replaceAll(" ", "").trim();
}
