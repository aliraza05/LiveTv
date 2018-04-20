//
//  BuisnessLayer.h
//  Therapist
//
//  Created by Nauman on 27/05/2014.
//  Copyright (c) 2014 shafiq rehman. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    eApiFetchAppData = 1,
    eApiSignIn,
    
} ApiName;

#define AUTH_TOKEN @"b50a576a7e6f77eb0c7b431f81f1b69771e7b409"


@protocol BusinessLayerDelegate <NSObject>

-(void)didReceiveResponseOfApi:(ApiName)api OnSuccess:(NSMutableArray*)dataArray;
-(void)didReceiveResponseOfApi:(ApiName)api OnFailure:(NSError*)error;

@end

@interface BusinessLayer : NSObject


+ (BusinessLayer *)sharedLayer;
-(instancetype)init __attribute__((unavailable("Please use + (BusinessLayer *)sharedLayer instead")));


#pragma mark - Signup API

-(void)signUpWithParams:(NSDictionary*)params andDelegate:(id<BusinessLayerDelegate>)delegate showHUD:(BOOL)showHud;

#pragma mark - Fetch APP DATA

-(void)fetchAppDataWithDelegate:(id<BusinessLayerDelegate>)delegate showHUD:(BOOL)showHud;

@end

