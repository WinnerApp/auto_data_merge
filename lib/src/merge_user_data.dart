import 'dart:io';

import 'package:auto_data_merge/auto_data_merge.dart';
import 'package:path/path.dart';

mergerUserData(List args) async {
  print(args);
  if (args.isEmpty) {
    throw '请输入用户表的个数';
  }
  final number = int.parse(args.first);
  final userFile = File(allUserFile);
  var index = 0;
  final outBuffer = StringBuffer();
  for (int i = 0; i < number; i++) {
    final path = '${table4Dir}_${i + 1}.csv';
    print('正在合并:$path 中的会员数据......');
    final lines = await File(path).readAsLines();
    for (int j = 0; j < lines.length; j++) {
      if (i != 0 && j == 0) continue;
      index = index + 1;
      outBuffer.writeln(lines[j]);
    }
  }
  print('正在合并第 [$index] 行用户数据......');
  if (!await userFile.exists()) {
    print('${userFile.path} 不存在正在创建...');
    await userFile.create(recursive: true);
  }
  await userFile.writeAsString(outBuffer.toString());
  print('✅合并完毕');
}
