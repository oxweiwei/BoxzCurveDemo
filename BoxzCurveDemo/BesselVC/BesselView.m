//
//  BesselView.m
//  BoxzCurveDemo
//
//  Created by freevision on 2019/1/16.
//  Copyright © 2019年 Boxz. All rights reserved.
//

#import "BesselView.h"
//#import "Math.h"


typedef struct
{
    float X;
    float Y;
} PointF;




typedef NS_ENUM (NSInteger,Gear_type){
    gear_1 = 1,
    gear_2 = 2,
    gear_3 = 3,
    gear_4 = 4,
    gear_5 = 5,
    
};



@interface BesselView ()<CAAnimationDelegate> {
    
    UIBezierPath *Path;
    UIBezierPath *Path2;
    UIBezierPath *Path3;
    CAKeyframeAnimation *animation;
    UIView *_heart;
}

@property (nonatomic,strong) CAKeyframeAnimation *animation;
//@property (nonatomic,strong) UIView *heart;
@property (nonatomic,strong) NSTimer *anTimer;
@property (nonatomic,copy) NSMutableArray *pointsArr;

#define PI 3.14159265359

@end


@implementation BesselView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self drawRect:self.frame];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    //线条颜色
    UIColor *color = [UIColor orangeColor];
    [color set];
    
    Path = [UIBezierPath bezierPath];           //添加路径
    Path.lineWidth = 1;
    Path.lineCapStyle = kCGLineCapRound;        //线条拐角
    Path.lineJoinStyle = kCGLineJoinRound;      //终点处理
    
    
    
    
    /*
     
     scale_x:占X轴增量的比例，越大开始越缓 取值范围0~1
     scale_y:占Y轴增量的比例，越大开始越陡 取值范围0~1
     p0:起点；
     p1：终点；
     p1：控制点1；
     p2：控制点2；
     
     第一档：delt = 1.0;
     第二档：delt = 0.8;
     第三档：delt = 0.6;
     第四档：delt = 0.4;
     第五档：delt = 0.2;
     
     
     //只要scale_x，scale_y与相等即 45度，哪怕它们都是0；
     
     
     
     
     */
    
    //    float delt = 1.0;
    //    float scale_x = 0.45;
    //    float scale_y = 0.06;
    //    float p0_x = 0;
    //    float p0_y = 200;
    //    float p1_x = 350;
    //    p1_x = p1_x*delt;
    //    float p1_y = 50;
    //    float p2_x = (p1_x-p0_x)*scale_x;
    //    float p2_y = p0_y-(p0_y-p1_y)*scale_y;
    //    float p3_x = (p1_x-p0_x)*(1-scale_x);
    //    float p3_y = p0_y-(p0_y-p1_y)*(1-scale_y);
    //
    //    CGPoint p0 = CGPointMake(p0_x, p0_y);       //(0, 200)
    //    CGPoint p1 = CGPointMake(p1_x, p1_y);       //(350, 50)
    //    CGPoint p2 = CGPointMake(p2_x, p2_y);       //(150, 190)
    //    CGPoint p3 = CGPointMake(p3_x, p3_y);       //(200, 60)
    
    //第一条线
    //    [Path moveToPoint:p0];
    //    [Path addLineToPoint:p2];
    //    [Path addLineToPoint:p3];
    //    [Path addLineToPoint:p1];
    
    //    [Path addCurveToPoint:p1 controlPoint1:p2 controlPoint2:p3];
    
    //    //第二条线
    //    [Path moveToPoint:(CGPoint){20,300}];
    //    [Path addCurveToPoint:(CGPoint){350,300} controlPoint1:(CGPoint){170,340} controlPoint2:(CGPoint){200,260}];
    //    //第三条线
    //    [Path moveToPoint:(CGPoint){20,400}];
    //    [Path addCurveToPoint:(CGPoint){350,550} controlPoint1:(CGPoint){170,410} controlPoint2:(CGPoint){200,540}];
    
    //根据坐标点连线
    //    [Path stroke];
    //    NSLog(@"%.2f",Path.currentPoint.y);
    
    
    /*
     
     PointF:输入的点数组；
     num：分的份数；
     target：想要第几个点；
     */
    //
    //    _pointsArr = [NSMutableArray array];
    //    PointF in[4] = {{p0_x, p0_y},{p2_x, p2_y},{p3_x, p3_y},{p1_x, p1_y}}; // 输入点
    //    int num = 1000;                     // 输出点数
    //    PointF out[num];                    // 输出点数组
    //    int target = 500;                   // 输出点数
    //
    ////    draw_bezier_curves(in,3,out,num); // 二阶贝塞尔曲线
    //    draw_bezier_curves(in,4,out,num);   // 三阶贝塞尔曲线
    //    for(int j=0; j<num; j++)    // 输出路径点
    //    {
    //        CGPoint subPoint =  CGPointMake(out[j].X, out[j].Y);
    //        if (j==0) {
    //            [Path moveToPoint:subPoint];
    //        }else {
    //            [Path addLineToPoint:subPoint];
    //        }
    ////        [_pointsArr addObject:subPoint];
    //        if (j == target) {
    //            printf("i=%d\t X=%f \t Y=%f \r\n",j,out[j].X,out[j].Y);
    //        }
    //    }
    
    //    [Path stroke];
    
    
    
    
    
    
    
    //核心动画
    _heart = [[UIView alloc] init];
    _heart.frame = CGRectMake(0, 0, 10, 10);
    _heart.layer.cornerRadius = 5.0;
    _heart.layer.masksToBounds = YES;
    _heart.backgroundColor =[UIColor redColor];
    [self addSubview:_heart];
    
    _animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    _animation.delegate = self;
    _animation.duration = 5.0f;// 动画时间间隔
    _animation.repeatCount = 1;// // 重复次数为最大值 FLT_MAX
    _animation.removedOnCompletion = NO;
    _animation.fillMode = kCAFillModeForwards;
    _animation.autoreverses = YES;//是否逆动画
    //设置加速度
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    
    /*
     timingFunctionName的enum值如下：
     kCAMediaTimingFunctionLinear 匀速
     kCAMediaTimingFunctionEaseIn 慢进
     kCAMediaTimingFunctionEaseOut 慢出
     kCAMediaTimingFunctionEaseInEaseOut 慢进慢出
     kCAMediaTimingFunctionDefault 默认值（慢进慢出）
     */
    
    //    CGPoint p0 = CGPointMake(p0_x, p0_y);       //(0, 200)
    //    CGPoint p1 = CGPointMake(p1_x, p1_y);       //(350, 50)
    //    CGPoint p2 = CGPointMake(p2_x, p2_y);       //(150, 190)
    //    CGPoint p3 = CGPointMake(p3_x, p3_y);       //(200, 60)
    
    
    
    //    float p0X = 50;
    //    float p0Y = 700;
    //    float p1X = 300;
    //    float p1Y = 150;
    
    
    float point0x = 20.0;
    float point0y = 300.0;
    float point1x = self.frame.size.width-40;
    float point1y = 100.0;
    //递增
    CGPoint point0 = CGPointMake(point0x, point0y);
    CGPoint point1 = CGPointMake(point1x, point1y);
    //递减
    CGPoint point0_0 = CGPointMake(point0x, point1y);
    CGPoint point1_1 = CGPointMake(point1x, point0y);
    
    float point0x0 = 20.0;
    float point0y0 = 550.0;
    float point1x1 = self.frame.size.width-40;
    float point1y1 = 350.0;
    //递增
    CGPoint point00 = CGPointMake(point0x0, point0y0);
    CGPoint point11 = CGPointMake(point1x1, point1y1);
    //递减
    CGPoint point00_0 = CGPointMake(point0x0, point1y1);
    CGPoint point11_1 = CGPointMake(point1x1, point0y0);
    
    [Path moveToPoint:point0];
    
    //Y递增，总时间变小
    [self getCurveGear:1.0 point0:point0 point1:point1];
    [self getCurveGear:0.8 point0:point0 point1:point1];
    [self getCurveGear:0.7 point0:point0 point1:point1];
    [self getCurveGear:0.6 point0:point0 point1:point1];
    [self getCurveGear:0.5 point0:point0 point1:point1];
    //Y递减，总时间变小
    [self getCurveGear:1.0 point0:point0_0 point1:point1_1];
    [self getCurveGear:0.8 point0:point0_0 point1:point1_1];
    [self getCurveGear:0.7 point0:point0_0 point1:point1_1];
    [self getCurveGear:0.6 point0:point0_0 point1:point1_1];
    [self getCurveGear:0.5 point0:point0_0 point1:point1_1];
    
    //Y递增，总时间不变
    [self getCurveGear:1.0 point0:point00 point1:point11];
    [self getCurveGear:1.3 point0:point00 point1:point11];
