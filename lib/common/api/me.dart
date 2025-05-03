part of 'api.dart';

class _Me {
  // 获取未读公告的数量
  final String getUnreadCount = '/me/getUnreadCount';
  // 获取走马灯信息
  final String getMarquee = '/me/marquee';
  // 获取Carousels
  final String getCarousel = '/me/getCarousel';
  // 获取常见问题列表
  final String getFaq = '/me/getFaq';
  // 获取头像列表
  final String getAvatarList = '/me/avatarList';
  // 获取教程
  final String getTutorial = '/me/getTutorial';
  // 获取优惠活动列表
  final String getPromotions = '/me/banner/list';
  // 获取版本号
  final String getVersion = '/me/getVersion';
  // 通知列表
  final String getNotify = '/me/notice';
  // 阅读通知
  final String readNotify = '/me/noticeDetail';
  // 获取客服列表
  final String getCustomer = '/me/getChatInfo';
  // 获取公告列表
  final String getPublicNotice = '/me/getPopupNotice';
  // 获取消息常见问题
  final String getCustomerFaqList = '/me/getQuestions';
  // 获取消息常见问题类型
  final String getCustomerFaqType = '/me/getTypes';
  // 反馈中心上传附件
  final String uploadFeedbackAttachment = '/me/attachment';
  // 建议反馈
  final String feedback = '/me/feedback';
  // 统计仲裁客服问题类型
  final String countArbitrationType = '/me/statisticsArbitrationCategory';
  // 获取服务器信息，服务器当前时间
  final String getServerInfo = '/me/getServerInfo';
  final String readVersionNotice = '/me/readVersionNotice';
  final String getVersionNoticeRedDot = '/me/getVersionNoticeRedDot';

  final String getLoginCustomerConfig = '/me/getLoginCustomerConfig';
  final String getLoginCustomerAnswer = '/me/getLoginCustomerAnswer';
  final String getLoginCustomerType = '/me/getLoginCustomerType';
  final String getFeedback = '/me/getFeedback';

  // 获取余额说明信息
  final String getBalanceTips = '/me/getBalanceTips';

  // 统计子问题点击次数
  final String countSubQuestionClick = '/me/autoIncrement/question';
  // 统计答案点击次数
  final String countAnswerClick = '/me/autoIncrement/answer';
  // 统计大类的统计人数和次数
  final String countMainQuestionClick = '/me/autoIncrement/category/answer';
  // 统计大类的客服点击次数
  final String countMainCustomerClick = '/me/autoIncrement/category/question';
}