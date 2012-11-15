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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *STD_TEXTIO;
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;
char *WORK_P_1228529659;
char *IEEE_P_1242562249;
char *UNISIM_P_0947159679;
char *IEEE_P_3564397177;
char *IEEE_P_2717149903;
char *IEEE_P_0774719531;
char *IEEE_P_1367372525;
char *UNISIM_P_3222816464;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_1242562249_init();
    unisim_p_0947159679_init();
    std_textio_init();
    ieee_p_2717149903_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    work_p_1228529659_init();
    work_a_1810882423_2372691052_init();
    work_a_3016449275_3212880686_init();
    work_a_2846173761_3212880686_init();
    work_a_1534282125_3212880686_init();
    work_a_3193845079_3212880686_init();
    work_a_2707128786_3212880686_init();
    work_a_2556186760_3212880686_init();
    work_a_0020357321_3212880686_init();
    work_a_0986959968_3212880686_init();
    work_a_0959457293_3212880686_init();
    work_a_1665695642_3212880686_init();
    work_a_3403327909_3212880686_init();
    ieee_p_3564397177_init();
    xilinxcorelib_a_0018893529_2959432447_init();
    xilinxcorelib_a_1177795618_2959432447_init();
    xilinxcorelib_a_1141304898_1709443946_init();
    xilinxcorelib_a_1262589035_0543512595_init();
    xilinxcorelib_a_2618323792_3212880686_init();
    work_a_3392787015_1930238488_init();
    unisim_a_2562466605_1496654361_init();
    unisim_a_1717296735_4086321779_init();
    work_a_4194340009_3212880686_init();
    work_a_3753591889_3212880686_init();
    unisim_a_3055263662_1392679692_init();
    work_a_4063098913_3212880686_init();
    work_a_3418682571_3212880686_init();
    work_a_4287484579_3212880686_init();
    work_a_2960981376_3212880686_init();
    unisim_a_1525108159_2393828108_init();
    ieee_p_0774719531_init();
    ieee_p_1367372525_init();
    unisim_p_3222816464_init();
    unisim_a_4160231357_3824467259_init();
    unisim_a_3207408508_2930107152_init();
    unisim_a_1302239101_1532504268_init();
    unisim_a_1490675510_1976025627_init();
    work_a_0213060440_0912031422_init();
    work_a_0353193995_3212880686_init();
    unisim_a_1478392591_3979135294_init();
    work_a_1554642963_3212880686_init();


    xsi_register_tops("work_a_1554642963_3212880686");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    WORK_P_1228529659 = xsi_get_engine_memory("work_p_1228529659");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    UNISIM_P_0947159679 = xsi_get_engine_memory("unisim_p_0947159679");
    IEEE_P_3564397177 = xsi_get_engine_memory("ieee_p_3564397177");
    IEEE_P_2717149903 = xsi_get_engine_memory("ieee_p_2717149903");
    IEEE_P_0774719531 = xsi_get_engine_memory("ieee_p_0774719531");
    IEEE_P_1367372525 = xsi_get_engine_memory("ieee_p_1367372525");
    UNISIM_P_3222816464 = xsi_get_engine_memory("unisim_p_3222816464");

    return xsi_run_simulation(argc, argv);

}
