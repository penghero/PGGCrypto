//
//  PGGCryptoAES.m
//  PGGCrypto
//
//  Created by 陈鹏 on 2017/10/24.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//  GitHub地址  https://github.com/penghero/PGGCrypto.git

#import "PGGCryptoAES.h"
#import "GTMBase64.h"
#import "NSData+AES.h"


@implementation PGGCryptoAES

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
    
}

+ (NSString*)decodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)encodeBase64Data:(NSData *)data {
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data {
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

#pragma mark - AES加密
    //将string转成带密码的data
+(NSString*)encryptAESData:(NSString*)string {
    
        //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES128EncryptWithKey:PGGkey gIv:PGGIv];
        //返回进行base64进行转码的加密字符串
    return [self encodeBase64Data:encryptedData];
}

#pragma mark - AES解密
    //将带密码的data转成string
+(NSString*)decryptAESData:(NSString *)string
{
        //base64解密
    NSData *decodeBase64Data=[GTMBase64 decodeString:string];
        //使用密码对data进行解密
    NSData *decryData = [decodeBase64Data AES128DecryptWithKey:PGGkey gIv:PGGIv];
        //将解了密码的nsdata转化为nsstring
    NSString *str = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return str;
}


@end