//    [self getCurveGear:1.5 point0:point00 point1:point11];
//    [self getCurveGear:1.7 point0:point00 point1:point11];
//    [self getCurveGear:1.9 point0:point00 point1:point11];
//    //Y递减，总时间不变
//    [self getCurveGear:1.0 point0:point00_0 point1:point11_1];
//    [self getCurveGear:1.3 point0:point00_0 point1:point11_1];
//    [self getCurveGear:1.5 point0:point00_0 point1:point11_1];
//    [self getCurveGear:1.7 point0:point00_0 point1:point11_1];
//    [self getCurveGear:1.9 point0:point00_0 point1:point11_1];
    
    _animation.path = Path.CGPath;                                  // 设置动画的路径为心形路径
    
    [_heart.layer addAnimation:_animation forKey:nil];              // 将动画添加到动画视图上
}


/**
 画S曲线
 gear：档位
 point0：起点坐标
 point1：终点坐标
 PointF：含有X,Y值的结构体；
 
 by zxw 2019_01_14
 */
#pragma mark - 画S曲线
- (void)getCurveGear:(float)gear point0:(CGPoint)point0 point1:(CGPoint)point1 {
    
    //线条颜色
    UIColor *color = [UIColor orangeColor];
    [color set];
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    
    
    float delt = gear;
    float scale_x = 0.45;
    float scale_y = 0.06;
    
    if (gear > 1.0) {
//        scale_x = scale_x*gear*1.2;
        
//    scale_x:占X轴增量的比例，值越大 开始越缓 取值范围0~1
//    scale_y:占Y轴增量的比例，值越大 开始越陡 取值范围0~1
        
         scale_x = 0.85;
         scale_y = 0.1;
    }
    
    float p0_x = point0.x;
    float p0_y = point0.y;
    float p1_x = point1.x;
    if (gear <= 1.0) {
        p1_x = p0_x+(p1_x-p0_x)*delt;
    }
    float p1_y = point1.y;
    float p2_x = p0_x+(p1_x-p0_x)*scale_x;
    float p2_y = p0_y+(p1_y-p0_y)*scale_y;
    float p3_x = p0_x+(p1_x-p0_x)*(1-scale_x);
    float p3_y = p0_y+(p1_y-p0_y)*(1-scale_y);
    
    
    
    //    CGPoint p0 = CGPointMake(p0_x, p0_y);       //(0, 200)
    //    CGPoint p1 = CGPointMake(p1_x, p1_y);       //(350, 50)
    //    CGPoint p2 = CGPointMake(p2_x, p2_y);       //(150, 190)
    //    CGPoint p3 = CGPointMake(p3_x, p3_y);       //(200, 60)
    
    PointF in[4] = {{p0_x, p0_y},{p2_x, p2_y},{p3_x, p3_y},{p1_x, p1_y}}; // 输入4个坐标点
    int num = 1000;                     // 输出点数
    PointF out[num];                    // 输出点数组
    int target = 500;                   // 输出点数
    draw_bezier_curves(in,4,out,num);   // 三阶贝塞尔曲线
    for(int j=0; j<num; j++)            // 输出路径点
    {
        CGPoint subPoint =  CGPointMake(out[j].X, out[j].Y);
        if (j==0) {
            [path moveToPoint:subPoint];
        }else {
            [path addLineToPoint:subPoint];
        }
        
        [Path addLineToPoint:subPoint];
        if (j == target) {
            printf("i=%d\t X=%f \t Y=%f \r\n",j,out[j].X,out[j].Y);
        }
    }
    
    [path stroke];                      //画曲线
}


