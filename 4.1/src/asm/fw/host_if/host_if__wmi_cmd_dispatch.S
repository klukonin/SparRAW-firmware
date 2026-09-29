/* host_if__wmi_cmd_dispatch @ 0x8da54c, 2356 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HOST CMD 0x%08X for MIDID %d
 *   host_if.cpp
 *   ---->> [HOST CMD] WMI_ECHO_CMDID
 *   ---->> [HOST CMD] WMI_ADD_DEBUG_TX_PCKT_CMDID
 *   ---->> [HOST CMD] WMI_VRING_CFG_CMDID
 *   ---->> [HOST CMD] WMI_RS_CFG_CMDID
 *   ---->> [HOST CMD] WMI_GET_MGMT_RETRY_LIMIT_CMDID
 *   ---->> [HOST CMD] WMI_GET_SELECTED_RF_SECTOR_INDEX_CMDID, cid=%d, sector_type=%d
 * Зовёт сам: POWER_MNGR__wmi_ps_dev_profile_cfg_cmd, POWER_MNGR__wmi_traffic_deferral_cmd, WMI_ADD_CIPHER_KEY_CMD, WMI_DELETE_CIPHER_KEY_CMD, __ld_r17_to_r13_ret, __st_r17_to_r13, encap_trans_type, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3, fw_mailbox__has_space
 */
	.section .text.host_if__wmi_cmd_dispatch,"ax",@progbits
	.global host_if__wmi_cmd_dispatch
host_if__wmi_cmd_dispatch:
L_8da54c:
	mov_s r0,0x0
	.global fwlog_HOST_CMD_WMI_GET_SELECTED_RF_SECTOR_INDE
fwlog_HOST_CMD_WMI_GET_SELECTED_RF_SECTOR_INDE:
L_8da54e:
	nop_s
L_8da550:
	push_s blink
L_8da552:
	bl L_8c02b8
L_8da556:
	mov_s r15,r0
L_8da558:
	ldw_s r3,[r1,0xa]
L_8da55a:
	mov_s r16,r1
L_8da55c:
	ldb r4,[r1, 0x8]
L_8da560:
	breq r3,0x863,L_8da576
L_8da568:
	mov_s r2,0x100640c
L_8da56e:
	mov_s r0,0x0
L_8da570:
	bl.d L_8edff8
L_8da574:
	mov_s r1,0x2
	.global L_8da576
L_8da576:
	ldw r0,[r16, 0x6]
L_8da57a:
	ldb r14,[r16, 0x8]
L_8da57e:
	add r13,r16,0x10
L_8da582:
	bbit1 r0,0x1,L_8da5a8
	.global L_8da586
L_8da586:
	ldw r0,[r16, 0x6]
L_8da58a:
	bbit1 r0,0x2,L_8da5bc
	.global L_8da58e
L_8da58e:
	bl.d L_8d74d8
L_8da592:
	mov r17,0x0
L_8da596:
	brne_s r0,0,L_8da5a4
L_8da598:
	ldw r0,[r16, 0xa]
L_8da59c:
	breq r0,0x1,L_8da5d0
L_8da5a0:
	breq r0,0x7,L_8da5da
	.global L_8da5a4
L_8da5a4:
	mov_s r0,r17
L_8da5a6:
	b_s L_8da5e2
	.global L_8da5a8
L_8da5a8:
	mov_s r0,blink
L_8da5aa:
	mov_s r2,0x1006224
L_8da5b0:
	mov_s r1,0x36
L_8da5b2:
	bset_s r1,r1,0xc
L_8da5b4:
	bl.d L_8c82c0
L_8da5b8:
	mov_s r3,0x82
L_8da5ba:
	b_s L_8da586
	.global L_8da5bc
L_8da5bc:
	mov_s r0,blink
L_8da5be:
	mov_s r2,0x1006224
L_8da5c4:
	mov_s r1,0x37
L_8da5c6:
	bset_s r1,r1,0xc
L_8da5c8:
	bl.d L_8c82c0
L_8da5cc:
	mov_s r3,0x84
L_8da5ce:
	b_s L_8da58e
	.global L_8da5d0
L_8da5d0:
	mov_s r0,r13
L_8da5d2:
	bl.d L_8e7774
L_8da5d6:
	mov_s r1,r14
L_8da5d8:
	b_s L_8da5e0
	.global L_8da5da
L_8da5da:
	bl.d L_8e7ba0
L_8da5de:
	mov_s r0,r14
	.global L_8da5e0
L_8da5e0:
	mov_s r0,0x1
	.global L_8da5e2
L_8da5e2:
	cmp_s r0,0x0
L_8da5e4:
	bne L_8dae70
L_8da5e8:
	ldw r0,[r16, 0xa]
L_8da5ec:
	cmp_s r0,0x857
L_8da5f2:
	beq L_8da898
L_8da5f6:
	bgt L_8da6e4
