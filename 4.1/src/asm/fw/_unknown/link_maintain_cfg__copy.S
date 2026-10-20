/* link_maintain_cfg__copy @ 0x8c9fcc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__apply_default_link_maintain_cfg, conn_mgr__set_link_maintain_cfg
 * Зовёт сам: memcpy_fw
 */
	.section .text.link_maintain_cfg__copy,"ax",@progbits
	.global link_maintain_cfg__copy
link_maintain_cfg__copy:
	.global L_8c9fcc
L_8c9fcc:
	mov_s r2,r0
L_8c9fce:
	push_s blink
L_8c9fd0:
	mov_s r0,r1
L_8c9fd2:
	breq r2,0x4,L_8c9fdc
L_8c9fd6:
	brhs r2,0x5,L_8c9fdc
L_8c9fda:
	brne_s r0,0,L_8c9fe0
	.global L_8c9fdc
L_8c9fdc:
	mov_s r0,0x0
L_8c9fde:
	b_s L_8c9ff2
	.global L_8c9fe0
L_8c9fe0:
	asl_s r1,r2,0x2
L_8c9fe2:
	add3_s r1,r1,r1
L_8c9fe4:
	add_s r1,r1,0x80120c
L_8c9fea:
	bl.d L_8c0460
L_8c9fee:
	mov_s r2,0x24
L_8c9ff0:
	mov_s r0,0x1
	.global L_8c9ff2
L_8c9ff2:
	pop_s blink
L_8c9ff4:
	j_s [blink]
L_8c9ff6:
	nop_s