PointF bezier_interpolation_func(float t, PointF* points, int count)
{
    assert(count>0);
    
    PointF tmp_points[count];
    for (int i = 1; i < count; ++i)
    {
        for (int j = 0; j < count - i; ++j)
        {
            if (i == 1)
            {
                tmp_points[j].X = (float)(points[j].X * (1 - t) + points[j + 1].X * t);
                tmp_points[j].Y = (float)(points[j].Y * (1 - t) + points[j + 1].Y * t);
                continue;
            }
            tmp_points[j].X = (float)(tmp_points[j].X * (1 - t) + tmp_points[j + 1].X * t);
            tmp_points[j].Y = (float)(tmp_points[j].Y * (1 - t) + tmp_points[j + 1].Y * t);
        }
    }
    return tmp_points[0];
}

void draw_bezier_curves(PointF* points, int count, PointF* out_points,int out_count)
{
    float step = 1.0 / out_count;
    float t =0;
    for(int i=0; i<out_count; i++)
    {
        PointF temp_point = bezier_interpolation_func(t, points, count);    // 计算插值点
        t += step;
        out_points[i] = temp_point;
    }
}



//动画开始时
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"开始了:%.2f",_heart.frame.origin.y);
    
}



//动画结束时
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //方法中的flag参数表明了动画是自然结束还是被打断,比如调用了removeAnimationForKey:方法或removeAnimationForKey方法，flag为NO，如果是正常结束，flag为YES。
    
    NSLog(@"结束了:%.2f",_heart.frame.origin.y);
    [_anTimer setFireDate:[NSDate distantFuture]];
    
    [self.anTimer invalidate];
    self.anTimer = nil;
}