L_8da5fa:
	cmp_s r0,0x822
L_8da600:
	beq L_8da98e
L_8da604:
	bgt L_8da6c6
L_8da608:
	cmp_s r0,0x17
L_8da60a:
	beq L_8dabea
L_8da60e:
	bgt L_8da62a
L_8da612:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8da614:
	cmp_s r0,0x15
L_8da616:
	bhi L_8dae4e
L_8da61a:
	ldw.x.as r0,[0x801bec,r0]
L_8da622:
	add r1,pcl,0xa
L_8da626:
	add1_s r1,r1,r0
L_8da628:
	j_s [r1]
	.global L_8da62a
L_8da62a:
	cmp_s r0,0x804
L_8da630:
	beq L_8da90a
L_8da634:
	bgt_s L_8da668
L_8da636:
	cmp_s r0,0x3f
L_8da638:
	beq L_8dac78
L_8da63c:
	cmp_s r0,0x42
L_8da63e:
	beq L_8dac92
L_8da642:
	cmp_s r0,0x803
L_8da648:
	bne L_8dae4e
L_8da64c:
	mov_s r2,0x100642c
L_8da652:
	mov_s r0,0x0
L_8da654:
	bl.d L_8edfb0
L_8da658:
	mov_s r1,0x2
L_8da65a:
	ld_s r1,[r13]
L_8da65c:
	mov_s r0,r15
L_8da65e:
	bl.d L_8e0844
L_8da662:
	mov_s r2,r14
L_8da664:
	b L_8dae70
	.global L_8da668
L_8da668:
	cmp_s r0,0x80e
L_8da66e:
	beq L_8da8d6
L_8da672:
	bgt_s L_8da698
L_8da674:
	cmp_s r0,0x808
L_8da67a:
	bne L_8dae4e
L_8da67e:
	mov_s r2,0x1006450
L_8da684:
	mov_s r0,0x0
L_8da686:
	bl.d L_8edfb0
L_8da68a:
	mov_s r1,0x2
L_8da68c:
	mov_s r0,r13
L_8da68e:
	bl.d L_8e09ac
L_8da692:
	mov_s r1,r14
L_8da694:
	b L_8dae70
	.global L_8da698
L_8da698:
	cmp_s r0,0x820
L_8da69e:
	beq L_8da924
L_8da6a2:
	cmp_s r0,0x821
L_8da6a8:
	bne L_8dae4e
L_8da6ac:
	mov_s r2,0x1006480
L_8da6b2:
	mov_s r0,0x0
L_8da6b4:
	bl.d L_8edfb0
L_8da6b8:
	mov_s r1,0x2
L_8da6ba:
	mov_s r0,r13
L_8da6bc:
	bl.d L_8f37b8
L_8da6c0:
	mov_s r1,r14
L_8da6c2:
	b L_8dae70
	.global L_8da6c6
L_8da6c6:
	sub r0,r0,0x823
L_8da6ce:
	cmp_s r0,0x33
L_8da6d0:
	bhi L_8dae4e
L_8da6d4:
	ldw.x.as r0,[0x801c18,r0]
L_8da6dc:
	add r1,pcl,0x8
L_8da6e0:
	add1_s r1,r1,r0
L_8da6e2:
	j_s [r1]
	.global L_8da6e4
L_8da6e4:
	cmp_s r0,0x919
L_8da6ea:
	beq L_8dab9c
L_8da6ee:
	bgt L_8da74c
L_8da6f2:
	cmp_s r0,0x905
L_8da6f8:
	beq L_8dad4a
L_8da6fc:
	bgt L_8da732
L_8da700:
	cmp_s r0,0x904
L_8da706:
	beq L_8dad32
L_8da70a:
	cmp_s r0,0x900
L_8da710:
	beq L_8dac2a
L_8da714:
	sub r0,r0,0x859
L_8da71c:
	cmp_s r0,0xf
L_8da71e:
	bhi L_8dae4e
L_8da722:
	ldw.x.as r0,[0x801c80,r0]
L_8da72a:
	add r1,pcl,0xa
L_8da72e:
	add1_s r1,r1,r0
L_8da730:
	j_s [r1]
	.global L_8da732
L_8da732:
	sub3 r0,r0,0x122
L_8da736:
	cmp_s r0,0x8
L_8da738:
	bhi L_8dae4e
L_8da73c:
	ldw.x.as r0,[0x801ca0,r0]
L_8da744:
	add r1,pcl,0x8
L_8da748:
	add1_s r1,r1,r0
L_8da74a:
	j_s [r1]
	.global L_8da74c
L_8da74c:
	cmp_s r0,0x9a3
L_8da752:
	beq L_8dae1a
L_8da756:
	bgt L_8da818
L_8da75a:
	cmp_s r0,0x930
L_8da760:
	beq L_8dad78
