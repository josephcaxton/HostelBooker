//
//  ViewController.h
//  HostelBooker
//
//  Created by Joseph caxton-idowu on 19/02/2014.
//  Copyright (c) 2014 Interview. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "HotelObject.h"
@interface ViewController : UITableViewController<MBProgressHUDDelegate>{
    
    
}
@property (nonatomic, strong)  MBProgressHUD *HUD;
@property (nonatomic, strong)  NSString *URL;
@property (nonatomic, strong)  NSData *jsonData;
@property (nonatomic, strong) NSString *strData;
@property (nonatomic, strong) NSMutableArray *LocationObjects;
@property (strong, nonatomic)  UITableView *mytableView;
@property (nonatomic, retain)  UIImageView *PlaceImageView;
@property (nonatomic, retain)  UIImage *PlaceImage;
@end
