export  function validateChinesePhoneNumber(phoneNumber: string): boolean {
  // 正则表达式，用于匹配中国大陆的手机号，通常是以1开头的11位数字
  const regex = /^1[3-9]\d{9}$/;

  return regex.test(phoneNumber);
}