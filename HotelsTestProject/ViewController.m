//
//  ViewController.m
//  HotelsTestProject
//
//  Created by Artem Abramov on 16/09/15.
//  Copyright © 2015 Artem Abramov. All rights reserved.
//

#import "ViewController.h"
#import "RequestOperationManager.h"
#import "APIRequest+Factory.h"

@interface ViewController ()

@property(nonatomic, assign) BOOL isLoaded;
@property(nonatomic, retain) AFHTTPRequestOperation *operation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.isLoaded) {
        self.operation = [[RequestOperationManager manager] fetch:[APIRequest requestOfHotelsList] success:^(AFHTTPRequestOperation *operation, NSArray *hotelsList) {
            NSLog(@"Successfully fetched hotels list: %@", hotelsList);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to fetch hotels list: %@", error.localizedDescription);
            [self showLoadingIndicator:NO];
            [self showErrorMessage:@"Unable to load list of hotels, please check your internet connection and try later."];
        }];
    }
}

- (void)showLoadingIndicator:(BOOL)isLoading
{

}

- (void)showErrorMessage:(NSString *)errorMessage
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
