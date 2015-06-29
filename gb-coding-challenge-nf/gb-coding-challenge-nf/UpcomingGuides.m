//
//  UpcomingGuides.m
//  
//
//  Created by Niklas Fahl on 6/29/15.
//
//

#import "UpcomingGuides.h"
#import "Guide.h"

@implementation UpcomingGuides

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"Guide" forKeyPath:@"propertyArrayMap.data"];
    }
    return self;
}

@end
