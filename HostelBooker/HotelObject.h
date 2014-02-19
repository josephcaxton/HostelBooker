//
//  HotelObject.h
//  HostelBooker
//
//  Created by Joseph caxton-idowu on 19/02/2014.
//  Copyright (c) 2014 Interview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelObject : NSObject


@property (nonatomic, strong) NSString * Name;
@property (nonatomic, strong) NSString * Address1;
@property (nonatomic, strong) NSString * Address2;
@property (nonatomic, strong) NSString * Type;
@property (nonatomic, strong) NSString * StarRating;
@property (nonatomic, strong) NSString * AverageRating;
@property (nonatomic, strong) NSString * ShortDescription;

@property (nonatomic, assign) float  Imagewidth;
@property (nonatomic, assign) float  ImageHeight;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * latitude;
@property (nonatomic, strong) NSString * longitude;



@end
