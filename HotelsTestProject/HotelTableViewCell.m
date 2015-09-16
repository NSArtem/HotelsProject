//
//  HotelTableViewCell.m
//  HotelsTestProject
//
//  Created by Artem Abramov on 16/09/15.
//  Copyright © 2015 Artem Abramov. All rights reserved.
//

#import "HotelTableViewCell.h"
#import "Hotel.h"

@interface HotelTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *hotelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotelAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotelStarsLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotelDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *availableSuitesLabel;

@end

@implementation HotelTableViewCell

- (void)configureWithModel:(Hotel *)hotel
{
    self.hotelNameLabel.text = hotel.hotelName.length ? hotel.hotelName : @"—";
    self.hotelAddressLabel.text = hotel.hotelAddress.length ? hotel.hotelAddress : @"—";

    if (hotel.hotelStars && hotel.hotelStars.integerValue > 0) {
        NSUInteger stars = (hotel.hotelStars.integerValue <= 10) ? hotel.hotelStars.integerValue : 10;
        self.hotelStarsLabel.text = [@"" stringByPaddingToLength:stars withString:@"★" startingAtIndex:0];
    } else {
        self.hotelStarsLabel.text = @"Rating unavailable";
    }

    self.hotelDistanceLabel.text = hotel.distance ? [NSString stringWithFormat:@"%@ km", hotel.distance] : @"";
    self.availableSuitesLabel.text = hotel.suitesAvailable.length ? hotel.suitesAvailable : @"No suites available";
}

@end
