//
//  SYViewController.m
//  SYCalander
//
//  Created by quke on 05/18/2017.
//  Copyright (c) 2017 quke. All rights reserved.
//

#import "SYViewController.h"
#import "BMHCCalenderCondtionView.h"

@interface SYViewController ()
@property(nonatomic,strong)BMHCCalenderCondtionView * dateConditonView;

@end

@implementation SYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dateConditonView = [[BMHCCalenderCondtionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.width, headViewHeigth)];
    self.dateConditonView.delegate = self;
    self.dateConditonView.dateSource = self;
    [self.view addSubview:self.dateConditonView];
    [self.dateConditonView setHidden:YES];

}

@end
