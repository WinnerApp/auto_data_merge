import 'package:auto_data_merge/auto_data_merge.dart' as auto_data_merge;
import 'package:auto_data_merge/auto_data_merge.dart';
import 'package:auto_data_merge/src/merge_push_user_to_result.dart';
import 'package:auto_data_merge/src/merge_user_data.dart';
import 'package:auto_data_merge/src/merge_user_info_to_result.dart';

void main(List<String> arguments) async {
  saveDir = arguments.first;
  final startDate = DateTime.now();
  await mergerUserData([arguments[1]]);
  await mergePushUserToResult([]);
  await mergeUserInfoToResult([]);
  final endDate = DateTime.now();
  print('耗时:${endDate.difference(startDate).inMilliseconds}毫秒');
}
