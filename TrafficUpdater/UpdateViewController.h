//
//  UpdateViewController.h
//  TrafficUpdater
//
//  Created by NHVinh on 2/21/14.
//  Copyright (c) 2014 hcmus.trafficupdater. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateViewController : UIViewController
{
    int ratingStarIndex;
    BOOL isTexting;
}
@property (strong, nonatomic) IBOutlet UIButton *recordButtonOutlet;
@property (strong, nonatomic) IBOutlet UIButton *cameraButtonOutlet;
@property (strong, nonatomic) IBOutlet UILabel *ratingNotifyLbl;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ratingStarsBtn;
@property (strong, nonatomic) IBOutlet UITextField *description;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)touchOutSide:(id)sender;
- (IBAction)beginTexting:(id)sender;

- (IBAction)rateStar:(id)sender;

@end
