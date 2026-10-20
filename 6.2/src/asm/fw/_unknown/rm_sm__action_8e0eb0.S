/* rm_sm__action_8e0eb0 @ 0x8e0eb0, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, rm__store_tune_request, rm_main_sm__enter_primary_non_locked, sta_psc_sm__action_8c318c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_sm__action_8e0eb0
rm_sm__action_8e0eb0:
	.global L_8e0eb0
L_8e0eb0:
	push_s blink
L_8e0eb2:
	bl L_8c01e4
L_8e0eb6:
	mov_s r13,r0
L_8e0eb8:
	mov_s r14,r1
L_8e0eba:
	mov_s r1,r2
L_8e0ebc:
	bl.d L_8e9ab4
L_8e0ec0:
	mov_s r2,r14
L_8e0ec2:
	bl.d L_8c9950
L_8e0ec6:
	mov_s r0,r13
L_8e0ec8:
	b L_8c0254
L_8e0ecc:
	mul64 r0,0x3c
L_8e0ed0:
	add r0,mlo,0x804de4
L_8e0ed8:
	b L_8c3194
L_8e0edc:
	mul64 r0,0x3c
L_8e0ee0:
	add r0,mlo,0x804de4
L_8e0ee8:
	b L_8c9990
