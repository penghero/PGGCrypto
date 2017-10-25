//
//  PGGCryptoMD5.m
//  PGGCrypto
//
//  Created by 陈鹏 on 2017/10/24.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//

#import "PGGCryptoMD5.h"

@implementation PGGCryptoMD5

+ (NSString *) pggMD5:(NSString *) input {
    const char *cStr = [input UTF8String]; //先转为UTF_8编码的字符串
    unsigned char pgg[CC_MD5_DIGEST_LENGTH]; //设置一个接受字符数组 /md5加密后是128bit, 16 字节 * 8位/字节 = 128 位
    CC_MD5( cStr, strlen(cStr), pgg );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){ //将16字节的16进制转成32字节的16进制字符串
        [output appendFormat:@"%02x", pgg[i]];
    }
    return  output;
}

@end
