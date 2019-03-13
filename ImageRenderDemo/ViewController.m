//
//  ViewController.m
//  ImageRenderDemo
//
//  Created by 黄龙 on 2019/3/12.
//  Copyright © 2019年 adong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    UIImageView *iconImageView = [UIImageView new];
    UIImage *icon = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weex@2x" ofType:@"png"]];
    if ([icon respondsToSelector:@selector(imageWithRenderingMode:)]) {
//        iconImageView.image = icon;
        iconImageView.image=[self convertImage:icon withSize:CGSizeMake(80, 80) andTintColor:[UIColor lightGrayColor]];
//        优化点：重绘指定大小
        
//        iconImageView.image =[self convertAlphaImage:[icon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withTintColor:[UIColor lightGrayColor]];
//        优化点：重绘透明背景
    } else {
        iconImageView.image = [self convertAlphaImage:icon withTintColor:[UIColor lightGrayColor]];
    }
    
//    CGRect gdtRect ={{0,0},{80,80}};
//    iconImageView.frame=gdtRect;
//    iconImageView.center = self.view.center;
//   center句会导到Color Misaligned Images紫色提示像素未对齐,如375的一半有小数，未取整
    CGSize viewSize=self.view.frame.size;
    CGRect gdtRect=CGRectMake(ceilf(viewSize.width/2-40), ceilf(viewSize.height/2-40), 80, 80);
    iconImageView.frame=gdtRect;
//   优化点：指定中间位置，并取整
    
//    iconImageView.opaque=YES;
//    iconImageView.layer.opaque=YES;
//    iconImageView.layer.masksToBounds=YES;
//    iconImageView.clipsToBounds=YES;
//    iconImageView.backgroundColor=[UIColor lightGrayColor];
    
    [self.view addSubview:iconImageView];
    UIImage *leftImage=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"home_tabbar_32x32_@2x" ofType:@"png"]];
    UIImage *newLeftImage=[leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:newLeftImage style:UIBarButtonItemStylePlain target:self action:@selector(onLeft)];
    
    UIImage *rightImage=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"comment_like_icon_press_16x16_@3x" ofType:@"png"]];
    UIImage *newrightImage=[rightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:newrightImage style:UIBarButtonItemStylePlain target:self action:@selector(onLeft)];
    

    
    UIView *tmpV1=[[UIView alloc]initWithFrame:CGRectMake(30, 100, 60, 60)];
    tmpV1.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:tmpV1];
    UIView *tmpV2=[[UIView alloc]initWithFrame:CGRectMake(60, 130, 60, 60)];
    tmpV2.backgroundColor=[UIColor cyanColor];
    tmpV2.alpha=0.7;
//   或者另一种写法
//   tmpV2.backgroundColor=[[UIColor cyanColor] colorWithAlphaComponent:0.8];都可以测试效果
//   设置UIView的alpha通知或UIView的backgroundColor的alpha通道，都会影响渲染性能
    [self.view addSubview:tmpV2];

    UIView *tmpV3=[[UIView alloc]initWithFrame:CGRectMake(30, 220, 160, 100)];
    tmpV3.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:tmpV3];
    UIView *tmpV4=[[UIView alloc]initWithFrame:CGRectMake(130, 250, 160, 100)];
    tmpV4.backgroundColor=[UIColor blueColor];
//  优化点：采用纯色backgroundColor
    [self.view addSubview:tmpV4];

    UIButton *tmpBtn1=[[UIButton alloc]initWithFrame:CGRectMake(80-60, 50-30, 120, 60)];
    [tmpV4 addSubview:tmpBtn1];
    [tmpBtn1 setTitle:@"渲染优化" forState:UIControlStateNormal];
    tmpBtn1.backgroundColor=[UIColor grayColor];
//  优化点：设置了backgroundColor则Color Blended Layers会显示为绿色，故尽可能设置非透明的底色
    
//    tmpBtn1.titleLabel.font=[UIFont systemFontOfSize:20];
//    优化点：设置了Font，会导致Color Misaligned Images黄色提示尺寸不一致
    
//    tmpBtn1.layer.cornerRadius=10;
//  优化点：如果设置了cornerRadius，则Color Blended Layers会显示为红色
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:tmpBtn1.bounds
                                               byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight
                                                     cornerRadii:CGSizeMake(10 , 10)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = tmpBtn1.bounds;
    layer.path = maskPath.CGPath;
    tmpBtn1.layer.mask = layer;
    //如果有边框，此时边框不能用tmpBtn1.layer.border来设置会有出入
    CAShapeLayer *borderLayer=[CAShapeLayer layer];
    borderLayer.path= maskPath.CGPath;
    borderLayer.fillColor= [UIColor clearColor].CGColor;
    borderLayer.strokeColor= [UIColor whiteColor].CGColor;
    borderLayer.lineWidth= 1;
    borderLayer.frame=tmpBtn1.bounds;
    [tmpBtn1.layer addSublayer:borderLayer];
//    优化点:改用CAShapeLayer和UIBezierPath来设置圆角
//    CAShapeLayer继承于CALayer,可以使用CALayer的所有属性值；
//    CAShapeLayer需要贝塞尔曲线配合使用才有意义（也就是说才有效果）
//    使用CAShapeLayer(属于CoreAnimation)与贝塞尔曲线可以实现不在view的drawRect（继承于CoreGraphics走的是CPU,消耗的性能较大）方法中画出一些想要的图形
//    CAShapeLayer动画渲染直接提交到手机的GPU当中，相较于view的drawRect方法使用CPU渲染而言，其效率极高，能大大优化内存使用情况。
    
    
  
    
//    tmpBtn1.layer.borderWidth=1;
//    tmpBtn1.layer.borderColor=[[UIColor whiteColor] CGColor];
//    tmpBtn1.layer.opaque=YES;
//    tmpBtn1.opaque=YES;
//  ***为button时，设不设置opaque没啥关系
    tmpBtn1.titleLabel.backgroundColor=[UIColor grayColor];
    tmpBtn1.titleLabel.layer.masksToBounds=YES;
//  优化点：title为中文时必须设置这个,否则即使设置了opaque，Color Blended Layers也会显示为红色
//    因为label的内容是中文，label实际渲染区域要大于label的size，最外层多了个sublayer。
    tmpBtn1.titleLabel.layer.opaque=YES;
    tmpBtn1.titleLabel.opaque=YES;
//  优化点：titleLabel.opaquea或titleLabel.layer.opaque设置为yes都行，2个同时写上肯定不会错吧
    
    
}

-(UIImage *)convertAlphaImage:(UIImage *)oldImage withTintColor:(UIColor *)tintColor{
    UIGraphicsBeginImageContextWithOptions(oldImage.size, YES, 0);
    CGRect tmpRect={{0,0},oldImage.size};
    [tintColor setFill];
    UIRectFill(tmpRect);
    [oldImage drawInRect:tmpRect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

-(UIImage *)convertImage:(UIImage *)oldImage withSize:(CGSize)newSize andTintColor:(UIColor *)tintColor{
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0);
    CGRect tmpRect={{0,0},newSize};
    if (tintColor){
        [tintColor setFill];
        UIRectFill(tmpRect);
    }
    [oldImage drawInRect:tmpRect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}



-(void)onLeft{
    
}



@end
