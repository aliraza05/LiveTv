

#import "Utilities.h"
#import "AppDelegate.h"

@implementation Utilities


+ (void) setRightImageWithPadding:(UIView*)view withImage:(NSString *)imageName
{
    if ([view isKindOfClass:[UITextField class]])
    {
        UIImageView *leftPadding           = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,5,20)];
        
        leftPadding.backgroundColor        = [UIColor clearColor];
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
        
        UIImageView *rightPadding          = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,15,15)];
        rightPadding.contentMode           = UIViewContentModeScaleAspectFit;
        
        rightPadding.image                 = [UIImage imageNamed:imageName];
        
        [rightView addSubview:rightPadding];
        
        rightView.userInteractionEnabled = false;
        
        leftPadding.contentMode            = UIViewContentModeScaleAspectFit;
        ((UITextField*)view).leftView      = leftPadding;
        ((UITextField*)view).rightView     = rightView;
        ((UITextField*)view).leftViewMode  = UITextFieldViewModeAlways;
        ((UITextField*)view).rightViewMode = UITextFieldViewModeUnlessEditing;
    }
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (NSString *)removeWhiteSpace:(NSString *)str
{
    NSArray* words = [str componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
    return [words componentsJoinedByString:@""];
}

//Get Height From Text
+ (CGFloat)getTextHeightFromString:(NSString *)text ViewWidth:(CGFloat)width WithPading:(CGFloat)pading FontName:(NSString *)fontName AndFontSize:(CGFloat)fontSize
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:fontName size:fontSize]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    NSLog(@"rect.size.height: %f", rect.size.height);
    return rect.size.height + pading;
}

+ (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+(BOOL)validateFirstAndLastNameCharsOnly: (NSString *) candidate
{
    NSString *nameRegex = @"[A-Za-z]{1,20}";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:candidate];
}
+ (BOOL) validateZipCode: (NSString *) candidate
{
    NSString *emailRegex = @"[0-9]{1,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}
+ (void)simpleOkAlertBox:(NSString*)title Body:(NSString*)body delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:body
                          delegate:delegate
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil];
    [alert show];
    alert = nil;
}



+ (void)alertWithText:(NSString *)alertTxt inViewController:(UIViewController *)viewController
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Alert"
                                 message:alertTxt
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                    
                                }];
    
    
    //Add your buttons to alert controller
    
    [alert addAction:yesButton];
    
    [viewController presentViewController:alert animated:YES completion:nil];
}


+(NSString*)findPlistPath:(NSString*)PlistName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",PlistName]]; //3
    return path;
}


+ (UIImage *)imageWithCustomColor:(UIColor *)color;
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(void)createPlist:(NSString *)plistName{
    
    NSError* error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * path =[Utilities findPlistPath:plistName];
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
}

+(void)writeIntoPlist:(NSMutableDictionary*)dataDict and:(NSString *)plistName{
    NSString * path =[Utilities findPlistPath:plistName];
    
    NSMutableDictionary *allKeys =[NSMutableDictionary new];
    [allKeys setObject:dataDict forKey:@"dataArray"];
    [allKeys writeToFile:path atomically:YES];
    
}

+(NSMutableDictionary*)readFromPlist:(NSMutableDictionary*)dataDict and:(NSString *)plistName
{
    // NSMutableArray *tempArray =[NSMutableArray arrayWithContentsOfFile:[UtilityClass findPlistPath:plistName]];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[Utilities findPlistPath:plistName]];
    return dictionary;
}

+(NSMutableDictionary *)setplist
{
    NSMutableDictionary *dictionary;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"signUp.plist"]; //3
    dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    return dictionary;
}

