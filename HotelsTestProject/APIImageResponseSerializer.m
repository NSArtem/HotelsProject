//
// Created by Artem Abramov on 17/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import "APIImageResponseSerializer.h"
@import UIKit;

@implementation APIImageResponseSerializer

/*
 * Crop image by 1px
 */
- (nullable id)responseObjectForResponse:(nullable NSURLResponse *)response data:(nullable NSData *)data error:(NSError *__nullable __autoreleasing *)error {
    id responseObject = [super responseObjectForResponse:response data:data error:error];
    if (*error == nil &&responseObject != nil && [responseObject isKindOfClass:[UIImage class]]) {
        UIImage *image = (UIImage *)responseObject;
        CGRect rect = {0, 0, image.size.width * image.scale, image.size.height * image.scale};
        rect = CGRectInset(rect, 1, 1);
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
        UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
        CGImageRelease(imageRef);
        return croppedImage;
    }
    return responseObject;
}

@end