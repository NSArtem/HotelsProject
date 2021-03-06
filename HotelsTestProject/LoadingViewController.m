//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController()

@property(nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic, weak) IBOutlet UIView *contentView;
@property(nonatomic, strong) UILabel *errorMessage;

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:activityIndicatorView];
    self.activityIndicatorView = activityIndicatorView;

    UILabel *errorMessage = [[UILabel alloc] init];
    errorMessage.textAlignment = NSTextAlignmentCenter;
    errorMessage.numberOfLines = 0;
    [self.view addSubview:errorMessage];
    self.errorMessage = errorMessage;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.activityIndicatorView.center = self.view.center;
    self.errorMessage.frame =  [self.errorMessage.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame) - 20.0f, CGFLOAT_MAX)
                                                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                                    attributes:@{NSFontAttributeName: self.errorMessage.font}
                                                                        context:nil];
    self.errorMessage.center = self.view.center;
}

- (void)showLoadingIndicator:(BOOL)isLoading
{
    self.contentView.hidden = isLoading;
    self.activityIndicatorView.hidden = !isLoading;
    if (isLoading) {
        [self.activityIndicatorView startAnimating];
    } else {
        [self.activityIndicatorView stopAnimating];
    }
}

- (void)showErrorMessage:(BOOL)isShown message:(NSString *)message
{
    self.errorMessage.hidden = !isShown;
    self.contentView.hidden = isShown;
    if (message.length) {
        self.errorMessage.text = message;

        [self.view setNeedsLayout];
    }
}


@end