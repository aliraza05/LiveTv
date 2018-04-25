//
//  UserRank.m
//
//  Created by Ali Raza on 9/19/17
//  Copyright (c) 2017 PUCIT. All rights reserved.
//

#import "Event.h"
#import "Channel.h"

NSString *const kEventName = @"name";
NSString *const kEventLevel = @"live";
NSString *const kEventStatus = @"status";
NSString *const kEventImageURL = @"image_url";
NSString *const kEventPriority = @"priority";
NSString *const kEventChannel = @"channels";


@interface Event ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Event

@synthesize name = _name;
@synthesize live = _live;
@synthesize status = _status;
@synthesize image_url = _image_url;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.name = [self objectOrNilForKey:kEventName fromDictionary:dict];
            self.live = [[self objectOrNilForKey:kEventLevel fromDictionary:dict] boolValue];
            self.status = [self objectOrNilForKey:kEventStatus fromDictionary:dict];
            self.image_url = [self objectOrNilForKey:kEventImageURL fromDictionary:dict];
            self.priority = [[self objectOrNilForKey:kEventPriority fromDictionary:dict] doubleValue];

        NSArray *channel = [self objectOrNilForKey:kEventChannel fromDictionary:dict];
        
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        
        for (NSDictionary *dict in channel)
        {
            Channel *chnl = [[Channel alloc]initWithDictionary:dict];
            [temp addObject:chnl];
        }
        self.channels = temp;
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kEventName];
    [mutableDict setValue:[NSNumber numberWithBool:self.live] forKey:kEventLevel];
    [mutableDict setValue:self.status forKey:kEventStatus];
    [mutableDict setValue:self.image_url forKey:kEventImageURL];
    [mutableDict setValue:[NSNumber numberWithDouble:self.priority] forKey:kEventPriority];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.name = [aDecoder decodeObjectForKey:kEventName];
    self.live = [aDecoder decodeBoolForKey:kEventLevel];
    self.status = [aDecoder decodeObjectForKey:kEventStatus];
    self.image_url = [aDecoder decodeObjectForKey:kEventImageURL];
    self.priority = [aDecoder decodeDoubleForKey:kEventPriority];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kEventName];
    [aCoder encodeBool:_live forKey:kEventLevel];
    [aCoder encodeObject:_status forKey:kEventStatus];
    [aCoder encodeObject:_image_url forKey:kEventImageURL];
    [aCoder encodeDouble:_priority forKey:kEventPriority];

}

- (id)copyWithZone:(NSZone *)zone
{
    Event *copy = [[Event alloc] init];
    
    if (copy)
    {

        copy.name = [self.name copyWithZone:zone];
        copy.live = self.live;
        copy.status = [self.status copyWithZone:zone];
        copy.image_url = [self.image_url copyWithZone:zone];
        copy.priority = self.priority;
    }
    
    return copy;
}


@end
