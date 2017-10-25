//
//  DetailedPublicViewController.h
//  PGGCrypto
//
//  Created by 陈鹏 on 2017/10/25.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//  GitHub地址  https://github.com/penghero/PGGCrypto.git

typedef enum {
    PGGControllerStyleMD5 = 0,
    PGGControllerStyleSha1 = 1,
    PGGControllerStyleHMAC = 2,
    PGGControllerStyleHMAC_MD5 = 3,
    PGGControllerStyleAES = 4,
    PGGControllerStyleDES = 5,
    PGGControllerStyleRSA = 6
}PGGControllerStyle;

@interface DetailedPublicViewController : UIViewController
@property (nonatomic,assign) NSInteger PGGControllerStyle;
@property (strong,nonatomic) NSString *pggTitle;
@property (strong, nonatomic) IBOutlet UITextField *needcrypto;
@property (strong, nonatomic) IBOutlet UITextView *showcrypto;
@property (strong, nonatomic) IBOutlet UITextField *decrypt;
@property (strong, nonatomic) IBOutlet UIButton *confirm;
@property (strong, nonatomic) IBOutlet UIButton *cancel;
@end
