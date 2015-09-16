//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

@import UIKit;
@import Foundation;

@interface LoadingViewController : UIViewController

@property(nonatomic, assign) BOOL isLoaded;

- (void)showLoadingIndicator:(BOOL)isLoading;
- (void)showErrorMessage:(BOOL)isShown message:(NSString *)message;

@end