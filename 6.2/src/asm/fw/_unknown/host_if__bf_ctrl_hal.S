/* host_if__bf_ctrl_hal @ 0x8dd028, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   *** BF CTRL HAL ***
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_if__bf_ctrl_hal
host_if__bf_ctrl_hal:
	.global L_8dd028
L_8dd028:
	push_s blink
L_8dd02a:
	bl L_8c01e4
L_8dd02e:
	sub_s sp,sp,0x4
L_8dd030:
	mov_s r13,r0
L_8dd032:
	mov_s r14,r2
L_8dd034:
	mov_s r1,0x1006278
L_8dd03a:
	bl.d L_8dcba8
L_8dd03e:
	mov_s r0,0x25
L_8dd040:
	bl.d L_8c33d0
L_8dd044:
	mov_s r0,r13
L_8dd046:
	mov_s r1,r0
L_8dd048:
	mov_s r2,0x0
L_8dd04a:
	st_s r2,[sp,0x0]
L_8dd04c:
	mov_s r0,r13
L_8dd04e:
	mov_s r3,0x1862
L_8dd054:
	mov_s r4,r2
L_8dd056:
	mov_s r5,r14
L_8dd058:
	mov_s r6,r2
L_8dd05a:
	bl.d L_8e4fc4
L_8dd05e:
	mov_s r7,r2
L_8dd060:
	b.d L_8c0254
L_8dd064:
	add_s sp,sp,0x4
L_8dd066:
	nop_s
