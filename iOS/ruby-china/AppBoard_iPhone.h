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

@class NavigationBoard_iPhone;
@class NodesBoard_iPhone;

@interface AppBoard_iPhone : BeeUIBoard
{
	BeeUIStack *			_stackNav;
	BeeUIStackGroup *		_stackGroup;
}

AS_SINGLETON( AppBoard_iPhone )

@end
