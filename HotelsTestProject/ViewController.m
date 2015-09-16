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
#import "HotelTableViewCell.h"

@interface HotelsViewController ()<UITableViewDataSource>

@property(nonatomic, assign) BOOL isLoaded;
@property(nonatomic, retain) AFHTTPRequestOperation *operation;
@property(nonatomic, copy) NSArray *hotels;
@property(nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) UILabel *errorMessage;

@end

@implementation HotelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 125.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:activityIndicatorView];
    self.activityIndicatorView = activityIndicatorView;

    UILabel *errorMessage = [[UILabel alloc] init];
    [self.view addSubview:errorMessage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.isLoaded && self.operation == nil) {
        self.operation = [[RequestOperationManager manager] fetch:[APIRequest requestOfHotelsList] success:^(AFHTTPRequestOperation *operation, NSArray *hotelsList) {
            NSLog(@"Successfully fetched hotels list: %@", hotelsList);
            self.hotels = hotelsList;
            self.isLoaded = YES;
            [self showLoadingIndicator:NO];
            [self showErrorMessage:NO message:nil];
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to fetch hotels list: %@", error.localizedDescription);
            [self showLoadingIndicator:NO];
            [self showErrorMessage:YES message:@"Unable to load list of hotels, please check your internet connection and try later."];
            self.isLoaded = NO;
            self.operation = nil;
        }];
        [self showLoadingIndicator:YES];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.activityIndicatorView.center = self.view.center;
    [self.errorMessage sizeThatFits:self.view.bounds.size];
    self.errorMessage.center = self.view.center;
}


- (void)showLoadingIndicator:(BOOL)isLoading
{
    self.tableView.hidden = isLoading;
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
    self.tableView.hidden = isShown;
    if (message.length) {
        self.errorMessage.text = message;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotelTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HotelTableViewCell class]) forIndexPath:indexPath];
    [cell configureWithModel:self.hotels[(NSUInteger)indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hotels.count;
}

- (IBAction)sortButtonPressed:(id)sender {
}

@end
