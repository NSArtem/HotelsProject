//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "LoadingViewController.h"

@class Hotel;

@interface HotelViewController : LoadingViewController

@property (nonatomic, strong) Hotel *hotel;

@end