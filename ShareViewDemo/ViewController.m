//
//  ViewController.m
//  ShareViewDemo
//
//  Created by 王恒求 on 2016/3/18.
//  Copyright © 2016年 王恒求. All rights reserved.
//

#import "ViewController.h"
#import "ShareView.h"
#import "FanShapeBtn.h"

@interface ViewController () {
    FanShapeBtn *fanBtn;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *testBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 100, CGRectGetWidth(self.view.frame)-30, 45)];
    testBtn.backgroundColor=[UIColor redColor];
    [testBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.view addSubview:testBtn];
    [testBtn addTarget:self action:@selector(testBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self fanShapeView];
}


-(void)testBtnClicked
{
    [ShareView show];
}

-(void)fanShapeView
{
    NSArray* imageArr= @[@"shareView_login_qq",@"shareView_login_wx",@"shareView_login_wb",@"shareView_login_tx"];
    
    for (int i=0; i<4; i++) {
        UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-35)/2, 310, 35, 35)];
        [shareBtn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        shareBtn.tag=2000+i;
        [self.view addSubview:shareBtn];
        shareBtn.transform=CGAffineTransformMakeRotation(M_PI_4);
        [self.view addSubview:shareBtn];
    }
    
    fanBtn = [[FanShapeBtn alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-50)/2, 300, 50, 50)];
    [fanBtn addTarget:self action:@selector(fanBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    fanBtn.tag=0;
    [self.view addSubview:fanBtn];
}

-(void)fanBtnClicked
{
    if (fanBtn.tag==0) {
        fanBtn.tag=1;
        [self extandShapeView];
    } else {
        fanBtn.tag=0;
        [self drawBackShapView];
    }
}

/** 展开*/
-(void)extandShapeView
{
    [UIView animateWithDuration:0.3 animations:^{
        fanBtn.transform = CGAffineTransformMakeRotation(M_PI_4);
        CGPoint center = fanBtn.center;
        CGFloat raduis = 70.0;
        /** 整个扇形的度数为135度，每个按钮角度差距45度*/
        CGFloat spaceAgle = M_PI_4;
        for (int i=0; i<4; i++) {
            UIButton *shareBtn = [self.view viewWithTag:2000+i];
            
            CGPoint btnCenter = CGPointMake(center.x+cosf(M_PI-spaceAgle*i-M_PI_4/2)*raduis, center.y-sinf(M_PI-spaceAgle*i-M_PI_4/2)*raduis);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*0.05*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    shareBtn.center=btnCenter;
                    shareBtn.transform=CGAffineTransformIdentity;
                } completion:nil];
            });
        }
    }];
}

-(void)drawBackShapView
{
    [UIView animateWithDuration:0.3 animations:^{
        fanBtn.transform = CGAffineTransformIdentity;
        CGPoint center = fanBtn.center;
        for (int i=0; i<4; i++) {
            UIButton *shareBtn = [self.view viewWithTag:2000+i];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*0.05*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:0.2 animations:^{
                    shareBtn.center=center;
                    shareBtn.transform=CGAffineTransformMakeRotation(M_PI_4);
                }];
            });
        }
    }];
}

@end