+(UIImage*)getImage:(NSString*)imageName
{
    NSString *mediaUrl =[[NSString alloc] init];
    NSData *imageData = [[NSData alloc] init];
    UIImage *imageFromImageData;
    
    //mediaUrl = [NSString stringWithFormat:@"%@%@",URLForImageDownload,imageName];
    
    //    [nImage setImageWithURL:[NSURL URLWithString:mediaUrl] placeholderImage:nil];
    
    if(nil != mediaUrl)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        @try
        {
            imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:mediaUrl]] ;
        }
        @catch (NSException * e)
        {
            
        }
        @finally
        {
            imageFromImageData = [[UIImage alloc] initWithData:imageData];
            if (imageFromImageData==nil)
            {
                return [UIImage imageNamed:@"no_avatar.png"];
            }
            else
            {
                return imageFromImageData;
            }
        }
    }
}

+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

+ (UIImage*)mergeImage:(UIImage*)first withImage:(UIImage*)second
{
    CGImageRef firstImageRef = first.CGImage;
    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
    CGFloat firstHeight = CGImageGetHeight(firstImageRef);
    
    CGImageRef secondImageRef = second.CGImage;
    CGFloat secondWidth = CGImageGetWidth(secondImageRef);
    CGFloat secondHeight = CGImageGetHeight(secondImageRef);
    
    CGSize mergedSize = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
    
    UIGraphicsBeginImageContext(mergedSize);
    
    [first drawInRect:CGRectMake(0, 0, firstWidth, firstHeight)];
    [second drawInRect:CGRectMake(0, 0, secondWidth, secondHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(BOOL)isTall
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        return YES;
    }
    return NO;
}

+(NSString *)getDeviceType
{
    NSString *deviceType = [UIDevice currentDevice].systemName;
    return deviceType;
}

+(NSString *)getDeviceVersion
{
    NSString *deviceVersion = [UIDevice currentDevice].systemVersion;
    return deviceVersion;
    //if ((![UIApplication sharedApplication].statusBarHidden && (int)[[UIScreen mainScreen] applicationFrame].size.height == 548) || ([UIApplication sharedApplication].statusBarHidden && (int)[[UIScreen mainScreen] applicationFrame].size.height == 568))
}
+ (UIImage*) imageCorrectedForCaptureOrientation:(UIImage*)anImage
{
    float rotation_radians = 0;
    bool perpendicular = false;
    
    switch ([anImage imageOrientation]) {
        case UIImageOrientationUp:
            rotation_radians = 0.0;
            break;
        case UIImageOrientationDown:
            rotation_radians = M_PI;
            break;
        case UIImageOrientationRight:
            rotation_radians = M_PI_2;
            perpendicular = true;
            break;
        case UIImageOrientationLeft:
            rotation_radians = -M_PI_2;
            perpendicular = true;
            break;
        default:
            break;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(anImage.size.width, anImage.size.height));
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, anImage.size.width/2, anImage.size.height/2);
    CGContextRotateCTM(context, rotation_radians);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    float width = perpendicular ? anImage.size.height : anImage.size.width;
    float height = perpendicular ? anImage.size.width : anImage.size.height;
    CGContextDrawImage(context, CGRectMake(-width / 2, -height / 2, width, height), [anImage CGImage]);
    
    if (perpendicular) {
        CGContextTranslateCTM(context, -anImage.size.height/2, -anImage.size.width/2);
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //newImage = [self resizeImage:newImage newSize: CGSizeMake(320.0,560.0)];
    
    return newImage;
}
+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize
{
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
//    NSLog(@"newSize Height %f", newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    CGContextDrawImage(context, newRect, imageRef);
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)applySepiaFilterToImage:(UIImage *)image {
    
    CIImage *inputImage = [CIImage imageWithData:UIImageJPEGRepresentation(image,0.6f)];
    UIImage *sepiaImage = nil;
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, inputImage, @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef outputImageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    sepiaImage = [UIImage imageWithCGImage:outputImageRef];
    CGImageRelease(outputImageRef);
    return sepiaImage;
}
+ (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

+ (NSString *)encodeString:(NSString *)string
{
    NSString *newString = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL,CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return newString;
}
/*
+ (void)clearTmpDirectory
{
    NSArray* tmpDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
    for (NSString *file in tmpDirectory) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), file] error:NULL];
    }
}*/

+ (void)clearTmpDirectory
{
    NSArray* tmpDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
    for (NSString *file in tmpDirectory) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), file] error:NULL];
    }
}

