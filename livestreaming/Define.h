//
//  GL_Define.h
//  GreatLocation
//
//  Created by Abdul Rehman on 22/05/2015.
//  Copyright (c) 2015 SDSol Technologies. All rights reserved.
//

#ifndef Define_h
#define Define_h

#import <objc/runtime.h>
#import <objc/message.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "UIColor+expanded.h"

#define activity_Indicator 1

#define ADD_BANNER_SCROLL_INTERVAL 3.0


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



#define APP_DELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


//com.yourguide.yourguide

// HTTP
//#define BASE_URL @"http://appserver.yourguide.today/Services/"


//#define BASE_URL @"http://staging2.sdsol.com/YourGuideServices/"

//#define BASE_URL @"http://192.168.1.56/YourGuideServices/"


//#define BASE_URL_IMAGES @"http://appserver.honkers-app.com/adminportal/images/"

#define NSLog if(1) NSLog

#define kToastViewDuration 2.0f
#define kDrawerSideWidth            230

#define DATE_TIME_FORMATER_FULL @"MM-dd-yyyy hh:mm a"


#define UserName @"admin"
#define Password @"admin"
#define DEVICE_TYPE     @"IOS"
#define kUserInfo       @"kUserInfo"
#define kContestFilters       @"ContestFilters"

#define kLastLoggedInUser   @"LastLoggedInUser"
#define iDeviceToken        @"DeviceId"

#define kDeviceToken @"DeviceToken"


#define strDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


#define signUpFB @"SignInWithFaceBook"
#define signUpGoogle @"SignInWithGooglePlus"
#define simpleSignUp @"SignUp"
#define simpleLogin @"SignIn"
#define updateProfile @"UpdateProfile"
#define ErrorMessage @"Check your internet connection and try again"

#define kUpdateNotificatoinBell @"kUpdateNotificatoinBell"

#define kgBrowseDealsWithoutFiler @"GetFilteredBusinessWithoutFiler"
#define kgGetOptionsBusiness @"GetOptionsBusiness"
#define kGetFeaturedBusiness @"GetFeaturedBusiness"
#define kGetBusinessWithLocation @"GetBusinessWithLocation"
#define kGetBusinessAlphabatically @"GetBusinessAlphabatically"
#define kGetBusinessWithSubCategories @"GetBusinessWithSubCategories"
#define kGetBusinessWithBoroughs @"GetBusinessWithBoroughs"

#define kgBrowswDeals @"GetBrowseDeals"
#define kgBusinessWithBoroughId @"GetBusinessByBoroughIdCategoryId"
#define kgBusinessWithNearMe    @"kgBusinessWithNearMe"
#define kgSearchBusiness @"SearchBusiness"
#define kgSearchBusinessWithText @"SearchBusinessWithText"

#define GLOpenTable @"openTable"
#define GLBookNow @"booknow"
#define GLPDFMenu @"pdfMenu"

#define glDiscoverAreas @"discover"
#define glDiscoverBorough @"SubDiscover"
#define glCategory @"location"
#define glBusinessList @"businessList"
#define glMyLocation @"myLocation"
#define glKeepLoginUserName @"loginUserName"
#define glKeepLoginUserPassword @"loginPassword"

#define KResetNotification @"ResetNotification"

#define KsetDealsDefault @"setDealsDefault"


#pragma mark - Color
#define kWhiteColor                 [UIColor whiteColor]
#define kBlackColor                 [UIColor blackColor]
#define kGrayColor                  [UIColor grayColor]
#define kRedColor                   [UIColor redColor]
#define kClearColor                 [UIColor clearColor]
#define kDarkGrayColor              [UIColor darkGrayColor]
#define klightGrayColor             [UIColor lightGrayColor]
#define iCustomColor(color)         [UIColor colorWithHexString:color]
#define kSetRGBColor(r, g, b, a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]


#endif
