import 'dart:io';

import 'package:path/path.dart';

var saveDir = '/Users/king/Desktop/auto_data_merge';
final table1File = join(saveDir, 'table1.csv');
final table2File = join(saveDir, 'table2.csv');
final table3File = join(saveDir, 'table3.csv');
final tabele5File = join(saveDir, 'table5.csv');
final table4Dir = join(saveDir, 'table4');
final allUserFile = join(saveDir, 'allUsers.csv');
final cacheResultFile = join(saveDir, 'cacheResult.csv');
final unfindPushIdFile = join(saveDir, 'unfindPushId.csv');
final unupdatedUserIdFile = join(saveDir, 'unupdatedUserIds.csv');

Future<List<String>> readAsLines(String path) async {
  final content = await File(path).readAsString();
  if (content.contains('\r')) return content.split('\r\n');
  return content.split('\n');
}

extension FileWrite on File {
  Future<void> writeString(String content) async {
    if (await exists()) {
      print('$path 不存在正在创建...');
      await create(recursive: true);
    }
    await writeAsString(content);
  }
}
