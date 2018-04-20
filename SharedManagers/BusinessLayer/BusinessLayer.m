//
//  BuisnessLayer.m
//  Therapist
//
//  Created by Nauman on 27/05/2014.
//  Copyright (c) 2014 shafiq rehman. All rights reserved.
//

#import "BusinessLayer.h"

#import "NetworkLayer.h"


@implementation BusinessLayer

+(BusinessLayer *)sharedLayer
{
    static BusinessLayer *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)sendResponseOfApi:(ApiName)api withError:(NSError*)error andDataArray:(NSMutableArray*)dataArray andDelegate:(id<BusinessLayerDelegate>)delegate
{
    if(error == nil)
    {
        if([delegate respondsToSelector:@selector(didReceiveResponseOfApi:OnSuccess:)])
            [delegate didReceiveResponseOfApi:api OnSuccess:dataArray];
    }
    else
    {
        if([delegate respondsToSelector:@selector(didReceiveResponseOfApi:OnFailure:)])
            [delegate didReceiveResponseOfApi:api OnFailure:error];
    }
}

-(NSDictionary*)validate:(NSDictionary*)response error:(NSError**)error
{
    NSDictionary *responseDict = [response valueForKey:@"Response"];
    NSString* message = [responseDict objectForKey:@"Message"];
    int code = [[responseDict objectForKey:@"Code"] intValue];
    
//    if (code <= 200)
    if (code == 0)
    {
        return  responseDict;
    }
    else
    {
        NSError *err = [NSError errorWithDomain:@"Plus1D" code:code userInfo:[NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey]];
        
        if (error) *error = err;
        
    }
    
    return nil;
}


#pragma mark - Signup API
-(void)fetchAppDataWithDelegate:(id<BusinessLayerDelegate>)delegate showHUD:(BOOL)showHud
{
    NSString *url = [NSString stringWithFormat:@"%@details", BASE_URL];

    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];

    [params setObject:[NSNumber numberWithInt:5] forKey:@"id"];
    [params setObject:AUTH_TOKEN forKey:@"auth_token"];

    [[NetworkLayer sharedNetworkLayer] postRequestWithURL:url params:params showHUD:showHud
     success:^(id response)
    {
        NSError *error;

        NSMutableArray *dataArray;
        dataArray = [NSMutableArray arrayWithObjects:response, nil];

        [self sendResponseOfApi:eApiFetchAppData withError:error andDataArray:dataArray andDelegate:delegate];
    }
    failure:^(NSError *error)
    {
        [self sendResponseOfApi:eApiFetchAppData withError:error andDataArray:nil andDelegate:delegate];
    }];
}


#pragma mark - SignIn API

-(void)signInWithParams:(NSDictionary *)params andDelegate:(id<BusinessLayerDelegate>)delegate showHUD:(BOOL)showHud
{
    NSString *url = [NSString stringWithFormat:@"%@Signin", BASE_URL];

    [[NetworkLayer sharedNetworkLayer] postRequestWithURL:url params:params showHUD:showHud
    success:^(id response)
     {
         
         NSError *error;
         NSDictionary *result = [self validate:response error:&error];
         
         NSMutableArray *dataArray;
         if(error == nil && result != nil)
         {
             NSDictionary *userInfoDic = [result valueForKeyPath:@"Data"];
             NSString* message = [result objectForKey:@"Message"];
             dataArray = [NSMutableArray arrayWithObjects:userInfoDic, message?message:NSLocalizedString(@"Success", nil), nil];
         }

         [self sendResponseOfApi:eApiSignIn withError:error andDataArray:dataArray andDelegate:delegate];
     }
     failure:^(NSError *error)
     {
         [self sendResponseOfApi:eApiSignIn withError:error andDataArray:nil andDelegate:delegate];
     }];
}
@end
