/* lmac_if__send_sta_cfg_05_b @ 0x8dc380, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__set_sectors_hal
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, lmac_if__post_cmd, mem_pool__alloc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__send_sta_cfg_05_b
lmac_if__send_sta_cfg_05_b:
	.global L_8dc380
L_8dc380:
	push_s blink
L_8dc382:
	bl L_8c01d8
L_8dc386:
	mov_s r14,r0
L_8dc388:
	mov_s r13,r1
L_8dc38a:
	mov_s r15,r2
L_8dc38c:
	mov_s r16,r3
L_8dc38e:
	mov_s r0,0x804280
L_8dc394:
	bl.d L_8c33d0
L_8dc398:
	mov r17,r4
L_8dc39c:
	mov_s r1,0x2
L_8dc39e:
	st_s r1,[r0,0x10]
L_8dc3a0:
	stb_s r14,[r0,0xc]
L_8dc3a2:
	stw_s r13,[r0,0x2]
L_8dc3a4:
	stb_s r15,[r0]
L_8dc3a6:
	stw r16,[r0, 0x6]
L_8dc3aa:
	stb r17,[r0, 0x4]
L_8dc3ae:
	stw 0xffff,[r0, 0xa]
L_8dc3b6:
	mov_s r1,0x5
L_8dc3b8:
	mov_s r2,0x28
L_8dc3ba:
	bl.d L_8e5204
L_8dc3be:
	mov_s r3,0x0
L_8dc3c0:
	b L_8c023c
