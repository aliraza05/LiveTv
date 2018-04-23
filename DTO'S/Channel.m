//
//  Channel.m
//  livestreaming
//
//  Created by Ali Raza on 23/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import "Channel.h"

NSString *const kChannelName = @"name";
NSString *const kChannelLive = @"live";
NSString *const kChannelurl = @"url";
NSString *const kchannel_type = @"channel_type";
NSString *const kChannelPriority = @"priority";
NSString *const kChannelimageurl = @"image_url";


@interface Channel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Channel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.name = [self objectOrNilForKey:kChannelName fromDictionary:dict];
        self.live = [[self objectOrNilForKey:kChannelLive fromDictionary:dict] boolValue];
        self.url = [self objectOrNilForKey:kChannelurl fromDictionary:dict];
        self.image_url = [self objectOrNilForKey:kChannelimageurl fromDictionary:dict];
        self.priority = [[self objectOrNilForKey:kChannelPriority fromDictionary:dict] doubleValue];
        self.channel_type = [self objectOrNilForKey:kchannel_type fromDictionary:dict];
    }
    
    return self;
    
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
