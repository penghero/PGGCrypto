//
//  PGGCryptoAES.h
//  PGGCrypto
//
//  Created by 陈鹏 on 2017/10/24.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//
/**
 AES加密（对称加密）
优点：简单、可并行计算、误差不传递
缺点：不能隐藏明文模式（比如图像加密轮廓仍在）、主动攻击（改明文，后续内容不影响，只要误差不传递该缺点就存在）
用途：需要并行加密的应用
 AES加密算法是密码学中的高级加密标准，该加密算法采用对称分组密码体制，密钥长度的最少支持为128、192、256，分组长度128位，算法应易于各种硬件和软件实现。这种加密算法是美国联邦政府采用的区块加密标准，这个标准用来替代原先的DES，已经被多方分析且广为全世界所使用。设计为支持128／192／256位（/32=nb)数据块大小（即分组长度）；支持128／192／256位（/32=nk)密码长度，，在10进制里，对应34×1038、62×1057、1.1×1077个密钥
 原理：
 */

@interface PGGCryptoAES : NSObject

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;

+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

#pragma mark - AES加密
    //将string转成带密码的data
+ (NSString*)encryptAESData:(NSString*)string;
    //将带密码的data转成string
+ (NSString*)decryptAESData:(NSString*)string;

@end
