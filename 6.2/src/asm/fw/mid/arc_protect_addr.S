/* arc_protect_addr @ 0x8c3b90, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   arc_protect_addr: id:%u %x:%x
 * Зовут его: tx_ppdu_ageing_timeout_detector__start_monitoring
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, arc_action_point__arm, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global arc_protect_addr
arc_protect_addr:
	.global L_8c3b90
L_8c3b90:
	push_s blink
L_8c3b92:
	bl L_8c01dc
L_8c3b96:
	sub_s sp,sp,0x20
L_8c3b98:
	mov_s r14,r0
L_8c3b9a:
	mov_s r15,r1
L_8c3b9c:
	mov_s r16,r2
L_8c3b9e:
	mov_s r1,0x1000acc
L_8c3ba4:
	mov_s r13,0x0
L_8c3ba6:
	mov_s r0,r13
L_8c3ba8:
	mov_s r2,r14
L_8c3baa:
	mov_s r3,r15
L_8c3bac:
	bl.d L_8dcd00
L_8c3bb0:
	mov r4,r16
L_8c3bb4:
	st_s r14,[sp,0x0]
L_8c3bb6:
	mov_s r1,0x1
L_8c3bb8:
	st_s r1,[sp,0x1c]
L_8c3bba:
	st_s r13,[sp,0x14]
L_8c3bbc:
	st_s r13,[sp,0x18]
L_8c3bbe:
	mov_s r0,0x2
L_8c3bc0:
	st_s r0,[sp,0xc]
L_8c3bc2:
	st_s r1,[sp,0x10]
L_8c3bc4:
	st_s r15,[sp,0x4]
L_8c3bc6:
	st r16,[sp, 0x8]
L_8c3bca:
	bl.d L_8c3af0
L_8c3bce:
	mov_s r0,sp
L_8c3bd0:
	b.d L_8c0244
L_8c3bd4:
	add_s sp,sp,0x20
L_8c3bd6:
	nop_s
