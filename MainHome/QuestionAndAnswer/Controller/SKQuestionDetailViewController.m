//
//  SKQuestionDetailViewController.m
//  Stockallocation
//
//  Created by wuyou on 2019/8/7.
//  Copyright © 2019年 SoWhat. All rights reserved.
//

#import "SKQuestionDetailViewController.h"
#import "SKQuestionDetailModel.h"
#import "SKGivingOpinionsViewController.h"
@interface SKQuestionDetailViewController ()

@property (nonatomic ,strong)SKQuestionDetailModel *data;
@property(nonatomic,strong)UIScrollView *scroller;
@property(nonatomic,strong)UIView *scrollerContentView;
@property (nonatomic, strong)UILabel *questionLabel;
@property (nonatomic , strong)UILabel *questiontorLabel;
@property (nonatomic , strong)UIImageView *anserImageView;
@property (nonatomic , strong)UILabel *auLabel;
@property (nonatomic , strong)UILabel *auTimeLabel;
@property (nonatomic , strong)UILabel *answerLabel;

@property (nonatomic , strong)UIButton *attentionBtn;

@end

@implementation SKQuestionDetailViewController

- (UIScrollView *)scroller {
    if (_scroller == nil) {
        _scroller = [[UIScrollView alloc]init];
        _scroller.backgroundColor = TableViewBGColor;
    }
    return _scroller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"问答详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestData];
    [self makeUI];
    // Do any additional setup after loading the view.
}

- (void)makeUI {
    WS(weakSelf);
    [self.view addSubview:self.scroller];
    [self.scroller mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(weakSelf.view);
        make.top.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-55);
    }];
    self.scrollerContentView = [[UIView alloc]init];
    [self.scroller addSubview:self.scrollerContentView];
    [self.scrollerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.scroller);
        make.width.mas_equalTo(weakSelf.scroller);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    
    UIView *topBackView = [[UIView alloc]init];
    topBackView.backgroundColor = [UIColor whiteColor];
    [self.scrollerContentView addSubview:topBackView];
    [topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.scrollerContentView);
        make.left.right.mas_equalTo(weakSelf.scrollerContentView);
        make.height.greaterThanOrEqualTo(@0.f);
    }];
    
    UIImageView *questionImageView = [[UIImageView alloc]init];
    questionImageView.image = [UIImage imageNamed:@"Group4"];
    [topBackView addSubview:questionImageView];
    [questionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topBackView.mas_left).mas_offset(15.0);
        make.top.mas_equalTo(topBackView.mas_top).mas_offset(15.0);
        make.width.height.mas_equalTo(45);
    }];
    
    self.questionLabel = [[UILabel alloc]init];
    self.questionLabel.numberOfLines = 3;
    self.questionLabel.font = [UIFont boldSystemFontOfSize:15];
    self.questionLabel.textColor = [UIColor hexStringToColor:@"333333"];
    [topBackView addSubview:self.questionLabel];
    
    [self.questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(questionImageView.mas_right).offset(15);
        make.top.mas_equalTo(questionImageView.mas_top);
        make.right.mas_equalTo(topBackView.mas_right).offset(-15);
    }];
    
    self.questiontorLabel = [[UILabel alloc]init];
    self.questiontorLabel.font = [UIFont systemFontOfSize:12];
    self.questiontorLabel.textColor = [UIColor hexStringToColor:@"999999"];
    [topBackView addSubview:self.questiontorLabel];
    
    [self.questiontorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topBackView.mas_left).offset(15);
        make.top.mas_equalTo(weakSelf.questionLabel.mas_bottom).offset(30);
        make.right.mas_equalTo(topBackView.mas_right).offset(-15);
        make.bottom.mas_equalTo(topBackView).offset(-20);
    }];
    
    UIView *bottomBackView = [[UIView alloc]init];
    bottomBackView.backgroundColor = [UIColor whiteColor];
    [self.scrollerContentView addSubview:bottomBackView];
    [bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topBackView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(topBackView);
        make.bottom.mas_equalTo(weakSelf.scrollerContentView);
    }];
    
    self.anserImageView = [[UIImageView alloc]init];
    self.anserImageView.layer.cornerRadius = 25;
    self.anserImageView.layer.masksToBounds = YES;
    [bottomBackView addSubview:self.anserImageView];
    [self.anserImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomBackView.mas_left).mas_offset(15.0);
        make.top.mas_equalTo(bottomBackView.mas_top).mas_offset(15.0);
        make.width.height.mas_equalTo(50);
    }];
    
    self.auLabel = [[UILabel alloc]init];
    self.auLabel.font = [UIFont boldSystemFontOfSize:15];
    self.auLabel.textColor = [UIColor hexStringToColor:@"333333"];
    [bottomBackView addSubview:self.auLabel];
    
    [self.auLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.anserImageView.mas_right).offset(15);
        make.top.mas_equalTo(weakSelf.anserImageView.mas_top);
        make.right.mas_equalTo(bottomBackView.mas_right).offset(-15);
    }];
    
    self.auTimeLabel = [[UILabel alloc]init];
    self.auTimeLabel.font = [UIFont systemFontOfSize:12];
    self.auTimeLabel.textColor = [UIColor hexStringToColor:@"333333"];
    [bottomBackView addSubview:self.auTimeLabel];
    
    [self.auTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.anserImageView.mas_right).offset(15);
        make.top.mas_equalTo(weakSelf.auLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(bottomBackView.mas_right).offset(-15);
    }];
    
    
    self.attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.attentionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.attentionBtn addTarget:self action:@selector(attentionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.attentionBtn setTitle:@"+关注" forState:UIControlStateNormal];
    self.attentionBtn.backgroundColor = KBlueColor;
    self.attentionBtn.layer.cornerRadius = 15;
    self.attentionBtn.layer.masksToBounds = YES;
    [bottomBackView addSubview:self.attentionBtn];
    
    [self.attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.anserImageView.mas_centerY);
        make.right.mas_equalTo(bottomBackView.mas_right).offset(-20);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    
    self.answerLabel = [[UILabel alloc]init];
    self.answerLabel.font = [UIFont boldSystemFontOfSize:15];
    self.answerLabel.numberOfLines = 0;
    self.answerLabel.textColor = [UIColor hexStringToColor:@"333333"];
    [bottomBackView addSubview:self.answerLabel];
    
    [self.answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.anserImageView.mas_left);
        make.top.mas_equalTo(weakSelf.anserImageView.mas_bottom).offset(20);
        make.right.mas_equalTo(bottomBackView.mas_right).offset(-15);
    }];
    
    UIView *noticeView = [[UIView alloc]init];
    noticeView.layer.borderColor = [UIColor hexStringToColor:@"FFD1A8"].CGColor;
    noticeView.layer.borderWidth = 1;
    noticeView.backgroundColor = [UIColor hexStringToColor:@"FFFDC9"];
    [bottomBackView addSubview:noticeView];
    
    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.answerLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(bottomBackView.mas_left).offset(20);
        make.right.mas_equalTo(bottomBackView.mas_right).offset(-20);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(bottomBackView.mas_bottom);
    }];
    
    UILabel *noticeLabel = [[UILabel alloc]init];
    noticeLabel.textColor = [UIColor hexStringToColor:@"F43C2B"];
    noticeLabel.numberOfLines = 0;
    noticeLabel.text = @"风险提示:以上内容仅代表个人观点,不构成投资建议,股市有风险,投资需谨慎";
    noticeLabel.font = [UIFont systemFontOfSize:12];
    [noticeView addSubview:noticeLabel];
    
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(noticeView.mas_left).offset(20);
        make.right.mas_equalTo(noticeView.mas_right).offset(-20);
        make.centerY.mas_equalTo(noticeView.mas_centerY);
    }];
    
    UIButton *questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [questionBtn setBackgroundColor:KBlueColor];
    [questionBtn setTitle:@"向答主提问" forState:UIControlStateNormal];
    [questionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [questionBtn addTarget:self action:@selector(questionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:questionBtn];
    
    [questionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.scroller.mas_bottom);
        make.left.right.mas_equalTo(weakSelf.scroller);
        make.height.mas_equalTo(55);
    }];
}

