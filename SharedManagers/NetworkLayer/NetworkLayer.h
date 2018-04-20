//
//  NetworkLayer.h

//  Copyright (c) 2013 SDSol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"



#define BASE_URL @"https://live-sports-tv.herokuapp.com/api/applications/"


//********** Basic authentication Live
//#define BASE_URL @""
//#define kUserName @"admin"
//#define kPassword @"admin"

@protocol NetworkLayerDelegate<NSObject>

-(void) fromNL_getZipCodeFromPlaceIdInNetwork:(id)destinationObject response:(NSDictionary *)responseDict withError:(NSError *)error;

@end

@interface NetworkLayer : AFHTTPSessionManager

@property (nonatomic, assign) id <NetworkLayerDelegate> networkLayerDelegate;

+ (NetworkLayer *)sharedNetworkLayer;

-(instancetype)init __attribute__((unavailable("Please use + (NetworkLayer *)sharedNetworkLayer instead")));



-(void)postRequestWithURL:(NSString*)urlString
                   params:(NSDictionary*)params
                  showHUD:(BOOL)showHud
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError *error))failure;

-(void)putRequestWithURL:(NSString*)urlString
                  params:(NSDictionary*)params
                 showHUD:(BOOL)showHud
                 success:(void (^)(id response))success
                 failure:(void (^)(NSError *error))failur;

-(void)getRequestWithURL:(NSString*)urlString
                  params:(NSDictionary*)params
                 showHUD:(BOOL)showHud
                 success:(void (^)(id response))success
                 failure:(void (^)(NSError *error))failure;

-(void)multiPartFormDataRequestWithURL:(NSString*)urlString
                                params:(NSDictionary*)params
                          profileImage:(UIImage *)image
                               showHUD:(BOOL)showHud
                               success:(void (^)(id response))success
                               failure:(void (^)(NSError *error))failure;

-(void)deleteRequestWithURL:(NSString*)urlString
                  params:(NSDictionary*)params
                 showHUD:(BOOL)showHud
                 success:(void (^)(id response))success
                 failure:(void (^)(NSError *error))failur;


@end
