# PGGCrypto
  鹏哥哥加密算法<br> 
  超全的加密算法锦集<br>
  每个算法都进行了封装 都可以通过类方法直接进行创建使用 而且各个类方法中都有详细的说明 使用时请仔细查看<br>
  如果对您有所帮助 请点进下面GitHub链接 送一颗宝贵的星星给我<br>
  GitHub地址  https://github.com/penghero/PGGCrypto.git
# 演示GIF
![image](https://github.com/penghero/PGGCrypto/blob/master/gif/Untitle1.gif)
# 部分讲解
1、AES加密（对称加密算法）<br>
优点：简单、可并行计算、误差不传递<br>
缺点：不能隐藏明文模式（比如图像加密轮廓仍在）、主动攻击（改明文，后续内容不影响，只要误差不传递该缺点就存在）<br>
用途：需要并行加密的应用<br>
 AES加密算法是密码学中的高级加密标准，该加密算法采用对称分组密码体制，密钥长度的最少支持为128、192、256，分组长度128位，算法应易于各种硬件和软件实现。这种加密算法是美国联邦政府采用的区块加密标准，这个标准用来替代原先的DES，已经被多方分析且广为全世界所使用。设计为支持128／192／256位（/32=nb)数据块大小（即分组长度）；支持128／192／256位（/32=nk)密码长度，，在10进制里，对应34×1038、62×1057、1.1×1077个密钥
 ```
 //(key和iv向量这里是16位的) 这里是CBC加密模式，安全性更高

- (NSData *)AES128EncryptWithKey:(NSString *)key gIv:(NSString *)Iv{//加密
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCKeySizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [Iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}


- (NSData *)AES128DecryptWithKey:(NSString *)key gIv:(NSString *)Iv{//解密
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCKeySizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [Iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}
 //加密
NSString *encrypt = [PGGCryptoAES encryptAESData:self.needcrypto.text];
//解密
NSString *decrypt = [PGGCryptoAES decryptAESData:self.showcrypto.text];
 ```
