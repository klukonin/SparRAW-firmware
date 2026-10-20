/* lmac_if_update_aw_ie_handler @ 0x8d8de0, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_update_aw_ie_handler. tbtt_start_time: 0x%x awake_window_duration: %d
 * Зовут его: mid__set_awake_window
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit2, lmac_mbox__alloc_slot, memcpy_fw, send_cmd2_lmac
 */
	.section .text.lmac_if_update_aw_ie_handler,"ax",@progbits
	.global lmac_if_update_aw_ie_handler
lmac_if_update_aw_ie_handler:
	.global L_8d8de0
L_8d8de0:
	push_s blink
L_8d8de2:
	bl L_8c02c0
L_8d8de6:
	sub_s sp,sp,0xc
L_8d8de8:
	mov_s r13,r0
L_8d8dea:
	mov_s r15,r1
L_8d8dec:
	mov_s r2,0x1004ed4
L_8d8df2:
	mov_s r0,0x0
L_8d8df4:
	mov_s r1,0x2
L_8d8df6:
	mov_s r3,r13
L_8d8df8:
	bl.d L_8edff8
L_8d8dfc:
	mov_s r4,r15
L_8d8dfe:
	bl L_8c2b0c
L_8d8e02:
	st_s r13,[sp,0x0]
L_8d8e04:
	mov_s r14,r0
L_8d8e06:
	st_s r15,[sp,0x4]
L_8d8e08:
	mov_s r0,0x1
L_8d8e0a:
	st_s r0,[sp,0x8]
L_8d8e0c:
	mov_s r0,0x9d
L_8d8e0e:
	st_s r0,[r14]
L_8d8e10:
	add_s r0,r14,0x4
L_8d8e12:
	mov_s r1,sp
L_8d8e14:
	bl.d L_8c0460
L_8d8e18:
	mov_s r2,0xc
L_8d8e1a:
	mov_s r0,r14
L_8d8e1c:
	mov_s r1,0x25
L_8d8e1e:
	mov_s r2,0x14
L_8d8e20:
	bl.d L_8e0694
L_8d8e24:
	mov_s r3,0x0
L_8d8e26:
	b.d L_8c032c
L_8d8e2a:
	add_s sp,sp,0xc
