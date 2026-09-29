/* l2mgr__set_mac_address @ 0x8f3284, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [Mid:%d] I'm ROOT: ADDR-%04X%08X
 * Зовут его: wmi_handler_set_mac_address
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit3, l2mgr__apply_mac_address, mac__apply_multicast_addr, memcpy_fw, mid_list__by_mid
 */
	.section .text.l2mgr__set_mac_address,"ax",@progbits
	.global l2mgr__set_mac_address
l2mgr__set_mac_address:
	.global L_8f3284
L_8f3284:
	push_s blink
L_8f3286:
	bl L_8c02c0
L_8f328a:
	sub_s sp,sp,0x8
L_8f328c:
	mov_s r13,r0
L_8f328e:
	mov_s r15,r1
L_8f3290:
	bl.d L_8ca1b0
L_8f3294:
	mov_s r0,r1
L_8f3296:
	add3 r14,r0,0x9
L_8f329a:
	bl.d L_8e1a68
L_8f329e:
	mov_s r1,r13
L_8f32a0:
	mov_s r0,r14
L_8f32a2:
	bl.d L_8e15f0
L_8f32a6:
	mov_s r1,r13
L_8f32a8:
	mov_s r0,sp
L_8f32aa:
	mov_s r1,r13
L_8f32ac:
	bl.d L_8c0460
L_8f32b0:
	mov_s r2,0x6
L_8f32b2:
	ldb r4,[sp, 0x2]
L_8f32b6:
	mov_s r2,0x100c75c
L_8f32bc:
	ld r5,[sp]
L_8f32c0:
	mov_s r0,0xb
L_8f32c2:
	mov_s r1,0x2
L_8f32c4:
	bl.d L_8ee034
L_8f32c8:
	mov_s r3,r15
L_8f32ca:
	b.d L_8c032c
L_8f32ce:
	add_s sp,sp,0x8
