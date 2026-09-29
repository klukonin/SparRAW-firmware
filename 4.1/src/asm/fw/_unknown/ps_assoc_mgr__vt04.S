/* ps_assoc_mgr__vt04 @ 0x8d5b68, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__init
 * Зовёт сам: __ld_r13_ret, ps_assoc_sm__init
 */
	.section .text.ps_assoc_mgr__vt04,"ax",@progbits
	.global ps_assoc_mgr__vt04
ps_assoc_mgr__vt04:
	.global L_8d5b68
L_8d5b68:
	push_s blink
L_8d5b6a:
	push_s r13
L_8d5b6c:
	mov_s r13,r0
L_8d5b6e:
	bl.d L_8d5ad4
L_8d5b72:
	add_s r0,r0,0xc
L_8d5b74:
	mov r0,-0x1
L_8d5b78:
	st_s r0,[r13]
L_8d5b7a:
	b.d L_8c033c
L_8d5b7e:
	st_s r0,[r13,0x4]