L_8da764:
	bgt L_8da7a2
L_8da768:
	cmp_s r0,0x91b
L_8da76e:
	beq L_8daa6e
L_8da772:
	cmp_s r0,0x91c
L_8da778:
	beq L_8dad5e
L_8da77c:
	cmp_s r0,0x921
L_8da782:
	bne L_8dae4e
L_8da786:
	mov_s r2,0x10064a8
L_8da78c:
	mov_s r0,0x0
L_8da78e:
	bl.d L_8edfb0
L_8da792:
	mov_s r1,0x2
L_8da794:
	mov_s r0,r15
L_8da796:
	mov_s r1,r13
L_8da798:
	bl.d L_8d9718
L_8da79c:
	mov_s r2,r14
L_8da79e:
	b L_8dae70
	.global L_8da7a2
L_8da7a2:
	cmp_s r0,0x9a0
L_8da7a8:
	beq L_8dadc6
L_8da7ac:
	bgt_s L_8da7d2
L_8da7ae:
	cmp_s r0,0x931
L_8da7b4:
	bne L_8dae4e
L_8da7b8:
	mov_s r2,0x10064cc
L_8da7be:
	mov_s r0,0x0
L_8da7c0:
	bl.d L_8edfb0
L_8da7c4:
	mov_s r1,0x2
L_8da7c6:
	mov_s r0,r14
L_8da7c8:
	bl.d L_8e7628
L_8da7cc:
	mov_s r1,r15
L_8da7ce:
	b L_8dae70
	.global L_8da7d2
L_8da7d2:
	cmp_s r0,0x9a1
L_8da7d8:
	beq L_8dadf0
L_8da7dc:
	cmp_s r0,0x9a2
L_8da7e2:
	bne L_8dae4e
L_8da7e6:
	mov_s r2,0x1006500
L_8da7ec:
	ldb r4,[r13, 0x1]
L_8da7f0:
	mov_s r0,0x0
L_8da7f2:
	mov_s r1,0x2
L_8da7f4:
	bl.d L_8edff8
L_8da7f8:
	ldb_s r3,[r13]
L_8da7fa:
	mov_s r14,0x804384
L_8da800:
	mov_s r0,r14
L_8da802:
	mov_s r1,r13
L_8da804:
	bl.d L_8e1288
L_8da808:
	mov_s r2,r15
L_8da80a:
	cmp_s r0,0x0
L_8da80c:
	bl.ne.d L_8cae64
L_8da810:
	mov.ne r0,r14
L_8da814:
	b L_8dae70
	.global L_8da818
L_8da818:
	cmp_s r0,0xf007
L_8da81e:
	beq L_8dab50
L_8da822:
	bgt_s L_8da85c
L_8da824:
	cmp_s r0,0xa01
L_8da82a:
	beq L_8daa22
L_8da82e:
	cmp_s r0,0xa05
L_8da834:
	beq L_8dad92
L_8da838:
	cmp_s r0,0xf003
L_8da83e:
	bne L_8dae4e
L_8da842:
	mov_s r2,0x1006554
L_8da848:
	mov_s r0,0x0
L_8da84a:
	bl.d L_8edfb0
L_8da84e:
	mov_s r1,0x2
L_8da850:
	mov_s r0,r13
L_8da852:
	bl.d L_8e7e4c
L_8da856:
	mov_s r1,r14
L_8da858:
	b L_8dae70
	.global L_8da85c
L_8da85c:
	sub r0,r0,0xf049
L_8da864:
	cmp_s r0,0x6
L_8da866:
	bhi L_8dae4e
L_8da86a:
	ldw.x.as r0,[0x801cb4,r0]
L_8da872:
	add r1,pcl,0xa
L_8da876:
	add1_s r1,r1,r0
L_8da878:
	j_s [r1]
L_8da87a:
	mov_s r2,0x1006580
L_8da880:
	mov_s r0,0x0
L_8da882:
	bl.d L_8edfb0
L_8da886:
	mov_s r1,0x2
L_8da888:
	ld_s r1,[r13]
L_8da88a:
	mov_s r0,r15
L_8da88c:
	ld_s r2,[r13,0x4]
L_8da88e:
	bl.d L_8dde58
L_8da892:
	mov_s r3,r14
L_8da894:
	b L_8dae70
	.global L_8da898
L_8da898:
	mov_s r2,0x10065a8
L_8da89e:
	mov_s r0,0x0
L_8da8a0:
	bl.d L_8edfb0
L_8da8a4:
	mov_s r1,0x2
L_8da8a6:
	ld_s r1,[r13]
L_8da8a8:
	add r2,r13,0x8
L_8da8ac:
	mov_s r0,r15
L_8da8ae:
	bl.d L_8e7fdc
L_8da8b2:
	ld_s r3,[r13,0x4]
L_8da8b4:
	b L_8dae70
L_8da8b8:
	mov_s r2,0x10065d0