#pragma mark Reset View
+(void)resetView:(float)yOrigin myView:(UIView*)myView
{
    CGRect viewFrame = myView.frame;
    if (yOrigin==0 && viewFrame.origin.y!=0)
    {
        viewFrame.origin.y=yOrigin;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [myView setFrame:viewFrame];
        [UIView commitAnimations];
    }
    else if(yOrigin>0 ||yOrigin<0)
    {
        viewFrame.origin.y=yOrigin;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [myView setFrame:viewFrame];
        [UIView commitAnimations];
    }
    
    
}

#pragma mark - Rotation

+ (UIImage *)imageRotatedByDegrees:(UIImage*)oldImage deg:(CGFloat)degrees{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,oldImage.size.width, oldImage.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degrees * -M_PI / 180);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, (degrees * -M_PI / 180));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-oldImage.size.width / 2, -oldImage.size.height / 2, oldImage.size.width, oldImage.size.height), [oldImage CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

#pragma mark - Font Size
+ (UIFont*)minimumFontSize:(NSString*)txtString FontType:(UIFont *)font WithMaxFontSize:(CGFloat)maxFont WithMinFontSize:(int)minFont AndMaxWidthOfView:(CGFloat)width
{
    UIFont *afont = [font fontWithSize:maxFont];
    
    int i;
    /* Time to calculate the needed font size.
     This for loop starts at the largest font size, and decreases by two point sizes (i=i-2)
     Until it either hits a size that will fit or hits the minimum size we want to allow (i > 10) */
    for(i = maxFont; i > minFont; i=i-1)
    {
        // Set the new font size.
        afont = [afont fontWithSize:i];
        // You can log the size you're trying: NSLog(@"Trying size: %u", i);
        
        // This step checks how tall the label would be with the desired font.
        //CGSize labelSize = [txtString sizeWithFont:font constrainedToSize:constraintSize];
        
        NSDictionary *attributes = @{NSFontAttributeName:afont};
        CGRect rect = [txtString boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                           options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:attributes
                                                           context:nil];
        
        /* Here is where you use the height requirement!
         Set the value in the if statement to the height of your UILabel
         If the label fits into your required height, it will break the loop
         and use that font size. */
        if(rect.size.height <= 35.0f)
            break;
    }
    // You can see what size the function is using by outputting: NSLog(@"Best size is: %u", i);
    // Set the UILabel's font to the newly adjusted font.
    return afont;
}

#pragma mark - TableView Specific Row Update
+  (void)updateTable:(UITableView*)tableView Row:(NSInteger)tblRow andSection:(NSInteger)tblSecton{
    
    [tableView beginUpdates];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:tblRow inSection:tblSecton]] withRowAnimation:UITableViewRowAnimationNone];
    [tableView endUpdates];
}

+(UITableViewCell *)parentCellForView:(id)theView
{
    id viewSuperView = [theView superview];
    while (viewSuperView != nil) {
        if ([viewSuperView isKindOfClass:[UITableViewCell class]]) {
            return (UITableViewCell *)viewSuperView;
        }
        else {
            viewSuperView = [viewSuperView superview];
        }
    }
    return nil;
}

#pragma mark - Amount Format
+ (NSString*)amountFormat:(float)value{
    
    NSNumberFormatter * formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMinimumFractionDigits:2];
    [formatter setMaximumFractionDigits:2]; // Set this if you need 2 digits
    NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:value]];
    
    if ([newString isEqualToString:@"0"])   newString = @"0.00";
    
    return newString;
}

- (void) rejectMatch:(NSUInteger)matchID forTurn:(NSUInteger)turnNumber{
    
    //    {"MatchId":184,"TurnNumber":2}
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithInteger:matchID], @"MatchId",
                            [NSNumber numberWithInteger:turnNumber], @"TurnNumber",
                            nil];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    
    NSLog(@"iReject Json String :  %@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    BOOL isTurnableToJSON = [NSJSONSerialization
                             isValidJSONObject:params];
    NSLog(@"Json Valid : %@", isTurnableToJSON ? @"Yes" : @"No");
    
