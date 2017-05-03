//
//  ShareView.m
//  ShareViewDemo
//
//  Created by 王恒求 on 2016/3/18.
//  Copyright © 2016年 王恒求. All rights reserved.
//

#import "ShareView.h"

#define kTag    1000

@interface ShareView()

@property (nonatomic,retain) NSArray *imageArr;
@property (nonatomic,retain) UIView *containerView;

@end

@implementation ShareView

+(void)show
{
    [[[ShareView alloc]init] show];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        self.backgroundColor = [UIColor clearColor];
        self.imageArr= @[@"shareView_login_qq",@"shareView_login_wx",@"shareView_login_wb",@"shareView_login_tx"];
        
        UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
        [visualEffectView setFrame:self.bounds];
        visualEffectView.alpha=0.5;
        visualEffectView.backgroundColor=[UIColor blackColor];
        [self addSubview:visualEffectView];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)]];
        
        [self initContainerView];
    }
    return self;
}

-(void)initContainerView
{
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, 100)];
    self.containerView.backgroundColor =[UIColor whiteColor];
    
    CGFloat btnWidth = 50;
    
    for (int i=0; i<4; i++) {
        UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*kSCREEN_WIDTH/4+(kSCREEN_WIDTH/4-50)/2, 100, btnWidth, btnWidth)];
        [shareBtn setImage:[UIImage imageNamed:self.imageArr[i]] forState:UIControlStateNormal];
        shareBtn.tag=kTag+i;
        [self.containerView addSubview:shareBtn];
    }
    
    [self addSubview:self.containerView];
}

-(void)show
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.containerView.transform=CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.containerView.frame));
        
        for (int i; i<4; i++) {
            UIButton *shareBtn=[self.containerView viewWithTag:kTag+i];
            CGPoint centerP = CGPointMake(kSCREEN_WIDTH/4* i  + (kSCREEN_WIDTH/8), 50);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*0.1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                /** usingSpringWithDamping的范围为0.0f到1.0f，数值越小，弹簧的振动效果越明显，initialSpringVelocity则表示初始的速度，数值越大一开始移动越快*/
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    shareBtn.center=centerP;
                } completion:nil];
            });
        }
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hide
{
    [self removeFromSuperview];
}

@end
