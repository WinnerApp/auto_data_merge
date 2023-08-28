用于给运营清洗数据使用

## 使用

```shell
auto_data_merge_test.exe [DIR] [NUMBER]
```
DIR  代表需要清晰数据存放的目录
NUMBER  代表用户总表分的子表的个数

## DIR 目录数据文件结构

- table1.csv 表 1 的数据
- table2.csv 表 2 的数据
- table3.csv 表 3 的数据
- table4_INDEX.csv 用户表分表数据
- table5.csv 结果表的数据
- allUsers.csv 添加推送用户的总表（自动创建）
- cacheResult.csv 最终的结果表 (自动创建)
- unfindPushId.csv 推送的用户无法查询出来的异常 ID 表
- unupdatedUserIds.csv 更新用户信息失败的异常用户 ID 表
