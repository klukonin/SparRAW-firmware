/* l2mgr__set_mac_address @ 0x8fbc64, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [Mid:%d] I'm ROOT: ADDR-%04X%08X
 * Зовут его: wmi__set_mac_address_thunk
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit3, fw_sysassert_fatal, l2mgr__apply_mac_address, mac__apply_multicast_addr, memcpy_fw, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__set_mac_address
l2mgr__set_mac_address:
	.global L_8fbc64
L_8fbc64:
	push_s blink
L_8fbc66:
	bl L_8c01d8
L_8fbc6a:
	sub_s sp,sp,0x8
L_8fbc6c:
	mov_s r16,r0
L_8fbc6e:
	mov_s r17,r1
L_8fbc70:
	bl.d L_8cc3dc
L_8fbc74:
	mov_s r0,r1
L_8fbc76:
	mov.f r13,r0
L_8fbc7a:
	beq_s L_8fbcb6
	.global L_8fbc7c
L_8fbc7c:
	add3 r14,r13,0x9
L_8fbc80:
	mov_s r0,r13
L_8fbc82:
	bl.d L_8e68b4
L_8fbc86:
	mov_s r1,r16
L_8fbc88:
	mov_s r0,r14
L_8fbc8a:
	bl.d L_8e6368
L_8fbc8e:
	mov_s r1,r16
L_8fbc90:
	mov_s r0,sp
L_8fbc92:
	mov_s r1,r16
L_8fbc94:
	bl.d L_8c0380
L_8fbc98:
	mov_s r2,0x6
L_8fbc9a:
	mov_s r1,0x100d690
L_8fbca0:
	ld r4,[sp]
L_8fbca4:
	mov_s r0,0x2b
L_8fbca6:
	mov_s r2,r17
L_8fbca8:
	bl.d L_8dcd00
L_8fbcac:
	ldb r3,[sp, 0x2]
L_8fbcb0:
	b.d L_8c023c
L_8fbcb4:
	add_s sp,sp,0x8
	.global L_8fbcb6
L_8fbcb6:
	mov_s r0,blink
L_8fbcb8:
	mov_s r1,0x16bf
L_8fbcbe:
	bl L_8c9b28
L_8fbcc2:
	b_s L_8fbc7c
