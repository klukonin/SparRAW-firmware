/* calib_engine__on_abort @ 0x8c1d74, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: RADIO_MGR__remove_request, __ld_r13_to_r13_ret, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__on_abort
calib_engine__on_abort:
	.global L_8c1d74
L_8c1d74:
	push_s blink
L_8c1d76:
	push_s r13
L_8c1d78:
	mov_s r13,r0
L_8c1d7a:
	ld_s r0,[r0,0x24]
L_8c1d7c:
	breq_s r0,0,L_8c1d86
L_8c1d7e:
	bl L_8e2798
L_8c1d82:
	mov_s r0,0x0
L_8c1d84:
	st_s r0,[r13,0x24]
	.global L_8c1d86
L_8c1d86:
	ld_s r0,[r13,0x28]
L_8c1d88:
	breq_s r0,0,L_8c1d92
L_8c1d8a:
	bl L_8c8de0
L_8c1d8e:
	mov_s r0,0x0
L_8c1d90:
	st_s r0,[r13,0x28]
	.global L_8c1d92
L_8c1d92:
	b L_8c025c
L_8c1d96:
	nop_s
