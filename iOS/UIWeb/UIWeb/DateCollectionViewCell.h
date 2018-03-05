//
//  DateCollectionViewCell.h
//  UIWeb
//
//  Created by Murphy Shi on 2016/11/3.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) IBOutlet UILabel *chineseDateLabel;

@end

@interface WeekCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *weekLabel;

@end
//@interface DateCollectionViewCell : UICollectionViewCell

//@end
