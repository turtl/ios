#import <Cordova/CDV.h>

@interface TurtlCorePlugin : CDVPlugin

- (void) turtlcc_start:(CDVInvokedUrlCommand*)command;
- (void) turtlcc_send:(CDVInvokedUrlCommand*)command;
- (void) turtlcc_recv:(CDVInvokedUrlCommand*)command;
- (void) turtlcc_recv_event:(CDVInvokedUrlCommand*)command;
- (void) turtlcc_free:(CDVInvokedUrlCommand*)command;
- (void) turtlcc_lasterr:(CDVInvokedUrlCommand*)command;
- (void) turtlcc_free_err:(CDVInvokedUrlCommand*)command;

@end