L_8da8be:
	mov_s r0,0x0
L_8da8c0:
	mov_s r1,0x2
L_8da8c2:
	bl.d L_8edfcc
L_8da8c6:
	ld.as r3,[gp,-0x29]
L_8da8ca:
	mov_s r0,r13
L_8da8cc:
	bl.d L_8e7b18
L_8da8d0:
	mov_s r1,r14
L_8da8d2:
	b L_8dae70
	.global L_8da8d6
L_8da8d6:
	mov_s r2,0x10065fc
L_8da8dc:
	mov_s r0,0x0
L_8da8de:
	bl.d L_8edfb0
L_8da8e2:
	mov_s r1,0x2
L_8da8e4:
	mov_s r0,r15
L_8da8e6:
	bl.d L_8e420c
L_8da8ea:
	mov_s r1,r13
L_8da8ec:
	b L_8dae70
L_8da8f0:
	mov_s r2,0x1006624
L_8da8f6:
	mov_s r0,0x0
L_8da8f8:
	bl.d L_8edfb0
L_8da8fc:
	mov_s r1,0x2
L_8da8fe:
	mov_s r0,r13
L_8da900:
	bl.d L_8e740c
L_8da904:
	mov_s r1,r14
L_8da906:
	b L_8dae70
	.global L_8da90a
L_8da90a:
	mov_s r2,0x1006654
L_8da910:
	mov_s r0,0x0
L_8da912:
	bl.d L_8edfb0
L_8da916:
	mov_s r1,0x2
L_8da918:
	mov_s r0,r15
L_8da91a:
	bl.d L_8c719c
L_8da91e:
	ld_s r1,[r13]
L_8da920:
	b L_8dae70
	.global L_8da924
L_8da924:
	mov_s r2,0x100667c
L_8da92a:
	mov_s r0,0x0
L_8da92c:
	bl.d L_8edfb0
L_8da930:
	mov_s r1,0x2
L_8da932:
	mov_s r0,r13
L_8da934:
	bl.d L_8f2ed0
L_8da938:
	mov_s r1,r14
L_8da93a:
	b L_8dae70
L_8da93e:
	mov_s r2,0x10066a8
L_8da944:
	mov_s r0,0x0
L_8da946:
	bl.d L_8edfb0
L_8da94a:
	mov_s r1,0x2
L_8da94c:
	bl.d L_8e77e4
L_8da950:
	mov_s r0,r14
L_8da952:
	b L_8dae70
L_8da956:
	mov_s r2,0x10066d0
L_8da95c:
	mov_s r0,0x0
L_8da95e:
	bl.d L_8edfb0
L_8da962:
	mov_s r1,0x2
L_8da964:
	mov_s r0,r13
L_8da966:
	bl.d L_8e77ec
L_8da96a:
	mov_s r1,r14
L_8da96c:
	b L_8dae70
L_8da970:
	mov_s r2,0x10066fc
L_8da976:
	mov_s r0,0x0
L_8da978:
	mov_s r1,0x2
L_8da97a:
	bl.d L_8edfcc
L_8da97e:
	ld.as r3,[gp,-0x2a]
L_8da982:
	mov_s r0,r13
L_8da984:
	bl.d L_8e7730
L_8da988:
	mov_s r1,r14
L_8da98a:
	b L_8dae70
	.global L_8da98e
L_8da98e:
	mov_s r2,0x1006720
L_8da994:
	mov_s r0,0x0
L_8da996:
	bl.d L_8edfb0
L_8da99a:
	mov_s r1,0x2
L_8da99c:
	mov_s r0,r13
L_8da99e:
	bl.d L_8f2bac
L_8da9a2:
	mov_s r1,r14
L_8da9a4:
	b L_8dae70
L_8da9a8:
	mov_s r2,0x100674c
L_8da9ae:
	mov_s r0,0x0
L_8da9b0:
	bl.d L_8edfb0
L_8da9b4:
	mov_s r1,0x2
L_8da9b6:
	mov_s r0,r13
L_8da9b8:
	bl.d L_8e7698
L_8da9bc:
	mov_s r1,r14
L_8da9be:
	b L_8dae70
L_8da9c2:
	mov_s r2,0x1006778
L_8da9c8:
	mov_s r0,0x0
L_8da9ca:
	bl.d L_8edfb0
L_8da9ce:
	mov_s r1,0x2
L_8da9d0:
	bl.d L_8e7724
L_8da9d4:
	mov_s r0,r14
L_8da9d6:
	b L_8dae70
L_8da9da:
	mov_s r2,0x10067a4
L_8da9e0:
	mov_s r0,0x0
L_8da9e2:
	bl.d L_8edfb0
L_8da9e6:
	mov_s r1,0x2
L_8da9e8:
	bl.d L_8e7728
L_8da9ec:
	mov_s r0,r14
