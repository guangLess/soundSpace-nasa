//
//  FISEachTrack.h
//  FISNasaWithRyanGuang
//
//  Created by Guang on 11/5/15.
//  Copyright © 2015 Guang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISEachTrack : NSObject

@property(strong, nonatomic)NSString * title;
@property(strong, nonatomic)NSString * soundDescription;
@property(strong, nonatomic)NSString * stream_url;

+(instancetype)activeSoundTrack:(NSDictionary *)dictionary;


@end
