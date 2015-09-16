//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import <AFNetworking/AFHTTPRequestOperation.h>
#import "HotelViewController.h"
#import "Hotel.h"
#import "RequestOperationManager.h"
#import "APIRequest+Factory.h"
#import "NSString+Rating.h"

@interface HotelViewController()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *hotelNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotelImageView;
@property (weak, nonatomic) IBOutlet UILabel *hotelAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotelRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotelSuitesLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotelDistanceLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imageLoadingActivityIndicator;

@property(nonatomic, retain) AFHTTPRequestOperation *operation;

@end

@implementation HotelViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.isLoaded && self.operation == nil) {
        self.operation = [[RequestOperationManager manager] fetch:[APIRequest requestOfHotel:self.hotel.hotelID] success:^(AFHTTPRequestOperation *operation, Hotel *hotel) {
            self.hotel = hotel;
            self.isLoaded = YES;
            [self showLoadingIndicator:NO];
            self.operation = nil;
            [self bindData:hotel];
            [self fetchImage:hotel.imageURLPath];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self showLoadingIndicator:NO];
            [self showErrorMessage:YES message:@"Unable to load hotel, please try later"];
            self.isLoaded = NO;
            self.operation = nil;
        }];
        [self showLoadingIndicator:YES];
    }
}

- (void)fetchImage:(NSString *)imageURLPath
{
    [self.imageLoadingActivityIndicator startAnimating];
    self.imageLoadingActivityIndicator.hidden = NO;
    [[RequestOperationManager manager] fetch:[APIRequest requestOfImage:imageURLPath] success:^(AFHTTPRequestOperation *operation, UIImage *image) {
        self.hotelImageView.image = image;
        [self.imageLoadingActivityIndicator stopAnimating];
        self.imageLoadingActivityIndicator.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.imageLoadingActivityIndicator stopAnimating];
        self.imageLoadingActivityIndicator.hidden = YES;
    }];
}

- (void)bindData:(Hotel *)hotel
{
    self.hotelNameLabel.text = hotel.hotelName.length ? hotel.hotelName : @"—";
    self.hotelAddressLabel.text = hotel.hotelAddress.length ? hotel.hotelAddress : @"—";
    self.hotelRatingLabel.text = [NSString ratingForNumber:hotel.hotelStars];
    self.hotelSuitesLabel.text = hotel.suitesAvailable.length ? hotel.suitesAvailable : @"No suites available";
    self.hotelDistanceLabel.text = hotel.distance ? [NSString stringWithFormat:@"%@ km", hotel.distance] : @"";
}


@end