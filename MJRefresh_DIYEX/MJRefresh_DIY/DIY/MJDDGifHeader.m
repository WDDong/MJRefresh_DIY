//
//  MJDDGifHeader.m
//  AwesomeBat
//
//  Created by waipmac02 on 2016/10/17.
//  Copyright © 2016年 kaicheng. All rights reserved.
//

#import "MJDDGifHeader.h"
@interface MJDDGifHeader()
{
    __unsafe_unretained UIImageView *_gifView;
}
@property (weak, nonatomic, readonly) UIImageView *gifView;
/** 动画图片 */
@property (strong, nonatomic) UIImage *image;
@end
@implementation MJDDGifHeader
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}
-(void)setImageName:(NSString *)imageName
{
    if (imageName.length == 0){
        return;
    }
    if ([UIScreen mainScreen].scale > 2) {
        imageName = [NSString stringWithFormat:@"%@@3x",imageName];
    }else{
        imageName = [NSString stringWithFormat:@"%@@2x",imageName];
    }
    self.image = [UIImage imageWithContentsOfFile:[[NSBundle mj_refreshBundle] pathForResource:imageName ofType:@"png"]];
    if (self.image.size.height > self.mj_h)
    {
        self.mj_h = self.image.size.height;
    }
}
#pragma mark - 实现父类的方法
- (void)prepare
{
    [super prepare];

    // 初始化间距
    self.labelLeftInset = 20;
    self.lastUpdatedTimeLabel.hidden = YES;

    self.stateLabel.hidden = YES;
    [self setImageName:@"loading_img_36x36"];
}
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    if (self.state != MJRefreshStateIdle || self.image == nil) return;
    // 停止动画
    [self stopAnimate];

}
-(void) startAnimate
{
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];

    animation.toValue = [ NSValue valueWithCATransform3D:

                         CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    [self.gifView.layer addAnimation:animation forKey:@"rotate360"];
}

-(void) stopAnimate
{
    [self.gifView.layer removeAllAnimations];
}
- (void)placeSubviews
{
    [super placeSubviews];

    if (self.gifView.constraints.count) return;

    self.gifView.frame = self.bounds;
    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden) {
        self.gifView.contentMode = UIViewContentModeCenter;
    } else {
        self.gifView.contentMode = UIViewContentModeRight;

        CGFloat stateWidth = self.stateLabel.mj_textWith;
        CGFloat timeWidth = 0.0;
        if (!self.lastUpdatedTimeLabel.hidden) {
            timeWidth = self.lastUpdatedTimeLabel.mj_textWith;
        }
        CGFloat textWidth = MAX(stateWidth, timeWidth);
        self.gifView.mj_w = self.mj_w * 0.5 - textWidth * 0.5 - self.labelLeftInset;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState

    // 根据状态做事情
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        [self stopAnimate];
        self.gifView.image = self.image;
        [self startAnimate];
    } else if (state == MJRefreshStateIdle) {
        [self stopAnimate];
    }
}
@end