//    [[APIRequestManager instance] PutAPICall:iRejectTurn CallBack:@"N_RejectMatchTurn" Caller:self.view];
}

+ (NSString *)getUniquePin
{
    NSString *getSalt = [[NSProcessInfo processInfo] globallyUniqueString];
    NSArray *filterSalt = [getSalt componentsSeparatedByString:@"-"];
//    NSLog(@"unique string %@", getSalt);
    NSString *uniqueString =  [filterSalt objectAtIndex:3];
//    NSLog(@"unique pin %@", uniqueString);
    return uniqueString;
}

+ (NSString *) getUniqueProcessID{
    
    return [[NSProcessInfo processInfo] globallyUniqueString];
}

+ (void) resetBatchCount:(NSString*)APIName{
    /*
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:devURL]];
    //-- the content of the POST request is passed in as an NSDictionary
    //-- in this example, there are two keys with an object each
    
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient setDefaultHeader:@"Authorization" value:@"Basic c2Rzb2w6c2Rzb2w5OQ=="];
    [httpClient setDefaultCredential:[NSURLCredential     credentialWithUser:BUserName
                                                                password:BPassword
                                                             persistence:NSURLCredentialPersistenceForSession]];
    
    [httpClient putPath:APIName parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Request Successful, response '%@'", responseStr);
//        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }];
     */
}

+ (BOOL)saveDataInDocumentsFolder:(NSData *)fdata withFileName:(NSString *)fname
{
    NSString *dataSavingPath = [NSString stringWithFormat:@"%@/%@",strDocumentPath,fname];
    NSLog(@"saveDataInDocumentsFolder: %@",dataSavingPath);
    BOOL isSaved = NO;
    if (![self fileExistAtPath:dataSavingPath])
    {
        isSaved = [fdata writeToFile:dataSavingPath atomically:YES];
    }
    return isSaved;
}

+ (BOOL) fileExistAtPath:(NSString*) path{
	NSFileManager* NSFm=[NSFileManager defaultManager];
	BOOL isDir = NO;
    if ([NSFm fileExistsAtPath:path])
    {
        isDir = YES;
    }
    return isDir;
}

+ (NSData *)getDataFromDocumentFolder:(NSString *)fileName
{
    NSString *dataSavingPath = [NSString stringWithFormat:@"%@/%@",strDocumentPath,fileName];
    NSData * fileData = [NSData dataWithContentsOfFile:dataSavingPath];
    return fileData;
}

#pragma mark - Set
+ (void) setViewContentFont:(UIView*)aView withFont:(UIFont*)aFont ofClass:(Class)classKind{
    
    for (UIView *view in [aView subviews])
        if ([view isKindOfClass:[UITextField class]] && [classKind isEqual:[UITextField class]])
            [((UITextField*)view) setFont:aFont];
    
        else if ([view isKindOfClass:[UITextView class]] && [classKind isEqual:[UITextView class]])
            [((UITextView*)view) setFont:aFont];
    
        else if ([view isKindOfClass:[UIButton class]] && [classKind isEqual:[UIButton class]])
            [((UIButton*)view).titleLabel setFont:aFont];
    
        else if ([view isKindOfClass:[UILabel class]] && [classKind isEqual:[UILabel class]])
            [((UILabel*)view) setFont:aFont];
}
+ (void) setViewContentFont:(UIView*)aView withFont:(UIFont*)aFont{
    
    for (UIView *view in [aView subviews])
        if ([view isKindOfClass:[UITextField class]])
            [((UITextField*)view) setFont:aFont];
    
        else if ([view isKindOfClass:[UITextView class]])
            [((UITextView*)view) setFont:aFont];
    
        else if ([view isKindOfClass:[UIButton class]])
            [((UIButton*)view).titleLabel setFont:aFont];
    
        else if ([view isKindOfClass:[UILabel class]])
            [((UILabel*)view) setFont:aFont];
}

