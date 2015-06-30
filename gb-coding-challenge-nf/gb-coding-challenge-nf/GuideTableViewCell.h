//
//  GuideTableViewCell.h
//  
//
//  Created by Niklas Fahl on 6/29/15.
//
//

#import <UIKit/UIKit.h>

@interface GuideTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *guideNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *guideTimeframeLabel;
@property (strong, nonatomic) IBOutlet UILabel *guideLocationLabel;

@end
