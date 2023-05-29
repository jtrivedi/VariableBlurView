//
//  CAFilter.h
//  VariableBlurView
//
//  Created by Janum Trivedi on 5/29/23.
//

#import <Foundation/Foundation.h>

/// This type is private QuartzCore API:
/// https://developer.limneos.net/index.php?ios=16.3&framework=QuartzCore.framework&header=CAFilter.h
///
@interface CAFilter : NSObject
+ (id)filterWithType:(id)arg1;
@end
