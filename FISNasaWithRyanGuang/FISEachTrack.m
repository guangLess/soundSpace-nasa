//
//  FISEachTrack.m
//  FISNasaWithRyanGuang
//
//  Created by Guang on 11/5/15.
//  Copyright © 2015 Guang. All rights reserved.
//

#import "FISEachTrack.h"

@implementation FISEachTrack

+(instancetype)activeSoundTrack:(NSDictionary *)dictionary{
    
    FISEachTrack * cellTrack = [[FISEachTrack alloc] init];
    cellTrack.title = dictionary[@"title"];
    cellTrack.soundDescription = dictionary[@"description"];
    cellTrack.stream_url = dictionary[@"stream_url"];
    
    return cellTrack;
}

@end
