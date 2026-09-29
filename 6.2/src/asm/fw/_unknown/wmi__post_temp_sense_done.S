/* wmi__post_temp_sense_done @ 0x8e5dac, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi__post_temp_sense_done
wmi__post_temp_sense_done:
	.global L_8e5dac
L_8e5dac:
	push_s blink
L_8e5dae:
	bl L_8c01e0
L_8e5db2:
	sub_s sp,sp,0x4
L_8e5db4:
	mov_s r14,r0
L_8e5db6:
	mov_s r13,r1
L_8e5db8:
	mov_s r15,r2
L_8e5dba:
	bl.d L_8c33d0
L_8e5dbe:
	mov_s r0,r2
L_8e5dc0:
	mov_s r1,r0
L_8e5dc2:
	st_s r14,[r0]
L_8e5dc4:
	st_s r13,[r0,0x4]
L_8e5dc6:
	mov_s r2,0x0
L_8e5dc8:
	st_s r2,[sp,0x0]
L_8e5dca:
	mov_s r0,r15
L_8e5dcc:
	mov_s r3,0x180e
L_8e5dd2:
	mov r4,0x24
L_8e5dd6:
	mov_s r5,r2
L_8e5dd8:
	mov_s r6,r2
L_8e5dda:
	bl.d L_8e4fc4
L_8e5dde:
	mov_s r7,r2
L_8e5de0:
	b.d L_8c024c
L_8e5de4:
	add_s sp,sp,0x4
L_8e5de6:
	nop_s
