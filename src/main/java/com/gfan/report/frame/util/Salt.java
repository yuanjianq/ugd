package com.gfan.report.frame.util;

import java.util.Random;

import com.google.common.base.Charsets;


/**
 * 生成日常开发中需要的 salt
 * 
 * @author yan
 * 
 */
public class Salt {

  /**
   * 生成 由大小写字母组成的 salt
   * 
   * @param num 生得个数
   */
  public static String produceSalt(int num) {
    Random random = new Random();
    byte[] bb = new byte[num];
    for (int i = 0; i < num; i++) {
      int nextInt = random.nextInt(62);
      byte a = 0;
      if (nextInt < 10) {
        a = (byte) (nextInt + 48);
      } else if (nextInt >= 10 && nextInt < 35) {
        a = (byte) (nextInt + 55);
      } else if (nextInt >= 35 && nextInt < 62) {
        a = (byte) (nextInt + 62);
      }
      bb[i] = a;
    }
    return new String(bb, Charsets.US_ASCII);
  }
  
//  public static void main(String[] args) {
//    System.out.println(produceSalt(6));
//  }

}
