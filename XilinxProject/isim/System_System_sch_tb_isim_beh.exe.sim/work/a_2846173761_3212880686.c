/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xc3576ebc */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Phillip/Dropbox/workspace/class_projects/MS1553_Interface/XilinxProject/DelayModule.vhd";
extern char *IEEE_P_3620187407;

int ieee_p_3620187407_sub_514432868_3965413181(char *, char *, char *);


static void work_a_2846173761_3212880686_p_0(char *t0)
{
    unsigned char t1;
    unsigned char t2;
    char *t3;
    unsigned char t4;
    char *t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    char *t12;
    int t13;
    int t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(49, ng0);
    t3 = (t0 + 1152U);
    t4 = xsi_signal_has_event(t3);
    if (t4 == 1)
        goto LAB8;

LAB9:    t2 = (unsigned char)0;

LAB10:    if (t2 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    xsi_set_current_line(54, ng0);
    t3 = (t0 + 1672U);
    t5 = *((char **)t3);
    t13 = *((int *)t5);
    t3 = (t0 + 1352U);
    t6 = *((char **)t3);
    t3 = (t0 + 5420U);
    t14 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t6, t3);
    t2 = (t13 == t14);
    if (t2 == 1)
        goto LAB14;

LAB15:    t1 = (unsigned char)0;

LAB16:    if (t1 != 0)
        goto LAB11;

LAB13:    xsi_set_current_line(59, ng0);
    t3 = (t0 + 3296);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t12 = *((char **)t9);
    *((unsigned char *)t12) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t3);

LAB12:    t3 = (t0 + 3152);
    *((int *)t3) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(51, ng0);
    t5 = (t0 + 1672U);
    t12 = *((char **)t5);
    t13 = *((int *)t12);
    t14 = (t13 + 1);
    t5 = (t0 + 3232);
    t15 = (t5 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    *((int *)t18) = t14;
    xsi_driver_first_trans_fast(t5);
    goto LAB3;

LAB5:    t5 = (t0 + 1032U);
    t9 = *((char **)t5);
    t10 = *((unsigned char *)t9);
    t11 = (t10 == (unsigned char)3);
    t1 = t11;
    goto LAB7;

LAB8:    t5 = (t0 + 1192U);
    t6 = *((char **)t5);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)3);
    t2 = t8;
    goto LAB10;

LAB11:    xsi_set_current_line(56, ng0);
    t9 = (t0 + 3232);
    t15 = (t9 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    *((int *)t18) = 0;
    xsi_driver_first_trans_fast(t9);
    xsi_set_current_line(57, ng0);
    t3 = (t0 + 3296);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t12 = *((char **)t9);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t3);
    goto LAB12;

LAB14:    t9 = (t0 + 1032U);
    t12 = *((char **)t9);
    t4 = *((unsigned char *)t12);
    t7 = (t4 == (unsigned char)3);
    t1 = t7;
    goto LAB16;

}


extern void work_a_2846173761_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2846173761_3212880686_p_0};
	xsi_register_didat("work_a_2846173761_3212880686", "isim/System_System_sch_tb_isim_beh.exe.sim/work/a_2846173761_3212880686.didat");
	xsi_register_executes(pe);
}
