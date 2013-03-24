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

#import "AppBoard_iPad.h"

@implementation AppBoard_iPad

DEF_SINGLETON( AppBoard_iPad )

// BeeUIBoard signal goes here
- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
		// 界面创建
        self.view.hintString = @"Hello Bee, iPad!";
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
		// 界面删除
        // SAFE_RELEASE_SUBVIEW(  );
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
		// 界面重新布局
	}
	else if ( [signal is:BeeUIBoard.LOAD_DATAS] )
	{
		// 数据加载
	}
	else if ( [signal is:BeeUIBoard.FREE_DATAS] )
	{
		// 数据释放
	}
	else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
	{
		// 将要显示
	}
	else if ( [signal is:BeeUIBoard.DID_APPEAR] )
	{
		// 已经显示
	}
	else if ( [signal is:BeeUIBoard.WILL_DISAPPEAR] )
	{
		// 将要隐藏
	}
	else if ( [signal is:BeeUIBoard.DID_DISAPPEAR] )
	{
		// 已经隐藏
	}
}

@end
