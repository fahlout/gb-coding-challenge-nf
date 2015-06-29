//
//  Guide.h
//  
//
//  Created by Niklas Fahl on 6/29/15.
//
//

#import <Foundation/Foundation.h>
#import "Venue.h"

@interface Guide : NSObject

@property (nonatomic, retain) NSString *startDate;
@property (nonatomic, retain) NSString *endDate;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) Venue *venue;
@property (nonatomic, retain) NSString *objType;
@property (nonatomic, retain) NSString *icon;

@end
