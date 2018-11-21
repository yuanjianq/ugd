package com.gfan.report.frame.util;

import org.apache.commons.codec.digest.DigestUtils;

public class hashMD5Util {

	  /**
     * 生成salt 默认使用8
     *
     * @return
     */
  public static String produceSalt() {
    return Salt.produceSalt(8);
  }
	

  /**
   * 产生一个加密后的密码
   * 
   * @param newPassword
   * @param pwd_salt
   * @return
   */
  public static String productNewPassword(String newPassword, String pwd_salt) {
    StringBuilder sb = new StringBuilder();
    String str = sb.append(newPassword).append(pwd_salt).toString();
    String md5Hex = DigestUtils.md5Hex(str);
    return md5Hex;
  }
  
  /*public static void main(String[] args) {
	  hashMD5Util h =  new hashMD5Util();
	  String s= h.produceSalt();
	  System.out.println(s);
	System.out.println(h.productNewPassword("123456",s));
  }*/
}