+ (void) setLeftPadding:(UIView*)aView textColor:(UIColor*)textColor placeHolderTextColor:(UIColor*)placeHolderTextColor andFont:(UIFont*)aFont{
    
    for (UIView *view in [aView subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            
            UILabel *leftPadding = [[UILabel alloc]initWithFrame:CGRectZero];
            leftPadding.text = @"  ";
            [leftPadding sizeToFit];
            leftPadding.backgroundColor = [UIColor clearColor];
            
            ((UITextField*)view).font = aFont;
            ((UITextField*)view).textColor = textColor;
            [((UITextField*)view) setValue:placeHolderTextColor forKeyPath:@"_placeholderLabel.textColor"];
            ((UITextField*)view).leftView = leftPadding;
            ((UITextField*)view).leftViewMode = UITextFieldViewModeAlways;
        }
    }
}

+ (void) setLeftPadding:(UIView*)aView
{
    for (UIView *view in [aView subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            
            UILabel *leftPadding = [[UILabel alloc]initWithFrame:CGRectZero];
            leftPadding.text = @"  ";
            [leftPadding sizeToFit];
            leftPadding.backgroundColor = [UIColor clearColor];
            
            ((UITextField*)view).leftView = leftPadding;
            ((UITextField*)view).leftViewMode = UITextFieldViewModeAlways;
        }
    }
}


+ (void) setLeftRightPadding:(UIView*)aView
{
    for (UIView *view in [aView subviews])
    {
        if ([view isKindOfClass:[UITextField class]])
        {
            UIImageView *leftPadding           = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,5,20)];
            
            leftPadding.backgroundColor        = [UIColor clearColor];
            
            UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
            rightView.backgroundColor          = [UIColor clearColor];
            
            leftPadding.contentMode            = UIViewContentModeScaleAspectFit;
            
            ((UITextField*)view).leftView      = leftPadding;
            ((UITextField*)view).rightView     = rightView;
            ((UITextField*)view).leftViewMode  = UITextFieldViewModeAlways;
            ((UITextField*)view).rightViewMode = UITextFieldViewModeUnlessEditing;
        }
        
    }
}


+ (void) setColorForView:(UIView*)aView Color:(UIColor *)aColor
{
    for (UIView *view in [aView subviews])
    {
        if ([view isKindOfClass:[UILabel class]])
        {
            ((UILabel *)view).textColor = aColor;
        }
    }
}


+ (void) setColorForView:(UIView*)aView Color:(UIColor *)aColor WithTag:(int)tag
{
    for (UIView *view in [aView subviews])
    {
        for (UIView *view in [aView subviews])
            if ([view isKindOfClass:[UITextField class]] && view.tag == tag)
                [((UITextField*)view) setBackgroundColor:aColor];
        
            else if ([view isKindOfClass:[UITextView class]] && view.tag == tag)
                [((UITextView*)view) setBackgroundColor:aColor];
        
            else if ([view isKindOfClass:[UIButton class]] && view.tag == tag)
                [((UIButton*)view).titleLabel setBackgroundColor:aColor];
        
            else if ([view isKindOfClass:[UILabel class]] && view.tag == tag)
                [((UILabel*)view) setBackgroundColor:aColor];
        
            else if ([view isKindOfClass:[UIImageView class]] && view.tag == tag)
                [((UIImageView *)view) setBackgroundColor:aColor];
    }
}


+(BOOL)isValidPinCode:(NSString *)password{
    NSString *filter = @"^[0-9]{4,4}";
    NSPredicate *evaluator = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", filter];
    return [evaluator evaluateWithObject:password];
}

+(NSString*) removeWhiteSpaceFromLeft:(NSString*)checkString{
    
    NSString *myString = checkString;
    NSRange range = [myString rangeOfString:@"^\\s*" options:NSRegularExpressionSearch];
    myString = [myString stringByReplacingCharactersInRange:range withString:@""];
    
    return myString;
}

