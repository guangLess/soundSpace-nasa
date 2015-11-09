//
//  FISSoundcloudAPIClient.m
//  FISNasaWithRyanGuang
//
//  Created by Guang on 11/5/15.
//  Copyright © 2015 Guang. All rights reserved.
//

#import "FISSoundcloudAPIClient.h"

@implementation FISSoundcloudAPIClient

NSString *const clientID = @"a3679e6542ad2a5adfc3d54e12024254";
NSString *const soudnID = @"172463129";
NSString *const nasaID = @"112904040";



-(void)getAPOD{
    
    /*
    //    //NSString * urlS = @"https://api.nasa.gov/planetary/apod?api_key=E7wz1Dcg3A4pkpP1ugOSFhsDkjf4bC73b0kw6fzf";
    //    //NSString * urlS = @"https://api.nasa.gov/planetary/apod?concept_tags=True&api_key=NNKOjkoul8n1CH18TWA9gwngW1s1SmjESPjNoUFo";
    //
    //    NSURL * url = [NSURL URLWithString:urlS];
    //    NSData * apiData = [NSData dataWithContentsOfURL:url];
    //
    //    NSDictionary * apiResult = [NSJSONSerialization JSONObjectWithData:apiData options:0 error:nil];
    //
    
    
    
    
    // NSLog(@"%@",apiResult);
    
     NSString * imageURLString = [apiResult objectForKey:@"url"];
     NSString * title = [apiResult objectForKey:@"title"];
     self.apodTitle.text = title;
     
     NSURL * imageURL =[NSURL URLWithString:imageURLString];
     NSData *imageData2 = [NSData dataWithContentsOfURL:imageURL];
     UIImage * testImage = [UIImage imageWithData:imageData2];
     self.test.image = testImage;
     
    */
}

+(void)getSound:(void (^)(NSArray * tracks))nasaTracks{

    NSURL * soundURL = [NSURL URLWithString:@"https://api.soundcloud.com/playlists/55323777/?client_id=a3679e6542ad2a5adfc3d54e12024254"];
    
    NSURLRequest * requestSound = [NSURLRequest requestWithURL:soundURL];
    NSURLSession * sessionSound = [NSURLSession sharedSession];
    NSURLSessionTask * soundTask = [sessionSound dataTaskWithRequest:requestSound completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSLog(@"im in the completion block");
        NSError *JSONerror = nil;
        NSDictionary * soundData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&JSONerror];
        NSArray * tracks = soundData[@"tracks"];
        
        nasaTracks(tracks);

        NSLog(@"JSONERROR: %@", JSONerror);
    }];
    
    [soundTask resume];
}


@end
