//
//  PGGCryptoDES.h
//  PGGCrypto
//
//  Created by 陈鹏 on 2017/10/24.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//  GitHub地址  https://github.com/penghero/PGGCrypto.git



@interface PGGCryptoDES : NSObject

//    加密方法
+(NSString *) encryptUseDES:(NSString *)plainText;
//    解密方法
+(NSString *)decryptUseDES:(NSString *)cipherText;

@end
