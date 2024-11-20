#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "Gfx/AppIcon" asset catalog image resource.
static NSString * const ACImageNameGfxAppIcon AC_SWIFT_PRIVATE = @"Gfx/AppIcon";

#undef AC_SWIFT_PRIVATE
