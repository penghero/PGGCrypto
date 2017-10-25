//
//  PGGCryptoRSA.h
//  PGGCrypto
//
//  Created by 陈鹏 on 2017/10/24.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//
/*
 RSA加密（非对称加密）
 特点
 RSA加密算法是目前最有影响力的公钥加密算法，并且被普遍认为是目前最优秀的公钥方案之一。RSA是第一个能同时用于加密和数宇签名的算法，它能够抵抗到目前为止已知的所有密码攻击，已被ISO推荐为公钥数据加密标准。RSA加密算法基于一个十分简单的数论事实：将两个大素数相乘十分容易，但想要对其乘积进行因式分解却极其困难，因此可以将乘积公开作为加密密钥。
 算法描述：
 （1）选择一对不同的、足够大的素数p，q。
 （2）计算n=pq。
 （3）计算f(n)=(p-1)(q-1)，同时对p, q严加保密，不让任何人知道。
 （4）找一个与f(n)互质的数e（公钥指数），且1<e<f(n)。
 （5）计算d（私钥指数），使得de≡1 mod f(n)。这个公式也可以表达为d ≡e-1 mod f(n)注，≡是数论中表示同余的符号。
 （6）公钥KU=(e,n)，私钥KR=(d,n)。
 （7）加密时，先将明文变换成0至n-1的一个整数M。若明文较长，可先分割成适当的组，然后再进行交换。设密文为C，则加密过程为： C = Me（mod n）
 （8）解密过程为： M = Cd（mod n）
  
  使用RSA情况 ：客户端进行登录时 使用较多（非对称加密方式）
 在使用RSA 加密前期准备 ：
 1、需要用到.der和.p12后缀格式的文件，其中.der格式的文件存放的是公钥（Public key）用于加密，.p12格式的文件存放的是私钥（Private key）用于解密（生成的文件 在电脑磁盘中 ）
 2、 将文件导入工程
 3、 添加Security.framework框架
 4、导入.der和.p12格式的秘钥文件
 注意：一定要记住你生成的.p12文件的密码 在解密的时候需要配合这个密码来使用
 【生成教程】
 {
 生成环境是在mac系统下，使用openssl进行生成，首先打开终端，按下面这些步骤依次来做：
 
 1. 生成模长为1024bit的私钥文件private_key.pem
 
 openssl genrsa -out private_key.pem 1024
 2. 生成证书请求文件rsaCertReq.csr
 
 openssl req -new -key private_key.pem -out rsaCerReq.csr
 注意：这一步会提示输入国家、省份、mail等信息，可以根据实际情况填写，或者全部不用填写，直接全部敲回车.
 
 3. 生成证书rsaCert.crt，并设置有效时间为1年
 
 openssl x509 -req -days 3650 -in rsaCerReq.csr -signkey private_key.pem -out rsaCert.crt
 4. 生成供iOS使用的公钥文件public_key.der
 
 openssl x509 -outform der -in rsaCert.crt -out public_key.der
 5. 生成供iOS使用的私钥文件private_key.p12
 
 openssl pkcs12 -export -out private_key.p12 -inkey private_key.pem -in rsaCert.crt
 注意：这一步会提示给私钥文件设置密码，直接输入想要设置密码即可，然后敲回车，然后再验证刚才设置的密码，再次输入密码，然后敲回车，完毕！
 在解密时，private_key.p12文件需要和这里设置的密码配合使用，因此需要牢记此密码.
 
 6. 生成供Java使用的公钥rsa_public_key.pem
 
 openssl rsa -in private_key.pem -out rsa_public_key.pem -pubout
 7. 生成供Java使用的私钥pkcs8_private_key.pem
 
 openssl pkcs8 -topk8 -in private_key.pem -out pkcs8_private_key.pem -nocrypt
 
 8.找到生成的文件所在位置，将public_key.der和private_key.p12这两个文件导入工程
 
 参考资料  http://www.jianshu.com/p/74a796ec5038
 生成密钥字符串网址
 http://web.chacuo.net/netrsakeypair
 这是一个在线生成RSA秘钥的网站, 生成公钥和秘钥后, 复制出来用于测试
 }
 */


@interface PGGCryptoRSA : NSObject
/**
 *   '.der'格式的公钥加密方法
 *
 *  @param str   需要加密的字符串
 *  @param path  '.der'格式的公钥文件路径
 */
+ (NSString *)encryptString:(NSString *)str publicKeyWithContentsOfFile:(NSString *)path;

/**
 *   '.p12'格式的私钥解密方法
 *
 *  @param str       需要解密的字符串
 *  @param path      '.p12'格式的私钥文件路径
 *  @param password  私钥文件密码
 */
+ (NSString *)decryptString:(NSString *)str privateKeyWithContentsOfFile:(NSString *)path password:(NSString *)password;

/**
 *  公钥加密方法
 *
 *  @param str    需要加密的字符串
 *  @param pubKey 公钥字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/**
 *  私钥解密方法
 *
 *  @param str     需要解密的字符串
 *  @param privKey 私钥字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;

@end
