

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import <UIKit/UIKit.h>

//#import <SDWebImage/UIImageView+WebCache.h>

@interface Utilities : NSObject

+ (void) setRightImageWithPadding:(UIView*)view withImage:(NSString *)imageName;

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (NSString *)removeWhiteSpace:(NSString *)str;

+(NSString*)getLocalDateStringFromUTCDateString:(NSString*)utcDateString;
+ (NSDate *)getLocalDateFromUTCString:(NSString *)utcTime;
+ (NSDate *)getEsternDateFromUTCString:(NSString *)utcTime;
+(NSString*)getEsternDateStringFromUTCDateString:(NSString*)utcDateString;

+ (CGFloat)getTextHeightFromString:(NSString *)text ViewWidth:(CGFloat)width WithPading:(CGFloat)pading FontName:(NSString *)fontName AndFontSize:(CGFloat)fontSize;

+ (BOOL)validateEmailWithString:(NSString*)email;

+ (BOOL)validateFirstAndLastNameCharsOnly: (NSString *) candidate ;

+ (BOOL) validateZipCode: (NSString *) candidate ;

+ (void)simpleOkAlertBox:(NSString*)title Body:(NSString*)body delegate:(id)delegate;

+ (void)alertWithText:(NSString *)alertTxt inViewController:(UIViewController *)viewController;

+ (void)createPlist:(NSString*)pListName;

+(NSString*)findPlistPath:(NSString*)PlistName;


+ (void)showHUD;
+ (void)hideHUD;


+ (void)writeIntoPlist:(NSMutableDictionary*)dataDict and:(NSString *)plistName;

+ (NSMutableDictionary*)readFromPlist:(NSMutableDictionary*)dataDict and:(NSString *)plistName;

+ (NSMutableDictionary *)setplist;

+(UIImage*)getImage:(NSString*)imageName;//Download image from a given URL

+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size ;

+ (UIImage*)mergeImage:(UIImage*)first withImage:(UIImage*)second;

+(BOOL)isTall;

+(NSString *)getDeviceVersion;

+(NSString *)getDeviceType;

+ (UIImage*) imageCorrectedForCaptureOrientation:(UIImage*)anImage;

//+ (UIImage *)resizeImage:(UIImage*)image;

+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize;

+ (UIImage *)applySepiaFilterToImage:(UIImage *)image;

+ (BOOL)connected;

+ (NSString *)encodeString:(NSString *)string;

+(void)resetView:(float)yOrigin myView:(UIView*)myView;

+ (UIImage *)imageRotatedByDegrees:(UIImage*)oldImage deg:(CGFloat)degrees;

+ (UIFont*)minimumFontSize:(NSString*)txtString FontType:(UIFont *)font WithMaxFontSize:(CGFloat)maxFont WithMinFontSize:(int)minFont AndMaxWidthOfView:(CGFloat)width;

+ (void)updateTable:(UITableView*)tableView Row:(NSInteger)tblRow andSection:(NSInteger)tblSecton;

+(UITableViewCell *)parentCellForView:(id)theView;

+ (NSString*)amountFormat:(float)value;

+ (NSString *)getUniquePin;
+ (NSString *) getUniqueProcessID;

+ (void)clearTmpDirectory;

+ (void) resetBatchCount:(NSString*)APIName;

+ (UIImage *)imageWithCustomColor:(UIColor *)color;

+ (BOOL)saveDataInDocumentsFolder:(NSData *)fdata withFileName:(NSString *)fname;
+ (NSData *)getDataFromDocumentFolder:(NSString *)fileName;

#pragma mark - Set
+ (void) setViewContentFont:(UIView*)aView withFont:(UIFont*)aFont ofClass:(Class)classKind;
+ (void) setViewContentFont:(UIView*)aView withFont:(UIFont*)aFont;
+ (void) setLeftPadding:(UIView*)aView textColor:(UIColor*)textColor placeHolderTextColor:(UIColor*)placeHolderTextColor andFont:(UIFont*)aFont;// This method will set LeftPadding for TextField
+ (void) setLeftPadding:(UIView*)aView;
+ (void) setLeftRightPadding:(UIView*)aView;
+ (void) setColorForView:(UIView*)aView Color:(UIColor *)aColor;
+ (void) setColorForView:(UIView*)aView Color:(UIColor *)aColor WithTag:(int)tag;

#pragma mark - Reset
+ (void) resetDictionary:(NSDictionary*)dict;
+ (void) resignViewFields:(UIView*)aView;// This methods will resign all textField/textView keyboard
+ (void) clearViewFields:(UIView*)aView;// This methods will clear all textField/textView

#pragma mark - AlertView Like Animation
+ (void)animateIn:(UIView*)aView;
+ (void)animateOut:(UIView*)aView;

#pragma mark - Date Formater
+ (NSString*) dateFormatedYearMonthDay:(NSDate*)date;
+ (NSString*) dateFormatedMonthDayYear:(NSDate*)date;
+(NSDate*)dateFromString:(NSString*)dateString;
+(NSString*)stringFromDate:(NSDate*)date;
+(NSString*)stringFromDateWithMilliSeconds:(NSDate*)date;

// Valid PIN with regex to allow user enter 4 nemeric values
+(BOOL)isValidPinCode:(NSString *)password;
+(NSString*) removeWhiteSpaceFromLeft:(NSString*)checkString;

#pragma mark - Encode image to base 64
+(NSString *)encodeToBase64StringImageAtPath:(NSString *)imagePath;
+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

#pragma mark - NSDate Methods
+ (NSString *)timeBetweenDatesInMinutes:(NSDate *)startDate EndDate:(NSDate *)endDate;
+ (BOOL)validationOfTimeBetweenDatesInMinutes:(NSDate *)startDate EndDate:(NSDate *)endDate;
+ (BOOL)validationOfTimeBetweenDatesInMinutesWithoutSameTime:(NSDate *)startDate EndDate:(NSDate *)endDate;

+ (NSArray *)sortManagedObjectArrayByObjectID:(NSArray *)array;

#pragma mark - Validation For Integer
+ (BOOL)validateIntegerValue:(NSString *)candidate;

#pragma mark - for get unique integerValue

+(long)getUniqueNumber;

+(void)setViewMovedUp:(BOOL)movedUp WithView:(UIView *)aView;


+ (void) higlight:(UIView*)aView;
+(void) unhighlight:(UIView*)aView;

#pragma mark - Pequeno Gourmet Helper Methods 

+ (NSString *)getImageNameForGame5:(NSString *)name WithIndex:(int)index;
+ (NSString *)getSmallImageNameForGame5:(NSString *)name;
+ (NSString *)getImageNameForGame1:(NSString *)name;
+ (NSString *)getImageNameForGame1ForSelectedState:(NSString *)name;
+ (CGRect)getRectFromString:(NSString *)str;
+ (NSString *)fromNumberToDigitsNames:(NSString *)str;
+ (CGPoint)getPointForResizedScreenWithPoint:(CGPoint)point;

#pragma mark - Music


@end
