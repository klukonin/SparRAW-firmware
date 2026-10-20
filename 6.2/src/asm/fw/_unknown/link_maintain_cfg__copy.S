/* link_maintain_cfg__copy @ 0x8cc170, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__apply_default_link_maintain_cfg, conn_mgr__set_link_maintain_cfg
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_maintain_cfg__copy
link_maintain_cfg__copy:
	.global L_8cc170
L_8cc170:
	mov_s r2,r0
L_8cc172:
	push_s blink
L_8cc174:
	mov_s r0,r1
L_8cc176:
	breq r2,0x4,L_8cc180
L_8cc17a:
	brhs r2,0x5,L_8cc180
L_8cc17e:
	brne_s r0,0,L_8cc184
	.global L_8cc180
L_8cc180:
	mov_s r0,0x0
L_8cc182:
	b_s L_8cc196
	.global L_8cc184
L_8cc184:
	asl_s r1,r2,0x2
L_8cc186:
	add3_s r1,r1,r1
L_8cc188:
	add_s r1,r1,0x801518
L_8cc18e:
	bl.d L_8c0380
L_8cc192:
	mov_s r2,0x24
L_8cc194:
	mov_s r0,0x1
	.global L_8cc196
L_8cc196:
	pop_s blink
L_8cc198:
	j_s [blink]
L_8cc19a:
	nop_s
