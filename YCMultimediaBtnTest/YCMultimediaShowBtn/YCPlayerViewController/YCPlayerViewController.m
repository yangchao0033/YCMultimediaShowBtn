//
//  YCPlayerViewController.m
//  YCMultimediaBtnTest
//
//  Created by 超杨 on 15/11/11.
//  Copyright © 2015年 超杨. All rights reserved.
//

#import "YCPlayerViewController.h"
#import "LxDBAnything.h"

@interface YCPlayerViewController ()<AVPlayerViewControllerDelegate>

@end

@implementation YCPlayerViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    LxDBAnyVar(self.player);
//    self.player = [AVPlayer url];
}

/*!
	@method		playerViewControllerWillStartPictureInPicture:
	@param		playerViewController
 The player view controller.
	@abstract	Delegate can implement this method to be notified when Picture in Picture will start.
 */
- (void)playerViewControllerWillStartPictureInPicture:(AVPlayerViewController *)playerViewController {
    
}

/*!
	@method		playerViewControllerDidStartPictureInPicture:
	@param		playerViewController
 The player view controller.
	@abstract	Delegate can implement this method to be notified when Picture in Picture did start.
 */
- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController {
    
}

/*!
	@method		playerViewController:failedToStartPictureInPictureWithError:
	@param		playerViewController
 The player view controller.
	@param		error
 An error describing why it failed.
	@abstract	Delegate can implement this method to be notified when Picture in Picture failed to start.
 */
- (void)playerViewController:(AVPlayerViewController *)playerViewController failedToStartPictureInPictureWithError:(NSError *)error{
    
}

/*!
	@method		playerViewControllerWillStopPictureInPicture:
	@param		playerViewController
 The player view controller.
	@abstract	Delegate can implement this method to be notified when Picture in Picture will stop.
 */
- (void)playerViewControllerWillStopPictureInPicture:(AVPlayerViewController *)playerViewController {
    
}

/*!
	@method		playerViewControllerDidStopPictureInPicture:
	@param		playerViewController
 The player view controller.
	@abstract	Delegate can implement this method to be notified when Picture in Picture did stop.
 */
- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController {
    
}

/*!
	@method		playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:
	@param		playerViewController
 The player view controller.
	@abstract	Delegate can implement this method and return NO to prevent player view controller from automatically being dismissed when Picture in Picture starts.
 */
- (BOOL)playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:(AVPlayerViewController *)playerViewController {
    
    return YES;
}

/*!
	@method		playerViewController:restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:
	@param		playerViewController
 The player view controller.
	@param		completionHandler
 The completion handler the delegate needs to call after restore.
	@abstract	Delegate can implement this method to restore the user interface before Picture in Picture stops.
 */
- (void)playerViewController:(AVPlayerViewController *)playerViewController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL restored))completionHandler {
    
}
@end
