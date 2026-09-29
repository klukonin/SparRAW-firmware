/* send_cmd2_lmac @ 0x8e0694, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   send_cmd2_lmac: type 0x%x, curr tsf 0x%08x %08x
 *   lmac_if.cpp
 * Зовут его: install_key_index_stub, lm_main_sm__config_lmac_bf_sm, lmac_if__send_abft_resp_ctrl, lmac_if__send_bcon_mgt, lmac_if__send_echo, lmac_if__send_init_cfg_cmd, lmac_if__send_lmac_personality, lmac_if__send_phy_ina_det_cfg, lmac_if__send_selective_neighbor_cfg, lmac_if__stop_beacon
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, basic_if__mailbox_send, fw_log__emit3, fw_sysassert_fatal, mac_read_tsf64
 * Глобалы (через gp): 0x8003a8
 */
	.section .text.send_cmd2_lmac,"ax",@progbits
	.global send_cmd2_lmac
send_cmd2_lmac:
	.global L_8e0694
L_8e0694:
	push_s blink
L_8e0696:
	bl L_8c02b0
L_8e069a:
	sub_s sp,sp,0x8
L_8e069c:
	mov_s r19,r0
L_8e069e:
	ld_s r0,[gp,0x238]
L_8e06a0:
	mov_s r18,r2
L_8e06a2:
	mov_s r16,r1
L_8e06a4:
	mov_s r17,r3
L_8e06a6:
	brne r0,0x1,L_8e0700
	.global L_8e06aa
L_8e06aa:
	mov_s r1,sp
L_8e06ac:
	mov_s r0,0x0
L_8e06ae:
	bl.d L_8e4840
L_8e06b2:
	mov_s r2,r0
L_8e06b4:
	ld r4,[sp, 0x4]
L_8e06b8:
	mov_s r2,0x1003e5c
L_8e06be:
	ld r5,[sp]
L_8e06c2:
	mov_s r0,0x0
L_8e06c4:
	mov_s r1,0x2
L_8e06c6:
	bl.d L_8ee034
L_8e06ca:
	mov_s r3,r16
L_8e06cc:
	mov_s r0,0x803e3c
L_8e06d2:
	mov_s r1,r19
L_8e06d4:
	mov_s r2,r16
L_8e06d6:
	mov_s r3,0x0
L_8e06d8:
	mov r4,r18
L_8e06dc:
	mov r5,r17
L_8e06e0:
	mov r6,0x0
L_8e06e4:
	bl.d L_8e048c
L_8e06e8:
	mov r7,0x0
L_8e06ec:
	mov_s r1,0x1
L_8e06ee:
	mov_s r0,0x886d80
L_8e06f4:
	st_s r1,[r0,0x58]
L_8e06f6:
	sync
L_8e06fa:
	b.d L_8c030c
L_8e06fe:
	add_s sp,sp,0x8
	.global L_8e0700
L_8e0700:
	mov_s r0,blink
L_8e0702:
	mov_s r2,0x1003e50
L_8e0708:
	mov_s r1,0x46
L_8e070a:
	bset_s r1,r1,0xc
L_8e070c:
	bl.d L_8c82c0
L_8e0710:
	mov r3,0x12b
L_8e0714:
	b_s L_8e06aa
L_8e0716:
	nop_s
