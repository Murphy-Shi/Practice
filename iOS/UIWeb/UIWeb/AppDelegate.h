//
//  AppDelegate.h
//  UIWeb
//
//  Created by murphy_shi on 16/8/17.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

typedef void (^passBlock)(NSString *);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, copy) passBlock passValue;
- (void)saveContext;

- (NSURL *)applicationDocumentsDiretory;


@end

