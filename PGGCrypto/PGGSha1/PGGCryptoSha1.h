//
//  PGGCryptoSha1.h
//  PGGCrypto
//
//  Created by 陈鹏 on 2017/10/25.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//
/*
 鹏哥哥sha1（安全[哈希算法]）只是叫做一种算法，用于检验数据完整性
 全名： 安全哈希算法（Secure Hash Algorithm）输出： 160bit
 与Md5比较
 相同点：
 因为二者均由MD4导出，SHA-1和MD5彼此很相似。相应的，他们的强度和其他特性也是相似。
 不同点：
 1. 对强行攻击的安全性：最显著和最重要的区别是SHA-1摘要比MD5摘要长32 位。使用强行技术，产生任何一个报文使其摘要等于给定报摘要的难度对MD5是2^128数量级的操作，而对SHA-1则是2^160数量级的操作。这样，SHA-1对强行攻击有更大的强度。
 2. 对密码分析的安全性：由于MD5的设计，易受密码分析的攻击，SHA-1显得不易受这样的攻击。
 3. 速度：在相同的硬件上，SHA-1的运行速度比MD5慢。
 */

@interface PGGCryptoSha1 : NSData

/**
 类方法创建 sha1加密方式

 @param input 需要加密的字符串（适用于纯字符串以及带有中文的字符串）
 @return 加密后的字符串
 */
+(NSString *) pgg_Sha1:(NSString *)input;

/**
 类方法创建 sha256加密方式

 @param input 需要加密的字符串
 @return 加密后的字符串
 */
+ (NSString *)pgg_Sha256:(NSString *)input;

@end
