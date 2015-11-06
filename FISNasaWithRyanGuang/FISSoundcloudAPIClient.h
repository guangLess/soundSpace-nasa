//
//  FISSoundcloudAPIClient.h
//  FISNasaWithRyanGuang
//
//  Created by Guang on 11/5/15.
//  Copyright © 2015 Guang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const clientID;

@interface FISSoundcloudAPIClient : NSObject
/*
 getTheAPOD
 getSound
 */


-(void)getAPOD;

+(void)getSound:(void (^)(NSArray * tracks))nasaTracks;


@end
