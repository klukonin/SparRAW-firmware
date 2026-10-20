/* ftm_main_sm__radio_allocated_cb @ 0x8f7f38, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] ftm_main_sm::radio_allocated_cb()
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, bits__set32_s0_w5, bits__set32_s16_w5, bits__set_s8_w5, ftm_main_sm__bits_set32_s24_w5, ftm_main_sm__radio_args, fw_log_emit0, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm_main_sm__radio_allocated_cb
ftm_main_sm__radio_allocated_cb:
	.global L_8f7f38
L_8f7f38:
	push_s blink
L_8f7f3a:
	bl.d L_8c3284
L_8f7f3e:
	push_s r13
L_8f7f40:
	mov_s r2,r0
L_8f7f42:
	mov_s r0,0x1
L_8f7f44:
	st_s r0,[r2,0xc]
L_8f7f46:
	mov_s r3,0x19
L_8f7f48:
	add_s r0,r2,0x4
L_8f7f4a:
	mov_s r1,r3
L_8f7f4c:
	bl.d L_8ed37c
L_8f7f50:
	mov_s r13,0x0
L_8f7f52:
	mov_s r1,0x1c
L_8f7f54:
	bl L_8ed580
L_8f7f58:
	mov_s r1,0x18
L_8f7f5a:
	bl L_8ed400
L_8f7f5e:
	mov_s r1,r3
L_8f7f60:
	bl.d L_8ed478
L_8f7f64:
	mov_s r3,r13
L_8f7f66:
	mov_s r0,r2
L_8f7f68:
	mov_s r1,0x7
L_8f7f6a:
	bl.d L_8e5204
L_8f7f6e:
	mov_s r2,0x10
L_8f7f70:
	bl L_8c3284
L_8f7f74:
	mov_s r1,r13
L_8f7f76:
	mov_s r2,r0
L_8f7f78:
	mov_s r0,0x2
L_8f7f7a:
	st_s r0,[r2,0xc]
L_8f7f7c:
	add r0,r2,0x8
L_8f7f80:
	bl.d L_8ed37c
L_8f7f84:
	mov_s r3,r13
L_8f7f86:
	mov_s r1,0xa
L_8f7f88:
	bl L_8ed580
L_8f7f8c:
	mov_s r0,r2
L_8f7f8e:
	mov_s r1,0x7
L_8f7f90:
	bl.d L_8e5204
L_8f7f94:
	mov_s r2,0x10
L_8f7f96:
	b L_8c025c
L_8f7f9a:
	nop_s
L_8f7f9c:
	push_s blink
L_8f7f9e:
	push_s r13
L_8f7fa0:
	mov_s r13,r1
L_8f7fa2:
	mov_s r1,0x1019e30
L_8f7fa8:
	bl.d L_8dcba8
L_8f7fac:
	mov_s r0,0x20
L_8f7fae:
	mov_s r0,r13
L_8f7fb0:
	mov_s r1,0x2
L_8f7fb2:
	mov_s r2,0x0
L_8f7fb4:
	mov_s r3,r2
L_8f7fb6:
	bl.d L_8d9b6c
L_8f7fba:
	mov_s r4,r2
L_8f7fbc:
	b L_8c025c
L_8f7fc0:
	ld_s r2,[r1,0x10]
L_8f7fc2:
	ld_s r0,[r2,0x48]
L_8f7fc4:
	ldb r4,[r2, 0x10]
L_8f7fc8:
	ldb r5,[r0, 0x10]
L_8f7fcc:
	mov_s r0,0x31910
L_8f7fd2:
	ld_s r2,[r1,0x14]
L_8f7fd4:
	b.d L_8e4e18
L_8f7fd8:
	mov_s r3,0x1
L_8f7fda:
	nop_s
