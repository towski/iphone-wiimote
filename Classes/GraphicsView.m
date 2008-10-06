//
//  MyView.m
//  ExploringGraphics2
//
//  Copyright TrailsintheSand.com 2008. All rights reserved.
//

#import "GraphicsView.h"
#include <sys/kernel.h>

#define kAccelFilt 0.03

@interface NSURLRequest (SomePrivateAPIs)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(id)fp8;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)fp8 forHost:(id)fp12;
@end

@implementation GraphicsView

- (id)initWithFrame:(CGRect)frameRect{
    self = [super initWithFrame:frameRect];
    challenged = false;
	x_pos = 0;
	y_pos = 0;
	[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:@"10.1.10.122"];
    accelX = 0.0;
    accelY = 0.0;

	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(9.0 / 60)];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
    return self;
}

- (void)drawRect:(CGRect)rect
{
}


- (void)dealloc
{
    [timer invalidate];
	[super dealloc];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSString *urlString = [NSString stringWithFormat:@"https://10.1.10.122:5010/t/mouseevent?x1=%d&y1=%d&type=click", x_pos, y_pos];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
												cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];	
	if (theConnection) {
		receivedData = [[NSMutableData data] retain];
	} else {
		NSLog(@"fail");
	}
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    if(fabs(acceleration.x) < 0.07){
		accelX = accelX;
	}else{
		accelX = (acceleration.x * kAccelFilt) + (accelX);// * (1.0 - kAccelFilt));
	}
    if(fabs(acceleration.y) < 0.07){
		accelY = accelY;
	}else{
		accelY = (-acceleration.y * kAccelFilt) + (accelY);// * (1.0 - kAccelFilt));
	}
	if(accelX > 0.1){
		accelX = 0.1;
	}
	if(accelY > 0.1){
		accelY = 0.1;
	}
	int cartesian_x = accelX * 10 * 720;
	int cartesian_y = accelY * 10 * 450;
	if(cartesian_x > 1440){
		cartesian_x = 1440;
	}
	if(cartesian_y > 900){
		cartesian_y = 900;
	}
	int temp_x_pos = cartesian_x + 720;
	int temp_y_pos = (cartesian_y - 450) * -1;
		x_pos = temp_x_pos;
		y_pos = temp_y_pos;
		NSString *urlString = [NSString stringWithFormat:@"https://10.1.10.122:5010/t/mouseevent?x1=%d&y1=%d", x_pos, y_pos];

		NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
													cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
		NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
		if (theConnection) {
			receivedData = [[NSMutableData data] retain];
		} else {
			NSLog(@"fail");
		}

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	[connection release];
	NSLog(@"Connection failed! Error - %@ %@",[error localizedDescription],[[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [receivedData appendData:data];	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [connection release];
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
	if ([challenge previousFailureCount] == 0) {
		NSLog(@"Challenged!");
		NSURLCredential *newCredential;
		newCredential=[NSURLCredential credentialWithUser:@"towski" password:@"s9m2b3" persistence:NSURLCredentialPersistencePermanent];
        [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
    } else {
		[[challenge sender] cancelAuthenticationChallenge:challenge];
        [self showPreferencesCredentialsAreIncorrectPanel:self];
    }
}

@end