L_8da9ee:
	b L_8dae70
L_8da9f2:
	mov_s r2,0x10067d0
L_8da9f8:
	mov_s r0,0x0
L_8da9fa:
	bl.d L_8edfb0
L_8da9fe:
	mov_s r1,0x2
L_8daa00:
	bl.d L_8e7720
L_8daa04:
	mov_s r0,r14
L_8daa06:
	b L_8dae70
L_8daa0a:
	mov_s r2,0x10067fc
L_8daa10:
	mov_s r0,0x0
L_8daa12:
	bl.d L_8edfb0
L_8daa16:
	mov_s r1,0x2
L_8daa18:
	bl.d L_8e772c
L_8daa1c:
	mov_s r0,r14
L_8daa1e:
	b L_8dae70
	.global L_8daa22
L_8daa22:
	mov_s r2,0x1006828
L_8daa28:
	mov_s r0,0x0
L_8daa2a:
	bl.d L_8edfb0
L_8daa2e:
	mov_s r1,0x2
L_8daa30:
	mov_s r0,r13
L_8daa32:
	bl.d L_8f2c6c
L_8daa36:
	mov_s r1,r14
L_8daa38:
	b L_8dae70
L_8daa3c:
	mov_s r2,0x100684c
L_8daa42:
	mov_s r0,0x0
L_8daa44:
	bl.d L_8edfb0
L_8daa48:
	mov_s r1,0x2
L_8daa4a:
	mov_s r0,r13
L_8daa4c:
	bl.d L_8e768c
L_8daa50:
	mov_s r1,r14
L_8daa52:
	b L_8dae70
L_8daa56:
	mov_s r2,0x1006870
L_8daa5c:
	mov_s r0,0x0
L_8daa5e:
	bl.d L_8edfb0
L_8daa62:
	mov_s r1,0x2
L_8daa64:
	bl.d L_8f2e50
L_8daa68:
	mov_s r0,r13
L_8daa6a:
	b L_8dae70
	.global L_8daa6e
L_8daa6e:
	mov_s r2,0x100689c
L_8daa74:
	mov_s r0,0x0
L_8daa76:
	bl.d L_8edfb0
L_8daa7a:
	mov_s r1,0x2
L_8daa7c:
	bl.d L_8f2cdc
L_8daa80:
	mov_s r0,r14
L_8daa82:
	b L_8dae70
L_8daa86:
	mov_s r2,0x10068c8
L_8daa8c:
	mov_s r0,0x0
L_8daa8e:
	bl.d L_8edfb0
L_8daa92:
	mov_s r1,0x2
L_8daa94:
	mov_s r0,r13
L_8daa96:
	bl.d L_8f2b74
L_8daa9a:
	mov_s r1,r14
L_8daa9c:
	b L_8dae70
L_8daaa0:
	mov_s r2,0x10068f0
L_8daaa6:
	mov_s r0,0x0
L_8daaa8:
	bl.d L_8edfb0
L_8daaac:
	mov_s r1,0x2
L_8daaae:
	mov_s r0,r13
L_8daab0:
	bl.d L_8f2b48
L_8daab4:
	mov_s r1,r14
L_8daab6:
	b L_8dae70
L_8daaba:
	mov_s r2,0x100691c
L_8daac0:
	mov_s r0,0x0
L_8daac2:
	bl.d L_8edfb0
L_8daac6:
	mov_s r1,0x2
L_8daac8:
	mov_s r0,r13
L_8daaca:
	bl.d L_8e7bf0
L_8daace:
	mov_s r1,r14
L_8daad0:
	b L_8dae70
L_8daad4:
	mov_s r2,0x1006948
L_8daada:
	mov_s r0,0x0
L_8daadc:
	bl.d L_8edfb0
L_8daae0:
	mov_s r1,0x2
L_8daae2:
	mov_s r0,r13
L_8daae4:
	bl.d L_8e7d2c
L_8daae8:
	mov_s r1,r14
L_8daaea:
	b L_8dae70
L_8daaee:
	mov_s r2,0x1006970
L_8daaf4:
	mov_s r0,0x0
L_8daaf6:
	bl.d L_8edfb0
L_8daafa:
	mov_s r1,0x2
L_8daafc:
	mov_s r0,r13
L_8daafe:
	bl.d L_8f3318
L_8dab02:
	mov_s r1,r14
L_8dab04:
	b L_8dae70
L_8dab08:
	mov_s r2,0x1006998
L_8dab0e:
	mov_s r0,0x0
L_8dab10:
	bl.d L_8edfb0
L_8dab14:
	mov_s r1,0x2
L_8dab16:
	bl.d L_8f2d2c
L_8dab1a:
	mov_s r0,r14
L_8dab1c:
	b L_8dae70
L_8dab20:
	mov_s r2,0x10069c0
L_8dab26:
	mov_s r0,0x0
