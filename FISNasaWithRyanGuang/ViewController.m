//
//  ViewController.m
//  FISNasaWithRyanGuang
//
//  Created by Guang on 10/22/15.
//  Copyright © 2015 Guang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *test;
@property (weak, nonatomic) IBOutlet UILabel *apodTitle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    NSString * urlS = @"https://api.nasa.gov/planetary/apod?api_key=E7wz1Dcg3A4pkpP1ugOSFhsDkjf4bC73b0kw6fzf";
    //NSString * urlS = @"https://api.nasa.gov/planetary/apod?concept_tags=True&api_key=NNKOjkoul8n1CH18TWA9gwngW1s1SmjESPjNoUFo";

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
