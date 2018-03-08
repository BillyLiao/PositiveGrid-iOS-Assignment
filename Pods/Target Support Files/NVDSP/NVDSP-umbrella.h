#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NVDSP.h"
#import "NVAllpassFilter.h"
#import "NVBandpassFilter.h"
#import "NVBandpassQPeakGainFilter.h"
#import "NVHighpassFilter.h"
#import "NVHighShelvingFilter.h"
#import "NVLowpassFilter.h"
#import "NVLowShelvingFilter.h"
#import "NVNotchFilter.h"
#import "NVPeakingEQFilter.h"
#import "NVClippingDetection.h"
#import "NVSoundLevelMeter.h"

FOUNDATION_EXPORT double NVDSPVersionNumber;
FOUNDATION_EXPORT const unsigned char NVDSPVersionString[];

