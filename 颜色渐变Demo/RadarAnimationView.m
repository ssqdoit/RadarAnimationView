//
//  RadarAnimationView.m
//  颜色渐变Demo
//
//  Created by 时双齐 on 16/5/13.
//  Copyright © 2016年 亿信互联. All rights reserved.
//

static const float timeinterval = 0.5;

#import <QuartzCore/QuartzCore.h>
#import "RadarAnimationView.h"

@interface RadarAnimationView ()
{
    //定时器
    NSTimer *_timer;
}
//按钮图片
@property (nonatomic,strong)UIButton *iamgeBtn;

@end

@implementation RadarAnimationView

- (void)drawRect:(CGRect)rect {

    self.alpha = 0.5;
    //创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:timeinterval target:self selector:@selector(setUp) userInfo:nil repeats:YES];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _iamgeBtn = [[UIButton alloc]initWithFrame:self.bounds];
        [_iamgeBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_iamgeBtn];
        
        //设置默认波纹颜色
        self.raderColor = [UIColor blueColor];
    }
    return self;
}

//按钮点击事件
-(void)imageBtnClick:(UIButton *)btn
{
    if (btn.selected) {
       
        NSLog(@"1");
        self.block(@"1");
        
    }else
    {
        NSLog(@"2");
        self.selectBlock(@"2");
    }
    
    btn.selected = !btn.selected;
}

//重写setter方法
-(void)setImage:(UIImage *)image
{
    _image = image;
    [self.iamgeBtn setImage:image forState:0];
}

-(void)setSelectImage:(UIImage *)selectImage
{
    _selectImage = selectImage;
    [self.iamgeBtn setImage:selectImage forState:1];
}

-(void)setRaderColor:(UIColor *)raderColor
{
    _raderColor = raderColor;
}


//画雷达圆圈图
-(void)setUp
{
    CGPoint center = CGPointMake(self.bounds.size.height / 2, self.bounds.size.width / 2);
    
    //使用贝塞尔画圆
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:50 startAngle:0 endAngle:2 * M_PI clockwise:YES];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.fillColor = self.raderColor.CGColor;
    shapeLayer.opacity = 0.2;
    shapeLayer.path = path.CGPath;
    

    [self.layer insertSublayer:shapeLayer below:self.iamgeBtn.layer];
    
    [self addAnimation:shapeLayer];
}

-(void)addAnimation:(CAShapeLayer *)shapeLayer
{
    //雷达圈圈大小的动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"path";
    CGPoint center = CGPointMake(self.bounds.size.height / 2, self.bounds.size.width / 2);
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:1 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:center radius:[UIScreen mainScreen].bounds.size.height startAngle:0 endAngle:2 * M_PI clockwise:YES];
    basicAnimation.fromValue = (__bridge id _Nullable)(path1.CGPath);
    basicAnimation.toValue = (__bridge id _Nullable)(path2.CGPath);
    basicAnimation.fillMode = kCAFillModeForwards;

    
    //雷达圈圈的透明度
    CABasicAnimation *opacityAnimation = [CABasicAnimation animation];
    opacityAnimation.keyPath = @"opacity";

    opacityAnimation.fromValue = @(0.2);
    opacityAnimation.toValue = @(0);
    opacityAnimation.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[basicAnimation,opacityAnimation];
    group.duration = 7;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.delegate = self;
    //指定的时间段完成后,动画就自动的从层上移除
    group.removedOnCompletion = YES;
    //添加动画到layer
    [shapeLayer addAnimation:group forKey:nil];
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if (flag) {
        NSLog(@"----");
        //释放动画结束的对象  获取最上层layer
        if ([self.layer.sublayers[0] isKindOfClass:[CAShapeLayer class]]) {
            CAShapeLayer *shaperLayer = (CAShapeLayer *)self.layer.sublayers[0];
            [shaperLayer removeFromSuperlayer];
            shaperLayer = nil;
            NSLog(@"%lu",self.layer.sublayers.count);
        }
  
    }
}


@end
