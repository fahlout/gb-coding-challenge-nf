//
//  GuideWebservice.h
//  
//
//  Created by Niklas Fahl on 6/29/15.
//
//

#import <Foundation/Foundation.h>
#import "Webservice.h"

typedef void(^UpcomingGuidesCompletionBlock)(WebOperation *operation, NSArray* upcomingGuides);

@interface GuideWebservice : Webservice

+ (GuideWebservice *)sharedInstance;

- (void)getUpcomingGuidesWithCompletion:(UpcomingGuidesCompletionBlock)completion;

@end
