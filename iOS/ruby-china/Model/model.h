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

@interface node : BeeActiveRecord

@property (nonatomic, retain) NSNumber *	id;
@property (nonatomic, retain) NSString *	name;
@property (nonatomic, retain) NSNumber *	topics_count;
@property (nonatomic, retain) NSString *	summary;
@property (nonatomic, retain) NSNumber *	section_id;
@property (nonatomic, retain) NSString *	section_name;
@property (nonatomic, retain) NSNumber *	sort;

@end

@interface user : BeeActiveRecord

@property (nonatomic, retain) NSNumber *	id;
@property (nonatomic, retain) NSString *	name;
@property (nonatomic, retain) NSString *	login;
@property (nonatomic, retain) NSString *	email;
@property (nonatomic, retain) NSString *	location;
@property (nonatomic, retain) NSString *	company;
@property (nonatomic, retain) NSString *	twitter;
@property (nonatomic, retain) NSString *	website;
@property (nonatomic, retain) NSString *	bio;
@property (nonatomic, retain) NSString *	tagline;
@property (nonatomic, retain) NSString *	github_url;
@property (nonatomic, retain) NSString *	gravatar_hash;
@property (nonatomic, retain) NSString *	avatar_url;

@end

@interface reply : BeeActiveRecord

@property (nonatomic, retain) NSNumber *	id;
@property (nonatomic, retain) NSNumber *	topic_id;
@property (nonatomic, retain) NSString *	body;
@property (nonatomic, retain) NSString *	body_html;
@property (nonatomic, retain) NSDate *		created_at;
@property (nonatomic, retain) NSDate *		updated_at;
@property (nonatomic, retain) user *		user;

@end

@interface topic : BeeActiveRecord

@property (nonatomic, retain) NSNumber *	id;
@property (nonatomic, retain) NSString *	title;
@property (nonatomic, retain) NSDate *		created_at;		// "2013-03-24T14:30:19+08:00"
@property (nonatomic, retain) NSDate *		updated_at;		// "2013-03-24T16:34:51+08:00"
@property (nonatomic, retain) NSDate *		replied_at;		// "2013-03-24T16:34:51+08:00"
@property (nonatomic, retain) NSNumber *	replies_count;
@property (nonatomic, retain) NSString *	node_name;
@property (nonatomic, retain) NSNumber *	node_id;
@property (nonatomic, retain) NSNumber *	last_reply_user_id;
@property (nonatomic, retain) NSString *	last_reply_user_login;
@property (nonatomic, retain) NSString *	body;
@property (nonatomic, retain) NSString *	body_html;
@property (nonatomic, retain) NSNumber *	hits;
@property (nonatomic, retain) user *		user;
@property (nonatomic, retain) NSArray *		replies;

@end