2、DES加密（对称加密解密）<br>
```
//    Des加密
+(NSString *) encryptUseDES:(NSString *)plainText {
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [PGGkey UTF8String], kCCKeySizeDES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [GTMBase64 stringByEncodingData:data];
    }
    return ciphertext;
}
//    Des解密
+(NSString *)decryptUseDES:(NSString *)cipherText {
    NSString *plaintext = nil;
    NSData *cipherdata = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [PGGkey UTF8String], kCCKeySizeDES,
                                          iv,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess){
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}
//加密
NSString *encrypt = [PGGCryptoDES encryptUseDES:self.needcrypto.text];
//解密
NSString *decrypt = [PGGCryptoDES decryptUseDES:self.showcrypto.text];
```
3、RSA加密  （非对称加密）<br>
包括.der和.p12文件加密解密，和公钥私钥字符串加密解密<br>
特点<br>
RSA加密算法是目前最有影响力的公钥加密算法，并且被普遍认为是目前最优秀的公钥方案之一。RSA是第一个能同时用于加密和数宇签名的算法，它能够抵抗到目前为止已知的所有密码攻击，已被ISO推荐为公钥数据加密标准。RSA加密算法基于一个十分简单的数论事实：将两个大素数相乘十分容易，但想要对其乘积进行因式分解却极其困难，因此可以将乘积公开作为加密密钥。<br>
```
#pragma mark - 使用'.der'公钥文件加密
    //加密
+ (NSString *)encryptString:(NSString *)str publicKeyWithContentsOfFile:(NSString *)path{
    if (!str || !path)  return nil;
    return [self encryptString:str publicKeyRef:[self getPublicKeyRefWithContentsOfFile:path]];
}

    //获取公钥
+ (SecKeyRef)getPublicKeyRefWithContentsOfFile:(NSString *)filePath{
    NSData *certData = [NSData dataWithContentsOfFile:filePath];
    if (!certData) {
        return nil;
    }
    SecCertificateRef cert = SecCertificateCreateWithData(NULL, (CFDataRef)certData);
    SecKeyRef key = NULL;
    SecTrustRef trust = NULL;
    SecPolicyRef policy = NULL;
    if (cert != NULL) {
        policy = SecPolicyCreateBasicX509();
        if (policy) {
            if (SecTrustCreateWithCertificates((CFTypeRef)cert, policy, &trust) == noErr) {
                SecTrustResultType result;
                if (SecTrustEvaluate(trust, &result) == noErr) {
                    key = SecTrustCopyPublicKey(trust);
                }
            }
        }
    }
    if (policy) CFRelease(policy);
    if (trust) CFRelease(trust);
    if (cert) CFRelease(cert);
    return key;
}

+ (NSString *)encryptString:(NSString *)str publicKeyRef:(SecKeyRef)publicKeyRef{
    if(![str dataUsingEncoding:NSUTF8StringEncoding]){
        return nil;
    }
    if(!publicKeyRef){
        return nil;
    }
    NSData *data = [self encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] withKeyRef:publicKeyRef];
    NSString *ret = base64_encode_data(data);
    return ret;
}

#pragma mark - 使用'.12'私钥文件解密

    //解密
+ (NSString *)decryptString:(NSString *)str privateKeyWithContentsOfFile:(NSString *)path password:(NSString *)password{
    if (!str || !path) return nil;
    if (!password) password = @"";
    return [self decryptString:str privateKeyRef:[self getPrivateKeyRefWithContentsOfFile:path password:password]];
}

    //获取私钥
+ (SecKeyRef)getPrivateKeyRefWithContentsOfFile:(NSString *)filePath password:(NSString*)password{
    
    NSData *p12Data = [NSData dataWithContentsOfFile:filePath];
    if (!p12Data) {
        return nil;
    }
    SecKeyRef privateKeyRef = NULL;
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init];
    [options setObject: password forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((__bridge CFDataRef) p12Data, (__bridge CFDictionaryRef)options, &items);
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
        securityError = SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
        if (securityError != noErr) {
            privateKeyRef = NULL;
        }
    }
    CFRelease(items);
    
    return privateKeyRef;
}

+ (NSString *)decryptString:(NSString *)str privateKeyRef:(SecKeyRef)privKeyRef{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (!privKeyRef) {
        return nil;
    }
    data = [self decryptData:data withKeyRef:privKeyRef];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}
//加密
NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
NSString *encrypt = [PGGCryptoRSA encryptString:self.needcrypto.text publicKeyWithContentsOfFile:public_key_path];
//解密
 1. 使用.p12中的私钥解密
NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
NSString *decrypt = [PGGCryptoRSA decryptString:self.showcrypto.text privateKeyWithContentsOfFile:private_key_path password:@"987654321"];
            /*
//2.使用字符串格式的私钥解密
NSString *private_key = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMiqi+VIC36C0+2A42dL0lC9slBJ2ER0NF+DGprjAkttnAaarYVCUP7WE6cfNwq3aPFC2OdFlQ3y2zT/EYcygo3zm1DCr0JAzctdXGDpcTJtwdts39RCWoOuAV3t5U75h3KdKWacS8BL4s+dUfZj5DiePgJHSqqverAENdHYXjbXAgMBAAECgYEAnwAL83Q/r1HIzUM4bQv2LQXyeY3ZsHwHV7sRZLMFiXDjlZQQdCvU8+f7EIw6V+J2Y9zc83v+HFxXd0m4wNC0ApEYjm2+k8TMPb1zsCsZprK04zfrJZ7IfT0UG3ih4h3g/f5QvVOw9HsjLMsHEhGcPt2v9BByePFJq6tUm3qQOZECQQDrY24fbp6IiCOjR6O9e6/u92xYoHqp5r3d+RdtHnroqZeMoSFfMaCWPIZkIXy3mKU3irOnJr5z8nYcQ8iq78u5AkEA2jzEpfBwWrMI/RMyoqKbLVPlpFWGytbaFMliFOfiTKZdznbeuKB5nnOaXzk3Ic41WwXItxdC2HRrHsxN1YT/DwJBAM/6BUXOZlJ5/wr4dEsqKtN4V4mjGV5e2mly+ejW4oAJwDZn8+V5Iss7ZP65u8k4HNqLOZq5l9M4anUkyvuFbjkCQQCF0aFbhzW9x+6JEE6KP18bykgUHoWKt3f+KwZDf3TaP2FiCq3DVFN+/6/3F+RgjEtXRxKugkrw42IT/n7zoJutAkBSywHknZuaJNhr9c4dCQhRYoFYYNZyh9jJ+b8WxL3Et24v3sRneoX/uE8WcE+vP2WBqqTaftGMya51lvhps7LW";
NSString *decrypt = [PGGCryptoRSA decryptString:self.showcrypto.text privateKey:private_key];
            */
```
4、MD5加密<br>
 MD5的作用是让大容量信息在用数字签名软件签署私人密钥前被"压缩"成一种保密的格式（就是把一个任意长度的字节串变换成一定长的十六进制数字串）。<br>
 全写： Message Digest Algorithm MD5（中文名为消息摘要算法第五版）<br>
 输出： 128bit<br>
 特点：<br>
 1、压缩性：任意长度的数据，算出的MD5值长度都是固定的。<br>
 2、容易计算：从原数据计算出MD5值很容易。<br>
 3、抗修改性：对原数据进行任何改动，哪怕只修改1个字节，所得到的MD5值都有很大区别。<br>
 4、弱抗碰撞：已知原数据和其MD5值，想找到一个具有相同MD5值的数据（即伪造数据）是非常困难的。<br>
 5、强抗碰撞：想找到两个不同的数据，使它们具有相同的MD5值，是非常困难的。<br>
 缺陷：Md5一度被认为十分靠谱。2004年8月17日的美国加州圣巴巴拉的国际密码学会议（Crypto’2004）上，来自中国山东大学的王小云教授做了破译MD5、HAVAL-128、 MD4和RIPEMD算法的报告，公布了MD系列算法的破解结果。2009年，冯登国、谢涛二人利用差分攻击，将MD5的碰撞算法复杂度从王小云的2^42进一步降低到2^21，极端情况下甚至可以降低至2^10。仅仅2^21的复杂度意味着即便是在2008年的计算机上，也只要几秒便可以找到一对碰撞。Md5已老， 在安全性要求较高的场合，不建议使用。<br>
 ```
 NSString *encrypt = [PGGCryptoMD5 pggMD5:self.needcrypto.text];
 ```
 5、sha1加密（安全[哈希算法]）只是叫做一种算法，用于检验数据完整性<br>
 全名： 安全哈希算法（Secure Hash Algorithm）输出： 160bit<br>
 与Md5比较<br>
 相同点：<br>
 因为二者均由MD4导出，SHA-1和MD5彼此很相似。相应的，他们的强度和其他特性也是相似。<br>
 不同点：<br>
 1. 对强行攻击的安全性：最显著和最重要的区别是SHA-1摘要比MD5摘要长32 位。使用强行技术，产生任何一个报文使其摘要等于给定报摘要的难度对MD5是2^128数量级的操作，而对SHA-1则是2^160数量级的操作。这样，SHA-1对强行攻击有更大的强度。<br>
 2. 对密码分析的安全性：由于MD5的设计，易受密码分析的攻击，SHA-1显得不易受这样的攻击。<br>
 3. 速度：在相同的硬件上，SHA-1的运行速度比MD5慢。<br>
 ```
 NSString *encrypt = [PGGCryptoSha1 pgg_Sha1:self.needcrypto.text]; //第一种sha1加密算法
 NSString *encrypt = [PGGCryptoSha1 pgg_Sha256:self.needcrypto.text]; //第二种sha256加密算法
 ```
 6、 HMAC加密消息摘要算法<br>
  我们通常在遇到的时候会看到“HMAC”字眼，mac（Message Authentication Code，消息认证码算法）是含有密钥散列函数算法，兼容了MD和SHA算法的特性，并在此基础上加上了密钥。因此MAC算法也经常被称作HMAC算法。<br>
```
NSString *encrypt = [PGGCryptoHMAC pgg_Hmac:self.needcrypto.text withKey:PGGkey];
```
 7、HMACMD5加密<br>
 ```
NSString *encrypt = [PGGCryptoHMACMD5 pggHMACMD5WithString:self.needcrypto.text WithKey:PGGkey];
 ```
  
  