L_8dab28:
	bl.d L_8edfb0
L_8dab2c:
	mov_s r1,0x2
L_8dab2e:
	bl.d L_8f32d0
L_8dab32:
	mov_s r0,r13
L_8dab34:
	b L_8dae70
L_8dab38:
	mov_s r2,0x10069ec
L_8dab3e:
	mov_s r0,0x0
L_8dab40:
	bl.d L_8edfb0
L_8dab44:
	mov_s r1,0x2
L_8dab46:
	bl.d L_8f2c88
L_8dab4a:
	mov_s r0,r14
L_8dab4c:
	b L_8dae70
	.global L_8dab50
L_8dab50:
	mov_s r2,0x1006a18
L_8dab56:
	mov_s r0,0x0
L_8dab58:
	bl.d L_8edfb0
L_8dab5c:
	mov_s r1,0x2
L_8dab5e:
	bl.d L_8e7afc
L_8dab62:
	mov_s r0,r14
L_8dab64:
	b L_8dae70
L_8dab68:
	mov_s r2,0x1006a40
L_8dab6e:
	mov_s r0,0x0
L_8dab70:
	bl.d L_8edfb0
L_8dab74:
	mov_s r1,0x2
L_8dab76:
	mov_s r0,r13
L_8dab78:
	bl.d L_8e7924
L_8dab7c:
	mov_s r1,r14
L_8dab7e:
	b L_8dae70
L_8dab82:
	mov_s r2,0x1006a68
L_8dab88:
	mov_s r0,0x0
L_8dab8a:
	bl.d L_8edfb0
L_8dab8e:
	mov_s r1,0x2
L_8dab90:
	mov_s r0,r13
L_8dab92:
	bl.d L_8e79dc
L_8dab96:
	mov_s r1,r14
L_8dab98:
	b L_8dae70
	.global L_8dab9c
L_8dab9c:
	mov_s r2,0x1006a90
L_8daba2:
	mov_s r0,0x0
L_8daba4:
	bl.d L_8edfb0
L_8daba8:
	mov_s r1,0x2
L_8dabaa:
	bl.d L_8eef70
L_8dabae:
	mov_s r0,r14
L_8dabb0:
	b L_8dae70
L_8dabb4:
	mov_s r2,0x1006ab8
L_8dabba:
	mov_s r0,0x0
L_8dabbc:
	bl.d L_8edfb0
L_8dabc0:
	mov_s r1,0x2
L_8dabc2:
	mov_s r0,r15
L_8dabc4:
	mov_s r1,r13
L_8dabc6:
	bl.d L_8d94b0
L_8dabca:
	mov_s r2,r14
L_8dabcc:
	b L_8dae70
L_8dabd0:
	mov_s r2,0x1006ae8
L_8dabd6:
	mov_s r0,0x0
L_8dabd8:
	bl.d L_8edfb0
L_8dabdc:
	mov_s r1,0x2
L_8dabde:
	mov_s r0,r13
L_8dabe0:
	bl.d L_8f3568
L_8dabe4:
	mov_s r1,r14
L_8dabe6:
	b L_8dae70
	.global L_8dabea
L_8dabea:
	mov_s r2,0x1006b14
L_8dabf0:
	mov_s r0,0x0
L_8dabf2:
	bl.d L_8edfb0
L_8dabf6:
	mov_s r1,0x2
L_8dabf8:
	mov_s r0,r13
L_8dabfa:
	bl.d L_8e77b0
L_8dabfe:
	mov_s r1,r14
L_8dac00:
	b L_8dae70
L_8dac04:
	mov_s r0,r15
L_8dac06:
	bl.d L_8d9864
L_8dac0a:
	mov_s r1,r13
L_8dac0c:
	b L_8dae70
L_8dac10:
	mov_s r0,r15
L_8dac12:
	mov_s r1,r13
L_8dac14:
	bl.d L_8d953c
L_8dac18:
	mov_s r2,r14
L_8dac1a:
	b L_8dae70
L_8dac1e:
	mov_s r0,r15
L_8dac20:
	bl.d L_8d967c
L_8dac24:
	mov_s r1,r13
L_8dac26:
	b L_8dae70
	.global L_8dac2a
L_8dac2a:
	mov_s r0,r15
L_8dac2c:
	bl.d L_8e7ee0
L_8dac30:
	mov_s r1,r13
L_8dac32:
	b L_8dae70
L_8dac36:
	mov_s r2,0x1006b44
L_8dac3c:
	mov_s r0,0x0
L_8dac3e:
	bl.d L_8edfb0
L_8dac42:
	mov_s r1,0x2
L_8dac44:
	mov_s r0,r14
L_8dac46:
	bl.d L_8e77f8
L_8dac4a:
	mov_s r1,r15
L_8dac4c:
	b L_8dae70
L_8dac50:
	mov_s r2,0x1006b70
L_8dac56:
	mov_s r0,0x0
