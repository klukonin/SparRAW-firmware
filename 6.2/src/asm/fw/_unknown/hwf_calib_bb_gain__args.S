/* hwf_calib_bb_gain__args @ 0x8dcb6c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_bb_gain_rows
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bytes__pick4_by_index
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_calib_bb_gain__args
hwf_calib_bb_gain__args:
	.global L_8dcb6c
L_8dcb6c:
	sub_s sp,sp,0x1c
L_8dcb6e:
	push_s blink
L_8dcb70:
	bl.d L_8c01e0
L_8dcb74:
	mov_s r1,r3
L_8dcb76:
	sub_s sp,sp,0x10
L_8dcb78:
	mov_s r13,r4
L_8dcb7a:
	mov_s r3,r5
L_8dcb7c:
	mov r4,r6
L_8dcb80:
	mov r5,r7
L_8dcb84:
	mov_s r0,r2
L_8dcb86:
	ld r6,[sp, 0x3c]
L_8dcb8a:
	ld r7,[sp, 0x40]
L_8dcb8e:
	ld_s r14,[sp,0x48]
L_8dcb90:
	ld_s r15,[sp,0x44]
L_8dcb92:
	st_s r15,[sp,0x0]
L_8dcb94:
	st_s r14,[sp,0x4]
L_8dcb96:
	add_s r14,sp,0xc
L_8dcb98:
	st_s r14,[sp,0x8]
L_8dcb9a:
	bl.d L_8d5578
L_8dcb9e:
	mov_s r2,r13
L_8dcba0:
	mov_s r12,0x20
L_8dcba2:
	b.d L_8c024e
L_8dcba6:
	add_s sp,sp,0x10
