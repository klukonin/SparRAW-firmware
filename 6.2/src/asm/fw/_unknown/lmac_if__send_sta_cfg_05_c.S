/* lmac_if__send_sta_cfg_05_c @ 0x8dc3c4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__config_txss_and_sta
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, lmac_if__post_cmd, mem_pool__alloc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__send_sta_cfg_05_c
lmac_if__send_sta_cfg_05_c:
	.global L_8dc3c4
L_8dc3c4:
	push_s blink
L_8dc3c6:
	bl L_8c01e0
L_8dc3ca:
	mov_s r14,r0
L_8dc3cc:
	mov_s r13,r1
L_8dc3ce:
	mov_s r0,0x804280
L_8dc3d4:
	bl.d L_8c33d0
L_8dc3d8:
	mov_s r15,r2
L_8dc3da:
	mov_s r1,0x2
L_8dc3dc:
	st_s r1,[r0,0x10]
L_8dc3de:
	stb_s r14,[r0,0xc]
L_8dc3e0:
	stw_s r13,[r0,0xa]
L_8dc3e2:
	stb_s r15,[r0,0x8]
L_8dc3e4:
	mov_s r1,0x5
L_8dc3e6:
	mov_s r2,0x28
L_8dc3e8:
	bl.d L_8e5204
L_8dc3ec:
	mov_s r3,0x0
L_8dc3ee:
	b L_8c024c
L_8dc3f2:
	nop_s