L_8dac58:
	bl.d L_8edfb0
L_8dac5c:
	mov_s r1,0x2
L_8dac5e:
	mov_s r0,r15
L_8dac60:
	bl.d L_8d9578
L_8dac64:
	mov_s r1,r14
L_8dac66:
	b L_8dae70
L_8dac6a:
	mov_s r0,r15
L_8dac6c:
	mov_s r1,r13
L_8dac6e:
	bl.d L_8ca964
L_8dac72:
	mov_s r2,r14
L_8dac74:
	b L_8dae70
	.global L_8dac78
L_8dac78:
	mov_s r2,0x1006b94
L_8dac7e:
	mov_s r0,0x0
L_8dac80:
	bl.d L_8edfb0
L_8dac84:
	mov_s r1,0x2
L_8dac86:
	mov_s r0,r13
L_8dac88:
	bl.d L_8e7dfc
L_8dac8c:
	mov_s r1,r14
L_8dac8e:
	b L_8dae70
	.global L_8dac92
L_8dac92:
	mov_s r2,0x1006bbc
L_8dac98:
	mov_s r0,0x0
L_8dac9a:
	bl.d L_8edfb0
L_8dac9e:
	mov_s r1,0x2
L_8daca0:
	mov_s r0,r13
L_8daca2:
	bl.d L_8e7a84
L_8daca6:
	mov_s r1,r14
L_8daca8:
	b_s L_8dae70
L_8dacaa:
	mov_s r2,0x1006be8
L_8dacb0:
	mov_s r0,0x0
L_8dacb2:
	bl.d L_8edfb0
L_8dacb6:
	mov_s r1,0x2
L_8dacb8:
	mov_s r0,r13
L_8dacba:
	bl.d L_8e7e50
L_8dacbe:
	mov_s r1,r14
L_8dacc0:
	b_s L_8dae70
L_8dacc2:
	mov_s r2,0x1006c14
L_8dacc8:
	mov_s r0,0x0
L_8dacca:
	bl.d L_8edfb0
L_8dacce:
	mov_s r1,0x2
L_8dacd0:
	bl.d L_8e7a9c
L_8dacd4:
	mov_s r0,r13
L_8dacd6:
	b_s L_8dae70
L_8dacd8:
	mov_s r2,0x1006c38
L_8dacde:
	mov_s r0,0x0
L_8dace0:
	bl.d L_8edfb0
L_8dace4:
	mov_s r1,0x2
L_8dace6:
	mov_s r0,r13
L_8dace8:
	bl.d L_8f3430
L_8dacec:
	mov_s r1,r14
L_8dacee:
	b_s L_8dae70
L_8dacf0:
	mov_s r2,0x1006c60
L_8dacf6:
	mov_s r0,0x0
L_8dacf8:
	bl.d L_8edfb0
L_8dacfc:
	mov_s r1,0x2
L_8dacfe:
	bl.d L_8f2e08
L_8dad02:
	mov_s r0,r13
L_8dad04:
	b_s L_8dae70
L_8dad06:
	mov_s r2,0x1006c80
L_8dad0c:
	mov_s r0,0x0
L_8dad0e:
	bl.d L_8edfb0
L_8dad12:
	mov_s r1,0x2
L_8dad14:
	bl.d L_8e78d8
L_8dad18:
	mov_s r0,r13
L_8dad1a:
	b_s L_8dae70
L_8dad1c:
	mov_s r2,0x1006cb4
L_8dad22:
	mov_s r0,0x0
L_8dad24:
	bl.d L_8edfb0
L_8dad28:
	mov_s r1,0x2
L_8dad2a:
	bl.d L_8e788c
L_8dad2e:
	mov_s r0,r13
L_8dad30:
	b_s L_8dae70
	.global L_8dad32
L_8dad32:
	mov_s r2,0x1006ce8
L_8dad38:
	mov_s r0,0x0
L_8dad3a:
	bl.d L_8edfb0
L_8dad3e:
	mov_s r1,0x2
L_8dad40:
	mov_s r0,r13
L_8dad42:
	bl.d L_8e7ea8
L_8dad46:
	mov_s r1,r14
L_8dad48:
	b_s L_8dae70
	.global L_8dad4a
L_8dad4a:
	mov_s r2,0x1006d18
L_8dad50:
	mov_s r0,0x0
L_8dad52:
	bl.d L_8edfb0
L_8dad56:
	mov_s r1,0x2
L_8dad58:
	bl L_8e7ed4
L_8dad5c:
	b_s L_8dae70
	.global L_8dad5e
L_8dad5e:
	mov_s r2,0x1006d44
L_8dad64:
	mov_s r0,0x0
L_8dad66:
	bl.d L_8edfb0
L_8dad6a:
	mov_s r1,0x2
L_8dad6c:
	mov_s r0,r13
