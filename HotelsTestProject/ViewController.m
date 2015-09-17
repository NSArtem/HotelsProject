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
#import "HotelViewController.h"

typedef NS_ENUM(NSInteger, SortOrder) {
    ByDistance,
    BySuitesAvailable
};

@interface HotelsViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property(nonatomic, retain) AFHTTPRequestOperation *operation;
@property(nonatomic, copy) NSArray *hotels;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HotelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 125.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
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
            self.operation = nil;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotelTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HotelTableViewCell class]) forIndexPath:indexPath];
    [cell configureWithModel:self.hotels[(NSUInteger)indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hotels.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HotelViewController *vc = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"HotelViewController"];
    Hotel *hotel = self.hotels[indexPath.row];
    vc.hotel = hotel;
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)sortButtonPressed:(id)sender {
    if (!self.isLoaded)
        return;
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sort"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sortByDistance = [UIAlertAction actionWithTitle:@"By distance"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                              [self sortDataByOrder:ByDistance];
                                                          }];
    [alert addAction:sortByDistance];

    UIAlertAction *sortBySuitesAvailable = [UIAlertAction actionWithTitle:@"By suites available"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action) {
                                                                     [self sortDataByOrder:BySuitesAvailable];
                                                                  }];
    [alert addAction:sortBySuitesAvailable];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sortDataByOrder:(SortOrder)sortOrder
{
    [self showLoadingIndicator:YES];
    NSArray *hotels = self.hotels;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSSortDescriptor *sortDescriptor;
        switch (sortOrder) {
            case BySuitesAvailable: {
                sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"suites.@count" ascending:NO];
                break;
            }
            case ByDistance: {
                sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
                break;
            }
        }

        NSArray *sortedArray = [hotels sortedArrayUsingDescriptors:@[sortDescriptor]];

        dispatch_async(dispatch_get_main_queue(), ^{
            self.hotels = sortedArray;
            [self.tableView reloadData];
            [self showLoadingIndicator:NO];
            [self.tableView setContentOffset:CGPointMake(0, -self.tableView.contentInset.top) animated:YES];
        });
    });
}


@end
