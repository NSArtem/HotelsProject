//
//  HotelTableViewCell.h
//  HotelsTestProject
//
//  Created by Artem Abramov on 16/09/15.
//  Copyright © 2015 Artem Abramov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Hotel;

@interface HotelTableViewCell : UITableViewCell

- (void)configureWithModel:(Hotel *)model;

@end
