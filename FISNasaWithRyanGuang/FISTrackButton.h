//
//  FISTrackButton.h
//  FISNasaWithRyanGuang
//
//  Created by Guang on 11/5/15.
//  Copyright © 2015 Guang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISEachTrack.h"


@interface FISTrackButton : UIButton

@property (nonatomic, strong) FISEachTrack *track;

/*
 class method 
 
 button.frame = CGRectMake(10 + arc4random_uniform(200), 10 + arc4random_uniform(200), 50 + arc4random_uniform(50), 50 + arc4random_uniform(50));
 button.backgroundColor = [UIColor redColor];

 */



@end
