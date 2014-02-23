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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Register for keyboard notifications
    [self registerForKeyboardNotifications];
    // Init rating index value and update rating buttons
    ratingStarIndex = 0;
    [self updateRatingStarsAtIndex:ratingStarIndex];
    
    // Init texting variable determine texting status
    isTexting = NO;
    [self updateBarButton];
    
    self.scrollView.contentSize = CGSizeMake(320, 500);

}

-(void)handleTap:(UIGestureRecognizer *)sender
{
    [self resignFirstResponder];
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

-(IBAction)uploadInfoToServer:(id)sender
{
    
}

-(IBAction)resetData:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchOutSide:(id)sender {
    [self resignFirstResponder];
}

- (IBAction)beginTexting:(id)sender {
    isTexting = YES;
    [self updateBarButton];
}

-(IBAction)doneTexting:(id)sender
{
    // If user touch left bar button
    if ([self.navigationItem.leftBarButtonItem isEqual:sender])
    {
        // Reset value in textfield
        [self.description setText:@""];
    }
    // Is user touch right bar button
    else if ([self.navigationItem.rightBarButtonItem isEqual:sender])
    {
        
    }
    
    isTexting = NO;
    [self updateBarButton];
    [self.view endEditing:YES];
}

-(void)updateBarButton
{
    if (isTexting)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTexting:)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(doneTexting:)];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cập nhật" style:UIBarButtonItemStyleBordered target:self action:@selector(uploadInfoToServer:)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Làm lại" style:UIBarButtonItemStyleBordered target:self action:@selector(resetData:)];
    }
    
}

- (IBAction)rateStar:(id)sender {
    ratingStarIndex = [self.ratingStarsBtn indexOfObject:sender];
    [self updateRatingStarsAtIndex:ratingStarIndex];
}

// ==============================================================
// Moving content under the keyboard
// Source: https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html#//apple_ref/doc/uid/TP40009542-CH5-SW7
// ==============================================================
-(void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (CGSize)getKeyboardSize:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue].size;
    return kbSize;
}

// Called when the UIKeyboardDidShowNotification is sent.
-(void)keyboardWasShown:(NSNotification *)aNotification
{
    CGSize kbSize;
    kbSize = [self getKeyboardSize:aNotification];
    
    CGRect bkgndRect = self.description.superview.frame;
    bkgndRect.size.height += kbSize.height;
    [self.description.superview setFrame:bkgndRect];
    [self.scrollView setContentOffset:CGPointMake(0, self.description.frame.origin.y - kbSize.height) animated:YES];
    
}

// Called when the UIKeyboardWillHiddenNotification is sent
-(void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    CGSize kbSize;
    kbSize = [self getKeyboardSize:aNotification];
    
    [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentOffset.y - self.description.frame.origin.y + kbSize.height) animated:YES];
    
    CGRect bkgndRect = self.description.superview.frame;
    bkgndRect.size.height -= kbSize.height;
    [self.description.superview setFrame:bkgndRect];
}

@end
