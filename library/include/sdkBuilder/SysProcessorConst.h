//
//  SysProcessorConst.h
//  RainbowChat4i
//
//  Created by JackJiang on 17/3/8.
//  Copyright © 2017年 JackJiang. All rights reserved.
//

/**
 * <p>
 * EVA.EPC框架之预定义系统保留的processor_id常量表.<br>
 * 它们对应于系统级的processor的id.<br>
 * 注：1000以内的processor_id用作系统保留，自定义的processor_id只能使用1000以外的，使用
 * 时推荐继承本常量表后再自定义自已的常量。
 * </p>
 *
 * @author Jack Jiang, 2017-03-08
 * @version 1.0
 */

#ifndef SysProcessorConst_h
#define SysProcessorConst_h


#endif /* SysProcessorConst_h */


/** 系统登陆 */
#define PROCESSSOR_LOGIN   -1
/** 退出登陆 */
#define PROCESSSOR_LOGOUT  -2

/** 系统一些默认功能的处理器id *///就是以前的PROCESSSOR_FRAME
#define PROCESSSOR_FW_BASE  0//0xf423f;
#define PROCESSSOR_AUTH     1//1001;
#define PROCESSSOR_OA       2//2001;
#define PROCESSSOR_NOTICE   3//9001;
/** 文件管理 */
#define PROCESSSOR_DOC      4//1003;
/** 工作流管理 */
#define PROCESSSOR_WORKFLOW 5