#pragma mark - Reset
+ (void) resetDictionary:(NSDictionary*)dict{
    
    for (NSString* key in [dict allKeys])
        [dict setValue:@"" forKey:key];
}

+ (void) resignViewFields:(UIView*)aView{
    
    for (UIView *view in [aView subviews])
        if ([view isKindOfClass:[UITextField class]])
            [((UITextField*)view) resignFirstResponder];
        else if ([view isKindOfClass:[UITextView class]])
            [((UITextView*)view) resignFirstResponder];
}

+ (void) clearViewFields:(UIView*)aView{
    
    for (UIView *view in [aView subviews])
        if ([view isKindOfClass:[UITextField class]])
            [((UITextField*)view) setText:@""];
        else if ([view isKindOfClass:[UITextView class]])
            [((UITextView*)view) setText:@""];
}

#pragma mark - AlertView Like Animation
+ (void)animateIn:(UIView*)aView
{
    aView.hidden = NO;
	// UIAlertView-like pop in animation
	aView.transform = CGAffineTransformMakeScale(0.6, 0.6);
	[UIView animateWithDuration:0.2 animations:^{
		aView.transform = CGAffineTransformMakeScale(1.1, 1.1);
	} completion:^(BOOL finished){
		[UIView animateWithDuration:1.0/15.0 animations:^{
			aView.transform = CGAffineTransformMakeScale(0.9, 0.9);
		} completion:^(BOOL finished){
			[UIView animateWithDuration:1.0/7.5 animations:^{
				aView.transform = CGAffineTransformIdentity;
			}];
		}];
	}];
}

+ (void)animateOut:(UIView*)aView
{
	[UIView animateWithDuration:1.0/7.5 animations:^{
		aView.transform = CGAffineTransformMakeScale(0.9, 0.9);
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:1.0/15.0 animations:^{
			aView.transform = CGAffineTransformMakeScale(1.1, 1.1);
		} completion:^(BOOL finished) {
			[UIView animateWithDuration:0.3 animations:^{
				aView.transform = CGAffineTransformMakeScale(0.01, 0.01);
			} completion:^(BOOL finished){
				
                aView.hidden = YES;

			}];
		}];
	}];
}

#pragma mark - Date Formater
+ (NSString*) dateFormatedYearMonthDay:(NSDate*)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    NSLog(@"formattedDateString: %@", formattedDateString);
    
    return formattedDateString;
}

+ (NSString*) dateFormatedMonthDayYear:(NSDate*)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyy"];//11/28/2013
    
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    NSLog(@"formattedDateString: %@", formattedDateString);
    
    return formattedDateString;
}

+(NSDate*)dateFromString:(NSString*)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //2013-12-21 19:00:00
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

+(NSString*)stringFromDate:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //2013-12-21 19:00:00
    NSString * dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


+(NSString*)stringFromDateWithMilliSeconds:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"]; //2013-12-21 19:00:00
    NSString * dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


