//
//  DateCollectionViewCell.m
//  UIWeb
//
//  Created by Murphy Shi on 2016/11/3.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "DateCollectionViewCell.h"

@implementation DateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
        self.imgView.backgroundColor = [UIColor whiteColor];
        self.imgView.layer.cornerRadius = 20.0;
        [self addSubview: self.imgView];
        
        self.dateLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 5, 40, 30)];
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        self.dateLabel.font = [UIFont boldSystemFontOfSize: 20.0];
        self.dateLabel.text = @"17";
        [self addSubview: self.dateLabel];
        
        self.chineseDateLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 20, 40, 30)];
        self.chineseDateLabel.textAlignment = NSTextAlignmentCenter;
        self.chineseDateLabel.font = [UIFont boldSystemFontOfSize: 11.0];
        self.chineseDateLabel.textColor = [UIColor grayColor];
        self.chineseDateLabel.text = @"初二";;
        [self addSubview: self.chineseDateLabel];
    }
    
    return self;
}

@end

@implementation WeekCell

-(UILabel *)weekLabel{
    if(!_weekLabel){
        _weekLabel = [[UILabel alloc] initWithFrame: self.bounds];
        [_weekLabel setTextAlignment: NSTextAlignmentCenter];
        
        [self addSubview: _weekLabel];
    }
    return _weekLabel;
}
@end