- (void)function:(id)sender {
    //self导致定时器不能被销毁
    NSLog(@"yyy:%.2f",_heart.layer.position.y);
}










/*
 
 /*
 1.实现画图有三种代码可以实现：
 
 UIBezierPath（贝塞尔曲线路径）：使用面向对象方式编码
 http://www.cnblogs.com/0320y/p/5082051.html
 CGContextRef（图形上下文）：是用函数式编码
 http://www.jianshu.com/p/afb7315768fa
 CGMutablePathRef（图形路径）：是用函数式编码
 http://www.cnblogs.com/wxios/p/4533106.html
 
 
 
 
 */

/*
 
 六边形
 */
//    //线条颜色
//    UIColor *color = [UIColor orangeColor];
//    [color set];
//
//    //创建path
//    path = [UIBezierPath bezierPath];
//    //设置线宽
//    path.lineWidth = 3;
//    //线条拐角
//    path.lineCapStyle = kCGLineCapRound;//    kCGLineCapButt,     kCGLineCapRound,     kCGLineCapSquare
//    //终点处理
//    path.lineJoinStyle = kCGLineJoinRound;//    kCGLineJoinMiter,     kCGLineJoinRound,     kCGLineJoinBevel
//
//    [path moveToPoint:(CGPoint){100,100}];
//    [path addLineToPoint:(CGPoint){200,100}];
//    [path addLineToPoint:(CGPoint){250,150}];
//    [path addLineToPoint:(CGPoint){200,200}];
//    [path addLineToPoint:(CGPoint){100,200}];
//    [path addLineToPoint:(CGPoint){50,150}];
//    [path closePath];
//    //根据坐标点连线
//
//     [path stroke];    //二维6边形线框
////    [path fill];        //二维实体六边形


/*
 矩形
 */

//    //线条颜色
//    UIColor *color = [UIColor orangeColor];
//    [color set];
//
//    //创建path
//    //rect四个值分别为（x、y、矩形长，矩形宽）
//    path = [UIBezierPath bezierPathWithRect:(CGRect){10,20,100,50}];
//    //设置线宽
//    path.lineWidth = 3;
//    //线条拐角
//    path.lineCapStyle = kCGLineCapRound;
//    //终点处理
//    path.lineJoinStyle = kCGLineJoinRound;
//
//    //根据坐标点连线
//    [path stroke];



/*
 绘制圆形或椭圆形
 这个方法根据传入的rect矩形参数绘制一个内切曲线。
 当传入的rect是一个正方形时，绘制的图像是一个内切圆；当传入的rect是一个长方形时，绘制的图像是一个内切椭圆。
 */

//    //线条颜色
//    UIColor *color = [UIColor orangeColor];
//    [color set];
//    //添加路径
//    path = [UIBezierPath bezierPathWithOvalInRect:(CGRect){50,50,200,100}];
//    path.lineWidth = 3;
//    //线条拐角
//    path.lineCapStyle = kCGLineCapRound;
//    //终点处理
//    path.lineJoinStyle = kCGLineJoinRound;
//    //根据坐标点连线
//    [path stroke];
//



