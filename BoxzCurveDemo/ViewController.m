//
//  ViewController.m
//  BoxzCurveDemo
//
//  Created by freevision on 2019/1/10.
//  Copyright © 2019年 Boxz. All rights reserved.
//

#import "ViewController.h"
#import "BesselVC.h"
#import "WifiLinkVC.h"




@interface ViewController ()

@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *functionArr = [NSArray arrayWithObjects:@"贝塞尔曲线",@"wifi连接",@"public", nil];
    
    
    
    for (int i = 0; i < functionArr.count; i++) {
        
        UIButton *vcBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100*(i+1), 100, 50)];
        vcBtn.tag = i;
        vcBtn.backgroundColor = [UIColor orangeColor];
        [vcBtn setTitle:functionArr[i] forState:UIControlStateNormal];
        [vcBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [vcBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateSelected];
        [vcBtn addTarget:self action:@selector(vcBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:vcBtn];
    }
    
    
    /*
     
     BesselVC 贝塞尔曲线
     WifiLinkVC Wifi连接
     PublicVC 公共类
     */
                            
    

}


//选择事务
- (void)vcBtnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
        {
            BesselVC *besselVC = [[BesselVC alloc] init];
            [self.navigationController pushViewController:besselVC animated:YES];
            besselVC.titleStr = sender.titleLabel.text;
        }
            break;
            
        case 1:
        {
           WifiLinkVC *wifiVC = [[WifiLinkVC alloc] init];
            [self.navigationController pushViewController:wifiVC animated:YES];
            wifiVC.titleStr = sender.titleLabel.text;
      }
            break;
            
        case 2:
            NSLog(@"%ld",sender.tag);
            break;
            
            
            
        default:
            break;
    }
    
}





@end


