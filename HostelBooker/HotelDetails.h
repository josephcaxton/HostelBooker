//
//  HotelDetails.h
//  HostelBooker
//
//  Created by Joseph caxton-idowu on 19/02/2014.
//  Copyright (c) 2014 Interview. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelObject.h"

@interface HotelDetails : UIViewController{
    
   HotelObject *obj; 
}
@property (nonatomic, strong)  HotelObject *obj;
@property (nonatomic, strong)  UILabel *Details;


@end
