//
//  PGGCryptoHMAC.h
//  PGGCrypto
//
//  Created by 陈鹏 on 2017/10/25.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//  GitHub地址  https://github.com/penghero/PGGCrypto.git

/**
 消息摘要算法
  我们通常在遇到的时候会看到“HMAC”字眼，mac（Message Authentication Code，消息认证码算法）是含有密钥散列函数算法，兼容了MD和SHA算法的特性，并在此基础上加上了密钥。因此MAC算法也经常被称作HMAC算法。
 */

@interface PGGCryptoHMAC : NSData

/**
 类方法创建HMAC

 @param plaintext 需要加密的明文文本
 @param key 加密密钥
 @return 经过密钥加密后的文本
 */
+ (NSString *)pgg_Hmac:(NSString *)plaintext withKey:(NSString *)key;

@end
