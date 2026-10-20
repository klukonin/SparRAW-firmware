/* vring__disable_and_ack @ 0x8d5244, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schd__disconnect_notify, vring_schd__fill_vring_cfg, vring_schd__resume_vring, vring_schd__stop_vring
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_dma__ack_881c44, vring_hw__write_disable
 */
	.section .text.vring__disable_and_ack,"ax",@progbits
	.global vring__disable_and_ack
vring__disable_and_ack:
	.global L_8d5244
L_8d5244:
	push_s blink
L_8d5246:
	bl L_8c02c4
L_8d524a:
	ld_s r1,[r0,0x20]
L_8d524c:
	mov_s r13,0x1
L_8d524e:
	st_s r13,[r0,0x24]
L_8d5250:
	brne r1,0x1,L_8d526e
L_8d5254:
	ldb_s r14,[r0,0x9]
L_8d5256:
	mov_s r0,0x0
L_8d5258:
	bset r0,r0,r14
L_8d525c:
	bl.d L_8cd734
L_8d5260:
	mov_s r1,r13
L_8d5262:
	mov_s r0,0x0
L_8d5264:
	bset r0,r0,r14
L_8d5268:
	bl.d L_8cd764
L_8d526c:
	mov_s r1,r13
	.global L_8d526e
L_8d526e:
	b L_8c0334
L_8d5272:
	nop_s
