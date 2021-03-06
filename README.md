>对第三方插件MBProgressHUD做一个简单的封装

github下载地址： https://github.com/jiangbin1993/MBProgressHUD-JJ.git

**下载的文件**

从github上下载下来文件后，主要有demo和封装的文件

![下载文件图.png](https://upload-images.jianshu.io/upload_images/2541004-5429c0f0e978a13b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 封装的文件代码展示：

文件MBProgressHUD+JJ.h

```

/**
 github:https://github.com/jiangbin1993/MBProgressHUD-JJ.git
 作者：Jonas
 **/

#import "MBProgressHUD.h"

// 统一的显示时长
#define kHudShowTime 1.5

@interface MBProgressHUD (JJ)

#pragma mark 在指定的view上显示hud
+ (void)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showWarning:(NSString *)Warning toView:(UIView *)view;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showActivityMessage:(NSString*)message view:(UIView *)view;
+ (MBProgressHUD *)showProgressBarToView:(UIView *)view;


#pragma mark 在window上显示hud
+ (void)showMessage:(NSString *)message;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showWarning:(NSString *)Warning;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message;
+ (MBProgressHUD *)showActivityMessage:(NSString*)message;


#pragma mark 移除hud
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end

```

文件MBProgressHUD+JJ.m

```

#import "MBProgressHUD+JJ.h"

@implementation MBProgressHUD (JJ)

#pragma mark 显示一条信息
+ (void)showMessage:(NSString *)message toView:(UIView *)view{
    [self show:message icon:nil view:view];
}

#pragma mark 显示带图片或者不带图片的信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 判断是否显示图片
    if (icon == nil) {
        hud.mode = MBProgressHUDModeText;
    }else{
        // 设置图片
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]];
        img = img == nil ? [UIImage imageNamed:icon] : img;
        hud.customView = [[UIImageView alloc] initWithImage:img];
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
    }
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 指定时间之后再消失
    [hud hide:YES afterDelay:kHudShowTime];
}

#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

#pragma mark 显示警告信息
+ (void)showWarning:(NSString *)Warning toView:(UIView *)view{
    [self show:Warning icon:@"warn" view:view];
}

#pragma mark 显示自定义图片信息
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message toView:(UIView *)view{
    [self show:message icon:imageName view:view];
}

#pragma mark 加载中
+ (MBProgressHUD *)showActivityMessage:(NSString*)message view:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 细节文字
    //    hud.detailsLabelText = @"请耐心等待";
    // 再设置模式
    hud.mode = MBProgressHUDModeIndeterminate;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+ (MBProgressHUD *)showProgressBarToView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = @"加载中...";
    return hud;
}



+ (void)showMessage:(NSString *)message{
    [self showMessage:message toView:nil];
}

+ (void)showSuccess:(NSString *)success{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error{
    [self showError:error toView:nil];
}

+ (void)showWarning:(NSString *)Warning{
    [self showWarning:Warning toView:nil];
}

+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message{
    [self showMessageWithImageName:imageName message:message toView:nil];
}

+ (MBProgressHUD *)showActivityMessage:(NSString*)message{
    return [self showActivityMessage:message view:nil];
}




+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD{
    [self hideHUDForView:nil];
}
@end


```


## 如何使用？

将下载下来的工程文件夹内的MBProgressHUD文件夹整个导入工程中

在使用的地方 #import "MBProgressHUD+JJ.h"

现在封装几个功能

### 一、提示普通信息

```
[MBProgressHUD showMessage:@"提示信息：你被包围了！哈哈哈哈！！！"];
```

![弹出提示信息gif](https://upload-images.jianshu.io/upload_images/2541004-1f243e6151fec380.gif?imageMogr2/auto-orient/strip)

## 二、提示带图片的信息

### 错误提示

代码：

```
[MBProgressHUD showError:@"出错了啊！"];
```


![提示错误gif](https://upload-images.jianshu.io/upload_images/2541004-887ed8e603fd6c3b.gif?imageMogr2/auto-orient/strip)

### 成功提示

```
[MBProgressHUD showSuccess:@"成功了！"];
```

![提示成功gif](https://upload-images.jianshu.io/upload_images/2541004-7136b5be54128c11.gif?imageMogr2/auto-orient/strip)


### 警告提示

```
[MBProgressHUD showWarning:@"警告注意!"];
```

![警告提示gif](https://upload-images.jianshu.io/upload_images/2541004-29a13c65a7b738af.gif?imageMogr2/auto-orient/strip)


### 自定义图片文字提示

```
[MBProgressHUD showMessageWithImageName:@"MBHUD_Info" message:@"哈哈哈！"];
```

![自定义图片提示gif](https://upload-images.jianshu.io/upload_images/2541004-afcd89f24a30226f.gif?imageMogr2/auto-orient/strip)


## 三、加载中

```
 MBProgressHUD *hud = [MBProgressHUD showActivityMessage:@"加载中..."];
 [hud hide:YES afterDelay:1.5]; // 1.5秒后移除
```

![加载中gif](https://upload-images.jianshu.io/upload_images/2541004-4258de4eef7ddb94.gif?imageMogr2/auto-orient/strip)




## 四、进度条

```
// 模拟网络请求进度
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
                float progress = 0.0f;
            
                while (progress < 1.0f) {
                    progress += 0.01f;
                    // 主线程刷新进度
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hud.progress = progress;
                    });
                    // 进程挂起50毫秒
                    usleep(50000);
                }
                // 100%后移除
                dispatch_async(dispatch_get_main_queue(), ^{
                    [hud hide:YES];
                });
            });
```

![进度条gif](https://upload-images.jianshu.io/upload_images/2541004-7ecfdb21e34dc369.gif?imageMogr2/auto-orient/strip)

使用详情查看demo



