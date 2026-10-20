/* conn_msm__on_ntf_key_installed @ 0x8d75a8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, assoc_ready_check_trig, basic_sm__inject_event, u_schd__add
 */
	.section .text.conn_msm__on_ntf_key_installed,"ax",@progbits
	.global conn_msm__on_ntf_key_installed
conn_msm__on_ntf_key_installed:
L_8d75a8:
	push_s blink
L_8d75aa:
	push_s r13
L_8d75ac:
	mov_s r13,r0
L_8d75ae:
	ld_s r0,[r0,0x2c]
L_8d75b0:
	mov_s r1,0x8
L_8d75b2:
	add r0,r0,0xb0
L_8d75b6:
	mov_s r2,0x0
L_8d75b8:
	mov_s r3,r2
L_8d75ba:
	bl.d L_8d6a1c
L_8d75be:
	mov_s r4,r2
L_8d75c0:
	ld_s r0,[r13,0x2c]
L_8d75c2:
	bl.d L_8c33f4
L_8d75c6:
	ld_s r0,[r0,0xc]
L_8d75c8:
	mov_s r0,0x2d5fc
L_8d75ce:
	ld_s r1,[r13,0x2c]
L_8d75d0:
	mov_s r2,0x0
L_8d75d2:
	bl.d L_8c2ac8
L_8d75d6:
	mov_s r3,0x1
L_8d75d8:
	b L_8c033c
