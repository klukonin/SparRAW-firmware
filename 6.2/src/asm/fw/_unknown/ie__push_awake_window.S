/* ie__push_awake_window @ 0x8e1f84, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_mgmt_build_step
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie__push_awake_window
ie__push_awake_window:
	.global L_8e1f84
L_8e1f84:
	sub_s sp,sp,0x4
L_8e1f86:
	push_s blink
L_8e1f88:
	stw r1,[sp, 0x4]
L_8e1f8c:
	mov_s r1,0x9d
L_8e1f8e:
	stb_s r1,[r0]
L_8e1f90:
	mov_s r2,0x2
L_8e1f92:
	stb_s r2,[r0,0x1]
L_8e1f94:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e1f96:
	bl.d L_8c0380
L_8e1f9a:
	add_s r1,sp,0x4
L_8e1f9c:
	mov_s r0,0x4
L_8e1f9e:
	pop_s blink
L_8e1fa0:
	j_s.d [blink]
L_8e1fa2:
	add_s sp,sp,0x4
