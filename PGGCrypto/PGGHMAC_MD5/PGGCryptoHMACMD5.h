//
//  PGGCryptoHMACMD5.h
//  PGGCrypto
//
//  Created by 陈鹏 on 2017/10/25.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//  GitHub地址  https://github.com/penghero/PGGCrypto.git


@interface PGGCryptoHMACMD5 : NSData

/**
 类方法创建HMACMD5

 @param plainText 需要加密的明文文本
 @param key 加密密钥
 @return 经过密钥加密后的文本
 */
+ (NSString *)pggHMACMD5WithString:(NSString *)plainText WithKey:(NSString *)key;

@end
