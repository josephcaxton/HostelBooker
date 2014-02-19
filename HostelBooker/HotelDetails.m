//
//  HotelDetails.m
//  HostelBooker
//
//  Created by Joseph caxton-idowu on 19/02/2014.
//  Copyright (c) 2014 Interview. All rights reserved.
//

#import "HotelDetails.h"

@interface HotelDetails ()

@end

@implementation HotelDetails
@synthesize obj,Details;

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
	
    
   Details = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 70.0, 300, 240.0)];
    

    Details.font = [UIFont fontWithName:@"Helvetica" size:10];
    Details.textColor = [UIColor colorWithRed:209.0/255.0 green:82.0/255.0 blue:23.0/255.0 alpha:1];
    Details.lineBreakMode = NSLineBreakByWordWrapping;
    Details.numberOfLines = 0;
    Details.text = [NSString stringWithFormat:@"Details: %@", obj.ShortDescription];
    [self.view addSubview:Details];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    
    
    self.view = view;
    
    
    
}


@end