+(NSString *)encodeToBase64StringImageAtPath:(NSString *)imagePath {
    UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+(UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}


+ (NSString *)timeBetweenDatesInMinutes:(NSDate *)startDate EndDate:(NSDate *)endDate
{
    NSTimeInterval distanceBetweenDates = [endDate timeIntervalSinceDate:startDate];
    NSInteger time = distanceBetweenDates;
    NSInteger minutes = (time / 60);
    return [NSString stringWithFormat:@"%ld", (long)minutes];
}

+ (BOOL)validationOfTimeBetweenDatesInMinutes:(NSDate *)startDate EndDate:(NSDate *)endDate
{
    NSTimeInterval distanceBetweenDates = [endDate timeIntervalSinceDate:startDate];
    NSInteger time = distanceBetweenDates;
    NSInteger minutes = (time / 60);
    BOOL valid = NO;
    if (minutes >= 0)
    {
        valid = YES;
    }
    else
    {
        valid = NO;
    }
    return valid;
}

+ (BOOL)validationOfTimeBetweenDatesInMinutesWithoutSameTime:(NSDate *)startDate EndDate:(NSDate *)endDate
{
    NSTimeInterval distanceBetweenDates = [endDate timeIntervalSinceDate:startDate];
    NSInteger time = distanceBetweenDates;
    NSInteger minutes = (time / 60);
    BOOL valid = NO;
    if (minutes > 0)
    {
        valid = YES;
    }
    else
    {
        valid = NO;
    }
    return valid;
}


//+ (NSArray *) sortManagedObjectArrayByObjectID:(NSArray *) array {
//    
//    NSArray *compareResult = [array sortedArrayUsingComparator:^NSComparisonResult(NSManagedObject *obj1, NSManagedObject *obj2) {
//        
//        NSString *s = [obj1.objectID.URIRepresentation lastPathComponent];
//        NSString *r = [obj2.objectID.URIRepresentation lastPathComponent];
//        return [s compare:r];
//        
//    }];
//    
//    return compareResult;
//    
//}

+ (BOOL)validateIntegerValue:(NSString *)candidate
{
    NSString *Regex = @"^[+-]{0,1}[0-9]+$";
    NSPredicate *intTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [intTest evaluateWithObject:candidate];
}
+(long)getUniqueNumber;
{
   return (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
}

+(void)setViewMovedUp:(BOOL)movedUp WithView:(UIView *)aView
{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
//        
//    CGRect rect = aView.frame;
//    if (movedUp)
//    {
//        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
//        // 2. increase the size of the view so that the area behind the keyboard is covered up.
//        NSLog(@"rect.origin.y: %f",rect.origin.y);
//        rect.origin.y = -kOFFSET_FOR_KEYBOARD;
//    }
//    else
//    {
//        // revert back to the normal state.
//        rect.origin.y = 0;
//    }
//    aView.frame = rect;
//    
//    [UIView commitAnimations];
}

/*
 #pragma mark - Textfield Delegate
 - (BOOL)textFieldShouldReturn:(UITextField *)textField
 {
 [textField resignFirstResponder];
 
 return YES;
 }
 
 - (void)textFieldDidBeginEditing:(UITextField *)textField
 {
 if (textField.tag > 100)    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y/2 + textField.frame.origin.y - 5) animated:YES];
 else
 [self.scrollView setContentOffset:CGPointZero animated:YES];
 }
 
 - (void)textFieldDidEndEditing:(UITextField *)textField
 {
 
 if (textField.tag > 100)    [self.scrollView setContentOffset:CGPointZero animated:YES];
 }
 */



+ (void) higlight:(UIView*)aView
{
    
    //    aView.layer.cornerRadius=8.0f;
    aView = (UITextField *)aView;
    aView.layer.masksToBounds=YES;
    aView.layer.borderColor=[[UIColor redColor] CGColor];
    aView.layer.borderWidth= 1.0f;
}

+(void) unhighlight:(UIView*)aView
{
    aView = (UITextField *)aView;
    aView.layer.borderColor=[[UIColor clearColor] CGColor];
}


+ (void)showHUD {
    [self hideHUD];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.label.text = @"Loading";
    
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window addSubview:hud];
    [window bringSubviewToFront:hud];
    [MBProgressHUD showHUDAddedTo:window animated:YES];
}

+ (void)hideHUD {
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    for (UIView *view in window.subviews)
    {
        if ([view isKindOfClass:[MBProgressHUD class]])
        {
            [view removeFromSuperview];
        }
    }
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
}


#pragma mark - Pequeno Gourmet Helper Methods
+ (NSString *)getImageNameForGame5:(NSString *)name WithIndex:(int)index
{
    NSString * finalName = @"";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        finalName = [NSString stringWithFormat:@"%@_%d_ipad",name,index];
    }
    else
    {
        finalName = [NSString stringWithFormat:@"%@_%d",name,index];
    }
    
    return finalName;
}


+ (NSString *)getSmallImageNameForGame5:(NSString *)name
{
    NSString * finalName = @"";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        finalName = [NSString stringWithFormat:@"%@_ipad",name];
    }
    else
    {
        finalName = [NSString stringWithFormat:@"%@",name];
    }
    
    return finalName;
}


