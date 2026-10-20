/* vring__reg_write_locked_3c @ 0x8cd6dc, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring, sm_pring__eop_evt, sm_pring__state_step, vring_schd__flush_response, vring_schd__move_to_ready
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.vring__reg_write_locked_3c,"ax",@progbits
	.global vring__reg_write_locked_3c
vring__reg_write_locked_3c:
	.global L_8cd6dc
L_8cd6dc:
	push_s blink
L_8cd6de:
	push_s r13
L_8cd6e0:
	lr r13,[0xa]
L_8cd6e4:
	bclr r2,r13,0x1
L_8cd6e8:
	flag r2
L_8cd6ec:
	mov_s r2,0x881c00
L_8cd6f2:
	st_s r0,[r2,0x3c]
L_8cd6f4:
	breq_s r1,0,L_8cd6fa
L_8cd6f6:
	sync
	.global L_8cd6fa
L_8cd6fa:
	lr r0,[0xa]
L_8cd6fe:
	bic r13,r13,-0x3
L_8cd702:
	or_s r13,r13,r0
L_8cd704:
	flag r13
L_8cd708:
	b L_8c033c