L_8dad6e:
	mov_s r1,r14
L_8dad70:
	bl.d L_8e7a24
L_8dad74:
	mov_s r2,r15
L_8dad76:
	b_s L_8dae70
	.global L_8dad78
L_8dad78:
	mov_s r2,0x1006d74
L_8dad7e:
	mov_s r0,0x0
L_8dad80:
	bl.d L_8edfb0
L_8dad84:
	mov_s r1,0x2
L_8dad86:
	mov_s r0,r13
L_8dad88:
	mov_s r1,r14
L_8dad8a:
	bl.d L_8e769c
L_8dad8e:
	mov_s r2,r15
L_8dad90:
	b_s L_8dae70
	.global L_8dad92
L_8dad92:
	mov_s r2,0x1006da8
L_8dad98:
	mov_s r0,0x0
L_8dad9a:
	bl.d L_8edfb0
L_8dad9e:
	mov_s r1,0x2
L_8dada0:
	mov_s r0,r15
L_8dada2:
	mov_s r1,r13
L_8dada4:
	bl.d L_8e7e00
L_8dada8:
	mov_s r2,r14
L_8dadaa:
	b_s L_8dae70
L_8dadac:
	mov_s r2,0x1006dd4
L_8dadb2:
	mov_s r0,0x0
L_8dadb4:
	bl.d L_8edfb0
L_8dadb8:
	mov_s r1,0x2
L_8dadba:
	mov_s r0,r15
L_8dadbc:
	mov_s r1,r13
L_8dadbe:
	bl.d L_8e222c
L_8dadc2:
	mov_s r2,r14
L_8dadc4:
	b_s L_8dae70
	.global L_8dadc6
L_8dadc6:
	mov_s r2,0x1006e00
L_8dadcc:
	mov_s r0,0x0
L_8dadce:
	bl.d L_8edfb0
L_8dadd2:
	mov_s r1,0x2
L_8dadd4:
	mov_s r14,0x8042ac
L_8dadda:
	mov_s r0,r14
L_8daddc:
	mov_s r1,r13
L_8dadde:
	bl.d L_8e1144
L_8dade2:
	mov_s r2,r15
L_8dade4:
	cmp_s r0,0x0
L_8dade6:
	bl.ne.d L_8cadb8
L_8dadea:
	mov.ne r0,r14
L_8dadee:
	b_s L_8dae70
	.global L_8dadf0
L_8dadf0:
	mov_s r2,0x1006e34
L_8dadf6:
	mov_s r0,0x0
L_8dadf8:
	bl.d L_8edfb0
L_8dadfc:
	mov_s r1,0x2
L_8dadfe:
	mov_s r14,0x8042b8
L_8dae04:
	mov_s r0,r14
L_8dae06:
	mov_s r1,r13
L_8dae08:
	bl.d L_8e11c4
L_8dae0c:
	mov_s r2,r15
L_8dae0e:
	cmp_s r0,0x0
L_8dae10:
	bl.ne.d L_8cae0c
L_8dae14:
	mov.ne r0,r14
L_8dae18:
	b_s L_8dae70
	.global L_8dae1a
L_8dae1a:
	ldb r4,[r13, 0x1]
L_8dae1e:
	mov_s r2,0x1006e68
L_8dae24:
	ldw r5,[r13, 0x2]
L_8dae28:
	mov_s r0,0x0
L_8dae2a:
	mov_s r1,0x2
L_8dae2c:
	bl.d L_8ee034
L_8dae30:
	ldb_s r3,[r13]
L_8dae32:
	mov_s r14,0x80438c
L_8dae38:
	mov_s r0,r14
L_8dae3a:
	mov_s r1,r13
L_8dae3c:
	bl.d L_8e12f4
L_8dae40:
	mov_s r2,r15
L_8dae42:
	cmp_s r0,0x0
L_8dae44:
	bl.ne.d L_8cae8c
L_8dae48:
	mov.ne r0,r14
L_8dae4c:
	b_s L_8dae70
	.global L_8dae4e
L_8dae4e:
	mov_s r2,0x1006ec8
L_8dae54:
	mov_s r0,0x0
L_8dae56:
	bl.d L_8edfb0
L_8dae5a:
	mov_s r1,r0
L_8dae5c:
	mov_s r0,blink
L_8dae5e:
	mov_s r2,0x1006224
L_8dae64:
	mov_s r1,0x38
L_8dae66:
	bset_s r1,r1,0xc
L_8dae68:
	bl.d L_8c82c0
L_8dae6c:
	mov r3,0x1f8
	.global L_8dae70
L_8dae70:
	add r0,r15,0x24
L_8dae74:
	mov_s r2,0x0
L_8dae76:
	ld_s r1,[r0]
L_8dae78:
	bl.d L_8d533c
L_8dae7c:
	st_s r2,[r1]
L_8dae7e:
	.byte 0xa1,0x04
