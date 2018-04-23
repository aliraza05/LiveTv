//
//  Channel.h
//  livestreaming
//
//  Created by Ali Raza on 23/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL live;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, strong) NSString *channel_type;
@property (nonatomic, assign) double priority;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