- (void)questionBtnClick {
    SKGivingOpinionsViewController *publicVC = [[SKGivingOpinionsViewController alloc] init];
    publicVC.type = 1;
    publicVC.tid = self.data.data.au_uid;
    publicVC.title = @"向TA提问";
    [self.navigationController pushViewController:publicVC animated:YES];
}

- (void)attentionBtnClick:(UIButton *)btn {
    WS(weakSelf);
    NSDictionary *params = @{@"token":[SKUserInfoModel userToken],@"id":self.data.data.au_uid};
    [SVCCommunityApi pointFocusNSDictionary:params BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if(code == 0){
            
            [weakSelf.view toastShow:[JSON objectForKey:@"msg"]];
            [self requestData];
        }
    } andfail:^(NSError *error) {
        
    } path:@"attention"];
}

- (void)updateUi {
    self.questionLabel.text = self.data.data.content;
    self.questiontorLabel.text = [NSString stringWithFormat:@"提问者:%@ | %@",self.data.data.nickname,self.data.data.cre_time];
    [self.anserImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerPath,self.data.data.au_img]]];
    self.auLabel.text = self.data.data.au_nickname;
    self.auTimeLabel.text = [NSString stringWithFormat:@"%@ 回答",self.data.data.au_cre_time];
    self.answerLabel.text = self.data.data.au_content;
    if ([self.data.data.is_gz isEqualToString:@"0"]) {
        //未关注
        [self.attentionBtn setTitle:@"+关注" forState:UIControlStateNormal];
    } else {
        //关注
        [self.attentionBtn setTitle:@"取消关注" forState:UIControlStateNormal];
    }
}

- (void)requestData {
    WS(weakSelf);
    NSDictionary *paras = @{@"token":[SKUserInfoModel userToken],@"wt_id":self.questionId};
    [SVCCommunityApi questionListDeatailWithNSDictionary:paras BlockSuccess:^(NSInteger code, NSString *msg, NSDictionary *JSON) {
        if (code == 0) {
            self.data = [SKQuestionDetailModel mj_objectWithKeyValues:JSON];
            [self updateUi];
        }
    } andfail:^(NSError *error) {
        [weakSelf.view toastShow:netFailString];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
