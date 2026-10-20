/* ucode_cmd_install_key @ 0x9353a4, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txrx_api_cmd_handler.c
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, memcpy_uc, uc_send_evt__sta_update_field_rsp, uc_sysassert
 */
	.section .text.ucode_cmd_install_key,"ax",@progbits
	.global ucode_cmd_install_key
ucode_cmd_install_key:
	.global L_9353a4
L_9353a4:
	push_s blink
L_9353a6:
	bl L_920214
L_9353aa:
	mov_s r14,r0
L_9353ac:
	ld_s r0,[r0]
L_9353ae:
	ld_s r13,[r14,0x8]
L_9353b0:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_9353b2:
	add3_s r0,r0,r0
L_9353b4:
	add_s r0,r0,0x801190
L_9353ba:
	add_s r13,r13,r0
L_9353bc:
	ld_s r0,[r14,0xc]
L_9353be:
	brhs r0,0x11,L_9353de
	.global L_9353c2
L_9353c2:
	mov_s r0,r13
L_9353c4:
	add r1,r14,0x10
L_9353c8:
	bl.d L_920310
L_9353cc:
	ld_s r2,[r14,0xc]
L_9353ce:
	ld_s r1,[r14,0x4]
L_9353d0:
	ld_s r0,[r14]
L_9353d2:
	cmp_s r1,0x0
L_9353d4:
	cmp.ne r1,0x4
L_9353d8:
	bne_s L_9353f2
L_9353da:
	mov_s r13,0x1
L_9353dc:
	b_s L_9353f8
	.global L_9353de
L_9353de:
	mov_s r0,blink
L_9353e0:
	mov_s r2,0x1001830
L_9353e6:
	mov_s r1,0x81
L_9353e8:
	bl.d L_925548
L_9353ec:
	mov r3,0x1da
L_9353f0:
	b_s L_9353c2
	.global L_9353f2
L_9353f2:
	brne r1,0x1,L_935406
L_9353f6:
	mov_s r13,0x0
	.global L_9353f8
L_9353f8:
	asl_s r2,r0,0x3
L_9353fa:
	add3_s r2,r2,r2
L_9353fc:
	add r3,r2,0x8011d7
L_935404:
	stb_s r13,[r3]
	.global L_935406
L_935406:
	bl L_925d54
L_93540a:
	b L_920284
L_93540e:
	nop_s
