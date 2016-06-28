//
//  FPImageView.h
//  Flickr Party
//
//  Created by Ulaş Sancak on 27/06/16.
//  Copyright © 2016 Ulaş Sancak. All rights reserved.
//

#import <UIKit/UIKit.h>
/*

 This class was created to override intrinsicContentSize method. When UIImageView gets an UIImage object it arranges it's size on it's own. But we want it to be stay static in order to display fine while displaying party details.
 
*/
@interface FPImageView : UIImageView

@end
