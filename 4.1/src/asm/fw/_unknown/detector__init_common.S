/* detector__init_common @ 0x8d5e80, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ka_necessity_detector__init, ka_necessity_detector__start_monitoring, l2mgr__init_oob_detector, tx_ppdu_ageing_timeout_detector__init, tx_ppdu_ageing_timeout_detector__start_monitoring
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_read_timer
 */
	.section .text.detector__init_common,"ax",@progbits
	.global detector__init_common
detector__init_common:
	.global L_8d5e80
L_8d5e80:
	push_s blink
L_8d5e82:
	bl L_8c02bc
L_8d5e86:
	mov_s r13,r0
L_8d5e88:
	mov_s r14,r1
L_8d5e8a:
	mov_s r15,r2
L_8d5e8c:
	mov_s r16,r3
L_8d5e8e:
	bl.d L_8e4694
L_8d5e92:
	st r4,[r0, 0xc]
L_8d5e96:
	st_s r14,[r13]
L_8d5e98:
	st_s r15,[r13,0x4]
L_8d5e9a:
	st r16,[r13, 0x8]
L_8d5e9e:
	mov_s r0,0x0
L_8d5ea0:
	st_s r0,[r13,0x10]
L_8d5ea2:
	mov r0,-0x1
L_8d5ea6:
	st_s r0,[r13,0x14]
L_8d5ea8:
	st_s r0,[r13,0x18]
L_8d5eaa:
	st_s r0,[r13,0x1c]
L_8d5eac:
	st_s r0,[r13,0x20]
L_8d5eae:
	mov_s r0,0x1
L_8d5eb0:
	st_s r0,[r13,0x28]
L_8d5eb2:
	mov_s r0,0xff
L_8d5eb4:
	b.d L_8c0324
L_8d5eb8:
	stb r0,[r13, 0x24]
