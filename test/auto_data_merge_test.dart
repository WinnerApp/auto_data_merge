import 'package:auto_data_merge/auto_data_merge.dart';
import 'package:auto_data_merge/src/merge_push_user_to_result.dart';
import 'package:auto_data_merge/src/merge_user_data.dart';
import 'package:auto_data_merge/src/merge_user_info_to_result.dart';
import 'package:test/test.dart';

void main() {
  test(
    '自动合并推送的用户数据',
    () async => await mergePushUserToResult([]),
    timeout: Timeout.none,
  );

  test(
    '合并数据到结果表',
    () async => await mergeUserInfoToResult([]),
    timeout: Timeout.none,
  );
  test('合并主用户表', () async => mergerUserData(["2"]), timeout: Timeout.none);
}
