//
//  BesselVC.m
//  BoxzCurveDemo
//
//  Created by freevision on 2019/1/16.
//  Copyright © 2019年 Boxz. All rights reserved.
//

#import "BesselVC.h"
#import "BesselView.h"

@interface BesselVC ()

@end

@implementation BesselVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    BesselView *draw = [[BesselView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:draw];

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
