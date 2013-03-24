//
//				   __                          __
//				  /\ \                        /\ \      __
//	 _ __   __  __\ \ \____  __  __        ___\ \ \___ /\_\    ___      __
//	/\  __\/\ \/\ \\ \  __ \/\ \/\ \      / ___\ \  _  \/\ \ /  _  \  / __ \
//	\ \ \/ \ \ \_\ \\ \ \_\ \ \ \_\ \    /\ \__/\ \ \ \ \ \ \/\ \/\ \/\ \_\ \_
//	 \ \_\  \ \____/ \ \_ __/\ \____ \   \ \____\\ \_\ \_\ \_\ \_\ \_\ \__/ \_\
//	  \/_/   \/___/   \/___/  \/___/_ \   \/____/ \/_/\/_/\/_/\/_/\/_/\/__/\/_/
//								 /\___/
//								 \/__/
//
//	Powered by BeeFramework
//	https://github.com/gavinkwoe/BeeFramework
//

#import "AppBoard_iPhone.h"
#import "NavigationBoard_iPhone.h"
#import "NodesBoard_iPhone.h"

#pragma mark -

@implementation AppBoard_iPhone

DEF_SINGLETON( AppBoard_iPhone )

- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
		_stackNav = [[BeeUIStack stackWithFirstBoardClass:[NavigationBoard_iPhone class]] retain];
		_stackNav.view.hidden = YES;
		[self.view addSubview:_stackNav.view];

		_stackGroup = [[BeeUIStackGroup stackGroup] retain];
		[_stackGroup append:[BeeUIStack stackWithFirstBoardClass:[NodesBoard_iPhone class]]];
		[self.view addSubview:_stackGroup.view];
	}
    else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
        SAFE_RELEASE( _stackGroup );
        SAFE_RELEASE( _stackNav );
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
		_stackNav.view.frame = self.viewBound;
		_stackGroup.view.frame = self.viewBound;
	}
}

@end
