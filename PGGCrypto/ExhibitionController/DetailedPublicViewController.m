//
//  DetailedPublicViewController.m
//  PGGCrypto
//
//  Created by 陈鹏 on 2017/10/25.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//

#import "DetailedPublicViewController.h"

@interface DetailedPublicViewController ()

@end

@implementation DetailedPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"测试加密";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)confirmBtn:(id)sender {
    switch (_PGGControllerStyle) {
        case PGGControllerStyleMD5: {
            NSLog(@"%ld",(long)_PGGControllerStyle);
            NSString *encrypt = [PGGCryptoMD5 pggMD5:self.needcrypto.text];
            [self.showcrypto setText:encrypt];
        }
            break;
        case PGGControllerStyleSha1:{
            NSLog(@"%ld",(long)_PGGControllerStyle);
//            NSString *encrypt = [PGGCryptoSha1 pgg_Sha1:self.needcrypto.text]; //第一种sha1加密算法
            NSString *encrypt = [PGGCryptoSha1 pgg_Sha256:self.needcrypto.text]; //第二种sha256加密算法
            [self.showcrypto setText:encrypt];
        }
            break;
        case PGGControllerStyleHMAC:{
            NSLog(@"%ld",(long)_PGGControllerStyle);
            NSString *encrypt = [PGGCryptoHMAC pgg_Hmac:self.needcrypto.text withKey:PGGkey];
            [self.showcrypto setText:encrypt];
        }
            break;
        case PGGControllerStyleHMAC_MD5:{
            NSLog(@"%ld",(long)_PGGControllerStyle);
            NSString *encrypt = [PGGCryptoHMACMD5 pggHMACMD5WithString:self.needcrypto.text WithKey:PGGkey];
            [self.showcrypto setText:encrypt];
        }
            break;
        case PGGControllerStyleAES:{
            NSLog(@"%ld",(long)_PGGControllerStyle);
            NSString *encrypt = [PGGCryptoAES encryptAESData:self.needcrypto.text];
            [self.showcrypto setText:encrypt];
        }
            break;
        case PGGControllerStyleDES:{
            NSLog(@"%ld",(long)_PGGControllerStyle);
            NSString *encrypt = [PGGCryptoDES encryptUseDES:self.needcrypto.text];
            [self.showcrypto setText:encrypt];
        }
            break;
        case PGGControllerStyleRSA:{
            NSLog(@"%ld",(long)_PGGControllerStyle);
//             1.   使用.der的公钥加密
            NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
            NSString *encrypt = [PGGCryptoRSA encryptString:self.needcrypto.text publicKeyWithContentsOfFile:public_key_path];
            [self.showcrypto setText:encrypt];
            /*
//            2. 使用字符串格式的公钥加密
            NSString *public_key = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIqovlSAt+gtPtgONnS9JQvbJQSdhEdDRfgxqa4wJLbZwGmq2FQlD+1hOnHzcKt2jxQtjnRZUN8ts0/xGHMoKN85tQwq9CQM3LXVxg6XEybcHbbN/UQlqDrgFd7eVO+YdynSlmnEvAS+LPnVH2Y+Q4nj4CR0qqr3qwBDXR2F421wIDAQAB";
            NSString *encrypt = [PGGCryptoRSA encryptString:self.needcrypto.text publicKey:public_key];
            [self.showcrypto setText:encrypt];
             */
        }
            break;
        default:
            break;
    }
}
- (IBAction)decryptBtn:(id)sender {
    switch (_PGGControllerStyle) {
        case PGGControllerStyleMD5: {
            NSLog(@"%ld",(long)_PGGControllerStyle);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"MD5是单向加密 无法进行解密功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case PGGControllerStyleSha1:{
            NSLog(@"%ld",(long)_PGGControllerStyle);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"哈希算法是单向加密 无法进行解密功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
            break;
        case PGGControllerStyleHMAC:{
            NSLog(@"%ld",(long)_PGGControllerStyle);
           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"HMAC算法是单向加密 无法进行解密功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case PGGControllerStyleHMAC_MD5:{
            NSLog(@"%ld",(long)_PGGControllerStyle);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"HMACMD5算法是单向加密 无法进行解密功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case PGGControllerStyleAES:{
            NSLog(@"%ld",(long)_PGGControllerStyle);
            if (self.showcrypto.text == nil) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请您先进行加密 然后才能验证" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }else{
            NSString *decrypt = [PGGCryptoAES decryptAESData:self.showcrypto.text];
            [self.decrypt setText:decrypt];
            }
        }
            break;
        case PGGControllerStyleDES:{
            NSLog(@"%ld",(long)_PGGControllerStyle);
            if (self.showcrypto.text == nil) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请您先进行加密 然后才能验证" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }else{
            NSString *decrypt = [PGGCryptoDES decryptUseDES:self.showcrypto.text];
            [self.decrypt setText:decrypt];
            }
        }
            break;
        case PGGControllerStyleRSA:{
            NSLog(@"%ld",(long)_PGGControllerStyle);
//          1. 使用.p12中的私钥解密
            NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
            NSString *decrypt = [PGGCryptoRSA decryptString:self.showcrypto.text privateKeyWithContentsOfFile:private_key_path password:@"987654321"];
            [self.decrypt setText:decrypt];
            /*
//           2.使用字符串格式的私钥解密
            NSString *private_key = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMiqi+VIC36C0+2A42dL0lC9slBJ2ER0NF+DGprjAkttnAaarYVCUP7WE6cfNwq3aPFC2OdFlQ3y2zT/EYcygo3zm1DCr0JAzctdXGDpcTJtwdts39RCWoOuAV3t5U75h3KdKWacS8BL4s+dUfZj5DiePgJHSqqverAENdHYXjbXAgMBAAECgYEAnwAL83Q/r1HIzUM4bQv2LQXyeY3ZsHwHV7sRZLMFiXDjlZQQdCvU8+f7EIw6V+J2Y9zc83v+HFxXd0m4wNC0ApEYjm2+k8TMPb1zsCsZprK04zfrJZ7IfT0UG3ih4h3g/f5QvVOw9HsjLMsHEhGcPt2v9BByePFJq6tUm3qQOZECQQDrY24fbp6IiCOjR6O9e6/u92xYoHqp5r3d+RdtHnroqZeMoSFfMaCWPIZkIXy3mKU3irOnJr5z8nYcQ8iq78u5AkEA2jzEpfBwWrMI/RMyoqKbLVPlpFWGytbaFMliFOfiTKZdznbeuKB5nnOaXzk3Ic41WwXItxdC2HRrHsxN1YT/DwJBAM/6BUXOZlJ5/wr4dEsqKtN4V4mjGV5e2mly+ejW4oAJwDZn8+V5Iss7ZP65u8k4HNqLOZq5l9M4anUkyvuFbjkCQQCF0aFbhzW9x+6JEE6KP18bykgUHoWKt3f+KwZDf3TaP2FiCq3DVFN+/6/3F+RgjEtXRxKugkrw42IT/n7zoJutAkBSywHknZuaJNhr9c4dCQhRYoFYYNZyh9jJ+b8WxL3Et24v3sRneoX/uE8WcE+vP2WBqqTaftGMya51lvhps7LW";
            NSString *decrypt = [PGGCryptoRSA decryptString:self.showcrypto.text privateKey:private_key];
            [self.decrypt setText:decrypt];
             */
        }
            break;
        default:
            break;
    }
}

- (IBAction)cancelBtn:(id)sender {
    self.needcrypto.text = nil;
    self.showcrypto.text = nil;
    self.decrypt.text = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
