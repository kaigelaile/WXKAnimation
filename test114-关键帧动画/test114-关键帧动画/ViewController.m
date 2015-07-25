//
//  ViewController.m
//  test114-关键帧动画
//
//  Created by apple on 15-7-19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)CALayer *layer;
@property(nonatomic,strong)UIButton *butt;
@property(nonatomic,strong)CADisplayLink *link;
@property(nonatomic,strong)NSTimer *time;
@end

@implementation ViewController
//-(CADisplayLink *)link{
//    if (_link==nil) {
//        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationkai)];
//    }
//        return _link;
//}

-(void)animationkai{
    //self.layer.backgroundColor = (__bridge CGColorRef)([UIColor colorWithRed:arc4random_uniform(256.0)/255 green:(256.0)/255 blue:(256.0)/255 alpha:1.0]);
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;

}
- (void)viewDidLoad {
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
   self.time = [NSTimer timerWithTimeInterval:1/120.0 target:self selector:@selector(animations) userInfo:nil repeats:YES];
    [self.time fire];

    [super viewDidLoad];
    CALayer *layer = [[CALayer alloc]init];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    self.layer = layer;
    [self.view.layer addSublayer:layer];
//    UIButton *butt = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    self.butt = butt;
//    butt.layer.backgroundColor = [UIColor grayColor].CGColor;
//    [self.view addSubview:butt];
//    //给按钮添加监听事件
//    [butt addTarget:self action:@selector(didclick) forControlEvents:UIControlEventTouchUpInside];
    }
//按钮的监听事件
//-(void)didclick{
//    NSLog(@"凯哥来了");
//
//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self test6];
}
//关键帧动画测试 layer 移动后的具体位置
-(void)test3{
    //创建关键帧动画对象
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置 values 数组中的值
    NSValue *p1 = [NSValue valueWithCGPoint:CGPointMake(0, 100)];
    NSValue *p2 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *p3 = [NSValue valueWithCGPoint:CGPointMake(200, 100)];
    //给 values 赋值
    animation.values = @[p1,p2,p3];
    //设置动画执行完不返回原来的位置
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //给 button 的 layer 添加动画
    [self.butt.layer addAnimation:animation forKey:nil];
    
}


//关键帧动画,随图形移动
-(void)test2{
    //创建关键帧动画,并且类型为 position
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //创建一个用于 label 移动的图形
    UIBezierPath *bezierpath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 300, 300) cornerRadius:50.0];
    //设置时间
    animation.duration = 1;
    //设置次数
    animation.repeatCount = 2;
    //设置 animation 的 path
    animation.path = bezierpath.CGPath;
    //给 layer 添加动画
    [self.layer addAnimation:animation forKey:nil];
}


//关键帧动画抖动
-(void)test1{
    //如果是已经执行过的动画就不再执行
    if ([self.layer animationForKey:@"key1"]) {
        return;
    }
    
    //创建关键帧动画对象
    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    //设置 keyframe 的values
    keyframe.values = @[@(-M_PI*0.3),@(M_PI*0.3),@(-M_PI*0.3)];
    //设置重复次数
    keyframe.repeatCount = 3;
    //设置动画事件
    keyframe.duration = 0.5;
    //设置动画执行完后不要回去
    keyframe.removedOnCompletion = NO;
    keyframe.fillMode = kCAFillModeForwards;
    //给图层添加动画,并且给该动画添加一个 key 值,用于下次判断动画是否还执行
    [self.layer addAnimation:keyframe forKey:@"key1"];

}
//组动画
-(void)test6{
    
    //组动画
    CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
    
//核心动画
    CABasicAnimation *animation1 = [[CABasicAnimation alloc]init];
    animation1.keyPath  = @"position";
    animation1.fromValue = [NSValue valueWithCGPoint:CGPointZero];
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 300)];
    //
    CABasicAnimation *animation2 = [[CABasicAnimation alloc]init];
    animation2.keyPath = @"transform.rotation";
    animation2.toValue = @(M_PI*20);
    
    //关键帧动画
    CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 200, 200)];
    animation3.path = path.CGPath;
    //
    CABasicAnimation *animation4 = [[CABasicAnimation alloc]init];
    animation4.keyPath = @"transform.scale";
    animation4.toValue = @(4);
    
    group.animations = @[animation2,animation1,animation4,animation3];
    group.repeatCount = CGFLOAT_MAX;
    group.duration = 1;
    
    [self.layer addAnimation:group forKey:nil];
    


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