/*
 
 绘制弧线
 其中 Center:圆弧的中心；
 radius:半径；
 startAngle:开始角度；
 endAngle:结束角度；
 clockwise:是否顺时针方向；
 */

//
//    //线条颜色
//    UIColor *color = [UIColor orangeColor];
//    [color set];
//    //添加路径
//    path = [UIBezierPath bezierPathWithArcCenter:(CGPoint){100,50}
//                                          radius:50
//                                      startAngle:0
//                                        endAngle:PI*0.5
//                                       clockwise:YES
//            ];
//    path.lineWidth = 3;
//    //线条拐角
//    path.lineCapStyle = kCGLineCapRound;
//    //终点处理
//    path.lineJoinStyle = kCGLineJoinRound;
//    //根据坐标点连线
//    [path stroke];




/*
 
 二次贝塞尔曲线和三次贝塞尔曲线的绘制
 曲线段在当前点开始，在指定的点结束；曲线的形状有开始点，结束点，一个或者多个控制点的切线定义。
 下图显示了两种曲线类型的相似，以及控制点和curve形状的关系。
 
 (1) 绘制二次贝塞尔曲线
 方法：- (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;
 */

//    //线条颜色
//    UIColor *color = [UIColor orangeColor];
//    [color set];
//    //添加路径
//    path = [UIBezierPath bezierPath];
//    path.lineWidth = 3;
//    //线条拐角
//    path.lineCapStyle = kCGLineCapRound;
//    //终点处理
//    path.lineJoinStyle = kCGLineJoinRound;
//    [path moveToPoint:(CGPoint){20,100}];
//    [path addQuadCurveToPoint:(CGPoint){100,100} controlPoint:(CGPoint){50,20}];
//    //根据坐标点连线
//    [path stroke];


/*
 
 绘制三次贝塞尔曲线
 方法：- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;
 */







/*
 工控领域经常会涉及速度加减速的算法：线性加减速，S曲线加减速（sin函数，拓展其他三角函数曲线）， 贝塞尔曲线，等等。
 线性加减速：    设定起始速度V0，目标速度V1，加速时间Ta（s,或加速度），这个的任务执行周期为ΔT( ms 级 或者设定定时器，定时时间必须大于任务周期否则还是按任务周期计算输出)。
 int  iCounter ;
 　 iCounter = Ta/(ΔT/1000) ;     //计算达到输出  任务需执行的  周期数。
 　for(int i =0; i<iCounter;i++ )
 　　Vout = V0+i*（V1-V0）/iCounter;          // Vout  为每个周期 输出 的 目标 速度。
 S曲线加减速： 设定起始速度V0，目标速度V1，加速时间Ta（s,或加速度），这个的任务执行周期为ΔT( ms 级 或者设定定时器，定时时间必须大于任务周期否则还是按任务周期计算输出)。
 　　int  iCounter ;
 　　iCounter = Ta/(ΔT/1000) ;     //计算达到输出  任务需执行的  周期数。
 　　for(int i =0; i<iCounter;i++ )
 Vout = V0+（V1-V0）（1+Sin( (pi/iCounter)*i-pi/2 )）;          // Vout  为每个周期 输出 的 目标 速度。
 贝塞尔曲线：很少或者基本不用贝塞尔曲线来规划 曲线加减速，但是有必要了解贝塞尔曲线的原理，及其低阶曲线的算法（3、4控制点）。
 
 贝塞尔曲线原理：
 
 
 */


//    float V0 = 0;
//    float V1 = 0.2;
//    float Ta = 30;
//    float ΔT = 2;
//
//
//
//线性
//    int iCounter = Ta/(ΔT/1000);     //计算达到输出  任务需执行的  周期数。
//    for(int i =0; i<iCounter;i++) {
//        float Vout = V0+i*(V1-V0)/iCounter;          // Vout  为每个周期 输出 的 目标 速度。
//        NSLog(@"%.2f",Vout);
//    }


//    S曲线

