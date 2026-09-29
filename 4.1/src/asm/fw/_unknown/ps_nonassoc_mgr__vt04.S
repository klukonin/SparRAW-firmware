/* ps_nonassoc_mgr__vt04 @ 0x8d5d2c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__init
 * Зовёт сам: __ld_r13_ret, ps_nonassoc_sm__init
 */
	.section .text.ps_nonassoc_mgr__vt04,"ax",@progbits
	.global ps_nonassoc_mgr__vt04
ps_nonassoc_mgr__vt04:
	.global L_8d5d2c
L_8d5d2c:
	push_s blink
L_8d5d2e:
	push_s r13
L_8d5d30:
	mov_s r13,r0
L_8d5d32:
	bl.d L_8d5c7c
L_8d5d36:
	add_s r0,r0,0xc
L_8d5d38:
	mov_s r1,0xffffff
L_8d5d3e:
	mov_s r0,0x0
L_8d5d40:
	st_s r1,[r13]
L_8d5d42:
	b.d L_8c033c
L_8d5d46:
	st_s r0,[r13,0x4]
