/* wmi__host_cmd_dispatch @ 0x8de43c, 3136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ---->> [HOST CMD] WMI_NEW_STA_CMDID
 *   ---->> [HOST CMD] WMI_ESE_CFG_CMDID
 *   ---->> [HOST CMD] WMI_SET_MULTI_DIRECTED_OMNIS_CONFIG_CMD
 *   ---->> [HOST CMD] WMI_SET_PASSPHRASE_CMDID
 *   ---->> [HOST CMD] WMI_PMC_CMDID
 *   ---->> [HOST CMD] WMI_ECHO_CMDID
 *   ---->> [HOST CMD] WMI_RF_PWR_ON_DELAY_CMDID
 *   ---->> [HOST CMD] WMI_SET_HIGH_POWER_TABLE_PARAMS_CMDID
 * Зовёт сам: POWER_MNGR__wmi_ps_dev_profile_cfg_cmd, POWER_MNGR__wmi_traffic_deferral_cmd, __st_r17_to_r13, beacon_interval, boot__clear_object_48, boot__clear_object_tail, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, host_if__bf_ctrl_hal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi__host_cmd_dispatch
wmi__host_cmd_dispatch:
	.global L_8de43c
L_8de43c:
	push_s blink
L_8de43e:
	bl L_8c01d8
L_8de442:
	sub_s sp,sp,0x8
L_8de444:
	mov_s r15,r0
L_8de446:
	ldw_s r0,[r1,0x6]
L_8de448:
	ldb_s r14,[r1,0x8]
L_8de44a:
	mov_s r16,r1
L_8de44c:
	add r13,r1,0x10
L_8de450:
	bbit1 r0,0x1,L_8de476
	.global L_8de454
L_8de454:
	ldw r0,[r16, 0x6]
L_8de458:
	bbit1 r0,0x2,L_8de482
	.global L_8de45c
L_8de45c:
	bl.d L_8da5a4
L_8de460:
	mov r17,0x0
L_8de464:
	brne_s r0,0,L_8de472
L_8de466:
	ldw r0,[r16, 0xa]
L_8de46a:
	breq r0,0x1,L_8de48e
L_8de46e:
	breq r0,0x7,L_8de498
	.global L_8de472
L_8de472:
	mov_s r0,r17
L_8de474:
	b_s L_8de4a0
	.global L_8de476
L_8de476:
	mov_s r0,blink
L_8de478:
	mov_s r1,0x36
L_8de47a:
	bl.d L_8c9b28
L_8de47e:
	bset_s r1,r1,0xc
L_8de480:
	b_s L_8de454
	.global L_8de482
L_8de482:
	mov_s r0,blink
L_8de484:
	mov_s r1,0x37
L_8de486:
	bl.d L_8c9b28
L_8de48a:
	bset_s r1,r1,0xc
L_8de48c:
	b_s L_8de45c
	.global L_8de48e
L_8de48e:
	mov_s r0,r13
L_8de490:
	bl.d L_8ec484
L_8de494:
	mov_s r1,r14
L_8de496:
	b_s L_8de49e
	.global L_8de498
L_8de498:
	bl.d L_8ecb94
L_8de49c:
	mov_s r0,r14
	.global L_8de49e
L_8de49e:
	mov_s r0,0x1
	.global L_8de4a0
L_8de4a0:
	cmp_s r0,0x0
L_8de4a2:
	bne L_8df070
L_8de4a6:
	ldw r1,[r16, 0xa]
L_8de4aa:
	cmp_s r1,0x913
L_8de4b0:
	beq L_8de918
L_8de4b4:
	bgt L_8de5a8
L_8de4b8:
	cmp_s r1,0x82a
L_8de4be:
	beq L_8dea8a
L_8de4c2:
	bgt L_8de520
L_8de4c6:
	cmp_s r1,0x804
L_8de4cc:
	beq L_8de856
L_8de4d0:
	bgt L_8de502
L_8de4d4:
	cmp_s r1,0x803
L_8de4da:
	beq L_8de7b0
L_8de4de:
	cmp_s r1,0x42
L_8de4e0:
	beq L_8decac
L_8de4e4:
	cmp_s r1,0x3f
L_8de4e6:
	beq L_8dec94
L_8de4ea:
	sub_s r2,r1,0x1
L_8de4ec:
	cmp_s r2,0x16
L_8de4ee:
	bhi L_8df066
L_8de4f2:
	ldw.x.as r2,[0x802064,r2]
L_8de4fa:
	add r0,pcl,0xa
L_8de4fe:
	add1_s r0,r0,r2
L_8de500:
	j_s [r0]
	.global L_8de502
L_8de502:
	sub r2,r1,0x808
L_8de50a:
	cmp_s r2,0x21
L_8de50c:
	bhi L_8df066
L_8de510:
	ldw.x.as r2,[0x802094,r2]
L_8de518:
	add r0,pcl,0x8
L_8de51c:
	add1_s r0,r0,r2
L_8de51e:
	j_s [r0]
	.global L_8de520
L_8de520:
	cmp_s r1,0x85e
L_8de526:
	beq L_8de7e4
L_8de52a:
	bgt L_8de556
L_8de52e:
	cmp_s r1,0x82b
L_8de534:
	beq L_8ded0e
L_8de538:
	sub r2,r1,0x835
L_8de540:
	cmp_s r2,0x28
L_8de542:
	bhi L_8df066
L_8de546:
	ldw.x.as r2,[0x8020d8,r2]
L_8de54e:
	add r0,pcl,0xa
L_8de552:
	add1_s r0,r0,r2
L_8de554:
	j_s [r0]
	.global L_8de556
L_8de556:
	cmp_s r1,0x867
L_8de55c:
	beq L_8dec6e
L_8de560:
	bgt_s L_8de580
L_8de562:
	sub r2,r1,0x85f
L_8de56a:
	cmp_s r2,0x7
L_8de56c:
	bhi L_8df066
L_8de570:
	ldw.x.as r2,[0x80212c,r2]
L_8de578:
	add r0,pcl,0x8
L_8de57c:
	add1_s r0,r0,r2
L_8de57e:
	j_s [r0]
	.global L_8de580
L_8de580:
	cmp_s r1,0x868
L_8de586:
	beq L_8deea0
L_8de58a:
	sub r2,r1,0x900
L_8de592:
	cmp_s r2,0x11
L_8de594:
	bhi L_8df066
L_8de598:
	ldw.x.as r2,[0x80213c,r2]
L_8de5a0:
	add r0,pcl,0x8
L_8de5a4:
	add1_s r0,r0,r2
L_8de5a6:
	j_s [r0]
	.global L_8de5a8
L_8de5a8:
	cmp_s r1,0x9a0
L_8de5ae:
	beq L_8def16
L_8de5b2:
	bgt L_8de670
L_8de5b6:
	cmp_s r1,0x930
L_8de5bc:
	beq L_8dedbe
L_8de5c0:
	bgt L_8de5e2
L_8de5c4:
	sub r2,r1,0x914
L_8de5cc:
	cmp_s r2,0x10
L_8de5ce:
	bhi L_8df066
L_8de5d2:
	ldw.x.as r2,[0x802160,r2]
L_8de5da:
	add r0,pcl,0xa
L_8de5de:
	add1_s r0,r0,r2
L_8de5e0:
	j_s [r0]
	.global L_8de5e2
L_8de5e2:
	cmp_s r1,0x992
L_8de5e8:
	beq L_8deb9c
L_8de5ec:
	bgt L_8de652
L_8de5f0:
	cmp_s r1,0x936
L_8de5f6:
	beq L_8dedf0
L_8de5fa:
	bgt_s L_8de62a
L_8de5fc:
	cmp_s r1,0x931
L_8de602:
	beq L_8dedd8
L_8de606:
	cmp_s r1,0x935
L_8de60c:
	bne L_8df066
L_8de610:
	mov_s r1,0x1006998
L_8de616:
	bl.d L_8dcba8
L_8de61a:
	mov_s r0,0x20
L_8de61c:
	mov_s r0,r13
L_8de61e:
	mov_s r1,r14
L_8de620:
	bl.d L_8ec2b8
L_8de624:
	mov_s r2,r15
L_8de626:
	b L_8df070
	.global L_8de62a
L_8de62a:
	cmp_s r1,0x960
L_8de630:
	beq L_8dee24
L_8de634:
	cmp_s r1,0x991
L_8de63a:
	bne L_8df066
L_8de63e:
	mov_s r1,sp
L_8de640:
	mov_s r0,0x0
L_8de642:
	bl.d L_8e9900
L_8de646:
	mov_s r2,r0
L_8de648:
	bl.d L_8e9620
L_8de64c:
	mov_s r0,r13
L_8de64e:
	b L_8df070
	.global L_8de652
L_8de652:
	sub r2,r1,0x993
L_8de65a:
	cmp_s r2,0x5
L_8de65c:
	bhi L_8df066
L_8de660:
	ldw.x.as r2,[0x802184,r2]
L_8de668:
	add r0,pcl,0x8
L_8de66c:
	add1_s r0,r0,r2
L_8de66e:
	j_s [r0]
	.global L_8de670
L_8de670:
	cmp_s r1,0xa05
L_8de676:
	beq L_8dee88
L_8de67a:
	bgt L_8de71a
L_8de67e:
	cmp_s r1,0x9a6
L_8de684:
	beq L_8dee54
L_8de688:
	bgt_s L_8de6a8
L_8de68a:
	sub r2,r1,0x9a1
L_8de692:
	cmp_s r2,0x4
L_8de694:
	bhi L_8df066
L_8de698:
	ldw.x.as r2,[0x802190,r2]
L_8de6a0:
	add r0,pcl,0x8
L_8de6a4:
	add1_s r0,r0,r2
L_8de6a6:
	j_s [r0]
	.global L_8de6a8
L_8de6a8:
	cmp_s r1,0x9a7
L_8de6ae:
	beq L_8dee6e
L_8de6b2:
	cmp_s r1,0xa02
L_8de6b8:
	beq L_8deeb8
L_8de6bc:
	bgt_s L_8de6ec
L_8de6be:
	cmp_s r1,0x9aa
L_8de6c4:
	beq L_8df004
L_8de6c8:
	cmp_s r1,0xa01
L_8de6ce:
	bne L_8df066
L_8de6d2:
	mov_s r1,0x10069bc
L_8de6d8:
	bl.d L_8dcba8
L_8de6dc:
	mov_s r0,0x20
L_8de6de:
	mov_s r0,r13
L_8de6e0:
	mov_s r1,r14
L_8de6e2:
	bl.d L_8fbb20
L_8de6e6:
	mov_s r2,r15
L_8de6e8:
	b L_8df070
	.global L_8de6ec
L_8de6ec:
	cmp_s r1,0xa03
L_8de6f2:
	beq L_8deee8
L_8de6f6:
	cmp_s r1,0xa04
L_8de6fc:
	bne L_8df066
L_8de700:
	mov_s r1,0x10069e0
L_8de706:
	bl.d L_8dcba8
L_8de70a:
	mov_s r0,0x20
L_8de70c:
	mov_s r0,r15
L_8de70e:
	mov_s r1,r13
L_8de710:
	bl.d L_8ece20
L_8de714:
	mov_s r2,r14
L_8de716:
	b L_8df070
	.global L_8de71a
L_8de71a:
	cmp_s r1,0xfff
L_8de720:
	beq L_8df05e
L_8de724:
	bgt_s L_8de744
L_8de726:
	sub r2,r1,0xa06
L_8de72e:
	cmp_s r2,0x9
L_8de730:
	bhi L_8df066
L_8de734:
	ldw.x.as r2,[0x80219c,r2]
L_8de73c:
	add r0,pcl,0x8
L_8de740:
	add1_s r0,r0,r2
L_8de742:
	j_s [r0]
	.global L_8de744
L_8de744:
	cmp_s r1,0xf003
L_8de74a:
	beq L_8dea2c
L_8de74e:
	cmp_s r1,0xf04d
L_8de754:
	beq L_8dec26
L_8de758:
	bgt_s L_8de786
L_8de75a:
	cmp_s r1,0xf007
L_8de760:
	beq L_8deaa2
L_8de764:
	cmp_s r1,0xf049
L_8de76a:
	bne L_8df066
L_8de76e:
	mov_s r1,0x1006a1c
L_8de774:
	bl.d L_8dcba8
L_8de778:
	mov_s r0,0x20
L_8de77a:
	mov_s r0,r13
L_8de77c:
	bl.d L_8ece64
L_8de780:
	mov_s r1,r14
L_8de782:
	b L_8df070
	.global L_8de786
L_8de786:
	cmp_s r1,0xf04e
L_8de78c:
	beq L_8dec3e
L_8de790:
	cmp_s r1,0xf04f
L_8de796:
	bne L_8df066
L_8de79a:
	mov_s r1,0x1006a48
L_8de7a0:
	bl.d L_8dcba8
L_8de7a4:
	mov_s r0,0x20
L_8de7a6:
	bl.d L_8fb738
L_8de7aa:
	mov_s r0,r13
L_8de7ac:
	b L_8df070
	.global L_8de7b0
L_8de7b0:
	mov_s r1,0x1006a68
L_8de7b6:
	bl.d L_8dcba8
L_8de7ba:
	mov_s r0,0x20
L_8de7bc:
	ld_s r1,[r13]
L_8de7be:
	mov_s r0,r15
L_8de7c0:
	bl.d L_8e5418
L_8de7c4:
	mov_s r2,r14
L_8de7c6:
	b L_8df070
L_8de7ca:
	mov_s r1,0x1006a8c
L_8de7d0:
	bl.d L_8dcba8
L_8de7d4:
	mov_s r0,0x20
L_8de7d6:
	mov_s r0,r15
L_8de7d8:
	mov_s r1,r13
L_8de7da:
	bl.d L_8e6e40
L_8de7de:
	mov_s r2,r14
L_8de7e0:
	b L_8df070
	.global L_8de7e4
L_8de7e4:
	mov_s r1,0x1006ab8
L_8de7ea:
	bl.d L_8dcba8
L_8de7ee:
	mov_s r0,0x20
L_8de7f0:
	mov_s r0,r13
L_8de7f2:
	mov_s r1,r14
L_8de7f4:
	bl.d L_8ec3f0
L_8de7f8:
	mov_s r2,r15
L_8de7fa:
	b L_8df070
L_8de7fe:
	mov_s r1,0x1006af0
L_8de804:
	bl.d L_8dcba8
L_8de808:
	mov_s r0,0x20
L_8de80a:
	mov_s r0,r15
L_8de80c:
	bl.d L_8e363c
L_8de810:
	mov_s r1,r13
L_8de812:
	b L_8df070
L_8de816:
	mov_s r1,0x1006b18
L_8de81c:
	bl.d L_8dcba8
L_8de820:
	mov_s r0,0x20
L_8de822:
	mov_s r0,r15
L_8de824:
	bl.d L_8e36cc
L_8de828:
	mov_s r1,r13
L_8de82a:
	b L_8df070
L_8de82e:
	mov_s r1,0x1006b44
L_8de834:
	mov_s r0,0x20
L_8de836:
	bl.d L_8dcc10
L_8de83a:
	ld.as r2,[gp,-0x2d]
L_8de83e:
	mov_s r0,r13
L_8de840:
	bl.d L_8ecb1c
L_8de844:
	mov_s r1,r14
L_8de846:
	b L_8df070
L_8de84a:
	mov_s r0,r15
L_8de84c:
	bl.d L_8e909c
L_8de850:
	mov_s r1,r13
L_8de852:
	b L_8df070
	.global L_8de856
L_8de856:
	mov_s r1,0x1006b70
L_8de85c:
	bl.d L_8dcba8
L_8de860:
	mov_s r0,0x20
L_8de862:
	mov_s r0,r15
L_8de864:
	bl.d L_8c87a4
L_8de868:
	ld_s r1,[r13]
L_8de86a:
	b L_8df070
L_8de86e:
	mov_s r1,0x1006b98
L_8de874:
	bl.d L_8dcba8
L_8de878:
	mov_s r0,0x20
L_8de87a:
	mov_s r0,r13
L_8de87c:
	bl.d L_8e55ac
L_8de880:
	mov_s r1,r14
L_8de882:
	b L_8df070
L_8de886:
	mov_s r1,0x1006bc8
L_8de88c:
	bl.d L_8dcba8
L_8de890:
	mov_s r0,0x20
L_8de892:
	mov_s r0,r13
L_8de894:
	bl.d L_8fb7fc
L_8de898:
	mov_s r1,r14
L_8de89a:
	b L_8df070
L_8de89e:
	mov_s r1,0x1006bf4
L_8de8a4:
	bl.d L_8dcba8
L_8de8a8:
	mov_s r0,0x20
L_8de8aa:
	bl.d L_8ec4ec
L_8de8ae:
	mov_s r0,r14
L_8de8b0:
	b L_8df070
L_8de8b4:
	mov_s r1,0x1006c1c
L_8de8ba:
	bl.d L_8dcba8
L_8de8be:
	mov_s r0,0x20
L_8de8c0:
	mov_s r0,r13
L_8de8c2:
	bl.d L_8ec4f4
L_8de8c6:
	mov_s r1,r14
L_8de8c8:
	b L_8df070
L_8de8cc:
	mov_s r1,0x1006c48
L_8de8d2:
	mov_s r0,0x20
L_8de8d4:
	bl.d L_8dcc10
L_8de8d8:
	ld.as r2,[gp,-0x2e]
L_8de8dc:
	mov_s r0,r13
L_8de8de:
	bl.d L_8ec434
L_8de8e2:
	mov_s r1,r14
L_8de8e4:
	b L_8df070
L_8de8e8:
	mov_s r1,0x1006c6c
L_8de8ee:
	bl.d L_8dcba8
L_8de8f2:
	mov_s r0,0x20
L_8de8f4:
	mov_s r0,r13
L_8de8f6:
	bl.d L_8fc198
L_8de8fa:
	mov_s r1,r14
L_8de8fc:
	b L_8df070
L_8de900:
	mov_s r1,0x1006c94
L_8de906:
	bl.d L_8dcba8
L_8de90a:
	mov_s r0,0x20
L_8de90c:
	mov_s r0,r13
L_8de90e:
	bl.d L_8fb4e0
L_8de912:
	mov_s r1,r14
L_8de914:
	b L_8df070
	.global L_8de918
L_8de918:
	mov_s r1,0x1006cc0
L_8de91e:
	bl.d L_8dcba8
L_8de922:
	mov_s r0,0x20
L_8de924:
	mov_s r0,r13
L_8de926:
	bl.d L_8ec358
L_8de92a:
	mov_s r1,r14
L_8de92c:
	b L_8df070
L_8de930:
	mov_s r1,0x1006cec
L_8de936:
	bl.d L_8dcba8
L_8de93a:
	mov_s r0,0x20
L_8de93c:
	bl.d L_8ec3e4
L_8de940:
	mov_s r0,r14
L_8de942:
	b L_8df070
L_8de946:
	mov_s r1,0x1006d18
L_8de94c:
	bl.d L_8dcba8
L_8de950:
	mov_s r0,0x20
L_8de952:
	bl.d L_8ec3e8
L_8de956:
	mov_s r0,r14
L_8de958:
	b L_8df070
L_8de95c:
	mov_s r1,0x1006d44
L_8de962:
	bl.d L_8dcba8
L_8de966:
	mov_s r0,0x20
L_8de968:
	bl.d L_8ec3e0
L_8de96c:
	mov_s r0,r14
L_8de96e:
	b L_8df070
L_8de972:
	mov_s r1,0x1006d70
L_8de978:
	bl.d L_8dcba8
L_8de97c:
	mov_s r0,0x20
L_8de97e:
	bl.d L_8ec3ec
L_8de982:
	mov_s r0,r14
L_8de984:
	b L_8df070
L_8de988:
	mov_s r1,0x1006d9c
L_8de98e:
	bl.d L_8dcba8
L_8de992:
	mov_s r0,0x20
L_8de994:
	mov_s r0,r13
L_8de996:
	bl.d L_8ec34c
L_8de99a:
	mov_s r1,r14
L_8de99c:
	b L_8df070
L_8de9a0:
	mov_s r1,0x1006dc0
L_8de9a6:
	bl.d L_8dcba8
L_8de9aa:
	mov_s r0,0x20
L_8de9ac:
	bl.d L_8fb77c
L_8de9b0:
	mov_s r0,r13
L_8de9b2:
	b L_8df070
L_8de9b6:
	mov_s r1,0x1006dec
L_8de9bc:
	bl.d L_8dcba8
L_8de9c0:
	mov_s r0,0x20
L_8de9c2:
	bl.d L_8fb648
L_8de9c6:
	mov_s r0,r14
L_8de9c8:
	b L_8df070
L_8de9cc:
	mov_s r1,0x1006e18
L_8de9d2:
	bl.d L_8dcba8
L_8de9d6:
	mov_s r0,0x20
L_8de9d8:
	mov_s r0,r13
L_8de9da:
	bl.d L_8fb4b4
L_8de9de:
	mov_s r1,r14
L_8de9e0:
	b L_8df070
L_8de9e4:
	mov_s r1,0x1006e40
L_8de9ea:
	bl.d L_8dcba8
L_8de9ee:
	mov_s r0,0x20
L_8de9f0:
	mov_s r0,r13
L_8de9f2:
	bl.d L_8fb490
L_8de9f6:
	mov_s r1,r14
L_8de9f8:
	b L_8df070
L_8de9fc:
	mov_s r1,0x1006e6c
L_8dea02:
	bl.d L_8dcba8
L_8dea06:
	mov_s r0,0x20
L_8dea08:
	mov_s r0,r13
L_8dea0a:
	bl.d L_8ecbe8
L_8dea0e:
	mov_s r1,r14
L_8dea10:
	b L_8df070
L_8dea14:
	mov_s r1,0x1006e98
L_8dea1a:
	bl.d L_8dcba8
L_8dea1e:
	mov_s r0,0x20
L_8dea20:
	mov_s r0,r13
L_8dea22:
	bl.d L_8ecd1c
L_8dea26:
	mov_s r1,r14
L_8dea28:
	b L_8df070
	.global L_8dea2c
L_8dea2c:
	mov_s r1,0x1006ec0
L_8dea32:
	bl.d L_8dcba8
L_8dea36:
	mov_s r0,0x20
L_8dea38:
	mov_s r0,r13
L_8dea3a:
	bl.d L_8ece1c
L_8dea3e:
	mov_s r1,r14
L_8dea40:
	b L_8df070
L_8dea44:
	mov_s r1,0x1006eec
L_8dea4a:
	bl.d L_8dcba8
L_8dea4e:
	mov_s r0,0x20
L_8dea50:
	mov_s r0,r13
L_8dea52:
	bl.d L_8fbcec
L_8dea56:
	mov_s r1,r14
L_8dea58:
	b L_8df070
L_8dea5c:
	mov_s r1,0x1006f14
L_8dea62:
	bl.d L_8dcba8
L_8dea66:
	mov_s r0,0x20
L_8dea68:
	mov_s r0,r14
L_8dea6a:
	bl.d L_8ec264
L_8dea6e:
	mov_s r1,r15
L_8dea70:
	b L_8df070
L_8dea74:
	mov_s r1,0x1006f3c
L_8dea7a:
	bl.d L_8dcba8
L_8dea7e:
	mov_s r0,0x20
L_8dea80:
	bl.d L_8fbcc4
L_8dea84:
	mov_s r0,r13
L_8dea86:
	b L_8df070
	.global L_8dea8a
L_8dea8a:
	mov_s r1,0x1006f68
L_8dea90:
	bl.d L_8dcba8
L_8dea94:
	mov_s r0,0x20
L_8dea96:
	mov_s r0,r14
L_8dea98:
	bl.d L_8fb5ec
L_8dea9c:
	mov_s r1,r15
L_8dea9e:
	b L_8df070
	.global L_8deaa2
L_8deaa2:
	mov_s r1,0x1006f94
L_8deaa8:
	bl.d L_8dcba8
L_8deaac:
	mov_s r0,0x20
L_8deaae:
	bl.d L_8eca3c
L_8deab2:
	mov_s r0,r14
L_8deab4:
	b L_8df070
L_8deab8:
	mov_s r1,0x1006fbc
L_8deabe:
	bl.d L_8dcba8
L_8deac2:
	mov_s r0,0x20
L_8deac4:
	mov_s r0,r13
L_8deac6:
	bl.d L_8ec840
L_8deaca:
	mov_s r1,r14
L_8deacc:
	b L_8df070
L_8dead0:
	mov_s r1,0x1006fe4
L_8dead6:
	bl.d L_8dcba8
L_8deada:
	mov_s r0,0x20
L_8deadc:
	mov_s r0,r13
L_8deade:
	bl.d L_8ec91c
L_8deae2:
	mov_s r1,r14
L_8deae4:
	b L_8df070
L_8deae8:
	mov_s r1,0x100700c
L_8deaee:
	bl.d L_8dcba8
L_8deaf2:
	mov_s r0,0x20
L_8deaf4:
	bl.d L_8f7160
L_8deaf8:
	mov_s r0,r14
L_8deafa:
	b L_8df070
L_8deafe:
	mov_s r1,0x1007034
L_8deb04:
	bl.d L_8dcba8
L_8deb08:
	mov_s r0,0x20
L_8deb0a:
	mov_s r0,r13
L_8deb0c:
	bl.d L_8fc11c
L_8deb10:
	mov_s r1,r14
L_8deb12:
	b L_8df070
L_8deb16:
	mov_s r1,0x1007058
L_8deb1c:
	bl.d L_8dcba8
L_8deb20:
	mov_s r0,0x20
L_8deb22:
	mov_s r0,r15
L_8deb24:
	mov_s r1,r13
L_8deb26:
	bl.d L_8dcfa8
L_8deb2a:
	mov_s r2,r14
L_8deb2c:
	b L_8df070
L_8deb30:
	mov_s r1,0x1007088
L_8deb36:
	bl.d L_8dcba8
L_8deb3a:
	mov_s r0,0x20
L_8deb3c:
	mov_s r0,r13
L_8deb3e:
	bl.d L_8fbf7c
L_8deb42:
	mov_s r1,r14
L_8deb44:
	b L_8df070
L_8deb48:
	mov_s r1,0x10070b4
L_8deb4e:
	bl.d L_8dcba8
L_8deb52:
	mov_s r0,0x20
L_8deb54:
	mov_s r0,r13
L_8deb56:
	bl.d L_8ec4bc
L_8deb5a:
	mov_s r1,r14
L_8deb5c:
	b L_8df070
L_8deb60:
	mov_s r0,r15
L_8deb62:
	bl.d L_8dd64c
L_8deb66:
	mov_s r1,r13
L_8deb68:
	b L_8df070
L_8deb6c:
	mov_s r0,r15
L_8deb6e:
	mov_s r1,r13
L_8deb70:
	bl.d L_8dd028
L_8deb74:
	mov_s r2,r14
L_8deb76:
	b L_8df070
L_8deb7a:
	mov_s r0,r15
L_8deb7c:
	bl.d L_8dd4b8
L_8deb80:
	mov_s r1,r13
L_8deb82:
	b L_8df070
L_8deb86:
	mov_s r1,0x10070e4
L_8deb8c:
	bl.d L_8dcba8
L_8deb90:
	mov_s r0,0x20
L_8deb92:
	bl.d L_8e9580
L_8deb96:
	mov_s r0,r13
L_8deb98:
	b L_8df070
	.global L_8deb9c
L_8deb9c:
	mov_s r1,0x100710c
L_8deba2:
	bl.d L_8dcba8
L_8deba6:
	mov_s r0,0x20
L_8deba8:
	bl.d L_8e975c
L_8debac:
	mov_s r0,r13
L_8debae:
	b L_8df070
L_8debb2:
	mov_s r1,0x1007140
L_8debb8:
	bl.d L_8dcba8
L_8debbc:
	mov_s r0,0x20
L_8debbe:
	bl.d L_8e95fc
L_8debc2:
	mov_s r0,r13
L_8debc4:
	b L_8df070
L_8debc8:
	mov_s r1,0x1007170
	.global L_8debce
L_8debce:
	bl.d L_8dcba8
L_8debd2:
	mov_s r0,0x20
L_8debd4:
	b L_8df070
L_8debd8:
	mov_s r1,0x1007198
L_8debde:
	b_s L_8debce
L_8debe0:
	mov_s r1,0x10071c0
L_8debe6:
	b_s L_8debce
L_8debe8:
	mov_s r1,0x10071f0
L_8debee:
	bl.d L_8dcba8
L_8debf2:
	mov_s r0,0x20
L_8debf4:
	mov_s r0,r15
L_8debf6:
	mov_s r1,r13
L_8debf8:
	bl.d L_8e71a8
L_8debfc:
	mov_s r2,r14
L_8debfe:
	b L_8df070
L_8dec02:
	mov_s r1,0x1007224
L_8dec08:
	bl.d L_8dcba8
L_8dec0c:
	mov_s r0,0x20
L_8dec0e:
	mov_s r0,r15
L_8dec10:
	bl.d L_8ccf7c
L_8dec14:
	mov_s r1,r14
L_8dec16:
	b L_8df070
L_8dec1a:
	mov_s r0,r15
L_8dec1c:
	bl.d L_8ed038
L_8dec20:
	mov_s r1,r13
L_8dec22:
	b L_8df070
	.global L_8dec26
L_8dec26:
	mov_s r1,0x1007258
L_8dec2c:
	bl.d L_8dcba8
L_8dec30:
	mov_s r0,0x20
L_8dec32:
	mov_s r0,r14
L_8dec34:
	bl.d L_8ec724
L_8dec38:
	mov_s r1,r15
L_8dec3a:
	b L_8df070
	.global L_8dec3e
L_8dec3e:
	mov_s r1,0x1007284
L_8dec44:
	bl.d L_8dcba8
L_8dec48:
	mov_s r0,0x20
L_8dec4a:
	mov_s r0,r15
L_8dec4c:
	bl.d L_8dd130
L_8dec50:
	mov_s r1,r14
L_8dec52:
	b L_8df070
L_8dec56:
	mov_s r1,0x10072a8
L_8dec5c:
	bl.d L_8dcba8
L_8dec60:
	mov_s r0,0x20
L_8dec62:
	mov_s r0,r15
L_8dec64:
	bl.d L_8dd3c8
L_8dec68:
	mov_s r1,r14
L_8dec6a:
	b L_8df070
	.global L_8dec6e
L_8dec6e:
	mov_s r1,0x10072d4
L_8dec74:
	bl.d L_8dcba8
L_8dec78:
	mov_s r0,0x20
L_8dec7a:
	mov_s r0,r15
L_8dec7c:
	bl.d L_8dd29c
L_8dec80:
	mov_s r1,r14
L_8dec82:
	b L_8df070
L_8dec86:
	mov_s r0,r15
L_8dec88:
	mov_s r1,r13
L_8dec8a:
	bl.d L_8cccbc
L_8dec8e:
	mov_s r2,r14
L_8dec90:
	b L_8df070
	.global L_8dec94
L_8dec94:
	mov_s r1,0x1007304
L_8dec9a:
	bl.d L_8dcba8
L_8dec9e:
	mov_s r0,0x20
L_8deca0:
	mov_s r0,r13
L_8deca2:
	bl.d L_8ecdc8
L_8deca6:
	mov_s r1,r14
L_8deca8:
	b L_8df070
	.global L_8decac
L_8decac:
	mov_s r1,0x100732c
L_8decb2:
	bl.d L_8dcba8
L_8decb6:
	mov_s r0,0x20
L_8decb8:
	mov_s r0,r13
L_8decba:
	bl.d L_8ec9d0
L_8decbe:
	mov_s r1,r14
L_8decc0:
	b L_8df070
L_8decc4:
	mov_s r1,0x1007358
L_8decca:
	bl.d L_8dcba8
L_8decce:
	mov_s r0,0x20
L_8decd0:
	bl.d L_8ec9e8
L_8decd4:
	mov_s r0,r13
L_8decd6:
	b L_8df070
L_8decda:
	mov_s r1,0x100737c
L_8dece0:
	bl.d L_8dcba8
L_8dece4:
	mov_s r0,0x20
L_8dece6:
	mov_s r0,r15
L_8dece8:
	mov_s r1,r13
L_8decea:
	bl.d L_8dd528
L_8decee:
	mov_s r2,r14
L_8decf0:
	b L_8df070
L_8decf4:
	mov_s r1,0x10073a0
L_8decfa:
	bl.d L_8dcba8
L_8decfe:
	mov_s r0,0x20
L_8ded00:
	mov_s r0,r15
L_8ded02:
	mov_s r1,r13
L_8ded04:
	bl.d L_8dd068
L_8ded08:
	mov_s r2,r14
L_8ded0a:
	b L_8df070
	.global L_8ded0e
L_8ded0e:
	mov_s r1,0x10073d0
L_8ded14:
	bl.d L_8dcba8
L_8ded18:
	mov_s r0,0x20
L_8ded1a:
	mov_s r0,r13
L_8ded1c:
	bl.d L_8fbe18
L_8ded20:
	mov_s r1,r14
L_8ded22:
	b L_8df070
L_8ded26:
	mov_s r0,r15
L_8ded28:
	bl.d L_8fb598
L_8ded2c:
	mov_s r1,r14
L_8ded2e:
	b L_8df070
L_8ded32:
	mov_s r1,0x10073f8
L_8ded38:
	bl.d L_8dcba8
L_8ded3c:
	mov_s r0,0x20
L_8ded3e:
	mov_s r0,r13
L_8ded40:
	mov_s r1,r15
L_8ded42:
	bl.d L_8fbbe8
L_8ded46:
	mov_s r2,r14
L_8ded48:
	b L_8df070
L_8ded4c:
	mov_s r1,0x1007434
L_8ded52:
	bl.d L_8dcba8
L_8ded56:
	mov_s r0,0x20
L_8ded58:
	bl.d L_8ec7f8
L_8ded5c:
	mov_s r0,r13
L_8ded5e:
	b L_8df070
L_8ded62:
	mov_s r1,0x1007468
L_8ded68:
	bl.d L_8dcba8
L_8ded6c:
	mov_s r0,0x20
L_8ded6e:
	bl.d L_8ec7b0
L_8ded72:
	mov_s r0,r13
L_8ded74:
	b L_8df070
L_8ded78:
	mov_s r1,0x100749c
L_8ded7e:
	bl.d L_8dcba8
L_8ded82:
	mov_s r0,0x20
L_8ded84:
	mov_s r0,r13
L_8ded86:
	bl.d L_8ecf1c
L_8ded8a:
	mov_s r1,r14
L_8ded8c:
	b L_8df070
L_8ded90:
	mov_s r1,0x10074cc
L_8ded96:
	bl.d L_8dcba8
L_8ded9a:
	mov_s r0,0x20
L_8ded9c:
	bl L_8ecf48
L_8deda0:
	b L_8df070
L_8deda4:
	mov_s r1,0x10074f8
L_8dedaa:
	bl.d L_8dcba8
L_8dedae:
	mov_s r0,0x20
L_8dedb0:
	mov_s r0,r13
L_8dedb2:
	mov_s r1,r14
L_8dedb4:
	bl.d L_8ec970
L_8dedb8:
	mov_s r2,r15
L_8dedba:
	b L_8df070
	.global L_8dedbe
L_8dedbe:
	mov_s r1,0x1007528
L_8dedc4:
	bl.d L_8dcba8
L_8dedc8:
	mov_s r0,0x20
L_8dedca:
	mov_s r0,r13
L_8dedcc:
	mov_s r1,r14
L_8dedce:
	bl.d L_8ec35c
L_8dedd2:
	mov_s r2,r15
L_8dedd4:
	b L_8df070
	.global L_8dedd8
L_8dedd8:
	mov_s r1,0x100755c
L_8dedde:
	bl.d L_8dcba8
L_8dede2:
	mov_s r0,0x20
L_8dede4:
	mov_s r0,r14
L_8dede6:
	bl.d L_8ec200
L_8dedea:
	mov_s r1,r15
L_8dedec:
	b L_8df070
	.global L_8dedf0
L_8dedf0:
	mov_s r1,0x1007590
L_8dedf6:
	bl.d L_8dcba8
L_8dedfa:
	mov_s r0,0x20
L_8dedfc:
	mov_s r0,r13
L_8dedfe:
	mov_s r1,r14
L_8dee00:
	bl.d L_8ec184
L_8dee04:
	mov_s r2,r15
L_8dee06:
	b L_8df070
L_8dee0a:
	mov_s r1,0x10075b4
L_8dee10:
	bl.d L_8dcba8
L_8dee14:
	mov_s r0,0x20
L_8dee16:
	mov_s r0,r15
L_8dee18:
	mov_s r1,r13
L_8dee1a:
	bl.d L_8dd310
L_8dee1e:
	mov_s r2,r14
L_8dee20:
	b L_8df070
	.global L_8dee24
L_8dee24:
	mov_s r1,0x10075e4
L_8dee2a:
	bl.d L_8dcba8
L_8dee2e:
	mov_s r0,0x20
L_8dee30:
	bl.d L_8dc3f4
L_8dee34:
	mov_s r0,r13
L_8dee36:
	b L_8df070
L_8dee3a:
	mov_s r1,0x1007608
L_8dee40:
	bl.d L_8dcba8
L_8dee44:
	mov_s r0,0x20
L_8dee46:
	mov_s r0,r15
L_8dee48:
	mov_s r1,r13
L_8dee4a:
	bl.d L_8ecfec
L_8dee4e:
	mov_s r2,r14
L_8dee50:
	b L_8df070
	.global L_8dee54
L_8dee54:
	mov_s r1,0x100763c
L_8dee5a:
	bl.d L_8dcba8
L_8dee5e:
	mov_s r0,0x20
L_8dee60:
	mov_s r0,r15
L_8dee62:
	mov_s r1,r13
L_8dee64:
	bl.d L_8ecfa0
L_8dee68:
	mov_s r2,r14
L_8dee6a:
	b L_8df070
	.global L_8dee6e
L_8dee6e:
	mov_s r1,0x1007670
L_8dee74:
	bl.d L_8dcba8
L_8dee78:
	mov_s r0,0x20
L_8dee7a:
	mov_s r0,r15
L_8dee7c:
	mov_s r1,r13
L_8dee7e:
	bl.d L_8ecf54
L_8dee82:
	mov_s r2,r14
L_8dee84:
	b L_8df070
	.global L_8dee88
L_8dee88:
	mov_s r1,0x10076ac
L_8dee8e:
	bl.d L_8dcba8
L_8dee92:
	mov_s r0,0x20
L_8dee94:
	mov_s r0,r15
L_8dee96:
	mov_s r1,r13
L_8dee98:
	bl.d L_8ecdcc
L_8dee9c:
	mov_s r2,r14
L_8dee9e:
	b_s L_8df070
	.global L_8deea0
L_8deea0:
	mov_s r1,0x10076d8
L_8deea6:
	bl.d L_8dcba8
L_8deeaa:
	mov_s r0,0x20
L_8deeac:
	mov_s r0,r15
L_8deeae:
	mov_s r1,r13
L_8deeb0:
	bl.d L_8e7340
L_8deeb4:
	mov_s r2,r14
L_8deeb6:
	b_s L_8df070
	.global L_8deeb8
L_8deeb8:
	mov_s r1,0x1007704
L_8deebe:
	bl.d L_8dcba8
L_8deec2:
	mov_s r0,0x20
L_8deec4:
	mov_s r0,r15
L_8deec6:
	mov_s r1,r13
L_8deec8:
	bl.d L_8ec56c
L_8deecc:
	mov_s r2,r14
L_8deece:
	b_s L_8df070
L_8deed0:
	mov_s r1,0x1007738
L_8deed6:
	bl.d L_8dcba8
L_8deeda:
	mov_s r0,0x20
L_8deedc:
	mov_s r0,r15
L_8deede:
	mov_s r1,r13
L_8deee0:
	bl.d L_8ec5fc
L_8deee4:
	mov_s r2,r14
L_8deee6:
	b_s L_8df070
	.global L_8deee8
L_8deee8:
	mov_s r1,0x1007770
L_8deeee:
	bl.d L_8dcba8
L_8deef2:
	mov_s r0,0x20
L_8deef4:
	mov_s r0,r15
L_8deef6:
	mov_s r1,r13
L_8deef8:
	bl.d L_8ec500
L_8deefc:
	mov_s r2,r14
L_8deefe:
	b_s L_8df070
L_8def00:
	mov_s r1,0x10077a4
L_8def06:
	bl.d L_8dcba8
L_8def0a:
	mov_s r0,0x20
L_8def0c:
	mov_s r0,r15
L_8def0e:
	bl.d L_8ec68c
L_8def12:
	mov_s r1,r14
L_8def14:
	b_s L_8df070
	.global L_8def16
L_8def16:
	mov_s r1,0x10077d0
L_8def1c:
	bl.d L_8dcba8
L_8def20:
	mov_s r0,0x20
L_8def22:
	mov_s r1,0x8004c4
L_8def28:
	ldb_s r0,[r1]
L_8def2a:
	mov_s r14,0x80483c
L_8def30:
	breq_s r0,0,L_8def3e
L_8def32:
	mov_s r0,0x0
L_8def34:
	stb_s r0,[r1]
L_8def36:
	mov_s r0,r14
L_8def38:
	bl.d L_8c1848
L_8def3c:
	mov_s r1,0x0
	.global L_8def3e
L_8def3e:
	mov_s r0,r14
L_8def40:
	mov_s r1,r13
L_8def42:
	bl.d L_8e5e00
L_8def46:
	mov_s r2,r15
L_8def48:
	cmp_s r0,0x0
L_8def4a:
	bl.ne.d L_8cd104
L_8def4e:
	mov.ne r0,r14
L_8def52:
	b_s L_8df070
L_8def54:
	mov_s r1,0x1007804
L_8def5a:
	bl.d L_8dcba8
L_8def5e:
	mov_s r0,0x20
L_8def60:
	mov_s r1,0x8004c4
L_8def66:
	ldb_s r0,[r1,0x1]
L_8def68:
	mov_s r14,0x804848
L_8def6e:
	breq_s r0,0,L_8def7c
L_8def70:
	mov_s r0,0x0
L_8def72:
	stb_s r0,[r1,0x1]
L_8def74:
	mov_s r0,r14
L_8def76:
	bl.d L_8c1854
L_8def7a:
	mov_s r1,0x0
	.global L_8def7c
L_8def7c:
	mov_s r0,r14
L_8def7e:
	mov_s r1,r13
L_8def80:
	bl.d L_8e5e84
L_8def84:
	mov_s r2,r15
L_8def86:
	cmp_s r0,0x0
L_8def88:
	bl.ne.d L_8cd14c
L_8def8c:
	mov.ne r0,r14
L_8def90:
	b_s L_8df070
L_8def92:
	ldb_s r2,[r13]
L_8def94:
	mov_s r1,0x1007838
L_8def9a:
	mov_s r0,0x20
L_8def9c:
	bl.d L_8dcc80
L_8defa0:
	ldb_s r3,[r13,0x1]
L_8defa2:
	mov_s r14,0x804914
L_8defa8:
	mov_s r0,r14
L_8defaa:
	mov_s r1,r13
L_8defac:
	bl.d L_8e5f44
L_8defb0:
	mov_s r2,r15
L_8defb2:
	cmp_s r0,0x0
L_8defb4:
	bl.ne.d L_8cd198
L_8defb8:
	mov.ne r0,r14
L_8defbc:
	b_s L_8df070
L_8defbe:
	ldw r4,[r13, 0x2]
L_8defc2:
	mov_s r1,0x100788c
L_8defc8:
	ldb_s r2,[r13]
L_8defca:
	mov_s r0,0x20
L_8defcc:
	bl.d L_8dcd00
L_8defd0:
	ldb_s r3,[r13,0x1]
L_8defd2:
	mov_s r14,0x80491c
L_8defd8:
	mov_s r0,r14
L_8defda:
	mov_s r1,r13
L_8defdc:
	bl.d L_8e5fb4
L_8defe0:
	mov_s r2,r15
L_8defe2:
	cmp_s r0,0x0
L_8defe4:
	bl.ne.d L_8cd1c0
L_8defe8:
	mov.ne r0,r14
L_8defec:
	b_s L_8df070
L_8defee:
	mov_s r1,0x10078ec
L_8deff4:
	bl.d L_8dcba8
L_8deff8:
	mov_s r0,0x20
L_8deffa:
	mov_s r0,r13
L_8deffc:
	bl.d L_8eceb8
L_8df000:
	mov_s r1,r15
L_8df002:
	b_s L_8df070
	.global L_8df004
L_8df004:
	mov_s r1,0x100791c
L_8df00a:
	bl.d L_8dcba8
L_8df00e:
	mov_s r0,0x20
L_8df010:
	mov_s r0,r13
L_8df012:
	bl.d L_8ec068
L_8df016:
	mov_s r1,r15
L_8df018:
	b_s L_8df070
L_8df01a:
	mov_s r1,0x1007944
L_8df020:
	bl.d L_8dcba8
L_8df024:
	mov_s r0,0x20
L_8df026:
	ld_s r1,[r13]
L_8df028:
	mov_s r0,r15
L_8df02a:
	bl.d L_8e6120
L_8df02e:
	mov_s r2,r14
L_8df030:
	b_s L_8df070
L_8df032:
	mov_s r1,0x1007978
L_8df038:
	bl.d L_8dcba8
L_8df03c:
	mov_s r0,0x20
L_8df03e:
	mov_s r0,r15
L_8df040:
	bl.d L_8e66ac
L_8df044:
	ldb_s r1,[r13]
L_8df046:
	b_s L_8df070
L_8df048:
	mov_s r1,0x10079a4
L_8df04e:
	bl.d L_8dcba8
L_8df052:
	mov_s r0,0x20
L_8df054:
	mov_s r0,r15
L_8df056:
	bl.d L_8e6178
L_8df05a:
	ld_s r1,[r13]
L_8df05c:
	b_s L_8df070
	.global L_8df05e
L_8df05e:
	bl.d L_8dc4d8
L_8df062:
	mov_s r0,r13
L_8df064:
	b_s L_8df070
	.global L_8df066
L_8df066:
	mov_s r0,r15
L_8df068:
	mov_s r2,0x0
L_8df06a:
	bl.d L_8e5728
L_8df06e:
	mov_s r3,r14
	.global L_8df070
L_8df070:
	add r0,r15,0x24
L_8df074:
	mov_s r2,0x0
L_8df076:
	ld_s r1,[r0]
L_8df078:
	bl.d L_8d86c0
