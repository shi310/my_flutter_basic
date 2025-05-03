part of 'config.dart';

class _Shard {
  // version
  final String versionKey = 'shared_version_key';
  // environment
  final String environmentKey = 'shared_environment_key';
  // token
  final String userTokenKey = 'shared_user_token_key';
  // 是否第一次使用 APP
  final String isUsedAppKey = 'shared_is_used_app_key';
  // 主题模式
  final String themeModeKey = 'shared_theme_mode_key';
  // 语言设置
  final String localKey = 'shared_local_key';
  // 保存的账号
  final String accountKey = 'shard_account_key';
  // 保存的手机号码
  final String phoneKey = 'shard_phone_key';
  // 是否今天不再展示首页通知
  final String isHidePublicNoticeKey = 'shared_is_hide_public_notice_key';
  // 是否今天不再展示挂单市场的通知
  final String isHideMarketNoticeKey = 'shared_is_hide_market_notice_key';
  // 保存对应cert的token
  final String qiChatCustomerHistoryListKey = 'qi_chat_customer_history_list_key';
}