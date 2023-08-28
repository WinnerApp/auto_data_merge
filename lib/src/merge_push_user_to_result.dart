import 'dart:io';
import 'package:auto_data_merge/auto_data_merge.dart';

mergePushUserToResult(List args) async {
  print('正在获取推送的用户数据...');
  final pushUsers = await File(table3File).readAsLines();
  print('正在获取全部的用户信息数据...');
  final allUsers = await File(allUserFile).readAsLines();
  final allUserMap = allUsers.asMap().map((key, value) {
    final user = value.split(',');
    final id = user[7];
    return MapEntry(id, value);
  });
  print('正在查询目前结果表的数据...');
  final results = await File(tabele5File).readAsLines();
  print('整份查询推送用户对应的用户信息数据...');
  final unfindPushIds = [];
  for (int i = 0; i < pushUsers.length; i++) {
    if (i == 0) continue;
    print('正在查询第 [$i] 行用户数据......');
    final pushUser = pushUsers[i].split(',');
    final openId = pushUser[1];
    final user = allUserMap[openId];
    if (user == null) {
      print('⚠️ 用户 [$openId] 查询不到');
      unfindPushIds.add(openId);
    } else {
      final userInfo = user.split(',');
      // 2023-06-15 17:26:04.0
      final date = pushUser[4].substring(5, 10);
      results.add('''${userInfo[2]},,,,,$date日,服务通知,引流小程序,,,''');
    }
  }
  final resultFile = File(cacheResultFile);
  print('正在写入结果数据...');
  final buffer = StringBuffer();
  for (int i = 0; i < results.length; i++) {
    buffer.writeln(results[i]);
  }
  await resultFile.writeAsString(buffer.toString());

  print('正在写出未识别的推送的 ID...');
  await File(unfindPushIdFile)
      .writeAsString(unfindPushIds.map((e) => '$e').join('\n'));
  print('✅合并完毕');
}
