//
//  UpdateViewController.m
//  TrafficUpdater
//
//  Created by NHVinh on 2/21/14.
//  Copyright (c) 2014 hcmus.trafficupdater. All rights reserved.
//

#import "UpdateViewController.h"

@interface UpdateViewController ()

@end

@implementation UpdateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    ratingStarIndex = 0;
    [self updateRatingStarsAtIndex:ratingStarIndex];
}

- (IBAction)updateInfo:(id)sender {
    
}

- (IBAction)resetData:(id)sender {
    ratingStarIndex = 0;
    [self updateRatingStarsAtIndex:ratingStarIndex];
}

-(void)updateRatingStarsAtIndex:(int)index
{
    if (index < 0 || index >= self.ratingStarsBtn.count)
        return;
    
    for (int i = index; i >= 0; i--)
    {
        UIButton *button = [self.ratingStarsBtn objectAtIndex:i];
        [button setImage:[UIImage imageNamed:@"1Star.png"] forState:UIControlStateNormal];
    }
    
    for (int i = index + 1; i < self.ratingStarsBtn.count; i++)
    {
        UIButton *button = [self.ratingStarsBtn objectAtIndex:i];
        [button setImage:[UIImage imageNamed:@"1Star_Disable.png"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rateStar:(id)sender {
    ratingStarIndex = [self.ratingStarsBtn indexOfObject:sender];
    [self updateRatingStarsAtIndex:ratingStarIndex];
}
@end
