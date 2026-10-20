/* conn_msm__on_ntf_lm_started__wait_for_lm_start @ 0x8d7ee8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: u_schd__add
 */
	.section .text.conn_msm__on_ntf_lm_started__wait_for_lm_start,"ax",@progbits
	.global conn_msm__on_ntf_lm_started__wait_for_lm_start
conn_msm__on_ntf_lm_started__wait_for_lm_start:
L_8d7ee8:
	mov_s r2,0x29bc4
L_8d7eee:
	ld_s r1,[r0,0x2c]
L_8d7ef0:
	mov_s r0,r2
L_8d7ef2:
	mov_s r2,0x0
L_8d7ef4:
	b.d L_8c2ac8
L_8d7ef8:
	mov_s r3,0x1
L_8d7efa:
	nop_s
