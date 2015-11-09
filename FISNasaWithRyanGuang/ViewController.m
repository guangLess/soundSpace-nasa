//
//  ViewController.m
//  FISNasaWithRyanGuang
//
//  Created by Guang on 10/22/15.
//  Copyright © 2015 Guang. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "FISSoundcloudAPIClient.h"
#import "FISEachTrack.h"
#import "FISTrackButton.h"

#import "ConnectedLines.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *test;
@property (weak, nonatomic) IBOutlet UILabel *apodTitle;
@property (strong, nonatomic) AVPlayer *audioPlayer; // player? !!! change
@property (strong, nonatomic) NSDate * dataCapture;

@property (strong, nonatomic) NSMutableArray * allTracks;
@property (strong, nonatomic) UILabel * soundTitel;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.allTracks = [NSMutableArray new];
    //[self getAllTracks];
    [self buttonManage];
    [self getApod];
    
   // ConnectedLines *view = [[ConnectedLines alloc]initWithFrame:CGRectMake(110, 100, 10, 10)];
   // [self.view addSubview:view];
    
    /*
     NSString *trackID = @"100026228";
     NSString *clientID = @"YOUR_CLIENT_ID";
     NSURL *trackURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.soundcloud.com/tracks/%@/stream?client_id=%@", trackID, clientID]];
     
     NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:trackURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
     // self.player is strong property
     self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
     [self.player play];
     }];
     [task resume];
     */
}

-(void)buttonManage{
    
    [self getAllTracks:^(NSArray *tracks) {
        
        for(NSUInteger i = 0; i < tracks.count; i++) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                FISTrackButton *button = [FISTrackButton buttonWithType:UIButtonTypeCustom];
                button.track = self.allTracks[i];
                //[button setTitle:[self.allTracks[i] title] forState:UIControlStateNormal];
                
                [self.view addSubview:button];
                [self makeThisThingFloat:button]; // Ryan added animation
                button.frame = CGRectMake(10 + arc4random_uniform(400), 10 + arc4random_uniform(600), 150 + arc4random_uniform(150), 25 + arc4random_uniform(0));
                //button.frame.origin =
                
                UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cross"]];
                [button addSubview:image];
                
//                ConnectedLines *view = [[ConnectedLines alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
//                [button addSubview:view];
                //button.backgroundColor = [UIColor redColor];
                [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            }];
        }
        
    }];

}


-(void)buttonTapped:(FISTrackButton *)sender
{
    NSLog(@"you tapped the button!");
    self.soundTitel = nil; // how to refresh 
    NSString *urlWithParams = [NSString stringWithFormat:@"%@?client_id=%@", sender.track.stream_url, clientID];
    NSURL * streamURL = [NSURL URLWithString: urlWithParams];
    self.audioPlayer = [[AVPlayer alloc] initWithURL:streamURL];
    [self.audioPlayer play];
    
    self.soundTitel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 100)];
    self.soundTitel.text = sender.track.title;
    [self.soundTitel sizeToFit];
    self.soundTitel.textColor = [UIColor whiteColor];
    [sender addSubview:self.soundTitel];
}

-(void)getAllTracks:(void (^)(NSArray * tracks))tracksReady{
 
   [ FISSoundcloudAPIClient getSound:^(NSArray *tracks) {
       
       for (NSDictionary * eachTrack in tracks) {
           FISEachTrack * tracClass = [FISEachTrack activeSoundTrack:eachTrack];
           [self.allTracks addObject:tracClass];
           NSLog(@"-- %@",tracClass.title);
       }
       tracksReady(self.allTracks);
   }];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)makeThisThingFloat:(id)thing{
    UIView *theThing = thing;
    
    [UIButton animateKeyframesWithDuration:10 delay:0 options: UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        [UIButton addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
            
            CGFloat newX = arc4random_uniform(5);
            CGFloat newY = arc4random_uniform(40);
            
            theThing.transform = CGAffineTransformMakeTranslation(newX, newY);
            
        }];
        [UIButton addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
            
            CGFloat newX = arc4random_uniform(5);
            CGFloat newY = arc4random_uniform(50);
            
            theThing.transform = CGAffineTransformMakeTranslation(newX, newY);
            
        }];
        [UIButton addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            CGFloat newX = arc4random_uniform(5);
            CGFloat newY = arc4random_uniform(60);
            
            theThing.transform = CGAffineTransformMakeTranslation(newX, newY);
            
        }];
        [UIButton addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            CGFloat newX = arc4random_uniform(5);
            CGFloat newY = arc4random_uniform(50);
            
            theThing.transform = CGAffineTransformMakeTranslation(newX, newY);
            
        }];
    } completion:^(BOOL finished) {
        [self makeThisThingFloat:(theThing)];
    }];
}

-(void)getApod{
    
    NSString * urlS = @"https://api.nasa.gov/planetary/apod?concept_tags=True&api_key=DEMO_KEY";
    NSURL * url = [NSURL URLWithString:urlS];
    NSData * apiData = [NSData dataWithContentsOfURL:url];
    NSDictionary * apiResult = [NSJSONSerialization JSONObjectWithData:apiData options:0 error:nil];
    
    NSString * imageURLString = [apiResult objectForKey:@"url"];
    NSString * title = [apiResult objectForKey:@"title"];
    self.apodTitle.text = title;
    
    NSURL * imageURL =[NSURL URLWithString:imageURLString];
    NSData *imageData2 = [NSData dataWithContentsOfURL:imageURL];
    UIImage * testImage = [UIImage imageWithData:imageData2];
    self.test.image = testImage;
}

@end
