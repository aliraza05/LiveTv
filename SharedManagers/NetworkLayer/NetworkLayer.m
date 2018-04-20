//
//  NetworkLayer.m
//  Copyright (c) 2013 SDSol. All rights reserved.
//

#import "NetworkLayer.h"




@implementation NetworkLayer


+ (NetworkLayer *)sharedNetworkLayer
{
    NSString *urlStr = BASE_URL;
    
    static dispatch_once_t pred;
    static NetworkLayer *_sharedNetworkLayer = nil;
    dispatch_once(&pred, ^{ _sharedNetworkLayer = [[self alloc] initWithBaseURL:[NSURL URLWithString:urlStr]]; });
    return _sharedNetworkLayer;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
     self.requestSerializer = [AFJSONRequestSerializer serializer];
//    [self.requestSerializer setAuthorizationHeaderFieldWithUsername:kUserName password:kPassword];
   
    return self;
}

-(void)postRequestWithURL:(NSString*)urlString
                  params:(NSDictionary*)params
                  showHUD:(BOOL)showHud
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError *error))failure
{

    if (![self connected])
    {
       failure([self getNetworkError]);
    }
    else
    {
        if(showHud) [APP_DELEGATE.window showHUDWithText:@"Loading..."];
        

        NSError *error;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                           options:NSJSONWritingPrettyPrinted error:&error];
        
        NSLog(@"JSon :  %@",[[NSString alloc] initWithData:jsonData
                                                  encoding:NSUTF8StringEncoding]);

        [self POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSLog(@"API:%@\n Response: %@",urlString, responseObject);
            
            success(responseObject);
            
            if(showHud) [APP_DELEGATE.window removeHUD];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if(showHud) [APP_DELEGATE.window removeHUD];
            failure(error);
            
        }];
    
    }
}


-(void)putRequestWithURL:(NSString*)urlString
                 params:(NSDictionary*)params
                 showHUD:(BOOL)showHud
                 success:(void (^)(id response))success
                 failure:(void (^)(NSError *error))failure
{
    if (![self connected])
    {
        failure([self getNetworkError]);
    }
    else
    {
        if(showHud) [APP_DELEGATE.window showHUDWithText:@"Loading..."];
        
        NSError *error;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                           options:NSJSONWritingPrettyPrinted error:&error];
        
        NSLog(@"JSon :  %@",[[NSString alloc] initWithData:jsonData
                                                   encoding:NSUTF8StringEncoding]);

       
        [self PUT:urlString parameters:params success:^(NSURLSessionTask *operation, id responseObject) {
            
            NSLog(@"API:%@\n Response: %@",urlString, responseObject);
            
            success(responseObject);
            
            if(showHud) [APP_DELEGATE.window removeHUD];
            
        }
        failure:^(NSURLSessionTask *operation, NSError *error)
        {
            if(showHud) [APP_DELEGATE.window removeHUD];
            failure(error);
        }];
    }
}


-(void)getRequestWithURL:(NSString*)urlString
                 params:(NSDictionary*)params
                 showHUD:(BOOL)showHud
                 success:(void (^)(id response))success
                 failure:(void (^)(NSError *error))failure
{
    if (![self connected])
    {
        failure([self getNetworkError]);
    }
    else
    {
        if(showHud) [APP_DELEGATE.window showHUDWithText:@"Loading..."];
        
        [self GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"API:%@\n Response: %@",urlString, responseObject);
            
            success(responseObject);
            
            if(showHud) [APP_DELEGATE.window removeHUD];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if(showHud) [APP_DELEGATE.window removeHUD];
            failure(error);
            
        }];

    }
}
-(void)deleteRequestWithURL:(NSString*)urlString
                     params:(NSDictionary*)params
                    showHUD:(BOOL)showHud
                    success:(void (^)(id response))success
                    failure:(void (^)(NSError *error))failur
{
    if (![self connected])
    {
        failur([self getNetworkError]);
    }
    else
    {
        if(showHud) [APP_DELEGATE.window showHUDWithText:@"Loading..."];
        
        [self DELETE:urlString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"API:%@\n Response: %@",urlString, responseObject);
            
            success(responseObject);
            
            if(showHud) [APP_DELEGATE.window removeHUD];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(showHud) [APP_DELEGATE.window removeHUD];
            failur(error);
        }];
    }
}


-(void)multiPartFormDataRequestWithURL:(NSString*)urlString
                                params:(NSDictionary*)params
                                 profileImage:(UIImage *)image
                               showHUD:(BOOL)showHud
                               success:(void (^)(id response))success
                               failure:(void (^)(NSError *error))failure
{
    if (![self connected])
    {
        failure([self getNetworkError]);
    }
    else
    {
        if(showHud) [APP_DELEGATE.window showProgressHUD];
        
        
        NSString *method = @"POST";
        
        NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:method URLString:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSError *error;

            NSData *iamgeData = UIImageJPEGRepresentation(image, 1.0);
            [formData appendPartWithFileData:iamgeData name:@"Image" fileName:@"Image.png" mimeType:@"image/png"];
            
            if (error)
            {
                failure(error);
                if(showHud) [APP_DELEGATE.window removeHUD];
            }
            
        } error:nil];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request
                                              
        progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"uploading progress ===== %f",uploadProgress.fractionCompleted);
            if(showHud) APP_DELEGATE.window.mbroundProgress.progress = (float)uploadProgress.fractionCompleted;
        });
                                                                               
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                                               
        if(showHud) [APP_DELEGATE.window removeHUD];
                                                                               
        if (error) {
                                                                                   
            failure(error);
        }
        else
        {
            NSLog(@"API:%@\n Response: %@",urlString, responseObject);
            success( responseObject);
        }
        }];
        
        [uploadTask resume];
    }
}



-(NSError*)getNetworkError
{
    NSError *error = [NSError errorWithDomain:@"Plus1D" code:345 userInfo:[NSDictionary dictionaryWithObject:NSLocalizedString(@"Internet is not reachable please check your connection.", nil)  forKey:NSLocalizedDescriptionKey]];
    
    return error;
}

-(BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

@end
