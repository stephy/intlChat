///Users/steph/dev /workspace/chat/IntlChat/FriendCell.m
//  FriendCell.m
//  IntlChat
//
//  Created by Stephani Alves on 7/20/14.
//  Copyright (c) 2014 stephanimoroni. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)onChatButton:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickOnCellAtIndex:withData:)]) {
        [_delegate didClickOnCellAtIndex: _cellIndex withData:@"chat"];
    }
}
@end
