//
//  GuideWebservice.m
//  
//
//  Created by Niklas Fahl on 6/29/15.
//
//

#import "GuideWebservice.h"
#import "NSObject+ObjectMap.h"
#import "UpcomingGuides.h"

@implementation GuideWebservice

#pragma mark - Init
- (id)init {
    self = [super init];
    if (self != nil) {
        self.OperationQueue = [[NSOperationQueue alloc]
                               init];
    }
    
    return self;
}

#pragma mark - Webservice Singleton
+ (GuideWebservice *)sharedInstance
{
    static GuideWebservice *_sharedInstance = nil;
    @synchronized(self) {
        if (_sharedInstance == nil)
            _sharedInstance = [[self alloc] init];
    }
    return _sharedInstance;
}

#pragma mark - API methods
- (void)getUpcomingGuidesWithCompletion:(UpcomingGuidesCompletionBlock)completion
{
    // Build request URL
    NSString *requestURL = @"https://www.guidebook.com/service/v2/upcomingGuides/";
    
    // Create Operation
    WebOperation *operation = [[WebOperation alloc] init];
    __weak WebOperation *weakOperation = operation;
    
    // Make request
    [operation setRequestWithBodyData:nil forHttpMethod:HTTP_METHOD_GET url:requestURL contentType:CONTENT_TYPE_JSON completion:^{
        // Handle response
        if (weakOperation.responseData) {
            // Get raw JSON package and print to console
            NSString *responseString = [[NSString alloc] initWithData:weakOperation.responseData encoding:NSUTF8StringEncoding];
            NSLog(@"Response JSON: %@", responseString);
            
            // Parse response data
            UpcomingGuides *upcomingGuides = [[UpcomingGuides alloc] initWithJSONData:weakOperation.responseData];
            
            if (upcomingGuides) {
                if ([upcomingGuides isKindOfClass:[UpcomingGuides class]]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(weakOperation, upcomingGuides.data);
                    });
                    return;
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil, nil);
        });
    }];
    
    [self.OperationQueue addOperation:operation];
}

@end