+ (NSString *)getImageNameForGame1:(NSString *)name
{
    NSString * finalName = @"";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        finalName = [NSString stringWithFormat:@"%@_ipadpro",name];
    }
    else
    {
        finalName = [NSString stringWithFormat:@"%@",name];
    }
    
    return finalName;
}


+ (NSString *)getImageNameForGame1ForSelectedState:(NSString *)name
{
    NSString * finalName = @"";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        finalName = [NSString stringWithFormat:@"%@_ipadpro",name];
    }
    else
    {
        finalName = [NSString stringWithFormat:@"%@",name];
    }

    return finalName;
}

+ (CGRect)getRectFromString:(NSString *)str
{
    NSArray * array_rect_str = [str componentsSeparatedByString:@","];
    CGRect rect = CGRectZero;
    if (array_rect_str.count > 3)
    {
        NSString * x_str = [array_rect_str objectAtIndex:0];
        NSString * y_str = [array_rect_str objectAtIndex:1];
        NSString * w_str = [array_rect_str objectAtIndex:2];
        NSString * h_str = [array_rect_str objectAtIndex:3];
        rect = CGRectMake(x_str.intValue, y_str.intValue, w_str.intValue, h_str.intValue);
    }
    
    return rect;
}

//Convert 1234 to one two three four
+ (NSString *)fromNumberToDigitsNames:(NSString *)str
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterSpellOutStyle];
    
    NSString * characters = @"";
    for (int i=0; i < [str length]; i++)
    {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [str characterAtIndex:i]];
        NSString *s = [f stringFromNumber:[NSNumber numberWithInt:ichar.intValue]];

        if (characters.length > 0)
        {
            characters = [NSString stringWithFormat:@"%@ %@",characters,s];
        }
        else
        {
            characters = s;
        }
    }
    
    return characters;
}


//Covert Points for Larger screens like iPhone 6 and 6 Plus
+ (CGPoint)getPointForResizedScreenWithPoint:(CGPoint)point
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGPoint origin = CGPointMake(point.x * scale, point.y * scale);
    return origin;
}

+ (NSDate *)getLocalDateFromUTCString:(NSString *)utcTime
{
    NSDateFormatter *utcFormatter = [[NSDateFormatter alloc] init];
    [utcFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [utcFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [utcFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *localDate = [utcFormatter dateFromString:utcTime];
    
    return localDate;
}
+ (NSDate *)getEsternDateFromUTCString:(NSString *)utcTime
{
    NSDateFormatter *utcFormatter = [[NSDateFormatter alloc] init];
//    [utcFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [utcFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];

    [utcFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [utcFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *localDate = [utcFormatter dateFromString:utcTime];
    
    return localDate;
}

+(NSString*)getLocalDateStringFromUTCDateString:(NSString*)utcDateString
{
    NSDateFormatter *utcFormatter = [[NSDateFormatter alloc] init];
    [utcFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [utcFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [utcFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *localDate = [utcFormatter dateFromString:utcDateString];
    
    NSDateFormatter *localFormatter = [[NSDateFormatter alloc] init];
    [localFormatter setDateFormat:@"MMM d, yyyy h:mm a"];
    NSString * dateString = [localFormatter stringFromDate:localDate];
    return dateString;
}

+(NSString*)getEsternDateStringFromUTCDateString:(NSString*)utcDateString
{
    NSDateFormatter *utcFormatter = [[NSDateFormatter alloc] init];
    [utcFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [utcFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [utcFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *localDate = [utcFormatter dateFromString:utcDateString];
    
    NSDateFormatter *localFormatter = [[NSDateFormatter alloc] init];
    [localFormatter setDateFormat:@"MMM d, yyyy h:mm a"];
    [localFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
    [utcFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];

    NSString * dateString = [NSString stringWithFormat:@"%@ ET",[localFormatter stringFromDate:localDate]];
    return dateString;
}

@end