//
//    int  iCounter ;
//    iCounter = Ta/(ΔT/1000) ;     //计算达到输出  任务需执行的  周期数。
//    for(int i =0; i<iCounter;i++) {
//        float Vout = V0+(V1-V0)*(1+sin((PI/iCounter)*i-PI/2));          // Vout  为每个周期 输出 的 目标 速度。 （1+Sin( (pi/iCounter)*i-pi/2 )）;
//        NSLog(@"%.2f",Vout);
//    }




////    贝塞尔曲线
//    NSArray *arr1 = [NSArray arrayWithObjects:@"3",@"8", nil];
//    NSArray *arr2 = [NSArray arrayWithObjects:@"4",@"3", nil];
//    NSArray *arr3 = [NSArray arrayWithObjects:@"2",@"7", nil];
//    NSArray *arr = [NSArray arrayWithObjects:arr1,arr2,arr3, nil];
//
//
//    for (int i = 0; i < 10; i++) {
//        float t = i / 10;
//        arr[i][0] = (float) (1 * Math.pow(1 - t, 2) * Math.pow(t, 0) * p0[0] + 2 * Math.pow(1 - t, 1) * Math.pow(t, 1) * p1[0] + 1 * Math.pow(1 - t, 0) * Math.pow(t, 2) * p2[0]);
//        arr[i][1] = (float) (1 * Math.pow(1 - t, 2) * Math.pow(t, 0) * p0[1] + 2 * Math.pow(1 - t, 1) * Math.pow(t, 1) * p1[1] + 1 * Math.pow(1 - t, 0) * Math.pow(t, 2) * p2[1]);
//
//    }




//
//        //矩形贝塞尔曲线
//        UIBezierPath* bezierPath_rect = [UIBezierPath bezierPathWithRect:CGRectMake(30, 50, 100, 100)];
//        [bezierPath_rect moveToPoint:CGPointMake(60, 60)];
//        [bezierPath_rect addLineToPoint:CGPointMake(80, 80)];
//        [bezierPath_rect addLineToPoint:CGPointMake(60, 90)];
//        //[bezierPath_rect closePath];
//        //[bezierPath_rect removeAllPoints];
//        bezierPath_rect.lineCapStyle = kCGLineCapButt;  //端点类型
//        bezierPath_rect.lineJoinStyle = kCGLineJoinMiter;  //线条连接类型
//        bezierPath_rect.miterLimit = 1;
//        CGFloat dash[] = {20,1};
//        [bezierPath_rect setLineDash:dash count:2 phase:0];
//        bezierPath_rect.lineWidth = 10;


//        //圆形 椭圆贝塞尔曲线
//        UIBezierPath *bezierPath_oval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(200, 50, 150, 100)];
//        bezierPath_oval.lineWidth = 10;

//还有圆角的贝塞尔曲线
//        UIBezierPath *bezierPath_RoundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(30, 200, 100, 100) cornerRadius:20];
//        bezierPath_RoundedRect.lineWidth = 10;


//    //绘制可选择圆角方位的贝塞尔曲线
//        UIBezierPath *bezierPath_RoundedCornerRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(200, 200, 100, 100) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
//        bezierPath_RoundedCornerRect.lineWidth = 10;

//        //绘制圆弧曲线
//        UIBezierPath *bezierPath_ArcCenter = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 400) radius:50 startAngle:M_PI / 2 * 3 endAngle:M_PI / 3 clockwise:YES];
//        bezierPath_ArcCenter.lineWidth = 10;

