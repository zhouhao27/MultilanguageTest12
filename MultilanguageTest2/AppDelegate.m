//
//  AppDelegate.m
//  MultilanguageTest2
//
//  Created by Zhou Hao on 09/11/14.
//  Copyright (c) 2014年 Zhou Hao. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [Parse setApplicationId:@"STCgTWFKNGaecRh0C7S3oYQ0Vj3WhsNMpgVi3frw"
                  clientKey:@"vS2qN6bsuczU5f0FIunxDZJETZPlVOKMURtRUdTQ"];
    

    PFQuery *subQuery = [PFQuery queryWithClassName:@"Product"];
    // This doesn't work
    //[subQuery orderByAscending:@"downloaded"];
    PFQuery *query = [PFQuery queryWithClassName:@"Translation"];
    [query whereKey:@"product" matchesQuery:subQuery];
    [query whereKey:@"language" equalTo:@"zh-Hans"];
    [query includeKey:@"product"];
    // I can only use this to sort
    //[query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for (PFObject* obj in objects) {
            
            PFObject* productObj = [obj objectForKey:@"product"];
            NSString* productId = [productObj objectForKey:@"product_id"];
            NSNumber* downloaded = [productObj objectForKey:@"downloaded"];
            NSString* title = [obj objectForKey:@"title"];
            NSString* desc = [obj objectForKey:@"description"];
            
            NSLog(@"product id = %@,downloaded = %d, tile = %@,description = %@",productId,downloaded.intValue,title,desc);
        }
        
    }];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
