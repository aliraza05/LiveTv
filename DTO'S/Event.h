//
//  UserRank.h
//
//  Created by Ali Raza on 9/19/17
//  Copyright (c) 2017 PUCIT. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Event : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL live;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, assign) double priority;

@property (nonatomic, strong) NSArray *channels;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