//
//        //添加二次 三次贝塞尔曲线
//        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
//        bezierPath.lineWidth = 2;
//        [bezierPath moveToPoint:CGPointMake(10, 520)];
//        [bezierPath addLineToPoint:CGPointMake(50, 530)];
//        [bezierPath addQuadCurveToPoint:CGPointMake(100, 510) controlPoint:CGPointMake(80, 650)];
//        [bezierPath addCurveToPoint:CGPointMake(200, 530) controlPoint1:CGPointMake(130, 600) controlPoint2:CGPointMake(170, 400)];
//        [bezierPath addArcWithCenter:CGPointMake(300, 400) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
//
//        [bezierPath moveToPoint:CGPointMake(20, 520)];
//        [bezierPath addLineToPoint:CGPointMake(40, 520)];
//        //根据CGPathRef绘制贝塞尔曲线
//        CGMutablePathRef path = CGPathCreateMutable();
//        CGPathMoveToPoint(path, NULL, 10, 640);
//        CGPathAddCurveToPoint(path, NULL, 100, 700, 250, 550, 350, 650);
//        UIBezierPath *bezierPath_CGPath = [UIBezierPath bezierPathWithCGPath:path];
//        bezierPath_CGPath.lineWidth = 4;
//        //选择填充颜色
//        [[UIColor redColor] set];
////        [bezierPath_rect fill];
////        [bezierPath_oval fill];
////        [bezierPath_RoundedRect fill];
////        [bezierPath_RoundedCornerRect fill];
//        //[bezierPath_ArcCenter fill];
//        //[bezierPath_CGPath fill];
//
//        //选择线条颜色
//        [[UIColor blackColor] set];
////        [bezierPath_rect stroke];
////        [bezierPath_oval stroke];
////        [bezierPath_RoundedRect stroke];
////        [bezierPath_RoundedCornerRect stroke];
////        [bezierPath_ArcCenter stroke];
//        [bezierPath stroke];
//        [bezierPath_CGPath stroke];
//        //
//        CALayer* aniLayer = [CALayer layer];
//        aniLayer.backgroundColor = [UIColor redColor].CGColor;
//        aniLayer.position = CGPointMake(10, 520);
//        aniLayer.bounds = CGRectMake(0, 0, 8, 8);
//        aniLayer.cornerRadius = 4;
//        [self.layer addSublayer:aniLayer];
//
//        //
//        CAKeyframeAnimation* keyFrameAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//        keyFrameAni.repeatCount = NSIntegerMax;
//        keyFrameAni.path = bezierPath.CGPath;
//        keyFrameAni.duration = 15;
//        keyFrameAni.beginTime = CACurrentMediaTime() + 1;
//        [aniLayer addAnimation:keyFrameAni forKey:@"keyFrameAnimation"];


/*
 
 ios CGPoint CGSize CGRect CGFloat用法
 
 1、数据类型：
 
 CGFloat: 浮点值的基本类型
 CGPoint: 表示一个二维坐标系中的点
 CGSize: 表示一个矩形的宽度和高度
 CGRect: 表示一个矩形的位置和大小
 
 typedef float CGFloat;// 32-bit
 typedef double CGFloat;// 64-bit
 
 struct CGPoint {
 CGFloat x;
 CGFloat y;
 };
 typedef struct CGPoint CGPoint;
 
 struct CGSize {
 CGFloat width;
 CGFloat height;
 };
 
 程序中的数学应用
 
 
 */


/*
 
 心型贝塞尔曲线
 
 */
// Drawing code
//    // 初始化UIBezierPath
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    // 首先设置一个起始点
//
//    /////左半边曲线
//    CGPoint startPoint = CGPointMake(rect.size.width/2,  rect.size.height*0.4);
//    // 以起始点为路径的起点
//    [path moveToPoint:startPoint];
//    // 设置一个终点
//    CGPoint endPoint = CGPointMake(rect.size.width/2, rect.size.height- rect.size.height*0.1);
//
//    // 设置第一个控制点
//    CGPoint controlPoint1 = CGPointMake(self.bounds.size.width*0.1, rect.size.height*0.1);
//    // 设置第二个控制点
//    CGPoint controlPoint2 = CGPointMake(0, self.frame.size.height*0.7);
//    // 添加三次贝塞尔曲线
//    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
//    // 设置另一个起始点
//    [path moveToPoint:endPoint];
//
//    //右半边曲线>>>>>>>>>>>>>>>>>>>>
//    // 设置第三个控制点
//    CGPoint controlPoint3 = CGPointMake(rect.size.width-self.bounds.size.width*0.1,  rect.size.height*0.1);
//    // 设置第四个控制点
//    CGPoint controlPoint4 = CGPointMake(rect.size.width, self.frame.size.height*0.7);
//    // 添加三次贝塞尔曲线
//    [path addCurveToPoint:startPoint controlPoint1:controlPoint4 controlPoint2:controlPoint3];
//    // 设置线宽
//    path.lineWidth = 3;
//    // 设置线断面类型
//    path.lineCapStyle = kCGLineCapRound;
//    // 设置连接类型
//    path.lineJoinStyle = kCGLineJoinRound;
//    // 设置画笔颜色
//    [[UIColor redColor] set];
//
//    [path stroke];






/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
