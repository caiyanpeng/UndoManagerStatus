/**
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *   
 *
 *
 */
#import "CAICommonController.h"

@interface CAICommonController ()<DrawViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *value;

@end

@implementation CAICommonController

- (instancetype)init
{
 
        self = [super initWithNibName:@"CommonView"
                               bundle:nil];

        
        return self;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.areas.delegate = self;

    self.view.backgroundColor = [UIColor whiteColor];
    

    
}
- (IBAction)undoChange:(id)sender {
    
    [_areas undo];
}
- (IBAction)redoChange:(id)sender {
    
    [_areas redo];
}

-(void)drawViewDidChanged:(int)type
{

    _value.text = [NSString stringWithFormat:@"%d",type];
}




@end
