//
//  ConnectedLines.m
//  oneLine
//
//  Created by Aditya Narayan on 6/29/15.
//  Copyright (c) 2015 Guang. All rights reserved.
//  add two guestures to a view will confuse the view. add guesture to the imageview, add mualible imageView to the View

#import "ConnectedLines.h"

@interface ConnectedLines ()
@property (nonatomic, strong) NSTimer *timer;
@property float a;
@property float t;
@property CGPoint bpoint;


@end

@implementation ConnectedLines

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect {
    
    [self oneLine];
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
    else{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
};

    self.path = [UIBezierPath bezierPath];
    self.path.flatness = 0.1;
    
    self.layerY = [CAShapeLayer layer];
    [self.layer addSublayer:self.layerY];

}


-(void)handleTimer:(NSTimer *)timer{
    //float a;
    self.a = self.a + 0.01;
    
    if ( self.a > 0.01){
        self.a = 0.005;
    }
    if (self.t >4) {
        self.t = 0.001;
    }
    self.t  = self.t + self.a;

    [self oneLine];
}

-(float)mapFunction: (float) value :(float)low1 :(float)low2 :(float)high1 :(float)high2 {
    return low2 + (high2 - low2) * (value - low1) / (high1 - low1);
}


-(void)oneLine{
    
    //float x = self.bpoint.x;
    //float y = self.bpoint.y;
    float x =1;
    float y = 1;
    
    [self.path removeAllPoints];
    [self.path moveToPoint:CGPointMake(1, 3)]; //move point
    //[self.path moveToPoint:CGPointMake(passpontX.x,passpontX.y)];
    
    float mapScale = [self mapFunction:self.bpoint.x :359 :10 :10 :15];

    float iv = mapScale;
    
    float tempT = self.t;
    
    float r =7;
    
    for ( float i = 1 ; i < 720 ; i = i+ iv){
        
        float ex = r * ((2* cosf((i/M_2_PI) + tempT )- cosf(2*((i/M_2_PI)))));
        float ey = r * ((2* sinf((i/M_2_PI) + tempT )- sinf(2*((i/M_2_PI)))));
        
        float random = arc4random_uniform(9);
        float random2 = arc4random_uniform(6);
        
        [self.path addCurveToPoint: CGPointMake(ex+x, ey+y) controlPoint1: CGPointMake(random + x, random2 +y)  controlPoint2: CGPointMake(ex + x, ey+y)];
        [self.path addLineToPoint:CGPointMake(ex + x +1, ey + y - 2)];
        
    }
    
    self.layerY.path = self.path.CGPath;
    self.layerY.strokeColor = [UIColor yellowColor].CGColor;
    
    self.layerY.lineWidth = 0.2;
    self.layerY.fillColor = nil;
    
}




@end
