//
//  Card+CoreDataProperties.h
//  UIWeb
//
//  Created by murphy_shi on 16/9/21.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface Card (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *no;
@property (nullable, nonatomic, retain) Pason *pason;

@end

NS_ASSUME_NONNULL_END
